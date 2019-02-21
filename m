Received: from eggs.gnu.org ([209.51.188.92]:60580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwm2G-0005Vs-VH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwm2F-0006HW-Jj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:57:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gwm2F-0006F7-9C
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:56:59 -0500
Date: Thu, 21 Feb 2019 11:56:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190221115646.416df963.cohuck@redhat.com>
In-Reply-To: <20190220225400.GF16456@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<1550566347-3648-1-git-send-email-yan.y.zhao@intel.com>
	<20190219153724.12460160.cohuck@redhat.com>
	<20190220225400.GF16456@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] vfio/migration: support device of
 device config capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org, Zhengxiao.zx@Alibaba-inc.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, kwankhede@nvidia.com, kevin.tian@intel.com, cjia@nvidia.com, arei.gonglei@huawei.com, kvm@vger.kernel.org

On Wed, 20 Feb 2019 17:54:00 -0500
Zhao Yan <yan.y.zhao@intel.com> wrote:

> On Tue, Feb 19, 2019 at 03:37:24PM +0100, Cornelia Huck wrote:
> > On Tue, 19 Feb 2019 16:52:27 +0800
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > Device config is the default data that every device should have. so
> > > device config capability is by default on, no need to set.
> > > 
> > > - Currently two type of resources are saved/loaded for device of device
> > >   config capability:
> > >   General PCI config data, and Device config data.
> > >   They are copies as a whole when precopy is stopped.
> > > 
> > > Migration setup flow:
> > > - Setup device state regions, check its device state version and capabilities.
> > >   Mmap Device Config Region and Dirty Bitmap Region, if available.
> > > - If device state regions are failed to get setup, a migration blocker is
> > >   registered instead.
> > > - Added SaveVMHandlers to register device state save/load handlers.
> > > - Register VM state change handler to set device's running/stop states.
> > > - On migration startup on source machine, set device's state to
> > >   VFIO_DEVICE_STATE_LOGGING
> > > 
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> > > ---
> > >  hw/vfio/Makefile.objs         |   2 +-
> > >  hw/vfio/migration.c           | 633 ++++++++++++++++++++++++++++++++++++++++++
> > >  hw/vfio/pci.c                 |   1 -
> > >  hw/vfio/pci.h                 |  25 +-
> > >  include/hw/vfio/vfio-common.h |   1 +
> > >  5 files changed, 659 insertions(+), 3 deletions(-)
> > >  create mode 100644 hw/vfio/migration.c
> > > 
> > > diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> > > index 8b3f664..f32ff19 100644
> > > --- a/hw/vfio/Makefile.objs
> > > +++ b/hw/vfio/Makefile.objs
> > > @@ -1,6 +1,6 @@
> > >  ifeq ($(CONFIG_LINUX), y)
> > >  obj-$(CONFIG_SOFTMMU) += common.o
> > > -obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
> > > +obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o migration.o  
> > 
> > I think you want to split the migration code: The type-independent
> > code, and the pci-specific code.
> >  
> ok. actually, now only saving/loading of pci generic config data is
> pci-specific. the data getting/setting through device state
> interfaces are type-independent.

Yes. If it has capability chains, it can probably be made to work.

> 
> > >  obj-$(CONFIG_VFIO_CCW) += ccw.o
> > >  obj-$(CONFIG_SOFTMMU) += platform.o
> > >  obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
(...)
> > > +static int vfio_save_data_device_config(VFIOPCIDevice *vdev, QEMUFile *f)
> > > +{
> > > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > > +    VFIORegion *region_ctl =
> > > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > > +    VFIORegion *region_config =
> > > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_CONFIG];
> > > +    void *dest;
> > > +    uint32_t sz;
> > > +    uint8_t *buf = NULL;
> > > +    uint32_t action = VFIO_DEVICE_DATA_ACTION_GET_BUFFER;
> > > +    uint64_t len = vdev->migration->devconfig_size;
> > > +
> > > +    qemu_put_be64(f, len);  
> > 
> > Why big endian? (Generally, do we need any endianness considerations?)
> >   
> I think big endian is the endian for qemu to save file.
> as long as qemu_put and qemu_get use the same endian, it will be no
> problem.
> do you think so?

Yes, as long we are explicit about the endianness. I'm not sure whether
e.g. power even has the ability to mix endianness.

