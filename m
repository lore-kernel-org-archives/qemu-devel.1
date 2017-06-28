Received: from eggs.gnu.org ([2001:4830:134:3::10]:38025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dQ65N-0007Yc-2J
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dQ65J-0005pn-Og
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:04:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:61713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1dQ65J-0005p4-EW
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:04:17 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 28 Jun 2017 06:04:10 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D1956B@SHSMSX101.ccr.corp.intel.com>
References: <1491301684-24367-1-git-send-email-yulei.zhang@intel.com>
	<20170626141906.6e38b235@w520.home>
	<01FDBDDE256B79498DC57789713132D469DCC1EE@SHSMSX101.ccr.corp.intel.com>
	<20170627134431.5947c771@w520.home>
In-Reply-To: <20170627134431.5947c771@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 5/5] vifo: introduce new VFIO ioctl
 VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "Zhang, Yulei" <yulei.zhang@intel.com>
Cc: "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Zheng, Xiao" <xiao.zheng@intel.com>, "Wang, Zhi
	A" <zhi.a.wang@intel.com>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, June 28, 2017 3:45 AM
>=20
> On Tue, 27 Jun 2017 08:56:01 +0000
> "Zhang, Yulei" <yulei.zhang@intel.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Qemu-devel [mailto:qemu-devel-
> > > bounces+yulei.zhang=3Dintel.com@nongnu.org] On Behalf Of Alex
> Williamson
> > > Sent: Tuesday, June 27, 2017 4:19 AM
> > > To: Zhang, Yulei <yulei.zhang@intel.com>
> > > Cc: Tian, Kevin <kevin.tian@intel.com>; joonas.lahtinen@linux.intel.c=
om;
> > > qemu-devel@nongnu.org; zhenyuw@linux.intel.com; Zheng, Xiao
> > > <xiao.zheng@intel.com>; Wang, Zhi A <zhi.a.wang@intel.com>
> > > Subject: Re: [Qemu-devel] [RFC 5/5] vifo: introduce new VFIO ioctl
> > > VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
> > >
> > > On Tue,  4 Apr 2017 18:28:04 +0800
> > > Yulei Zhang <yulei.zhang@intel.com> wrote:
> > >
> > > > New VFIO ioctl VFIO_DEVICE_PCI_GET_DIRTY_BITMAP is used to sync
> the
> > > > pci device dirty pages during the migration.
> > >
> > > If this needs to exist, it needs a lot more documentation.  Why is th=
is
> > > a PCI specific device ioctl?  Couldn't any vfio device need this?
> > >
> > > > Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> > > > ---
> > > >  hw/vfio/pci.c              | 32 ++++++++++++++++++++++++++++++++
> > > >  hw/vfio/pci.h              |  2 ++
> > > >  linux-headers/linux/vfio.h | 14 ++++++++++++++
> > > >  3 files changed, 48 insertions(+)
> > > >
> > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > > index 833cd90..64c851f 100644
> > > > --- a/hw/vfio/pci.c
> > > > +++ b/hw/vfio/pci.c
> > > > @@ -32,6 +32,7 @@
> > > >  #include "pci.h"
> > > >  #include "trace.h"
> > > >  #include "qapi/error.h"
> > > > +#include "exec/ram_addr.h"
> > > >
> > > >  #define MSIX_CAP_LENGTH 12
> > > >
> > > > @@ -39,6 +40,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice
> > > *vdev);
> > > >  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool
> enabled);
> > > >  static VMStateDescription vfio_pci_vmstate;
> > > >  static void vfio_vm_change_state_handler(void *pv, int running,
> RunState
> > > state);
> > > > +static void vfio_log_sync(MemoryListener *listener,
> > > MemoryRegionSection *section);
> > > >
> > > >  /*
> > > >   * Disabling BAR mmaping can be slow, but toggling it around INTx =
can
> > > > @@ -2869,6 +2871,11 @@ static void vfio_realize(PCIDevice *pdev,
> Error
> > > **errp)
> > > >      vfio_setup_resetfn_quirk(vdev);
> > > >
> qemu_add_vm_change_state_handler(vfio_vm_change_state_handler,
> > > vdev);
> > > >
> > > > +    vdev->vfio_memory_listener =3D (MemoryListener) {
> > > > +	    .log_sync =3D vfio_log_sync,
> > > > +    };
> > > > +    memory_listener_register(&vdev->vfio_memory_listener,
> > > &address_space_memory);
> > > > +
> > > >      return;
> > > >
> > > >  out_teardown:
> > > > @@ -2964,6 +2971,7 @@ static void
> vfio_vm_change_state_handler(void
> > > *pv, int running, RunState state)
> > > >      if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET,
> vfio_status))
> > > {
> > > >          error_report("vfio: Failed to %s device\n", running ? "sta=
rt" :
> "stop");
> > > >      }
> > > > +    vdev->device_stop =3D running ? false : true;
> > > >      g_free(vfio_status);
> > > >  }
> > > >
> > > > @@ -3079,6 +3087,30 @@ static int vfio_device_get(QEMUFile *f, void
> *pv,
> > > size_t size, VMStateField *fie
> > > >      return 0;
> > > >  }
> > > >
> > > > +static void vfio_log_sync(MemoryListener *listener,
> > > MemoryRegionSection *section)
> > > > +{
> > > > +    VFIOPCIDevice *vdev =3D container_of(listener, struct VFIOPCID=
evice,
> > > vfio_memory_listener);
> > > > +
> > > > +    if (vdev->device_stop) {
> > > > +        struct vfio_pci_get_dirty_bitmap *d;
> > > > +        ram_addr_t size =3D int128_get64(section->size);
> > > > +        unsigned long page_nr =3D size >> TARGET_PAGE_BITS;
> > > > +        unsigned long bitmap_size =3D (BITS_TO_LONGS(page_nr) + 1)=
 *
> > > sizeof(unsigned long);
> > > > +        d =3D g_malloc0(sizeof(*d) + bitmap_size);
> > > > +        d->start_addr =3D section->offset_within_address_space;
> > > > +        d->page_nr =3D page_nr;
> > > > +
> > > > +        if (ioctl(vdev->vbasedev.fd,
> VFIO_DEVICE_PCI_GET_DIRTY_BITMAP, d))
> > > {
> > > > +            error_report("vfio: Failed to fetch dirty pages for mi=
gration\n");
> > > > +            goto exit;
> > > > +        }
> > > > +        cpu_physical_memory_set_dirty_lebitmap((unsigned long*)&d-
> > > >dirty_bitmap, d->start_addr, d->page_nr);
> > > > +
> > > > +exit:
> > > > +        g_free(d);
> > > > +    }
> > > > +}
> > > > +
> > > >  static void vfio_instance_init(Object *obj)
> > > >  {
> > > >      PCIDevice *pci_dev =3D PCI_DEVICE(obj);
> > > > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > > > index bd98618..984391d 100644
> > > > --- a/hw/vfio/pci.h
> > > > +++ b/hw/vfio/pci.h
> > > > @@ -144,6 +144,8 @@ typedef struct VFIOPCIDevice {
> > > >      bool no_kvm_intx;
> > > >      bool no_kvm_msi;
> > > >      bool no_kvm_msix;
> > > > +    bool device_stop;
> > > > +    MemoryListener vfio_memory_listener;
> > > >  } VFIOPCIDevice;
> > > >
> > > >  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int =
len);
> > > > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.=
h
> > > > index fa17848..aa73ee1 100644
> > > > --- a/linux-headers/linux/vfio.h
> > > > +++ b/linux-headers/linux/vfio.h
> > > > @@ -502,6 +502,20 @@ struct vfio_pci_status_set{
> > > >
> > > >  #define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE +
> 14)
> > > >
> > > > +/**
> > > > + * VFIO_DEVICE_PCI_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE,
> VFIO_BASE +
> > > 15,
> > > > + *				    struct vfio_pci_get_dirty_bitmap)
> > > > + *
> > > > + * Return: 0 on success, -errno on failure.
> > > > + */
> > > > +struct vfio_pci_get_dirty_bitmap{
> > > > +	__u64	       start_addr;
> > > > +	__u64	       page_nr;
> > > > +	__u8           dirty_bitmap[];
> > > > +};
> > > > +
> > > > +#define VFIO_DEVICE_PCI_GET_DIRTY_BITMAP _IO(VFIO_TYPE,
> VFIO_BASE
> > > + 15)
> > > > +
> > >
> > > Dirty since when?  Since the last time we asked?  Since the device wa=
s
> > > stopped?  Why is anything dirtied after the device is stopped?  Is th=
is
> > > any pages the device has ever touched?  Thanks,
> > >
> > > Alex
> > Dirty since the device start operation and before it was stopped. We tr=
ack
> > down all the guest pages that device was using before it was stopped, a=
nd
> > leverage this dirty bitmap for page sync during migration.
>=20
> I don't understand how this is useful or efficient.  This implies that
> the device is always tracking dirtied pages even when we don't care
> about migration.  Don't we want to enable dirty logging at some point
> and track dirty pages since then?  Otherwise we can just assume the
> device dirties all pages and get rid of this ioctl.  Thanks,
>=20

