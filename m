Received: from eggs.gnu.org ([2001:4830:134:3::10]:51162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daD49-0004qm-2N
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daD45-00006r-4z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:32:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daD44-00006Q-SO
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:32:49 -0400
Received: by mail-pf0-x244.google.com with SMTP id q85so14347983pfq.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:32:48 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100549536.27487.11322702271540744350.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f278e478-83a7-0842-5cfb-f0582aec3b5d@ozlabs.ru>
Date: Wed, 26 Jul 2017 13:32:41 +1000
MIME-Version: 1.0
In-Reply-To: <150100549536.27487.11322702271540744350.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.11 PATCH 01/26] spapr: move
 spapr_create_phb() to core machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 26/07/17 03:58, Greg Kurz wrote:
> This function is only used when creating the default PHB. Let's rename
> it and move it to the core machine code for clarity.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c              |   13 ++++++++++++-
>  hw/ppc/spapr_pci.c          |   11 -----------
>  include/hw/pci-host/spapr.h |    2 --
>  3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2a3e53d5d58c..53969315ac24 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2142,6 +2142,17 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
>      g_free(type);
>  }
>  
> +static PCIHostState *spapr_create_default_phb(sPAPRMachineState *spapr)


Nit: you could get rid of the *spapr here.

Anyway,

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
> +    qdev_prop_set_uint32(dev, "index", 0);
> +    qdev_init_nofail(dev);
> +
> +    return PCI_HOST_BRIDGE(dev);
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void ppc_spapr_init(MachineState *machine)
>  {
> @@ -2374,7 +2385,7 @@ static void ppc_spapr_init(MachineState *machine)
>      /* Set up PCI */
>      spapr_pci_rtas_init();
>  
> -    phb = spapr_create_phb(spapr, 0);
> +    phb = spapr_create_default_phb(spapr);
>  
>      for (i = 0; i < nb_nics; i++) {
>          NICInfo *nd = &nd_table[i];
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index d84abf1070a0..70a99a032267 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1982,17 +1982,6 @@ static const TypeInfo spapr_phb_info = {
>      }
>  };
>  
> -PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index)
> -{
> -    DeviceState *dev;
> -
> -    dev = qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
> -    qdev_prop_set_uint32(dev, "index", index);
> -    qdev_init_nofail(dev);
> -
> -    return PCI_HOST_BRIDGE(dev);
> -}
> -
>  typedef struct sPAPRFDT {
>      void *fdt;
>      int node_off;
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 38470b2f0e5c..5a4e9686d562 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -111,8 +111,6 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
>      return xics_get_qirq(XICS_FABRIC(spapr), phb->lsi_table[pin].irq);
>  }
>  
> -PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
> -
>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>                            uint32_t xics_phandle,
>                            void *fdt);
> 
> 


-- 
Alexey