(...)
> > > +static int vfio_set_device_state(VFIOPCIDevice *vdev,
> > > +        uint32_t dev_state)
> > > +{
> > > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > > +    VFIORegion *region =
> > > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > > +    uint32_t sz = sizeof(dev_state);
> > > +
> > > +    if (!vdev->migration) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (pwrite(vbasedev->fd, &dev_state, sz,
> > > +              region->fd_offset +
> > > +              offsetof(struct vfio_device_state_ctl, device_state))
> > > +            != sz) {
> > > +        error_report("vfio: Failed to set device state %d", dev_state);  
> > 
> > Can the kernel reject this if a state transition is not allowed (or are
> > all transitions allowed?)
> >   
> yes, kernel can reject some state transition if it's not allowed.
> But currently all transitions are allowed.
> Maybe a check of self-to-self transition is needed in kernel.

Self-to-self looks benign enough to simply return success early.

> 
> > > +        return -1;
> > > +    }
> > > +    vdev->migration->device_state = dev_state;
> > > +    return 0;
> > > +}
(...)
> > > +static int vfio_check_devstate_version(VFIOPCIDevice *vdev)
> > > +{
> > > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > > +    VFIORegion *region =
> > > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > > +
> > > +    uint32_t version;
> > > +    uint32_t size = sizeof(version);
> > > +
> > > +    if (pread(vbasedev->fd, &version, size,
> > > +                region->fd_offset +
> > > +                offsetof(struct vfio_device_state_ctl, version))
> > > +            != size) {
> > > +        error_report("%s Failed to read version of device state interfaces",
> > > +                vbasedev->name);
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (version != VFIO_DEVICE_STATE_INTERFACE_VERSION) {
> > > +        error_report("%s migration version mismatch, right version is %d",
> > > +                vbasedev->name, VFIO_DEVICE_STATE_INTERFACE_VERSION);  
> > 
> > So, we require an exact match... or should we allow to extend the
> > interface in an backwards-compatible way, in which case we'd require
> > (QEMU interface version) <= (kernel interface version)?
> >  
> currently yes. we can discuss on that.

If we want to allow that, we need to have a strictly monotonous
progression of versions here (which means dragging along old
compatibility code for basically forever). Maintaining a table about
which version is compatible with which other version would get insane
pretty quickly.

Can we somehow accommodate more optional regions via capabilities?
Maybe via optional vmstates?

> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
(...)
> > > +static void vfio_pci_load_config(VFIOPCIDevice *vdev, QEMUFile *f)
> > > +{
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    uint32_t ctl, msi_lo, msi_hi, msi_data, bar_cfg, i;
> > > +    bool msi_64bit;
> > > +
> > > +    /* retore pci bar configuration */
> > > +    ctl = pci_default_read_config(pdev, PCI_COMMAND, 2);
> > > +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > > +            ctl & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
> > > +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > +        bar_cfg = qemu_get_be32(f);
> > > +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar_cfg, 4);
> > > +    }
> > > +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > > +            ctl | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
> > > +
> > > +    /* restore msi configuration */
> > > +    ctl = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> > > +    msi_64bit = !!(ctl & PCI_MSI_FLAGS_64BIT);
> > > +
> > > +    vfio_pci_write_config(&vdev->pdev,
> > > +            pdev->msi_cap + PCI_MSI_FLAGS,
> > > +            ctl & (!PCI_MSI_FLAGS_ENABLE), 2);
> > > +
> > > +    msi_lo = qemu_get_be32(f);
> > > +    vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, msi_lo, 4);
> > > +
> > > +    if (msi_64bit) {
> > > +        msi_hi = qemu_get_be32(f);
> > > +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> > > +                msi_hi, 4);
> > > +    }
> > > +    msi_data = qemu_get_be32(f);
> > > +    vfio_pci_write_config(pdev,
> > > +            pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> > > +            msi_data, 2);
> > > +
> > > +    vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> > > +            ctl | PCI_MSI_FLAGS_ENABLE, 2);
> > > +  
> > 
> > Ok, this function is indeed pci-specific and probably should be moved
> > to the vfio-pci code (other types could hook themselves up in the same
> > place, then).
> >   
> yes, this is the only pci-specific code.
> maybe using VFIO_DEVICE_TYPE_PCI as a sign to decide whether to save/load
> pci config data?
> or as Dave said, put saving/loading of pci config data into
> VMStateDescription interface?

I like having an interface like vmstate where other types can register
themselves better than introducing conditional handling based on
hard-coded type values.
