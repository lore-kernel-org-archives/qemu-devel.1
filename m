Received: from eggs.gnu.org ([2001:4830:134:3::10]:40126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cq8M8-0002Ok-HS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cq8M4-0004wt-J7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:13:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cq8M4-0004w5-DN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11DA5437F4C
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 01:12:56 +0000 (UTC)
Date: Tue, 21 Mar 2017 03:12:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170321031220-mutt-send-email-mst@kernel.org>
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
	<1489980999-5965-3-git-send-email-jasowang@redhat.com>
	<20170320090734.GN17405@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320090734.GN17405@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH fixup 2/2] vhost: genearlize iommu memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 20, 2017 at 05:07:34PM +0800, Peter Xu wrote:
> On Mon, Mar 20, 2017 at 11:36:39AM +0800, Jason Wang wrote:
> > We assumes the iommu_ops were attached to the root region of address
> > space. This may not true for all kinds of IOMMU implementation. So fix
> > this by not assume as->root has iommu_ops and:
> > 
> > - register a memory listener to dma_as
> > - during region_add, if it's a region of IOMMU, register a specific
> >   IOMMU notifier, and store all notifiers in a list
> > - during region_del, compare and delete the IOMMU notifier
> > 
> > This is a must for making vhost device IOTLB works for IOMMU other
> > than intel ones.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> [...]
> 
> > @@ -1454,9 +1509,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >          goto fail_features;
> >      }
> >  
> > -    if (vhost_dev_has_iommu(hdev)) {
> > -        memory_region_register_iommu_notifier(vdev->dma_as->root,
> > -                                              &hdev->n);
> > +    if (true) {
> 
> Here the if clause can be removed. And...
> 
> > +        memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
> >      }
> >  
> >      r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
> > @@ -1536,10 +1590,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
> >                               hdev->vq_index + i);
> >      }
> >  
> > -    if (vhost_dev_has_iommu(hdev)) {
> > +    if (true) {
> 
> ...here. Besides that:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Since this patchset depends on vtd vfio series and fixes its breakage
> to vhost, I'll pick them up for consistency for next post of vtd vfio
> series as well.
> 
> Thanks,
> 
> -- peterx

Sounds good. It's best to order patches in a way that avoids
breakages even for people that bisect though.
Might require some patch squashing.

-- 
MST
