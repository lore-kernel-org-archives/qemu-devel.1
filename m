Received: from eggs.gnu.org ([2001:4830:134:3::10]:39239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eR8FY-0005UE-9E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eR8FU-00026H-3t
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:07:24 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eR8FT-00024a-Og
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:07:20 -0500
Received: by mail-pl0-x242.google.com with SMTP id n13so6127195plp.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:07:19 -0800 (PST)
References: <20171218040852.13478.19208.stgit@gimli.home>
	<20171218050253.13478.49457.stgit@gimli.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b3cab6e2-eccf-990a-12ac-213512377cdf@ozlabs.ru>
Date: Tue, 19 Dec 2017 14:07:13 +1100
MIME-Version: 1.0
In-Reply-To: <20171218050253.13478.49457.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 5/5] vfio/pci: Allow relocating
 MSI-X MMIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com

On 18/12/17 16:02, Alex Williamson wrote:
> With recently proposed kernel side vfio-pci changes, the MSI-X vector
> table area can be mmap'd from userspace, allowing direct access to
> non-MSI-X registers within the host page size of this area.  However,
> we only get that direct access if QEMU isn't also emulating MSI-X
> within that same page.  For x86/64 host, the system page size is 4K
> and the PCI spec recommends a minimum of 4K to 8K alignment to
> separate MSI-X from non-MSI-X registers, therefore only devices which
> don't honor this recommendation would see any improvement from this
> option.  The real targets for this feature are hosts where the page
> size exceeds the PCI spec recommended alignment, such as ARM64 systems
> with 64K pages.
> 
> This new x-msix-relocation option accepts the following options:
> 
>   off: Disable MSI-X relocation, use native device config (default)
>   auto: Automaically relocate MSI-X MMIO to another BAR or offset
>        based on minimum additional MMIO requirement
>   bar0..bar5: Specify the target BAR, which will either be extended
>        if the BAR exists or added if the BAR slot is available.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/pci.c        |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h        |    1 
>  hw/vfio/trace-events |    2 +
>  3 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c383b842da20..b4426abf297a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1352,6 +1352,101 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>      }
>  }
>  
> +static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev)
> +{
> +    int target_bar = -1;
> +    size_t msix_sz;
> +
> +    if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
> +        return;
> +    }
> +
> +    /* The actual minimum size of MSI-X structures */
> +    msix_sz = (vdev->msix->entries * PCI_MSIX_ENTRY_SIZE) +
> +              (QEMU_ALIGN_UP(vdev->msix->entries, 64) / 8);
> +    /* Round up to host pages, we don't want to share a page */
> +    msix_sz = REAL_HOST_PAGE_ALIGN(msix_sz);
> +    /* PCI BARs must be a power of 2 */
> +    msix_sz = pow2ceil(msix_sz);
> +
> +    /* Auto: pick the BAR that incurs the least additional MMIO space */
> +    if (vdev->msix_relo == OFF_AUTOPCIBAR_AUTO) {
> +        int i;
> +        size_t best = UINT64_MAX;
> +
> +        for (i = 0; i < PCI_ROM_SLOT; i++) {


I belieive that going from the other end is safer approach for "auto",
especially after discovering how mpt3sas works. Or you could add
"autoreverse" switch...




> +            size_t size;
> +
> +            if (vdev->bars[i].ioport) {
> +                continue;
> +            }
> +
> +            /* MSI-X MMIO must reside within first 32bit offset of BAR */
> +            if (vdev->bars[i].size > (UINT32_MAX / 2))
> +                continue;
> +
> +            /*
> +             * Must be pow2, so larger of double existing or double msix_sz,
> +             * or if BAR unimplemented, msix_sz
> +             */
> +            size = MAX(vdev->bars[i].size * 2,
> +                       vdev->bars[i].size ? msix_sz * 2 : msix_sz);
> +
> +            trace_vfio_msix_relo_cost(vdev->vbasedev.name, i, size);
> +
> +            if (size < best) {
> +                best = size;
> +                target_bar = i;
> +            }
> +
> +            if (vdev->bars[i].mem64) {
> +              i++;
> +            }
> +        }
> +    } else {
> +        target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
> +    }
> +
> +    if (target_bar < 0 || vdev->bars[target_bar].ioport ||
> +        (!vdev->bars[target_bar].size &&
> +         target_bar > 0 && vdev->bars[target_bar - 1].mem64)) {
> +        return; /* Go BOOM?  Plumb Error */
> +    }


