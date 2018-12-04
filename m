Received: from eggs.gnu.org ([208.118.235.92]:55492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gU6Tf-0006HZ-Py
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gU6Ta-0001yf-P9
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 03:54:47 -0500
References: <20181130094957.4121-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a0204583-70a9-7da5-bc8c-c0fe0abc318c@redhat.com>
Date: Tue, 4 Dec 2018 09:54:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181130094957.4121-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2018-11-30 10:49, David Hildenbrand wrote:
> Just like on other architectures, we should stop the clock while the gu=
est
> is not running. This is already properly done for TCG. Right now, doing=
 an
> offline migration (stop, migrate, cont) can easily trigger stalls in th=
e
> guest.
>=20
> Even doing a
>     (hmp) stop
>     ... wait 2 minutes ...
>     (hmp) cont
> will already trigger stalls.
>=20
> So whenever the guest stops, backup the KVM TOD. When continuing to run
> the guest, restore the KVM TOD.
>=20
> One special case is starting a simple VM: Reading the TOD from KVM to
> stop it right away until the guest is actually started means that the
> time of any simple VM will already differ to the host time. We can
> simply leave the TOD running and the guest won't be able to recognize
> it.
>=20
> For migration, we actually want to keep the TOD stopped until really
> starting the guest. To be able to catch most errors, we should however
> try to set the TOD in addition to simply storing it. So we can still
> catch basic migration problems.
>=20
> If anything goes wrong while backing up/restoring the TOD, we have to
> ignore it (but print a warning). This is then basically a fallback to
> old behavior (TOD remains running).
>=20
> I tested this very basically with an initrd:
>     1. Start a simple VM. Observed that the TOD is kept running. Old
>        behavior.
>     2. Ordinary live migration. Observed that the TOD is temporarily
>        stopped on the destination when setting the new value and
>        correctly started when finally starting the guest.
>     3. Offline live migration. (stop, migrate, cont). Observed that the
>        TOD will be stopped on the source with the "stop" command. On th=
e
>        destination, the TOD is temporarily stopped when setting the new
>        value and correctly started when finally starting the guest via
>        "cont".
>     4. Simple stop/cont correctly stops/starts the TOD. (multiple stops
>        or conts in a row have no effect, so works as expected)
>=20
> In the future, we might want to send the guest a special kind of time s=
ync
> interrupt under some conditions, so it can synchronize its tod to the
> host tod. This is interesting for migration scenarios but also when we
> get time sync interrupts ourselves. This however will most probably hav=
e
> to be handled in KVM (e.g. when the tods differ too much) and is not
> desired e.g. when debugging the guest. (single stepping should not
> result in permanent time syncs). I consider something like that an add-=
on
> on top of this basic "don't break the guest" handling.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> v2 -> v3:
> - use device_class_set_parent_realize() to implement a child realize
>   function
>=20
>  hw/s390x/tod-kvm.c     | 102 ++++++++++++++++++++++++++++++++++++++++-
>  include/hw/s390x/tod.h |   8 +++-
>  2 files changed, 107 insertions(+), 3 deletions(-)

LGTM now.

Reviewed-by: Thomas Huth <thuth@redhat.com>
