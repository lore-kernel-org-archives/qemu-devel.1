Received: from eggs.gnu.org ([2001:4830:134:3::10]:49295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YH7-0004gF-8G
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YH3-0003zm-VM
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:48:37 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9YH3-0003zM-OA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:48:33 -0400
Received: from player696.ha.ovh.net (unknown [10.109.108.38])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2E47114770
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:48:32 +0200 (CEST)
Date: Fri, 20 Apr 2018 17:48:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420174828.4a73bf54@bahia.lan>
In-Reply-To: <20180417071722.9399-8-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-8-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 07/10] spapr: Make a helper to set
 up cpu entry point state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 17 Apr 2018 17:17:19 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Under PAPR, only the boot CPU is active when the system starts.  Other cpus
> must be explicitly activated using an RTAS call.  The entry state for the
> boot and secondary cpus isn't identical, but it has some things in common.
> We're going to add a bit more common setup later, too, so to simplify
> make a helper which sets up the common entry state for both boot and
> secondary cpu threads.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c                  | 4 +---
>  hw/ppc/spapr_cpu_core.c         | 9 +++++++++
>  hw/ppc/spapr_rtas.c             | 6 +++---
>  include/hw/ppc/spapr_cpu_core.h | 3 +++
>  4 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fbb2c6752c..e0cabfa6ee 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1536,10 +1536,8 @@ static void spapr_machine_reset(void)
>      g_free(fdt);
>  
>      /* Set up the entry state */
> -    first_ppc_cpu->env.gpr[3] = fdt_addr;
> +    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>      first_ppc_cpu->env.gpr[5] = 0;
> -    first_cpu->halted = 0;
> -    first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
>  
>      spapr->cas_reboot = false;
>  }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index b1c3cf11f0..ecd40dbf03 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -80,6 +80,15 @@ static void spapr_cpu_reset(void *opaque)
>      env->spr[SPR_AMOR] = 0xffffffffffffffffull;
>  }
>  
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
> +{
> +    CPUPPCState *env = &cpu->env;
> +
> +    env->nip = SPAPR_ENTRY_POINT;
> +    env->gpr[3] = r3;
> +    CPU(cpu)->halted = 0;
> +}
> +
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
>  {
>      qemu_unregister_reset(spapr_cpu_reset, cpu);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0ec5fa4cfe..d79aa44467 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -37,6 +37,7 @@
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/ppc/spapr_rtas.h"
> +#include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/boards.h"
>  
> @@ -173,14 +174,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
>           * new cpu enters */
>          kvm_cpu_synchronize_state(cs);
>  
> +        spapr_cpu_set_entry_state(cpu, start, r3);
> +
>          env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
>  
>          /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
>          env->spr[SPR_LPCR] |= pcc->lpcr_pm;
>  
> -        env->nip = start;
> -        env->gpr[3] = r3;
> -        cs->halted = 0;
>          spapr_cpu_set_endianness(cpu);
>          spapr_cpu_update_tb_offset(cpu);
>  
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 1a38544706..11cab30838 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -12,6 +12,7 @@
>  #include "hw/qdev.h"
>  #include "hw/cpu/core.h"
>  #include "target/ppc/cpu-qom.h"
> +#include "target/ppc/cpu.h"
>  
>  #define TYPE_SPAPR_CPU_CORE "spapr-cpu-core"
>  #define SPAPR_CPU_CORE(obj) \
> @@ -40,4 +41,6 @@ typedef struct sPAPRCPUCoreClass {
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
>  void spapr_cpu_core_reset(sPAPRCPUCore *sc);
>  
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
> +
>  #endif
