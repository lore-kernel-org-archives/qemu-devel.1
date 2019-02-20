Received: from eggs.gnu.org ([209.51.188.92]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwPZk-0007d6-6y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwPZi-0003WD-71
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwPZg-0003Ph-67
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:58:02 -0500
Date: Wed, 20 Feb 2019 10:57:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190220105734.GC2608@work-vm>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<1550566347-3648-1-git-send-email-yan.y.zhao@intel.com>
	<20190219110144.GA2941@work-vm>
	<20190220051232.GA16456@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220051232.GA16456@joy-OptiPlex-7040>
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com, alex.williamson@redhat.com, intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com

* Zhao Yan (yan.y.zhao@intel.com) wrote:
> On Tue, Feb 19, 2019 at 11:01:45AM +0000, Dr. David Alan Gilbert wrote:
> > * Yan Zhao (yan.y.zhao@intel.com) wrote:

<snip>

> > > +    msi_data = qemu_get_be32(f);
> > > +    vfio_pci_write_config(pdev,
> > > +            pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> > > +            msi_data, 2);
> > > +
> > > +    vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> > > +            ctl | PCI_MSI_FLAGS_ENABLE, 2);
> > 
> > It would probably be best to use a VMStateDescription and the macros
> > for this if possible; I bet you'll want to add more fields in the future
> > for example.
> yes, it is also a good idea to use VMStateDescription for pci general
> config data, which are saved one time in stop-and-copy phase.
> But it's a little hard to maintain two type of interfaces.
> Maybe use the way as what VMStateDescription did, i.e. using field list and
> macros?

Maybe, but if you can actually use the VMStateDescription it would give
you the versioning and conditional fields and things like that.

> > Also what happens if the data read from the migration stream is bad or
> > doesn't agree with this devices hardware? How does this fail?
> >
> right, errors in migration stream needs to be checked. I'll add the error
> check.
> For the hardware incompatiable issue, seems vfio_pci_write_config does not
> return error if device driver returns error for this write.

It would be great if we could make that fail properly.

> Seems it needs to be addressed in somewhere else like checking
> compitibility before lauching migration.

That would be good; but we should still guard against it being wrong
if possible - these type of checks for compatibility are probably quite
difficult.

Dave

