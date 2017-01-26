Received: from eggs.gnu.org ([2001:4830:134:3::10]:50745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cWjLp-0000CG-JS
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cWjLl-0007M0-Ij
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:40:29 -0500
Date: Thu, 26 Jan 2017 13:40:21 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170126124021.GG9606@toto>
References: <20170126101600.16348-1-caliborn@sdf.lonestar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170126101600.16348-1-caliborn@sdf.lonestar.org>
Subject: Re: [Qemu-devel] [PATCH v2.1] target-ppc: Add MMU model check for
 booke machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Valentin Plotkin <caliborn@sdf.lonestar.org>
Cc: qemu-devel@nongnu.org, Valentin Plotkin <caliborn@sdf.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Scott Wood <scottwood@freescale.com>, qemu-ppc@nongnu.org

On Thu, Jan 26, 2017 at 10:15:59AM +0000, Valentin Plotkin wrote:
> From: Valentin Plotkin <caliborn@sdf.org>
> 
> Machines bamboo, e500 and virtex-ml507 assume a certain MMU model,
> otherwise resulting in unpredictable behavior. Add apropriate checks
> into *_init functions.

Thanks Valentin.

Regarding the virtex parts:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Valentin Plotkin <caliborn@sdf.org>
> ---
>  hw/ppc/e500.c          | 6 ++++++
>  hw/ppc/ppc440_bamboo.c | 6 ++++++
>  hw/ppc/virtex_ml507.c  | 7 +++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index cf8b122..5b1958c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -827,6 +827,12 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>          env = &cpu->env;
>          cs = CPU(cpu);
>  
> +        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
> +            fprintf(stderr, "MMU model %i not supported by this machine.\n",
> +                env->mmu_model);
> +            exit(1);
> +        }
> +
>          if (!firstenv) {
>              firstenv = env;
>          }
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 5c535b1..9d997bf 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -193,6 +193,12 @@ static void bamboo_init(MachineState *machine)
>      }
>      env = &cpu->env;
>  
> +    if (env->mmu_model != POWERPC_MMU_BOOKE) {
> +        fprintf(stderr, "MMU model %i not supported by this machine.\n",
> +            env->mmu_model);
> +        exit(1);
> +    }
> +
>      qemu_register_reset(main_cpu_reset, cpu);
>      ppc_booke_timers_init(cpu, 400000000, 0);
>      ppc_dcr_init(env, NULL, NULL);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index b97d966..fdbcf22 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -221,6 +221,13 @@ static void virtex_init(MachineState *machine)
>  
>      cpu = ppc440_init_xilinx(&ram_size, 1, machine->cpu_model, 400000000);
>      env = &cpu->env;
> +
> +    if (env->mmu_model != POWERPC_MMU_BOOKE) {
> +        fprintf(stderr, "MMU model %i not supported by this machine.\n",
> +            env->mmu_model);
> +        exit(1);
> +    }
> +
>      qemu_register_reset(main_cpu_reset, cpu);
>  
>      memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size);
> -- 
> 2.5.5
> 
> 
> This fixes 'qemu-system-ppc -nographic -cpu G2leGP3 -M ppce500; bug from
> BiteSizedTasks.
> 
> Version 2: fixed style, moved checks from mmubooke_create_initial_mapping
> to *_init. Thanks to Thomas Huth <thuth@redhat.com>.
> 
> Version 2.1: seems like my mailer added linebreaks without ever notyfing.
> Sorry for the mess, will use git send-mail from now on.
