Received: from eggs.gnu.org ([2001:4830:134:3::10]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1efzza-00028s-5N
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1efzzW-0005E6-T1
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:20:22 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1efzzW-0005D5-Jv
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:20:18 -0500
Received: by mail-pg0-x243.google.com with SMTP id w17so3355885pgv.6
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 19:20:18 -0800 (PST)
References: <151700552398.7196.2573848773899364520.stgit@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4f0a9638-208c-9ebc-aed5-e3ebb4374054@ozlabs.ru>
Date: Mon, 29 Jan 2018 14:20:12 +1100
MIME-Version: 1.0
In-Reply-To: <151700552398.7196.2573848773899364520.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fix MSI/MSIX selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 27/01/18 09:25, Greg Kurz wrote:
> In various place we don't correctly check if the device supports MSI or
> MSI-X. This can cause devices to be advertised with MSI support, even
> if they only support MSI-X (like virtio-pci-* devices for example):
> 
>                 ethernet@0 {
>                         ibm,req#msi = <0x1>; <--- wrong!
> 			.
> 			ibm,loc-code = "qemu_virtio-net-pci:0000:00:00.0";
> 			.
> 			ibm,req#msi-x = <0x3>;
>                 };
> 
> Worse, this can also cause the "ibm,change-msi" RTAS call to corrupt the
> PCI status and cause migration to fail:
> 
>   qemu-system-ppc64: get_pci_config_device: Bad config data: i=0x6
>     read: 0 device: 10 cmask: 10 wmask: 0 w1cmask:0
>                               ^^
>            PCI_STATUS_CAP_LIST bit which is assumed to be constant
> 
> This patch changes spapr_populate_pci_child_dt() to properly check for
> MSI support using msi_present(): this ensures that PCIDevice::msi_cap
> was set by msi_init() and that msi_nr_vectors_allocated() will look at
> the right place in the config space.
> 
> Checking PCIDevice::msix_entries_nr is enough for MSI-X but let's add
> a call to msix_present() there as well for consistency.
> 
> It also changes rtas_ibm_change_msi() to select the appropriate MSI
> type in Function 1 instead of always selecting plain MSI. This new
> behaviour is compliant with LoPAPR 1.1, as described in "Table 71.
> ibm,change-msi Argument Call Buffer":
> 
>   Function 1: If Number Outputs is equal to 3, request to set to a new
>            number of MSIs (including set to 0).
>            If the “ibm,change-msix-capable” property exists and Number
>            Outputs is equal to 4, request is to set to a new number of
>            MSI or MSI-X (platform choice) interrupts (including set to
>            0).
> 
> Since MSI is the the platform default (LoPAPR 6.2.3 MSI Option), let's
> check for MSI support first.
> 
> And finally, it checks the input parameters are valid, as described in
> LoPAPR 1.1 "R1–7.3.10.5.1–3":
> 
>   For the MSI option: The platform must return a Status of -3 (Parameter
>   error) from ibm,change-msi, with no change in interrupt assignments if
>   the PCI configuration address does not support MSI and Function 3 was
>   requested (that is, the “ibm,req#msi” property must exist for the PCI
>   configuration address in order to use Function 3), or does not support
>   MSI-X and Function 4 is requested (that is, the “ibm,req#msi-x” property
>   must exist for the PCI configuration address in order to use Function 4),
>   or if neither MSIs nor MSI-Xs are supported and Function 1 is requested.
> 
> This ensures that the ret_intr_type variable contains a valid MSI type
> for this device, and that spapr_msi_setmsg() won't corrupt the PCI status.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c |   61 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 37f18b3d3235..39a14980d397 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -280,13 +280,42 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>      int *config_addr_key;
>      Error *err = NULL;
>  
> +    /* Fins sPAPRPHBState */
> +    phb = spapr_pci_find_phb(spapr, buid);
> +    if (phb) {
> +        pdev = spapr_pci_find_dev(spapr, buid, config_addr);
> +    }
> +    if (!phb || !pdev) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
>      switch (func) {
> -    case RTAS_CHANGE_MSI_FN:
>      case RTAS_CHANGE_FN:
> -        ret_intr_type = RTAS_TYPE_MSI;
> +        if (msi_present(pdev)) {
> +            ret_intr_type = RTAS_TYPE_MSI;
> +        } else if (msix_present(pdev)) {
> +            ret_intr_type = RTAS_TYPE_MSIX;
> +        } else {
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
> +        break;
> +    case RTAS_CHANGE_MSI_FN:
> +        if (msi_present(pdev)) {
> +            ret_intr_type = RTAS_TYPE_MSI;
> +        } else {
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
>          break;
>      case RTAS_CHANGE_MSIX_FN:
> -        ret_intr_type = RTAS_TYPE_MSIX;
> +        if (msix_present(pdev)) {
> +            ret_intr_type = RTAS_TYPE_MSIX;
> +        } else {
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +            return;
> +        }
>          break;
>      default:
>          error_report("rtas_ibm_change_msi(%u) is not implemented", func);
> @@ -294,16 +323,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>          return;
>      }
>  
> -    /* Fins sPAPRPHBState */
> -    phb = spapr_pci_find_phb(spapr, buid);
> -    if (phb) {
> -        pdev = spapr_pci_find_dev(spapr, buid, config_addr);
> -    }
> -    if (!phb || !pdev) {
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
>      msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
>  
>      /* Releasing MSIs */
> @@ -1286,13 +1305,17 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells",
>                            RESOURCE_CELLS_SIZE));
>  
> -    max_msi = msi_nr_vectors_allocated(dev);
> -    if (max_msi) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
> +    if (msi_present(dev)) {
> +        max_msi = msi_nr_vectors_allocated(dev);
> +        if (max_msi) {
> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
> +        }
>      }
> -    max_msix = dev->msix_entries_nr;
> -    if (max_msix) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix));
> +    if (msix_present(dev)) {
> +        max_msix = dev->msix_entries_nr;
> +        if (max_msix) {
> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix));
> +        }


Oh. I was under impression this is set up by SLOF; and everything capable
of MSIX can do MSI too (too big assumption, I know).

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




David, no, this was not a bug I told you about.



>      }
>  
>      populate_resource_props(dev, &rp);
> 


-- 
Alexey
