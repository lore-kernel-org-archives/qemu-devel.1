Received: from eggs.gnu.org ([2001:4830:134:3::10]:44062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d966j-0004A8-5W
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d966g-0000ZC-1z
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:39:29 -0400
References: <20170512050451.9979-1-david@gibson.dropbear.id.au>
	<20170512050451.9979-4-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3a2b9076-097e-c505-de81-81ffcf4f90f5@redhat.com>
Date: Fri, 12 May 2017 10:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170512050451.9979-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] pseries: Enable HPT resizing for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, thuth@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, aik@ozlabs.ru
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, benh@kernel.crashing.org

On 12/05/2017 07:04, David Gibson wrote:
> We've now implemented a PAPR extensions which allows PAPR guests (i.e.
> "pseries" machine type) to resize their hash page table during runtime.
> 
> However, that extension is only enabled if explicitly chosen on the
> command line.  This patch enables it by default for spapr-2.10, but leaves
> it disabled (by default) for older machine types.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b9b7733..a0f5139 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3224,7 +3224,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->dr_lmb_enabled = true;
>      smc->tcg_default_cpu = "POWER8";
>      mc->has_hotpluggable_cpus = true;
> -    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
> +    smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path = spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler = spapr_nmi;
>      smc->phb_placement = spapr_phb_placement;
> @@ -3320,8 +3320,11 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
>  
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> +    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
