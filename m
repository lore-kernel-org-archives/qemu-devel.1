Received: from eggs.gnu.org ([2001:4830:134:3::10]:47524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGk4o-0007WC-0R
	for qemu-devel@nongnu.org; Thu, 10 May 2018 07:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGk4k-0001VW-Te
	for qemu-devel@nongnu.org; Thu, 10 May 2018 07:49:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGk4k-0001Ug-OI
	for qemu-devel@nongnu.org; Thu, 10 May 2018 07:49:34 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com> (Yulei
	Zhang's message of "Tue, 10 Apr 2018 14:03:13 +0800")
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
Reply-To: quintela@redhat.com
Date: Thu, 10 May 2018 13:51:45 +0200
Message-ID: <8736yz3ezy.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, kwankhede@nvidia.com, zhi.a.wang@intel.com, alex.williamson@redhat.com, dgilbert@redhat.com

Yulei Zhang <yulei.zhang@intel.com> wrote:
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

[...]

> +static uint64_t vfio_dirty_log_sync(VFIOPCIDevice *vdev)
> +{
> +    RAMBlock *block;
> +    struct vfio_device_get_dirty_bitmap *d;
> +    uint64_t page = 0;
> +    ram_addr_t size;
> +    unsigned long nr, bitmap;
> +
> +    RAMBLOCK_FOREACH(block) {

BTW, you are asking to sync all blocks of memory?  Does vfio needs it?
Things like acpi tables, or similar weird blocks looks strange, no?

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

Are you sure that this are the number of dirty pages?  It looks to me to
the total number of pages in the region, no?

> +        }
> +        g_free(d);
> +    }
> +
> +exit:
> +    return page;
> +}

You walk the whole RAM on each bitmap.  Could it be possible that driver
knows _what_ memory regions it can have dirty pages on?


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

As said in other emails, this is not for iterative migration, see how we
do for ram (I have simplified it a bit):

static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
                             uint64_t *res_precopy_only,
                             uint64_t *res_compatible,
                             uint64_t *res_postcopy_only)
{
    RAMState **temp = opaque;
    RAMState *rs = *temp;
    uint64_t remaining_size;

    remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;

    if (remaining_size < max_size) {
        qemu_mutex_lock_iothread();
        rcu_read_lock();
        migration_bitmap_sync(rs);
        rcu_read_unlock();
        qemu_mutex_unlock_iothread();
        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
    }

    *res_precopy_only += remaining_size;
}

I.e. we only do the sync stage if we don't have enough dirty pages on
the bitmap.

BTW, once that we are here, independently of this, perhaps we should
change the "sync" to take functions for each ramblock instead of for
the whole ram.

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

As said before, I would suggest that you add several fields:
- VERSION: So you can make incopatible changes
- FLAGS: compatible changes
- SIZE of the region?  Rest of QEMU don't have it, I consider it an
  error.  Having it makes way easier to analyze the stream and seach for errors.

> +    /* retore pci bar configuration */
> +    ctl = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          ctl & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);

Please forgive my pci ignorance, but are we really want to store the pci
configuration every time that we receive an iteration stage?

> +    for (i = 0; i < PCI_ROM_SLOT; i++) {

Is this PCI_ROM_SLOT fixed by some spec or should we transfer it?

> +        bar_cfg = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar_cfg, 4);
> +    }
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          ctl | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
> +
> +    /* restore msi configuration */
> +    ctl = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +    msi_64bit = !!(ctl & PCI_MSI_FLAGS_64BIT);

old experence show this is a bad idea.  See all the ifdefs for 32/64 bit
on target/i386/machine.c

I really suggest to store on the stream a bool with msi_64bit value and
send dummy values for 32bit mode and do nothing on destination.  The
simpler is your stream, the less bugs that you end with.


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
> +    g_free(buf);
> +
> +exit:
> +    return 0;
> +}

BTW, this looks easy to do with vmstate, no need to use save_live for this.


> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> +{
> +    qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);

I think it would be a good idea that it would be a good idea that you do
the malloc() here.  Failing migration on completion for a memory error
in the completion stage is considered rude O:-)

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

Seing what you are doing, I will put your configuration data here on the
vmsd, and will only left the dirty pages/log handrinng for the register_savevm.

Or you can search for inspiration in virtio log handling.  If you are
just using ram, you don't need to transfer anything, you just need to
make sure that you are called when the memory dirty bit is updated so
you can add your log.

Later, Juan.
