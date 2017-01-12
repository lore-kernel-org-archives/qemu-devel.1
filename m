Received: from eggs.gnu.org ([2001:4830:134:3::10]:51202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRgqQ-00037j-Pq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRgqD-0005H1-HF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:59:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRgqD-0005Gd-6Z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:59:01 -0500
Date: Thu, 12 Jan 2017 16:58:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112163519-mutt-send-email-mst@kernel.org>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1479108340-3453-4-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479108340-3453-4-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v7 03/10] pci: Convert msix_init() to Error
 and fix callers to check it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Nov 14, 2016 at 03:25:33PM +0800, Cao jin wrote:
> msix_init() reports errors with error_report(), which is wrong when
> it's used in realize().  The same issue was fixed for msi_init() in
> commit 1108b2f.

Is there some way to trigger this? Markus says "QMP is broken"
so surely one can make it fail somehow?

> 
> For some devices(like e1000e, vmxnet3) who won't fail because of
> msix_init's failure, suppress the error report by passing NULL error object.
> 
> Bonus: add comment for msix_init.
> 
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Dmitry Fleytman <dmitry@daynix.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

So how about making just this API change as small as possible
and I'll merge. Enhancements can then go through other trees.


> ---
>  hw/block/nvme.c        |  5 ++++-
>  hw/misc/ivshmem.c      |  8 ++++----
>  hw/net/e1000e.c        |  6 +++++-
>  hw/net/rocker/rocker.c |  7 ++++++-
>  hw/net/vmxnet3.c       |  8 ++++++--
>  hw/pci/msix.c          | 34 +++++++++++++++++++++++++++++-----
>  hw/scsi/megasas.c      |  5 ++++-
>  hw/usb/hcd-xhci.c      | 13 ++++++++-----
>  hw/vfio/pci.c          |  8 ++++++--
>  hw/virtio/virtio-pci.c | 11 +++++------
>  include/hw/pci/msix.h  |  5 +++--
>  11 files changed, 80 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index d479fd2..2d703c8 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -831,6 +831,7 @@ static int nvme_init(PCIDevice *pci_dev)
>  {
>      NvmeCtrl *n = NVME(pci_dev);
>      NvmeIdCtrl *id = &n->id_ctrl;
> +    Error *err = NULL;
>  
>      int i;
>      int64_t bs_size;
> @@ -872,7 +873,9 @@ static int nvme_init(PCIDevice *pci_dev)
>      pci_register_bar(&n->parent_obj, 0,
>          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>          &n->iomem);
> -    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4);
> +    if (msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, &err)) {
> +        error_report_err(err);
> +    }
>  
>      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
>      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));


This previously ignored errors, so should probably pass in NULL.

> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 230e51b..ca6f804 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -749,13 +749,13 @@ static void ivshmem_reset(DeviceState *d)
>      }
>  }
>  
> -static int ivshmem_setup_interrupts(IVShmemState *s)
> +static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
>  {
>      /* allocate QEMU callback data for receiving interrupts */
>      s->msi_vectors = g_malloc0(s->vectors * sizeof(MSIVector));
>  
>      if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
> -        if (msix_init_exclusive_bar(PCI_DEVICE(s), s->vectors, 1)) {
> +        if (msix_init_exclusive_bar(PCI_DEVICE(s), s->vectors, 1, errp)) {
>              return -1;
>          }
>  
> @@ -897,8 +897,8 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>          qemu_chr_fe_set_handlers(&s->server_chr, ivshmem_can_receive,
>                                   ivshmem_read, NULL, s, NULL, true);
>  
> -        if (ivshmem_setup_interrupts(s) < 0) {
> -            error_setg(errp, "failed to initialize interrupts");
> +        if (ivshmem_setup_interrupts(s, errp) < 0) {
> +            error_prepend(errp, "Failed to initialize interrupts: ");
>              return;
>          }
>      }
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 4994e1c..74cbbef 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -292,7 +292,11 @@ e1000e_init_msix(E1000EState *s)
>                          E1000E_MSIX_IDX, E1000E_MSIX_TABLE,
>                          &s->msix,
>                          E1000E_MSIX_IDX, E1000E_MSIX_PBA,
> -                        0xA0);
> +                        0xA0, NULL);
> +
> +    /* Any error other than -ENOTSUP(board's MSI support is broken)
> +     * is a programming error. Fall back to INTx silently on -ENOTSUP */
> +    assert(!res || res == -ENOTSUP);
>  
>      if (res < 0) {
>          trace_e1000e_msix_init_fail(res);

I'd rather move these asserts to a separate patch as noted below.

> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index e9d215a..8f829f2 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1256,14 +1256,19 @@ static int rocker_msix_init(Rocker *r)
>  {
>      PCIDevice *dev = PCI_DEVICE(r);
>      int err;
> +    Error *local_err = NULL;
>  
>      err = msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
>                      &r->msix_bar,
>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSET,
>                      &r->msix_bar,
>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
> -                    0);
> +                    0, &local_err);
> +    /* Any error other than -ENOTSUP(board's MSI support is broken)
> +     * is a programming error. */
> +    assert(!err || err == -ENOTSUP);
>      if (err) {
> +        error_report_err(local_err);
>          return err;
>      }
>  

