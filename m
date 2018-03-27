Received: from eggs.gnu.org ([2001:4830:134:3::10]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f0ips-0000as-LA
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f0ipp-0008I2-En
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:16:00 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:55631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f0ipp-0008Gd-8Z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:15:57 -0400
Received: from player168.ha.ovh.net (unknown [10.109.122.134])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 7F703B423
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:15:55 +0200 (CEST)
Date: Tue, 27 Mar 2018 09:15:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180327091544.2bcd5380@bahia.lan>
In-Reply-To: <20180327043741.7705-4-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 03/12] target/ppc: Pass cpu instead
 of env to ppc_create_page_sizes_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org

On Tue, 27 Mar 2018 15:37:32 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> As a rule we prefer to pass PowerPCCPU instead of CPUPPCState, and this
> change will make some things simpler later on.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/fdt.c         | 5 +++--
>  hw/ppc/pnv.c         | 4 ++--
>  hw/ppc/spapr.c       | 4 ++--
>  include/hw/ppc/fdt.h | 2 +-
>  4 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
> index 2ffc5866e4..2721603ffa 100644
> --- a/hw/ppc/fdt.c
> +++ b/hw/ppc/fdt.c
> @@ -13,9 +13,10 @@
>  #include "hw/ppc/fdt.h"
>  
>  #if defined(TARGET_PPC64)
> -size_t ppc_create_page_sizes_prop(CPUPPCState *env, uint32_t *prop,
> -                                     size_t maxsize)
> +size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
> +                                  size_t maxsize)
>  {
> +    CPUPPCState *env = &cpu->env;
>      size_t maxcells = maxsize / sizeof(uint32_t);
>      int i, j, count;
>      uint32_t *p = prop;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 98ee3c607a..5a79b24828 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -209,8 +209,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
>  
> -    page_sizes_prop_size = ppc_create_page_sizes_prop(env, page_sizes_prop,
> -                                                  sizeof(page_sizes_prop));
> +    page_sizes_prop_size = ppc_create_page_sizes_prop(cpu, page_sizes_prop,
> +                                                      sizeof(page_sizes_prop));
>      if (page_sizes_prop_size) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
>                             page_sizes_prop, page_sizes_prop_size)));
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2c0be8c898..a35bffd524 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -581,8 +581,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
>  
> -    page_sizes_prop_size = ppc_create_page_sizes_prop(env, page_sizes_prop,
> -                                                  sizeof(page_sizes_prop));
> +    page_sizes_prop_size = ppc_create_page_sizes_prop(cpu, page_sizes_prop,
> +                                                      sizeof(page_sizes_prop));
>      if (page_sizes_prop_size) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
>                            page_sizes_prop, page_sizes_prop_size)));
> diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
> index bd5b0a8c3d..a8cd85069f 100644
> --- a/include/hw/ppc/fdt.h
> +++ b/include/hw/ppc/fdt.h
> @@ -23,7 +23,7 @@
>          }                                                          \
>      } while (0)
>  
> -size_t ppc_create_page_sizes_prop(CPUPPCState *env, uint32_t *prop,
> +size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
>                                    size_t maxsize);
>  
>  #endif /* PPC_FDT_H */
