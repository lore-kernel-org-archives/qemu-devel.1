Received: from eggs.gnu.org ([2001:4830:134:3::10]:52853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNItr-0004Tw-3k
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dNItn-0003F0-VV
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:08:55 -0400
References: <149789192064.8356.6383758991647148922.stgit@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3f9a94c6-6391-d45e-fbd9-32a8e1e8504f@redhat.com>
Date: Tue, 20 Jun 2017 15:08:47 +0200
MIME-Version: 1.0
In-Reply-To: <149789192064.8356.6383758991647148922.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr/ppc: fix backward
 migration to QEMU 2.9
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

On 19/06/2017 19:05, Greg Kurz wrote:
> Commit c783b0012708 ("ppc: Rework CPU compatibility testing across
> migration") added a subsection to the vmstate description of CPUs.
> This subsection is sent when the CPU compat_pvr field is non-zero,
> which is likely to happen after CAS negociation (since QEMU 2.9) or
> even before CAS negociation if the user explicitely asked for compat
> mode.
> 
> This breaks backward migration of existing pseries-2.9 machine types
> since they don't know about this "compat" subsection:
> 
> qemu-system-ppc64: error while loading state for instance 0x0 of
>  device 'cpu'
> 
> This patch reverts to the behavior of simply ignoring the PVR when
> migrating older machines (ie, let the migration succeed if the user
> is sure that the CPU on the destination is close enough to work).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

but I think it should be merged with patch ("ppc: Rework CPU
compatibility testing across migration") that is not merged and in the
maintainer tree.

thanks,
Laurent

> ---
>  hw/ppc/spapr.c              |    7 ++++++-
>  target/ppc/cpu.h            |    1 +
>  target/ppc/machine.c        |    2 +-
>  target/ppc/translate_init.c |    2 ++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d4d781876b27..265d49bbcd7f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3474,7 +3474,12 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
>   * pseries-2.9
>   */
>  #define SPAPR_COMPAT_2_9                                               \
> -    HW_COMPAT_2_9
> +    HW_COMPAT_2_9                                                      \
> +    {                                                                  \
> +        .driver = TYPE_POWERPC_CPU,                                    \
> +        .property = "pre-2.10-migration",                              \
> +        .value    = "on",                                              \
> +    },                                                                 \
>  
>  static void spapr_machine_2_9_instance_options(MachineState *machine)
>  {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 09393e601fd9..6ee2a26a963d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1211,6 +1211,7 @@ struct PowerPCCPU {
>      uint64_t mig_insns_flags;
>      uint64_t mig_insns_flags2;
>      uint32_t mig_nb_BATs;
> +    bool pre_2_10_migration;
>  };
>  
>  static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index a29aabe8f079..1b7aede579ea 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -608,7 +608,7 @@ static bool compat_needed(void *opaque)
>      PowerPCCPU *cpu = opaque;
>  
>      assert(!(cpu->compat_pvr && !cpu->vhyp));
> -    return (cpu->compat_pvr != 0);
> +    return !cpu->pre_2_10_migration && cpu->compat_pvr != 0;
>  }
>  
>  static const VMStateDescription vmstate_compat = {
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 53aff5a7b734..783bf98217cc 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10610,6 +10610,8 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
>  
>  static Property ppc_cpu_properties[] = {
>      DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
> +    DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
> +                     false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> 
> 