> > > +}
> > > +
> > > +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> > > +{
> > > +    VFIOPCIDevice *vdev = opaque;
> > > +    int flag;
> > > +    uint64_t len;
> > > +    int ret = 0;
> > > +
> > > +    if (version_id != VFIO_DEVICE_STATE_INTERFACE_VERSION) {
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    do {
> > > +        flag = qemu_get_byte(f);
> > > +
> > > +        switch (flag & ~VFIO_SAVE_FLAG_CONTINUE) {
> > > +        case VFIO_SAVE_FLAG_SETUP:
> > > +            break;
> > > +        case VFIO_SAVE_FLAG_PCI:
> > > +            vfio_pci_load_config(vdev, f);
> > > +            break;
> > > +        case VFIO_SAVE_FLAG_DEVCONFIG:
> > > +            len = qemu_get_be64(f);
> > > +            vfio_load_data_device_config(vdev, f, len);
> > > +            break;
> > > +        default:
> > > +            ret = -EINVAL;
> > > +        }
> > > +    } while (flag & VFIO_SAVE_FLAG_CONTINUE);
> > > +
> > > +    return ret;
> > > +}
> > > +
> > > +static void vfio_pci_save_config(VFIOPCIDevice *vdev, QEMUFile *f)
> > > +{
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    uint32_t msi_cfg, msi_lo, msi_hi, msi_data, bar_cfg, i;
> > > +    bool msi_64bit;
> > > +
> > > +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > +        bar_cfg = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> > > +        qemu_put_be32(f, bar_cfg);
> > > +    }
> > > +
> > > +    msi_cfg = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> > > +    msi_64bit = !!(msi_cfg & PCI_MSI_FLAGS_64BIT);
> > > +
> > > +    msi_lo = pci_default_read_config(pdev,
> > > +            pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> > > +    qemu_put_be32(f, msi_lo);
> > > +
> > > +    if (msi_64bit) {
> > > +        msi_hi = pci_default_read_config(pdev,
> > > +                pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> > > +                4);
> > > +        qemu_put_be32(f, msi_hi);
> > > +    }
> > > +
> > > +    msi_data = pci_default_read_config(pdev,
> > > +            pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> > > +            2);
> > > +    qemu_put_be32(f, msi_data);
> > > +
> > > +}
> > > +
> > > +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> > > +{
> > > +    VFIOPCIDevice *vdev = opaque;
> > > +    int rc = 0;
> > > +
> > > +    qemu_put_byte(f, VFIO_SAVE_FLAG_PCI | VFIO_SAVE_FLAG_CONTINUE);
> > > +    vfio_pci_save_config(vdev, f);
> > > +
> > > +    qemu_put_byte(f, VFIO_SAVE_FLAG_DEVCONFIG);
> > > +    rc += vfio_get_device_config_size(vdev);
> > > +    rc += vfio_save_data_device_config(vdev, f);
> > > +
> > > +    return rc;
> > > +}
> > > +
> > > +static int vfio_save_setup(QEMUFile *f, void *opaque)
> > > +{
> > > +    VFIOPCIDevice *vdev = opaque;
> > > +    qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);
> > > +
> > > +    vfio_set_device_state(vdev, VFIO_DEVICE_STATE_RUNNING |
> > > +            VFIO_DEVICE_STATE_LOGGING);
> > > +    return 0;
> > > +}
> > > +
> > > +static int vfio_load_setup(QEMUFile *f, void *opaque)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static void vfio_save_cleanup(void *opaque)
> > > +{
> > > +    VFIOPCIDevice *vdev = opaque;
> > > +    uint32_t dev_state = vdev->migration->device_state;
> > > +
> > > +    dev_state &= ~VFIO_DEVICE_STATE_LOGGING;
> > > +
> > > +    vfio_set_device_state(vdev, dev_state);
> > > +}
> > > +
> > > +static SaveVMHandlers savevm_vfio_handlers = {
> > > +    .save_setup = vfio_save_setup,
> > > +    .save_live_pending = vfio_save_live_pending,
> > > +    .save_live_iterate = vfio_save_iterate,
> > > +    .save_live_complete_precopy = vfio_save_complete_precopy,
> > > +    .save_cleanup = vfio_save_cleanup,
> > > +    .load_setup = vfio_load_setup,
> > > +    .load_state = vfio_load_state,
> > > +};
> > > +
> > > +int vfio_migration_init(VFIOPCIDevice *vdev, Error **errp)
> > > +{
> > > +    int ret;
> > > +    Error *local_err = NULL;
> > > +    vdev->migration = g_new0(VFIOMigration, 1);
> > > +
> > > +    if (vfio_device_state_region_setup(vdev,
> > > +              &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL],
> > > +              VFIO_REGION_SUBTYPE_DEVICE_STATE_CTL,
> > > +              "device-state-ctl")) {
> > > +        goto error;
> > > +    }
> > > +
> > > +    if (vfio_check_devstate_version(vdev)) {
> > > +        goto error;
> > > +    }
> > > +
> > > +    if (vfio_get_device_data_caps(vdev)) {
> > > +        goto error;
> > > +    }
> > > +
> > > +    if (vfio_device_state_region_setup(vdev,
> > > +              &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_CONFIG],
> > > +              VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_CONFIG,
> > > +              "device-state-data-device-config")) {
> > > +        goto error;
> > > +    }
> > > +
> > > +    if (vfio_device_data_cap_device_memory(vdev)) {
> > > +        error_report("No suppport of data cap device memory Yet");
> > > +        goto error;
> > > +    }
> > > +
> > > +    if (vfio_device_data_cap_system_memory(vdev) &&
> > > +            vfio_device_state_region_setup(vdev,
> > > +              &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_BITMAP],
> > > +              VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_DIRTYBITMAP,
> > > +              "device-state-data-dirtybitmap")) {
> > > +        goto error;
> > > +    }
> > > +
> > > +    vdev->migration->device_state = VFIO_DEVICE_STATE_RUNNING;
> > > +
> > > +    register_savevm_live(NULL, TYPE_VFIO_PCI, -1,
> > > +            VFIO_DEVICE_STATE_INTERFACE_VERSION,
> > > +            &savevm_vfio_handlers,
> > > +            vdev);
> > > +
> > > +    vdev->migration->vm_state =
> > > +        qemu_add_vm_change_state_handler(vfio_vm_change_state_handler, vdev);
> > > +
> > > +    return 0;
> > > +error:
> > > +    error_setg(&vdev->migration_blocker,
> > > +            "VFIO device doesn't support migration");
> > > +    ret = migrate_add_blocker(vdev->migration_blocker, &local_err);
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        error_free(vdev->migration_blocker);
> > > +    }
> > > +
> > > +    g_free(vdev->migration);
> > > +    vdev->migration = NULL;
> > > +
> > > +    return ret;
> > > +}
> > > +
> > > +void vfio_migration_finalize(VFIOPCIDevice *vdev)
> > > +{
> > > +    if (vdev->migration) {
> > > +        int i;
> > > +        qemu_del_vm_change_state_handler(vdev->migration->vm_state);
> > > +        unregister_savevm(NULL, TYPE_VFIO_PCI, vdev);
> > > +        for (i = 0; i < VFIO_DEVSTATE_REGION_NUM; i++) {
> > > +            vfio_region_finalize(&vdev->migration->region[i]);
> > > +        }
> > > +        g_free(vdev->migration);
> > > +        vdev->migration = NULL;
> > > +    } else if (vdev->migration_blocker) {
> > > +        migrate_del_blocker(vdev->migration_blocker);
> > > +        error_free(vdev->migration_blocker);
> > > +    }
> > > +}
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index c0cb1ec..b8e006b 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -37,7 +37,6 @@
> > >  
> > >  #define MSIX_CAP_LENGTH 12
> > >  
> > > -#define TYPE_VFIO_PCI "vfio-pci"
> > >  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> > >  
> > >  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
> > > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > > index b1ae4c0..4b7b1bb 100644
> > > --- a/hw/vfio/pci.h
> > > +++ b/hw/vfio/pci.h
> > > @@ -19,6 +19,7 @@
> > >  #include "qemu/event_notifier.h"
> > >  #include "qemu/queue.h"
> > >  #include "qemu/timer.h"
> > > +#include "sysemu/sysemu.h"
> > >  
> > >  #define PCI_ANY_ID (~0)
> > >  
> > > @@ -56,6 +57,21 @@ typedef struct VFIOBAR {
> > >      QLIST_HEAD(, VFIOQuirk) quirks;
> > >  } VFIOBAR;
> > >  
> > > +enum {
> > > +    VFIO_DEVSTATE_REGION_CTL = 0,
> > > +    VFIO_DEVSTATE_REGION_DATA_CONFIG,
> > > +    VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY,
> > > +    VFIO_DEVSTATE_REGION_DATA_BITMAP,
> > > +    VFIO_DEVSTATE_REGION_NUM,
> > > +};
> > > +typedef struct VFIOMigration {
> > > +    VFIORegion region[VFIO_DEVSTATE_REGION_NUM];
> > > +    uint32_t data_caps;
> > > +    uint32_t device_state;
> > > +    uint64_t devconfig_size;
> > > +    VMChangeStateEntry *vm_state;
> > > +} VFIOMigration;
> > > +
> > >  typedef struct VFIOVGARegion {
> > >      MemoryRegion mem;
> > >      off_t offset;
> > > @@ -132,6 +148,8 @@ typedef struct VFIOPCIDevice {
> > >      VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
> > >      VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
> > >      void *igd_opregion;
> > > +    VFIOMigration *migration;
> > > +    Error *migration_blocker;
> > >      PCIHostDeviceAddress host;
> > >      EventNotifier err_notifier;
> > >      EventNotifier req_notifier;
> > > @@ -198,5 +216,10 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> > >  void vfio_display_reset(VFIOPCIDevice *vdev);
> > >  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> > >  void vfio_display_finalize(VFIOPCIDevice *vdev);
> > > -
> > > +bool vfio_device_data_cap_system_memory(VFIOPCIDevice *vdev);
> > > +bool vfio_device_data_cap_device_memory(VFIOPCIDevice *vdev);
> > > +int vfio_set_dirty_page_bitmap(VFIOPCIDevice *vdev,
> > > +         uint64_t start_addr, uint64_t page_nr);
> > > +int vfio_migration_init(VFIOPCIDevice *vdev, Error **errp);
> > > +void vfio_migration_finalize(VFIOPCIDevice *vdev);
> > >  #endif /* HW_VFIO_VFIO_PCI_H */
> > > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > > index 1b434d0..ed43613 100644
> > > --- a/include/hw/vfio/vfio-common.h
> > > +++ b/include/hw/vfio/vfio-common.h
> > > @@ -32,6 +32,7 @@
> > >  #endif
> > >  
> > >  #define VFIO_MSG_PREFIX "vfio %s: "
> > > +#define TYPE_VFIO_PCI "vfio-pci"
> > >  
> > >  enum {
> > >      VFIO_DEVICE_TYPE_PCI = 0,
> > > -- 
> > > 2.7.4
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > _______________________________________________
> > intel-gvt-dev mailing list
> > intel-gvt-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
