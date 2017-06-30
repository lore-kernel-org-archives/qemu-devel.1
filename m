Received: from eggs.gnu.org ([2001:4830:134:3::10]:52147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQpRc-0007OZ-Da
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQpRW-00088s-Gy
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:30:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQpRW-00088X-Ap
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:30:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C8C7333C0
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:30:13 +0000 (UTC)
Date: Fri, 30 Jun 2017 14:30:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170630063002.GD24859@pxdev.xzpeter.org>
References: <1498710417-7807-1-git-send-email-peterx@redhat.com>
	<20170629163418-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170629163418-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: fix migration breakage on mr
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 29, 2017 at 04:35:04PM +0300, Michael S. Tsirkin wrote:
> On Thu, Jun 29, 2017 at 12:26:57PM +0800, Peter Xu wrote:
> > Migration is broken after the vfio integration work:
> > 
> > qemu-kvm: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
> > qemu-kvm: Failed to load ich9_ahci:ahci
> > qemu-kvm: error while loading state for instance 0x0 of device '0000:00:1f.2/ich9_ahci'
> > qemu-kvm: load of migration failed: Operation not permitted
> > 
> > The problem is that vfio work introduced dynamic memory region
> > switching (actually it is also used for future PT mode), and this memory
> > region layout is not properly delivered to destination when migration
> > happens. Solution is to rebuild the layout in post_load.
> > 
> > Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1459906
> > Fixes: 558e0024 ("intel_iommu: allow dynamic switch of IOMMU region")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index a9b59bd..36b231d 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2332,11 +2332,28 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
> >      }
> >  }
> >  
> > +static int vtd_post_load(void *opaque, int version_id)
> > +{
> > +    IntelIOMMUState *iommu = opaque;
> > +
> > +    /*
> > +     * Since commit 558e00 ("intel_iommu: allow dynamic switch of
> > +     * IOMMU region"),
> 
> I would drop this part of the comment. It isn't of interest
> to people reading code directly, while people reading git
> history see the commit log.

Ok. Will resend. Thanks.

-- 
Peter Xu
