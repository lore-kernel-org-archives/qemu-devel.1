Received: from eggs.gnu.org ([2001:4830:134:3::10]:37349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f85NI-0005jQ-8n
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f85NF-0007zo-3a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:44:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1f85NE-0007yw-MU
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:44:53 -0400
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <a4bfe3d3-d9a0-565e-800c-c4493e328d87@nvidia.com>
Date: Mon, 16 Apr 2018 20:14:40 +0530
MIME-Version: 1.0
In-Reply-To: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for
 VFIO device to support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, alex.williamson@redhat.com, dgilbert@redhat.com, quintela@redhat.com



On 4/10/2018 11:33 AM, Yulei Zhang wrote:
> Instead of using vm state description, add SaveVMHandlers for VFIO
> device to support live migration.
> 
> Introduce new Ioctl VFIO_DEVICE_GET_DIRTY_BITMAP to fetch the memory
> bitmap that dirtied by vfio device during the iterative precopy stage
> to shorten the system downtime afterward.
> 
> For vfio pci device status migrate, during the system downtime, it will
> save the following states
> 1. pci configuration space addr0~addr5
> 2. pci configuration space msi_addr msi_data
> 3. pci device status fetch from device driver
> 
> And on the target side the vfio_load will restore the same states
> 1. re-setup the pci bar configuration
> 2. re-setup the pci device msi configuration
> 3. restore the pci device status
> 

Can #1 and #2 be setup by vendor driver? Vendor driver knows
capabilities of device and vendor driver can setup rather than have the
restore code in common place and then handle all the capability cases here.


> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  hw/vfio/pci.c              | 195 +++++++++++++++++++++++++++++++++++++++++++--
>  linux-headers/linux/vfio.h |  14 ++++
>  2 files changed, 204 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 13d8c73..ac6a9c7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -33,9 +33,14 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> +#include "migration/register.h"
> +#include "exec/ram_addr.h"
>  
>  #define MSIX_CAP_LENGTH 12
>  
> +#define VFIO_SAVE_FLAG_SETUP 0
> +#define VFIO_SAVE_FLAG_DEV_STATE 1
> +
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>  static void vfio_vm_change_state_handler(void *pv, int running, RunState state);
> @@ -2639,6 +2644,190 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static uint64_t vfio_dirty_log_sync(VFIOPCIDevice *vdev)
> +{
> +    RAMBlock *block;
> +    struct vfio_device_get_dirty_bitmap *d;
> +    uint64_t page = 0;
> +    ram_addr_t size;
> +    unsigned long nr, bitmap;
> +
> +    RAMBLOCK_FOREACH(block) {
> +        size = block->used_length;
> +        nr = size >> TARGET_PAGE_BITS;
> +        bitmap = (BITS_TO_LONGS(nr) + 1) * sizeof(unsigned long);
> +        d = g_malloc0(sizeof(*d) +  bitmap);
> +        d->start_addr = block->offset;
> +        d->page_nr = nr;
> +        if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_DIRTY_BITMAP, d)) {
> +            error_report("vfio: Failed to get device dirty bitmap");
> +            g_free(d);
> +            goto exit;
> +        }
> +
> +        if (d->page_nr) {
> +            cpu_physical_memory_set_dirty_lebitmap(
> +                                 (unsigned long *)&d->dirty_bitmap,
> +                                 d->start_addr, d->page_nr);
> +            page += d->page_nr;
> +        }
> +        g_free(d);
> +    }
> +
> +exit:
> +    return page;
> +}
> +
> +static void vfio_save_live_pending(QEMUFile *f, void *opaque, uint64_t max_size,
> +                   uint64_t *non_postcopiable_pending,
> +                   uint64_t *postcopiable_pending)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    uint64_t pending;
> +
> +    qemu_mutex_lock_iothread();
> +    rcu_read_lock();
> +    pending = vfio_dirty_log_sync(vdev);
> +    rcu_read_unlock();
> +    qemu_mutex_unlock_iothread();
> +    *non_postcopiable_pending += pending;
> +}
> +

This doesn't provide a way to read device's state during pre-copy phase.
device_state region can be used to read device specific data from vendor
driver during pre-copy phase. That could be done by mmap device_state
region during init and then ioctl vendor driver here to query size of
data copied to device_state region and pending data size.


> +static int vfio_load(QEMUFile *f, void *opaque, int version_id)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int sz = vdev->device_state.size - VFIO_DEVICE_STATE_OFFSET;
> +    uint8_t *buf = NULL;
> +    uint32_t ctl, msi_lo, msi_hi, msi_data, bar_cfg, i;
> +    bool msi_64bit;
> +
> +    if (qemu_get_byte(f) == VFIO_SAVE_FLAG_SETUP) {
> +        goto exit;
> +    }
> +
> +    /* retore pci bar configuration */
> +    ctl = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          ctl & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        bar_cfg = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar_cfg, 4);
> +    }
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          ctl | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
> +
> +    /* restore msi configuration */
> +    ctl = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +    msi_64bit = !!(ctl & PCI_MSI_FLAGS_64BIT);
> +
> +    vfio_pci_write_config(&vdev->pdev,
> +                          pdev->msi_cap + PCI_MSI_FLAGS,
> +                          ctl & (!PCI_MSI_FLAGS_ENABLE), 2);
> +
> +    msi_lo = qemu_get_be32(f);
> +    vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, msi_lo, 4);
> +
> +    if (msi_64bit) {
> +        msi_hi = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                              msi_hi, 4);
> +    }
> +    msi_data = qemu_get_be32(f);
> +    vfio_pci_write_config(pdev,
> +              pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +              msi_data, 2);
> +
> +    vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                          ctl | PCI_MSI_FLAGS_ENABLE, 2);
> +
> +    buf = g_malloc(sz);
> +    if (buf == NULL) {
> +        error_report("vfio: Failed to allocate memory for migrate");
> +        return -1;
> +    }
> +
> +    qemu_get_buffer(f, buf, sz);
> +    if (pwrite(vdev->vbasedev.fd, buf, sz,
> +               vdev->device_state.offset + VFIO_DEVICE_STATE_OFFSET) != sz) {
> +        error_report("vfio: Failed to write Device State Region");
> +        return -1;
> +    }
> +

