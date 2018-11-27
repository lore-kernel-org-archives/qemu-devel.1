Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRcnW-00005V-HO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRcnV-0007gz-Cg
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:49:02 -0500
Date: Tue, 27 Nov 2018 13:48:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181127134851.0e81dcf6.cohuck@redhat.com>
In-Reply-To: <f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
References: <20181127114102.4319-1-david@redhat.com>
	<f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 27 Nov 2018 13:43:24 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 27.11.2018 12:41, David Hildenbrand wrote:
> > Just like on other architectures, we should stop the clock while the guest
> > is not running. This is already properly done for TCG. Right now, doing an
> > offline migration (stop, migrate, cont) can easily trigger stalls in the
> > guest.
> > 
> > Even doing a
> >     (hmp) stop
> >     ... wait 2 minutes ...
> >     (hmp) cont
> > will already trigger stalls.
> > 
> > So whenever the guest stops, backup the KVM TOD. When continuning to run
> > the guest, restore the KVM TOD.  
> 
> We do a similar thing for managedsave so it probably makes sense to solve
> the stall warnings. Now: At the same time, we actually want to have the guest
> see the real time and maybe even share the TOD clock with the host in some
> way, while at the same time avoid the stall warnings.
> 
> One idea is to signal the guest on migration (and stop start events) and let
> the guest do a time sync with the host.
> In fact, it seems that by architecture we need to signal a special sclp signal 
> anyway if stsi information would change (e.g. on migration). Maybe we can 
> piggyback on that and do some time sync interface in the future.

That sounds interesting.

Out of curiosity, is z/VM already doing something like that when you
migrate Linux guests? Or do they do it differently enough from what
QEMU is doing anyway?