Agree. Regarding to interface definition we'd better follow general
dirty logging scheme as Alex pointed out, possibly through another
ioctl cmd to enable/disable logging. However vendor specific=20
implementation may choose to ignore the cmd while always tracking=20
dirty pages, as on Intel Processor Graphics. Below is some background.

CPU dirty logging is done through either CPU page fault or HW dirty
bit logging (e.g. Intel PML). However there is a gap in DMA side today.=20
DMA page fault requires both IOMMU and device support (through=20
PCI ATS/PRS), which is not widely available today and mostly for=20
special types of workloads (e.g. Shared Virtual Memory). Regarding
to dirty bit, at least VTd doesn't support it today.

So the alternative option is to rely on mediation layer to track the
dirty pages, since workload submissions on vGPU are mediated. It's
feasible for simple devices such as NIC, which has a clear definition
of descriptors so it's easy to scan and capture which pages will be
dirtied. However doing same thing for complex GPU (meaning
to scan all GPU commands, shader instructions, indirect structures,=20
etc.) is weigh too complex and insufficient. Today we only scan
privileged commands for security purpose which is only a very=20
small portion of all possible cmd set.

Then in reality we choose a simplified approach. instead of tracking
incrementally dirtied pages since last query, we treat all pages which
are currently mapped in GPU page tables as dirtied. To avoid overhead
of walking global page table (GGTT) and all active per-process page
tables (PPGTTs) upon query, we choose to always maintain a bitmap=20
which is updated when mediating guest updates to those GTT entries.=20
It adds negligible overhead at run-time since those operations are=20
already mediated.

