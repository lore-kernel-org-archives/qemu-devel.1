Received: from eggs.gnu.org ([2001:4830:134:3::10]:38664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMHuA-00081K-4Z
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMHu6-0001ZQ-TN
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:25:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eMHu6-0001YM-Iv
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:25:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CD0E62E85
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 18:25:13 +0000 (UTC)
Date: Tue, 5 Dec 2017 18:25:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171205182459.GE2405@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<20171129185026.23632-4-dgilbert@redhat.com>
	<20171130164853.2ed19634@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130164853.2ed19634@redhat.com>
Subject: Re: [Qemu-devel] [RFC 3/7] vhost: New memory update functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, mst@redhat.com

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Wed, 29 Nov 2017 18:50:22 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > vhost_update_mem will replace the existing update mechanism.
> > They make use of the Flatview we have now to make the update simpler.
> > This commit just adds the basic structure.
> see below suggestion on dropping vhost_region_add/vhost_region_del
> 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/virtio/vhost.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 938253d1e8..c959a59fb3 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -629,6 +629,43 @@ static void vhost_begin(MemoryListener *listener)
> >      dev->mem_changed_start_addr = -1;
> >  }
> >  
> > +struct vhost_update_mem_tmp {
> > +    struct vhost_dev   *dev;
> > +    uint32_t nregions;
> > +    struct vhost_memory_region *regions;
> > +};
> > +
> > +/* Called for each MRS from vhost_update_mem */
> > +static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
> > +{
> > +    if (!vhost_section(mrs)) {
> > +        return 0;
> > +    }
> > +
> it's possible to move section tracking from vhost_region_add() to here
> 
>     ++dev->n_mem_sections;                                                       
>     dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,          
>                                 dev->n_mem_sections);                            
>     ;[dev->n_mem_sections - 1] = *section;                       
>     memory_region_ref(section->mr);  
> ...
> 
> > +static int vhost_update_mem(struct vhost_dev *dev)
> > +{
> > +    int res;
> > +    struct vhost_update_mem_tmp vtmp;
> > +    vtmp.regions = 0;
> > +    vtmp.nregions = 0;
> > +    vtmp.dev = dev;
>        
>  iterate over dev->mem_sections
>     memory_region_unref(section->mr);
>  g_free(dev->mem_sections)
>  dev->mem_sections = NULL;
> 
> with this you won't need vhost_region_add/del callbacks anymore

Yes, with the addition of a:
   dev->n_mem_sections = 0;

in the deletion bit, that seems to work nicely.  Added.

Thanks,

Dave

> 
> > +
> > +    res = address_space_iterate(&address_space_memory,
> > +                                vhost_update_mem_cb, &vtmp);
> > +    if (res) {
> > +        goto out;
> > +    }
> > +
> > +    /* TODO */
> > +out:
> > +    g_free(vtmp.regions);
> > +    return res;
> > +}
> > +
> >  static void vhost_commit(MemoryListener *listener)
> >  {
> >      struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> > @@ -648,6 +685,10 @@ static void vhost_commit(MemoryListener *listener)
> >          return;
> >      }
> >  
> > +    if (vhost_update_mem(dev)) {
> > +        return;
> > +    }
> > +
> >      if (dev->started) {
> >          start_addr = dev->mem_changed_start_addr;
> >          size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
> > @@ -1523,6 +1564,9 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >          goto fail_features;
> >      }
> >  
> > +    if (vhost_update_mem(hdev)) {
> > +        goto fail_mem;
> > +    }
> >      if (vhost_dev_has_iommu(hdev)) {
> >          memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
> >      }
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
