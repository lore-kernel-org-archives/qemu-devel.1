Received: from eggs.gnu.org ([2001:4830:134:3::10]:35401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daE9a-0001Qv-Pr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daE9W-00054M-S2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:42:34 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daE9W-00053m-LH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:42:30 -0400
Received: by mail-pf0-x243.google.com with SMTP id q85so14474660pfq.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:42:30 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100568549.27487.11903027800624299907.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0d1e2a57-14cb-4c4d-d8f7-915cd94c2eba@ozlabs.ru>
Date: Wed, 26 Jul 2017 14:42:23 +1000
MIME-Version: 1.0
In-Reply-To: <150100568549.27487.11903027800624299907.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 16/26] spapr: enable
 PHB hotplug for pseries-2.11
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

On 26/07/17 04:01, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> 
> The 'dr_phb_enabled' field of that class can be set as
> part of machine-specific init code, and is then propagated
> to sPAPREnvironment to conditionally enable creation of DRC
> objects and device-tree description to facilitate hotplug
> of PHBs.
> 
> Since we can't migrate this state to older machine types,
> default the option to true and disable it for older machine
> types.
> 
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> Changes since RFC:
> - rebased against ppc-for-2.10
> - updated changelog and title
> - set default to true and disable for 2.10 and older
> ---
>  hw/ppc/spapr.c         |    6 ++++++
>  include/hw/ppc/spapr.h |    3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 277daa4f9645..8dc505343c0f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2382,6 +2382,8 @@ static void ppc_spapr_init(MachineState *machine)
>      /* We always have at least the nvram device on VIO */
>      spapr_create_nvram(spapr);
>  
> +    spapr->dr_phb_enabled = smc->dr_phb_enabled;
> +
>      /* Set up PCI */
>      spapr_pci_rtas_init();
>  
> @@ -3482,6 +3484,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift = 28;
> +    smc->dr_phb_enabled = true;
>  }
>  
>  static const TypeInfo spapr_machine_info = {
> @@ -3558,8 +3561,11 @@ static void spapr_machine_2_10_instance_options(MachineState *machine)
>  
>  static void spapr_machine_2_10_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_11_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
> +    smc->dr_phb_enabled = false;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a705c17..8004d9c2ab2c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -59,6 +59,7 @@ struct sPAPRMachineClass {
>  
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
> +    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
>      bool pre_2_10_has_unused_icps;
> @@ -122,6 +123,8 @@ struct sPAPRMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
>  
> +    bool dr_phb_enabled; /* hotplug / dynamic-reconfiguration of PHBs */

The one in the class seems sufficient unless we are going to allow
disabling this via the command line.



> +
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> 
> 


-- 
Alexey