I'd rather move these asserts to a separate patch as noted below.

> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 92f6af9..a433cc0 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2191,10 +2191,14 @@ vmxnet3_init_msix(VMXNET3State *s)
>                          VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_TABLE,
>                          &s->msix_bar,
>                          VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
> -                        VMXNET3_MSIX_OFFSET(s));
> +                        VMXNET3_MSIX_OFFSET(s), NULL);
> +
> +    /* Any error other than -ENOTSUP(board's MSI support is broken)
> +     * is a programming error. Fall back to INTx on -ENOTSUP */
> +    assert(!res || res == -ENOTSUP);
>  
>      if (0 > res) {
> -        VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
> +        VMW_WRPRN("Failed to initialize MSI-X, board's MSI support is broken");
>          s->msix_used = false;
>      } else {
>          if (!vmxnet3_use_msix_vectors(s, VMXNET3_MAX_INTRS)) {

I'd rather move these changes to a separate patch.

> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 0cee631..d03016f 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -21,6 +21,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/xen/xen.h"
>  #include "qemu/range.h"
> +#include "qapi/error.h"
>  
>  #define MSIX_CAP_LENGTH 12
>  
> @@ -238,11 +239,29 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
>      }
>  }
>  
> -/* Initialize the MSI-X structures */
> +/* Make PCI device @dev MSI-X capable
> + * @nentries is the max number of MSI-X vectors that the device support.
> + * @table_bar is the MemoryRegion that MSI-X table structure resides.
> + * @table_bar_nr is number of base address register corresponding to @table_bar.
> + * @table_offset indicates the offset that the MSI-X table structure starts with
> + * in @table_bar.
> + * @pba_bar is the MemoryRegion that the Pending Bit Array structure resides.
> + * @pba_bar_nr is number of base address register corresponding to @pba_bar.
> + * @pba_offset indicates the offset that the Pending Bit Array structure
> + * starts with in @pba_bar.
> + * Non-zero @cap_pos puts capability MSI-X at that offset in PCI config space.
> + * @errp is for returning errors.
> + *
> + * Return 0 on success; set @errp and return -errno on error:
> + * -ENOTSUP means lacking msi support for a msi-capable platform.
> + * -EINVAL means capability overlap, happens when @cap_pos is non-zero,
> + * also means a programming error, except device assignment, which can check
> + * if a real HW is broken.*/

/*
 * Multi-line comments
 * should look
 * like this
 */

/* Not
 * like this */


>  int msix_init(struct PCIDevice *dev, unsigned short nentries,
>                MemoryRegion *table_bar, uint8_t table_bar_nr,
>                unsigned table_offset, MemoryRegion *pba_bar,
> -              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos)
> +              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
> +              Error **errp)
>  {
>      int cap;
>      unsigned table_size, pba_size;
> @@ -250,10 +269,12 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
>  
>      /* Nothing to do if MSI is not supported by interrupt controller */
>      if (!msi_nonbroken) {
> +        error_setg(errp, "MSI-X is not supported by interrupt controller");
>          return -ENOTSUP;
>      }
>  
>      if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
> +        error_setg(errp, "The number of MSI-X vectors is invalid");
>          return -EINVAL;
>      }
>  
> @@ -266,10 +287,13 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
>          table_offset + table_size > memory_region_size(table_bar) ||
>          pba_offset + pba_size > memory_region_size(pba_bar) ||
>          (table_offset | pba_offset) & PCI_MSIX_FLAGS_BIRMASK) {
> +        error_setg(errp, "table & pba overlap, or they don't fit in BARs,"
> +                   " or don't align");
>          return -EINVAL;
>      }
>  
> -    cap = pci_add_capability(dev, PCI_CAP_ID_MSIX, cap_pos, MSIX_CAP_LENGTH);
> +    cap = pci_add_capability2(dev, PCI_CAP_ID_MSIX,
> +                              cap_pos, MSIX_CAP_LENGTH, errp);
>      if (cap < 0) {
>          return cap;
>      }
> @@ -306,7 +330,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
>  }
>  
>  int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
> -                            uint8_t bar_nr)
> +                            uint8_t bar_nr, Error **errp)
>  {
>      int ret;
>      char *name;
> @@ -338,7 +362,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
>      ret = msix_init(dev, nentries, &dev->msix_exclusive_bar, bar_nr,
>                      0, &dev->msix_exclusive_bar,
>                      bar_nr, bar_pba_offset,
> -                    0);
> +                    0, errp);
>      if (ret) {
>          return ret;
>      }
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 52a4123..fada834 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -2360,9 +2360,12 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
>  
>      if (megasas_use_msix(s) &&
>          msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
> -                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68)) {
> +                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, &err)) {
> +        /*TODO: check msix_init's error, and should fail on msix=on */

Missing space after *.

> +        error_report_err(err);
>          s->msix = ON_OFF_AUTO_OFF;
>      }
> +
>      if (pci_is_express(dev)) {
>          pcie_endpoint_cap_init(dev, 0xa0);
>      }

