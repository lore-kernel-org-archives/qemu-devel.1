Received: from eggs.gnu.org ([2001:4830:134:3::10]:55859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gBs1D-0007ia-Eb
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 21:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gBs1A-0002Cz-1z
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 21:50:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gBs19-00020h-MM
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 21:49:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id s4-v6so8494645plp.0
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 18:49:58 -0700 (PDT)
References: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
	<153933511983.3834759.10815543413375425072.stgit@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e77c6869-d89e-c5df-c43f-a2b5df3fbf59@ozlabs.ru>
Date: Mon, 15 Oct 2018 12:49:53 +1100
MIME-Version: 1.0
In-Reply-To: <153933511983.3834759.10815543413375425072.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr_pci: rename some structured
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>



On 12/10/2018 20:05, Greg Kurz wrote:
> According to CODING_STYLE, structured types names are expected to be
> in CamelCase but we have:
> 
> typedef struct spapr_pci_msi {
>     uint32_t first_irq;
>     uint32_t num;
> } spapr_pci_msi;
> 
> typedef struct spapr_pci_msi_mig {
>     uint32_t key;
>     spapr_pci_msi value;
> } spapr_pci_msi_mig;
> 
> Acronyms are often written in upper-case, but here we would en up with
> a lot of upper-case letters in a row (ie, sPAPRPCIMSI) which defeats the
> purpose of CamelCase. It even displays "RPC" which looks awkward.

Yet more common than this. I vote for sPAPRPCIMSI as PCI is an acronym.
"pci" is small letters hurts my eyes :)



> This patch twists the rule a bit to keep the type names readable:
> sPAPRpciMSI and sPAPRpciMSImig.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - moved g_malloc change to a separate patch
>     - new naming proposal that doesn't drop PCI
>     - more detailed description in the changelog
> ---
>  hw/ppc/spapr_pci.c          |   22 +++++++++++-----------
>  include/hw/pci-host/spapr.h |   12 ++++++------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0537ce018f51..2ee933e2d1ec 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -277,7 +277,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>      unsigned int irq, max_irqs = 0;
>      sPAPRPHBState *phb = NULL;
>      PCIDevice *pdev = NULL;
> -    spapr_pci_msi *msi;
> +    sPAPRpciMSI *msi;
>      int *config_addr_key;
>      Error *err = NULL;
>      int i;
> @@ -325,7 +325,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>          return;
>      }
>  
> -    msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
> +    msi = (sPAPRpciMSI *) g_hash_table_lookup(phb->msi, &config_addr);
>  
>      /* Releasing MSIs */
>      if (!req_num) {
> @@ -414,7 +414,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                       irq, req_num);
>  
>      /* Add MSI device to cache */
> -    msi = g_new(spapr_pci_msi, 1);
> +    msi = g_new(sPAPRpciMSI, 1);
>      msi->first_irq = irq;
>      msi->num = req_num;
>      config_addr_key = g_new(int, 1);
> @@ -445,7 +445,7 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
>      unsigned int intr_src_num = -1, ioa_intr_num = rtas_ld(args, 3);
>      sPAPRPHBState *phb = NULL;
>      PCIDevice *pdev = NULL;
> -    spapr_pci_msi *msi;
> +    sPAPRpciMSI *msi;
>  
>      /* Find sPAPRPHBState */
>      phb = spapr_pci_find_phb(spapr, buid);
> @@ -458,7 +458,7 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
>      }
>  
>      /* Find device descriptor and start IRQ */
> -    msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
> +    msi = (sPAPRpciMSI *) g_hash_table_lookup(phb->msi, &config_addr);
>      if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >= msi->num)) {
>          trace_spapr_pci_msi("Failed to return vector", config_addr);
>          rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> @@ -1849,9 +1849,9 @@ static const VMStateDescription vmstate_spapr_pci_msi = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField []) {
> -        VMSTATE_UINT32(key, spapr_pci_msi_mig),
> -        VMSTATE_UINT32(value.first_irq, spapr_pci_msi_mig),
> -        VMSTATE_UINT32(value.num, spapr_pci_msi_mig),
> +        VMSTATE_UINT32(key, sPAPRpciMSImig),
> +        VMSTATE_UINT32(value.first_irq, sPAPRpciMSImig),
> +        VMSTATE_UINT32(value.num, sPAPRpciMSImig),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -1883,12 +1883,12 @@ static int spapr_pci_pre_save(void *opaque)
>      if (!sphb->msi_devs_num) {
>          return 0;
>      }
> -    sphb->msi_devs = g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
> +    sphb->msi_devs = g_new(sPAPRpciMSImig, sphb->msi_devs_num);
>  
>      g_hash_table_iter_init(&iter, sphb->msi);
>      for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
>          sphb->msi_devs[i].key = *(uint32_t *) key;
> -        sphb->msi_devs[i].value = *(spapr_pci_msi *) value;
> +        sphb->msi_devs[i].value = *(sPAPRpciMSI *) value;
>      }
>  
>      return 0;
> @@ -1938,7 +1938,7 @@ static const VMStateDescription vmstate_spapr_pci = {
>                               vmstate_spapr_pci_lsi, struct spapr_pci_lsi),
>          VMSTATE_INT32(msi_devs_num, sPAPRPHBState),
>          VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, sPAPRPHBState, msi_devs_num, 0,
> -                                    vmstate_spapr_pci_msi, spapr_pci_msi_mig),
> +                                    vmstate_spapr_pci_msi, sPAPRpciMSImig),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 7c66c3872f96..eb8436b4fc32 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -34,15 +34,15 @@
>  
>  typedef struct sPAPRPHBState sPAPRPHBState;
>  
> -typedef struct spapr_pci_msi {
> +typedef struct sPAPRpciMSI {
>      uint32_t first_irq;
>      uint32_t num;
> -} spapr_pci_msi;
> +} sPAPRpciMSI;
>  
> -typedef struct spapr_pci_msi_mig {
> +typedef struct sPAPRpciMSImig {
>      uint32_t key;
> -    spapr_pci_msi value;
> -} spapr_pci_msi_mig;
> +    sPAPRpciMSI value;
> +} sPAPRpciMSImig;
>  
>  struct sPAPRPHBState {
>      PCIHostState parent_obj;
> @@ -70,7 +70,7 @@ struct sPAPRPHBState {
>      GHashTable *msi;
>      /* Temporary cache for migration purposes */
>      int32_t msi_devs_num;
> -    spapr_pci_msi_mig *msi_devs;
> +    sPAPRpciMSImig *msi_devs;
>  
>      QLIST_ENTRY(sPAPRPHBState) list;
>  
> 
> 

-- 
Alexey
