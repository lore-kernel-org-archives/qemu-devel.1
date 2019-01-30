Received: from eggs.gnu.org ([209.51.188.92]:56683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gopDS-0005G3-4C
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gopDG-0006bo-El
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:43:34 -0500
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:36358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gopDA-0006QY-TV
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:43:26 -0500
Received: from player159.ha.ovh.net (unknown [10.109.146.50])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 524301CDF1B
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 13:43:10 +0100 (CET)
Date: Wed, 30 Jan 2019 13:43:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190130134303.754a43ab@bahia.lan>
In-Reply-To: <20190130014216.98287-1-aik@ozlabs.ru>
References: <20190130014216.98287-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] spapr: Drop unused
 parameters from fdt building helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 30 Jan 2019 12:42:16 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> spapr_load_rtas() handles now RTAS address and size information in the FDT
> so drop them from spapr_build_fdt().
> 
> While we are here, fix a small typo.
> 
> Fixes: 2cac78c12ade9 "pseries: Consolidate RTAS loading"

One nit. The last rtas_* user in spapr_build_fdt() was removed by the
following hunk:

@@ -949,12 +966,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
         }
     }
 
-    /* RTAS */
-    ret = spapr_rtas_device_tree_setup(fdt, rtas_addr, rtas_size);
-    if (ret < 0) {
-        error_report("Couldn't set up RTAS device tree properties");
-    }
-
     /* cpus */
     spapr_populate_cpus_dt_node(fdt, spapr);
 
from commit:

3f5dabceba24 "pseries: Consolidate construction of /rtas device tree node"

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/ppc/spapr.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a217c7f..fa12723 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1225,9 +1225,7 @@ static void spapr_dt_hypervisor(sPAPRMachineState *spapr, void *fdt)
>      }
>  }
>  
> -static void *spapr_build_fdt(sPAPRMachineState *spapr,
> -                             hwaddr rtas_addr,
> -                             hwaddr rtas_size)
> +static void *spapr_build_fdt(sPAPRMachineState *spapr)
>  {
>      MachineState *machine = MACHINE(spapr);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> @@ -1644,14 +1642,14 @@ static void spapr_machine_reset(void)
>  
>      /*
>       * We place the device tree and RTAS just below either the top of the RMA,
> -     * or just below 2GB, whichever is lowere, so that it can be
> +     * or just below 2GB, whichever is lower, so that it can be
>       * processed with 32-bit real mode code if necessary
>       */
>      rtas_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR);
>      rtas_addr = rtas_limit - RTAS_MAX_SIZE;
>      fdt_addr = rtas_addr - FDT_MAX_SIZE;
>  
> -    fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> +    fdt = spapr_build_fdt(spapr);
>  
>      spapr_load_rtas(spapr, fdt, rtas_addr);
>  