This "if" only seems to make sense for the non-auto branch...


> +
> +    /*
> +     * If adding a new BAR, test if we can make it 64bit.  We make it
> +     * prefetchable since QEMU MSI-X emulation has no read side effects
> +     * and doing so makes mapping more flexible.
> +     */
> +    if (!vdev->bars[target_bar].size) {
> +        if (target_bar < (PCI_ROM_SLOT - 1) &&
> +            !vdev->bars[target_bar + 1].size) {
> +            vdev->bars[target_bar].mem64 = true;
> +            vdev->bars[target_bar].type = PCI_BASE_ADDRESS_MEM_TYPE_64;
> +        }
> +        vdev->bars[target_bar].type |= PCI_BASE_ADDRESS_MEM_PREFETCH;
> +        vdev->bars[target_bar].size = msix_sz;
> +        vdev->msix->table_offset = 0;
> +    } else {
> +        vdev->bars[target_bar].size = MAX(vdev->bars[target_bar].size * 2,
> +                                          msix_sz * 2);
> +        /*
> +         * Due to above size calc, MSI-X always starts halfway into the BAR,
> +         * which will always be a separate host page.
> +         */
> +        vdev->msix->table_offset = vdev->bars[target_bar].size / 2;
> +    }
> +
> +    vdev->msix->table_bar = target_bar;
> +    vdev->msix->pba_bar = target_bar;


Ah, here is how I got confused that commenting vfio_pci_fixup_msix_region() out
was not necessary at the time but I missed that it is called before
vfio_pci_relocate_msix(), when simply swapped - BARs get mapped. Ok, thanks,




> +    /* Requires 8-byte alignment, but PCI_MSIX_ENTRY_SIZE guarantees that */
> +    vdev->msix->pba_offset = vdev->msix->table_offset +
> +                                  (vdev->msix->entries * PCI_MSIX_ENTRY_SIZE);
> +
> +    trace_vfio_msix_relo(vdev->vbasedev.name,
> +                         vdev->msix->table_bar, vdev->msix->table_offset);
> +}
> +
>  /*
>   * We don't have any control over how pci_add_capability() inserts
>   * capabilities into the chain.  In order to setup MSI-X we need a
> @@ -1430,6 +1525,8 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>      vdev->msix = msix;
>  
>      vfio_pci_fixup_msix_region(vdev);
> +
> +    vfio_pci_relocate_msix(vdev);
>  }
>  
>  static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
> @@ -2845,13 +2942,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>      vfio_pci_size_rom(vdev);
>  
> +    vfio_bars_prepare(vdev);
> +
>      vfio_msix_early_setup(vdev, &err);
>      if (err) {
>          error_propagate(errp, err);
>          goto error;
>      }
>  
> -    vfio_bars_prepare(vdev);
>      vfio_bars_register(vdev);
>  
>      ret = vfio_add_capabilities(vdev, errp);
> @@ -3041,6 +3139,8 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                     nv_gpudirect_clique,
>                                     qdev_prop_nv_gpudirect_clique, uint8_t),
> +    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
> +                                OFF_AUTOPCIBAR_OFF),
>      /*
>       * TODO - support passed fds... is this necessary?
>       * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index dcdb1a806769..588381f201b4 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
>                                  (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
>      int32_t bootindex;
>      uint32_t igd_gms;
> +    OffAutoPCIBAR msix_relo;
>      uint8_t pm_cap;
>      uint8_t nv_gpudirect_clique;
>      bool pci_aer;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index fae096c0724f..437ccdd29053 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -16,6 +16,8 @@ vfio_msix_pba_disable(const char *name) " (%s)"
>  vfio_msix_pba_enable(const char *name) " (%s)"
>  vfio_msix_disable(const char *name) " (%s)"
>  vfio_msix_fixup(const char *name, int bar, uint64_t start, uint64_t end) " (%s) MSI-X region %d mmap fixup [0x%"PRIx64" - 0x%"PRIx64"]"
> +vfio_msix_relo_cost(const char *name, int bar, uint64_t cost) " (%s) BAR %d cost 0x%"PRIx64""
> +vfio_msix_relo(const char *name, int bar, uint64_t offset) " (%s) BAR %d offset 0x%"PRIx64""
>  vfio_msi_enable(const char *name, int nr_vectors) " (%s) Enabled %d MSI vectors"
>  vfio_msi_disable(const char *name) " (%s)"
>  vfio_pci_load_rom(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s ROM:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
> 
> 


-- 
Alexey
