Received: from eggs.gnu.org ([2001:4830:134:3::10]:54996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dWupm-0004gh-Pc
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 21:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dWupl-00027E-Mv
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 21:28:26 -0400
Date: Mon, 17 Jul 2017 09:28:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170717012809.GO27284@pxdev.xzpeter.org>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-7-git-send-email-eric.auger@redhat.com>
	<20170714021733.GA27284@pxdev.xzpeter.org>
	<AM5PR0401MB2545B52A31CCA827DB3EE5A79AAD0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM5PR0401MB2545B52A31CCA827DB3EE5A79AAD0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio-iommu: Implement the
 translation and commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>
Cc: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Fri, Jul 14, 2017 at 06:40:34AM +0000, Bharat Bhushan wrote:
> Hi Peter,
> 
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, July 14, 2017 7:48 AM
> > To: Eric Auger <eric.auger@redhat.com>
> > Cc: eric.auger.pro@gmail.com; peter.maydell@linaro.org;
> > alex.williamson@redhat.com; mst@redhat.com; qemu-arm@nongnu.org;
> > qemu-devel@nongnu.org; jean-philippe.brucker@arm.com;
> > wei@redhat.com; kevin.tian@intel.com; Bharat Bhushan
> > <bharat.bhushan@nxp.com>; marc.zyngier@arm.com; tn@semihalf.com;
> > will.deacon@arm.com; drjones@redhat.com; robin.murphy@arm.com;
> > christoffer.dall@linaro.org
> > Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio-iommu: Implement the
> > translation and commands
> > 
> > On Wed, Jun 07, 2017 at 06:01:25PM +0200, Eric Auger wrote:
> > > This patch adds the actual implementation for the translation routine
> > > and the virtio-iommu commands.
> > >
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > 
> > [...]
> > 
> > >  static int virtio_iommu_attach(VirtIOIOMMU *s,
> > >                                 struct virtio_iommu_req_attach *req)
> > > @@ -95,10 +135,34 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> > >      uint32_t asid = le32_to_cpu(req->address_space);
> > >      uint32_t devid = le32_to_cpu(req->device);
> > >      uint32_t reserved = le32_to_cpu(req->reserved);
> > > +    viommu_as *as;
> > > +    viommu_dev *dev;
> > >
> > >      trace_virtio_iommu_attach(asid, devid, reserved);
> > >
> > > -    return VIRTIO_IOMMU_S_UNSUPP;
> > > +    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
> > > +    if (dev) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
> > > +    if (!as) {
> > > +        as = g_malloc0(sizeof(*as));
> > > +        as->id = asid;
> > > +        as->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
> > > +                                         NULL, NULL, (GDestroyNotify)g_free);
> > > +        g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
> > > +        trace_virtio_iommu_new_asid(asid);
> > > +    }
> > > +
> > > +    dev = g_malloc0(sizeof(*dev));
> > > +    dev->as = as;
> > > +    dev->id = devid;
> > > +    as->nr_devices++;
> > > +    trace_virtio_iommu_new_devid(devid);
> > > +    g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);
> > 
> > Here do we need to record something like a refcount for address space?
> > Since...
> 
> We are using "nr_devices" as number of devices attached to an address-space
> 
> > 
> > > +
> > > +    return VIRTIO_IOMMU_S_OK;
> > >  }
> > >
> > >  static int virtio_iommu_detach(VirtIOIOMMU *s, @@ -106,10 +170,13 @@
> > > static int virtio_iommu_detach(VirtIOIOMMU *s,  {
> > >      uint32_t devid = le32_to_cpu(req->device);
> > >      uint32_t reserved = le32_to_cpu(req->reserved);
> > > +    int ret;
> > >
> > >      trace_virtio_iommu_detach(devid, reserved);
> > >
> > > -    return VIRTIO_IOMMU_S_UNSUPP;
> > > +    ret = g_tree_remove(s->devices, GUINT_TO_POINTER(devid));
> > 
> > ... here when detach, imho we should check the refcount: if there is no
> > device using specific address space, we should release the address space as
> > well.
> > 
> > Otherwise there would have no way to destroy an address space?
> 
> 
> Here if nr_devices == 0 then release the address space, is that ok? 
> 
> This is how I implemented as part of VFIO integration over this patch series.
> 	"[RFC PATCH 2/2] virtio-iommu: vfio integration with virtio-iommu"

Sorry I didn't read that when posting. It is what I mean.  Thanks,

-- 
Peter Xu