This disabled msix silently so should probably keep doing so for now.
Then you can keep the existing TODO.

> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 0ace273..153b006 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3703,11 +3703,14 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
>      }
>  
>      if (xhci->msix != ON_OFF_AUTO_OFF) {
> -        /* TODO check for errors */
> -        msix_init(dev, xhci->numintrs,
> -                  &xhci->mem, 0, OFF_MSIX_TABLE,
> -                  &xhci->mem, 0, OFF_MSIX_PBA,
> -                  0x90);
> +        /* TODO check for errors, and should fail when msix=on */
> +        ret = msix_init(dev, xhci->numintrs,
> +                        &xhci->mem, 0, OFF_MSIX_TABLE,
> +                        &xhci->mem, 0, OFF_MSIX_PBA,
> +                        0x90, &err);
> +        if (ret) {
> +            error_report_err(err);
> +        }
>      }
>  }
>  

Please just pass in NULL in this patch. Do enhancements
in a separate one to be merged by someone who cares.


> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7dbe0e..0bcfaad 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1432,6 +1432,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>  static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>  {
>      int ret;
> +    Error *local_err = NULL;
>  
>      vdev->msix->pending = g_malloc0(BITS_TO_LONGS(vdev->msix->entries) *
>                                      sizeof(unsigned long));
> @@ -1439,12 +1440,15 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>                      vdev->bars[vdev->msix->table_bar].region.mem,
>                      vdev->msix->table_bar, vdev->msix->table_offset,
>                      vdev->bars[vdev->msix->pba_bar].region.mem,
> -                    vdev->msix->pba_bar, vdev->msix->pba_offset, pos);
> +                    vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
> +                    &local_err);
>      if (ret < 0) {
>          if (ret == -ENOTSUP) {
> +            error_report_err(local_err);
>              return 0;
>          }
> -        error_setg(errp, "msix_init failed");
> +
> +        error_propagate(errp, local_err);
>          return ret;
>      }
>  
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 06831de..5acce38 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1693,13 +1693,12 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>  
>      if (proxy->nvectors) {
>          int err = msix_init_exclusive_bar(&proxy->pci_dev, proxy->nvectors,
> -                                          proxy->msix_bar_idx);
> +                                          proxy->msix_bar_idx, errp);
> +        /* Any error other than -ENOTSUP(board's MSI support is broken)
> +         * is a programming error. */
> +        assert(!err || err == -ENOTSUP);

This is spread in too many places. Almost everyone except vfio
wants this, so simple msix_init should include this assert,
and vfio should have a special _check variant that
does not. You can make these asserts in a separate patch
though. This one is already too big.

>          if (err) {
> -            /* Notice when a system that supports MSIx can't initialize it.  */
> -            if (err != -ENOTSUP) {
> -                error_report("unable to init msix vectors to %" PRIu32,
> -                             proxy->nvectors);
> -            }
> +            error_report_err(*errp);
>              proxy->nvectors = 0;
>          }
>      }
> diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
> index 048a29d..1f27658 100644
> --- a/include/hw/pci/msix.h
> +++ b/include/hw/pci/msix.h
> @@ -9,9 +9,10 @@ MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
>  int msix_init(PCIDevice *dev, unsigned short nentries,
>                MemoryRegion *table_bar, uint8_t table_bar_nr,
>                unsigned table_offset, MemoryRegion *pba_bar,
> -              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos);
> +              uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
> +              Error **errp);
>  int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
> -                            uint8_t bar_nr);
> +                            uint8_t bar_nr, Error **errp);
>  
>  void msix_write_config(PCIDevice *dev, uint32_t address, uint32_t val, int len);
>  
> -- 
> 2.1.0
> 
> 
