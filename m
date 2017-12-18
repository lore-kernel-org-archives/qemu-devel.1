Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eQrLe-0002NT-Rn
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eQrLb-00009Z-LX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:04:34 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eQrLb-000074-AZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:04:31 -0500
Received: by mail-pf0-x244.google.com with SMTP id y89so9435694pfk.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 01:04:29 -0800 (PST)
References: <20171218040852.13478.19208.stgit@gimli.home>
	<20171218050253.13478.49457.stgit@gimli.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f76b5d78-0107-cca8-5e72-ab9944c8a90b@ozlabs.ru>
Date: Mon, 18 Dec 2017 20:04:23 +1100
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


While I am digesting the patchset, here are some test results.

This is the device:

00:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008
PCI-Express Fusion-MPT SAS-3 (rev 02)
Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]

Capabilities: [c0] MSI-X: Enable+ Count=96 Masked-
        Vector table: BAR=1 offset=0000e000
        PBA: BAR=1 offset=0000f000


Test #1: x-msix-relocation = "off":

FlatView #1
 AS "memory", root: system
 AS "cpu-memory", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  0000210000000000-000021000000dfff (prio 0, i/o): 0001:03:00.0 BAR 1
  000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
  000021000000e600-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
@000000000000e600
  0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]

Ok, works.


Test #2: x-msix-relocation = "auto":

FlatView #2
 AS "memory", root: system
 AS "cpu-memory", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  0000200080000000-00002000800005ff (prio 0, i/o): msix-table
  0000200080000600-000020008000ffff (prio 1, i/o): 0001:03:00.0 base BAR 0
@0000000000000600
  0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
  0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]


The guest fails probing because the first 64bit BAR is broken.

lspci:

Region 0: Memory at 200080000000 (32-bit, prefetchable) [size=64K]
Region 1: Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
Region 3: Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]

Capabilities: [c0] MSI-X: Enable- Count=96 Masked-
        Vector table: BAR=0 offset=00000000
        PBA: BAR=0 offset=00000600



Test #3: x-msix-relocation = "bar1"


FlatView #1
 AS "memory", root: system
 AS "cpu-memory", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
  0000210000010000-00002100000105ff (prio 0, i/o): msix-table
  0000210000010600-000021000001ffff (prio 1, i/o): 0001:03:00.0 base BAR 1
@0000000000010600
  0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]

Ok, works. BAR1 became 128K. However no part of BAR1 was mapped, i.e.
appear as "ramd" in flatview, should it have appeared?

This is "mtree":

memory-region: pci@800000020000000.mmio
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
    0000210000000000-000021000001ffff (prio 1, i/o): 0001:03:00.0 base BAR 1
      0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
      0000210000010000-00002100000105ff (prio 0, i/o): msix-table
      0000210000010600-000021000001060f (prio 0, i/o): msix-pba [disabled]
    0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 base BAR 3
      0000210000040000-000021000007ffff (prio 0, i/o): 0001:03:00.0 BAR 3
        0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR
3 mmaps[0]




Test #4: x-msix-relocation = "bar5"

The same net result as test #3: it works but BAR1 is not mapped:


Region 1: Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
Region 3: Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]
Region 5: Memory at 200080000000 (32-bit, prefetchable) [size=64K]

Capabilities: [c0] MSI-X: Enable+ Count=96 Masked-
        Vector table: BAR=5 offset=00000000
        PBA: BAR=5 offset=00000600

FlatView #0
 AS "memory", root: system
 AS "cpu-memory", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  0000200080000000-00002000800005ff (prio 0, i/o): msix-table
  0000200080000600-000020008000ffff (prio 1, i/o): 0001:03:00.0 base BAR 5
@0000000000000600
  0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
  0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]


memory-region: pci@800000020000000.mmio
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
    0000000080000000-000000008000ffff (prio 1, i/o): 0001:03:00.0 base BAR 5
      0000000080000000-00000000800005ff (prio 0, i/o): msix-table
      0000000080000600-000000008000060f (prio 0, i/o): msix-pba [disabled]
    0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 base BAR 1
      0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
    0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 base BAR 3
      0000210000040000-000021000007ffff (prio 0, i/o): 0001:03:00.0 BAR 3
        0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR
3 mmaps[0]



and there is also one minor comment below.


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


This could be in 2/5.


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
