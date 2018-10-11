Received: from eggs.gnu.org ([2001:4830:134:3::10]:48854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYkB-0001R1-EP
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYk7-00019W-BV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:03:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAYk7-000198-3k
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:02:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so8966012wmt.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 04:02:59 -0700 (PDT)
References: <153924123502.3669683.1365591120394690822.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b91d4bf-58b2-55b6-d41d-348865b7542a@redhat.com>
Date: Thu, 11 Oct 2018 13:02:50 +0200
MIME-Version: 1.0
In-Reply-To: <153924123502.3669683.1365591120394690822.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: rename some structured types
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

Hi Greg,

On 11/10/2018 09:00, Greg Kurz wrote:
> According to CODING_STYLE, structured types names are expected to be
> in CamelCase. PCI is dropped from the name for better readability.
> 
> While here, this also converts a call to g_malloc(n * sizeofi(foo)) to

sizeof(foo)

> g_new(n, foo), which is a recommended good practice.

Clearly 2 different patches...

> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c          |   22 +++++++++++-----------
>  include/hw/pci-host/spapr.h |   12 ++++++------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index c2271e6ed462..bfb959f2b065 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -277,7 +277,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>      unsigned int irq, max_irqs = 0;
>      sPAPRPHBState *phb = NULL;
>      PCIDevice *pdev = NULL;
> -    spapr_pci_msi *msi;
> +    sPAPRMSI *msi;

In CamelCase this should be "SpaprMsi"...
I however agree sPAPRMSI is nicer, the code is also easier to review.

>      int *config_addr_key;
>      Error *err = NULL;
>      int i;
> @@ -325,7 +325,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>          return;
>      }
>  
> -    msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
> +    msi = (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_addr);
>  
>      /* Releasing MSIs */
>      if (!req_num) {
> @@ -414,7 +414,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                       irq, req_num);
>  
>      /* Add MSI device to cache */
> -    msi = g_new(spapr_pci_msi, 1);
> +    msi = g_new(sPAPRMSI, 1);
>      msi->first_irq = irq;
>      msi->num = req_num;
>      config_addr_key = g_new(int, 1);
> @@ -445,7 +445,7 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
>      unsigned int intr_src_num = -1, ioa_intr_num = rtas_ld(args, 3);
>      sPAPRPHBState *phb = NULL;
>      PCIDevice *pdev = NULL;
> -    spapr_pci_msi *msi;
> +    sPAPRMSI *msi;
>  
>      /* Find sPAPRPHBState */
>      phb = spapr_pci_find_phb(spapr, buid);
> @@ -458,7 +458,7 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
>      }
>  
>      /* Find device descriptor and start IRQ */
> -    msi = (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &config_addr);
> +    msi = (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_addr);
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
> +        VMSTATE_UINT32(key, sPAPRMSIMig),
> +        VMSTATE_UINT32(value.first_irq, sPAPRMSIMig),
> +        VMSTATE_UINT32(value.num, sPAPRMSIMig),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -1883,12 +1883,12 @@ static int spapr_pci_pre_save(void *opaque)
>      if (!sphb->msi_devs_num) {
>          return 0;
>      }
> -    sphb->msi_devs = g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_msi_mig));
> +    sphb->msi_devs = g_new(sPAPRMSIMig, sphb->msi_devs_num);
>  
>      g_hash_table_iter_init(&iter, sphb->msi);
>      for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
>          sphb->msi_devs[i].key = *(uint32_t *) key;
> -        sphb->msi_devs[i].value = *(spapr_pci_msi *) value;
> +        sphb->msi_devs[i].value = *(sPAPRMSI *) value;
>      }
>  
>      return 0;
> @@ -1938,7 +1938,7 @@ static const VMStateDescription vmstate_spapr_pci = {
>                               vmstate_spapr_pci_lsi, struct spapr_pci_lsi),
>          VMSTATE_INT32(msi_devs_num, sPAPRPHBState),
>          VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, sPAPRPHBState, msi_devs_num, 0,
> -                                    vmstate_spapr_pci_msi, spapr_pci_msi_mig),
> +                                    vmstate_spapr_pci_msi, sPAPRMSIMig),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 7c66c3872f96..041126da573d 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -34,15 +34,15 @@
>  
>  typedef struct sPAPRPHBState sPAPRPHBState;
>  
> -typedef struct spapr_pci_msi {
> +typedef struct sPAPRMSI {
>      uint32_t first_irq;
>      uint32_t num;
> -} spapr_pci_msi;
> +} sPAPRMSI;
>  
> -typedef struct spapr_pci_msi_mig {
> +typedef struct sPAPRMSIMig {
>      uint32_t key;
> -    spapr_pci_msi value;
> -} spapr_pci_msi_mig;
> +    sPAPRMSI value;
> +} sPAPRMSIMig;
>  
>  struct sPAPRPHBState {
>      PCIHostState parent_obj;
> @@ -70,7 +70,7 @@ struct sPAPRPHBState {
>      GHashTable *msi;
>      /* Temporary cache for migration purposes */
>      int32_t msi_devs_num;
> -    spapr_pci_msi_mig *msi_devs;
> +    sPAPRMSIMig *msi_devs;
>  
>      QLIST_ENTRY(sPAPRPHBState) list;
>  
> 
> 