Every time when Qemu tries to query dirty map, it likely will get
a similar large dirty bitmap (not exactly same since GPU page tables
are being changed) then will exit iterative memory copy very soon,
which will ends up like below:

1st round: Qemu copies all the memory (say 4GB) to another machine
2nd round: Qemu queries vGPU dirty map (usually in several hundreds
of MBs) and combine with CPU dirty map to copy
3rd round: Qemu will get similar size of dirty pages then exit the=20
pre-copy phase since dirty set doesn't converge

Although it's not that efficient, no need to stop service for whole 4GB
memory copy still saves a lot. In our measurement the service=20
shutdown time is ~300ms over 10Gb link when running 3D benchmarks
(e.g. 3DMark, Heaven, etc.) and media transcoding workloads, while
copying whole system memory may easily take seconds to trigger TDR.
though service shutdown time is bigger than usual server-based scenario,
it's somehow OK for interactive usages (e.g. VDI) or offline transcoding=20
usages. You may take a look at our demo at:

https://www.youtube.com/watch?v=3Dy2SkU5JODIY

In a nutshell, our current dirty logging implementation is a bit
awkward due to arch limitation, but it does work well for some=20
scenarios. Most importantly I agree we should design interface=20
in a more general way to enable/disable dirty logging as stated
earlier.

Hope above makes the whole background clearer. :-)

Thanks
Kevin
