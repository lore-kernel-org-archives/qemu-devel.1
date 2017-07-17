Received: from eggs.gnu.org ([2001:4830:134:3::10]:40269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX3Ew-0007fS-EB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX3Ep-0005vd-8E
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dX3Ep-0005v5-19
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:26:51 -0400
Date: Mon, 17 Jul 2017 11:26:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170717102642.GG2106@work-vm>
References: <20170713190116.21608-1-dgilbert@redhat.com>
	<20170717101703.GH7163@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717101703.GH7163@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > There's a rare exit seg if the guest is accessing
> > IO during exit.
> > It's always hitting the atomic_inc(&bs->in_flight) with a NULL
> > bs. This was added recently in 99723548  but I don't see it
> > as the cause.
> > 
> > Flip vl.c around so we pause the cpus before closing the block devices,
> > that way we shouldn't have anything trying to access them when
> > they're gone.
> > 
> > This was originally Red Hat bz https://bugzilla.redhat.com/show_bug.cgi?id=1451015
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reported-by: Cong Li <coli@redhat.com>
> > 
> > --
> > This is a very rare race, I'll leave it running in a loop to see if
> > we hit anything else and to check this really fixes it.
> > 
> > I do worry if there are other cases that can trigger this - e.g.
> > hot-unplug or ejecting a CD.
> > 
> > ---
> >  vl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks;  and the test I left running seems solid - ~12k runs
over the weekend with no seg.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
