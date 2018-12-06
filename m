Received: from eggs.gnu.org ([2001:4830:134:3::10]:39039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUqIB-0007qJ-8D
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUqI6-0001Wa-9h
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:49:59 -0500
Date: Thu, 6 Dec 2018 10:49:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181206104948.4e8f8fed.cohuck@redhat.com>
In-Reply-To: <20181130094957.4121-1-david@redhat.com>
References: <20181130094957.4121-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/tod: Properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 30 Nov 2018 10:49:57 +0100
David Hildenbrand <david@redhat.com> wrote:

> Just like on other architectures, we should stop the clock while the guest
> is not running. This is already properly done for TCG. Right now, doing an
> offline migration (stop, migrate, cont) can easily trigger stalls in the
> guest.
> 
> Even doing a
>     (hmp) stop
>     ... wait 2 minutes ...
>     (hmp) cont
> will already trigger stalls.
> 
> So whenever the guest stops, backup the KVM TOD. When continuing to run
> the guest, restore the KVM TOD.
> 
> One special case is starting a simple VM: Reading the TOD from KVM to
> stop it right away until the guest is actually started means that the
> time of any simple VM will already differ to the host time. We can
> simply leave the TOD running and the guest won't be able to recognize
> it.
> 
> For migration, we actually want to keep the TOD stopped until really
> starting the guest. To be able to catch most errors, we should however
> try to set the TOD in addition to simply storing it. So we can still
> catch basic migration problems.
> 
> If anything goes wrong while backing up/restoring the TOD, we have to
> ignore it (but print a warning). This is then basically a fallback to
> old behavior (TOD remains running).
> 
> I tested this very basically with an initrd:
>     1. Start a simple VM. Observed that the TOD is kept running. Old
>        behavior.
>     2. Ordinary live migration. Observed that the TOD is temporarily
>        stopped on the destination when setting the new value and
>        correctly started when finally starting the guest.
>     3. Offline live migration. (stop, migrate, cont). Observed that the
>        TOD will be stopped on the source with the "stop" command. On the
>        destination, the TOD is temporarily stopped when setting the new
>        value and correctly started when finally starting the guest via
>        "cont".
>     4. Simple stop/cont correctly stops/starts the TOD. (multiple stops
>        or conts in a row have no effect, so works as expected)
> 
> In the future, we might want to send the guest a special kind of time sync
> interrupt under some conditions, so it can synchronize its tod to the
> host tod. This is interesting for migration scenarios but also when we
> get time sync interrupts ourselves. This however will most probably have
> to be handled in KVM (e.g. when the tods differ too much) and is not
> desired e.g. when debugging the guest. (single stepping should not
> result in permanent time syncs). I consider something like that an add-on
> on top of this basic "don't break the guest" handling.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v2 -> v3:
> - use device_class_set_parent_realize() to implement a child realize
>   function
> 
>  hw/s390x/tod-kvm.c     | 102 ++++++++++++++++++++++++++++++++++++++++-
>  include/hw/s390x/tod.h |   8 +++-
>  2 files changed, 107 insertions(+), 3 deletions(-)

Thanks, applied.
