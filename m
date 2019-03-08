Received: from eggs.gnu.org ([209.51.188.92]:33075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2Grz-00018J-9K
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2Grv-0001Sr-5B
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:53:05 -0500
Date: Fri, 8 Mar 2019 07:52:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190308075257.6c1da245@x1.home>
In-Reply-To: <20190308043456.GU7722@umbus.fritz.box>
References: <20190307050518.64968-1-aik@ozlabs.ru>
	<20190307050518.64968-4-aik@ozlabs.ru>
	<20190307150232.7384b7ce@w520.home>
	<20190308043456.GU7722@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 3/3] spapr: Support NVIDIA V100 GPU
 with NVLink2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

On Fri, 8 Mar 2019 15:34:56 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Mar 07, 2019 at 03:02:32PM -0700, Alex Williamson wrote:
> > On Thu,  7 Mar 2019 16:05:18 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:  
> > > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > > index 40a12001f580..15ec0b4c2723 100644
> > > --- a/hw/vfio/pci-quirks.c
> > > +++ b/hw/vfio/pci-quirks.c
> > > @@ -2180,3 +2180,123 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
> > >  
> > >      return 0;
> > >  }
> > > +
> > > +static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
> > > +                                     const char *name,
> > > +                                     void *opaque, Error **errp)
> > > +{
> > > +    uint64_t tgt = (uint64_t) opaque;
> > > +    visit_type_uint64(v, name, &tgt, errp);
> > > +}
> > > +
> > > +static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
> > > +                                                 const char *name,
> > > +                                                 void *opaque, Error **errp)
> > > +{
> > > +    uint32_t link_speed = (uint32_t)(uint64_t) opaque;
> > > +    visit_type_uint32(v, name, &link_speed, errp);
> > > +}
> > > +
> > > +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
> > > +{
> > > +    int ret;
> > > +    void *p;
> > > +    struct vfio_region_info *nv2region = NULL;
> > > +    struct vfio_info_cap_header *hdr;
> > > +    MemoryRegion *nv2mr = g_malloc0(sizeof(*nv2mr));  
> > 
> > This is leaked in the below error paths and there's no cleanup on
> > finalize.  I assume these devices don't support hotplug, but they could
> > at least use the existing quirk infrastructure so as not to set a bad
> > precedent. 
> >   
> > > +
> > > +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> > > +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> > > +                                   PCI_VENDOR_ID_NVIDIA,
> > > +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
> > > +                                   &nv2region);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    p = mmap(NULL, nv2region->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> > > +             MAP_SHARED, vdev->vbasedev.fd, nv2region->offset);
> > > +
> > > +    if (!p) {
> > > +        return -errno;
> > > +    }  
> > 
> > I think the above suggestion requires simply defining a quirk above:
> > 
> > VFIOQuirk *quirk;
> > 
> > Initializing it with one MemoryRegion here:
> > 
> > quirk = vfio_quirk_alloc(1);
> >   
> > > +
> > > +    memory_region_init_ram_ptr(nv2mr, OBJECT(vdev), "nvlink2-mr",  
> > 
> > s/nv2mr/quirk->mem/
> >   
> > > +                               nv2region->size, p);  
> > 
> > Then adding it to the device, for instance assuming there's always a
> > BAR0, attach it there:
> > 
> > QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> > 
> > At least then it pretends to support cleanup.  
> 
> This does simplify the cleanup of the extra MRs.  It is a bit odd to
> attach it specifically to a BAR that's not otherwise tied to these
> resources (both the NV2 memory and ATSD are special NVLink extensions,
> not attached to a PCI BAR).

Yep, it's not perfect, we could add a list of non-BAR, non-VGA quirks
to the device itself, but I'm not sure it's necessary.  A comment to
track this discontinuity would be nice at least though.  Thanks,

Alex