Again here if device_state region in mmaped, QEMU would write buffer to
that region and an ioclt can be used to convey that new data is written
to the region along with size of data.


> +    g_free(buf);
> +
> +exit:
> +    return 0;
> +}
> +
> +static int vfio_save_complete(QEMUFile *f, void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int sz = vdev->device_state.size - VFIO_DEVICE_STATE_OFFSET;
> +    uint8_t *buf = NULL;
> +    uint32_t msi_cfg, msi_lo, msi_hi, msi_data, bar_cfg, i;
> +    bool msi_64bit;
> +
> +    qemu_put_byte(f, VFIO_SAVE_FLAG_DEV_STATE);
> +
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        bar_cfg = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> +        qemu_put_be32(f, bar_cfg);
> +    }
> +
> +    msi_cfg = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +    msi_64bit = !!(msi_cfg & PCI_MSI_FLAGS_64BIT);
> +
> +    msi_lo = pci_default_read_config(pdev,
> +                                     pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> +    qemu_put_be32(f, msi_lo);
> +
> +    if (msi_64bit) {
> +        msi_hi = pci_default_read_config(pdev,
> +                                         pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                         4);
> +        qemu_put_be32(f, msi_hi);
> +    }
> +
> +    msi_data = pci_default_read_config(pdev,
> +               pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +               2);
> +    qemu_put_be32(f, msi_data);
> +
> +    buf = g_malloc(sz);
> +    if (buf == NULL) {
> +        error_report("vfio: Failed to allocate memory for migrate");
> +        goto exit;
> +    }
> +
> +    if (pread(vdev->vbasedev.fd, buf, sz,
> +              vdev->device_state.offset + VFIO_DEVICE_STATE_OFFSET) != sz) {
> +        error_report("vfio: Failed to read Device State Region");
> +        goto exit;
> +    }
> +

Again here getting buffer information from vendor driver and directly
reading that data from mmaped region would help.

> +    qemu_put_buffer(f, buf, sz);
> +
> +exit:
> +    g_free(buf);
> +
> +    return 0;
> +}
> +
> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> +{
> +    qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);
> +    return 0;
> +}
> +
> +static SaveVMHandlers savevm_vfio_handlers = {
> +    .save_setup = vfio_save_setup,
> +    .save_live_pending = vfio_save_live_pending,
> +    .save_live_complete_precopy = vfio_save_complete,
> +    .load_state = vfio_load,
> +};
> +

Isn't .is_active, .save_live_iterate and .cleanup required?
What is vendor driver have large amount of data in device's memory which
vendor driver is aware of? and vendor driver would required multiple
iterations to send that data to QEMU to save complete state of device?

Isn't there should be an ioclt to convey QEMU's MIGRATION_STATUS_* to
vendor driver? Knowing migration status would help vendor driver take
necessary action, like MIGRATION_STATUS_SETUP,
MIGRATION_STATUS_CANCELLED, MIGRATION_STATUS_FAILED,
MIGRATION_STATUS_COMPLETED, I think these are important states that
vendor driver should know.

Thanks,
Kirti

>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> @@ -2898,6 +3087,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
>      qemu_add_vm_change_state_handler(vfio_vm_change_state_handler, vdev);
> +    register_savevm_live(NULL, "vfio-pci", 0, 1, &savevm_vfio_handlers, vdev);
>  
>      return;
>  
> @@ -3051,10 +3241,6 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static const VMStateDescription vfio_pci_vmstate = {
> -    .name = "vfio-pci",
> -};
> -
>  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3062,7 +3248,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  
>      dc->reset = vfio_pci_reset;
>      dc->props = vfio_pci_dev_properties;
> -    dc->vmsd = &vfio_pci_vmstate;
>      dc->desc = "VFIO-based PCI device assignment";
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      pdc->realize = vfio_realize;
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 8f02f2f..2c911d9 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -512,6 +512,20 @@ struct vfio_pci_hot_reset {
>  
>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
>  
> +/**
> + * VFIO_DEVICE_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> + *				    struct vfio_device_get_dirty_bitmap)
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_device_get_dirty_bitmap {
> +	__u64	       start_addr;
> +	__u64	       page_nr;
> +	__u8           dirty_bitmap[];
> +};
> +
> +#define VFIO_DEVICE_GET_DIRTY_BITMAP	_IO(VFIO_TYPE, VFIO_BASE + 14)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**
> 
