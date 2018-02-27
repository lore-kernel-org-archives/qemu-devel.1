Received: from eggs.gnu.org ([2001:4830:134:3::10]:36251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eql7U-0008ND-EE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eql7R-0000RI-9m
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:41:00 -0500
Date: Tue, 27 Feb 2018 19:40:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180227194042.GJ2847@work-vm>
References: <1518797321-28356-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518797321-28356-6-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518797321-28356-6-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv5 5/5] hmp: change hmp_info_cpus to use
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

* Viktor Mihajlovski (mihajlov@linux.vnet.ibm.com) wrote:
> Changing the implementation of hmp_info_cpus() to call
> qmp_query_cpus_fast() instead of qmp_query_cpus. This has the
> following consequences:
> 
>   o No further code change required for qmp_query_cpus deprecation
> 
>   o HMP profits from the less disruptive cpu information retrieval
> 
>   o HMP 'info cpus' won't display architecture specific data anymore,
>     which should be tolerable in the light of the deprecation of
>     query-cpus.
> 
> In order to allow 'info cpus' to be executed completely on the
> fast path, monitor_get_cpu_index() has been adapted to not synchronize
> the cpu state.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Yep, that's fine we let HMP change over time.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c     | 41 +++++++----------------------------------
>  monitor.c | 13 ++++++++++---
>  2 files changed, 17 insertions(+), 37 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 7870d6a..ae86bfb 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -360,50 +360,23 @@ void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict)
>  
>  void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>  {
> -    CpuInfoList *cpu_list, *cpu;
> +    CpuInfoFastList *cpu_list, *cpu;
>  
> -    cpu_list = qmp_query_cpus(NULL);
> +    cpu_list = qmp_query_cpus_fast(NULL);
>  
>      for (cpu = cpu_list; cpu; cpu = cpu->next) {
>          int active = ' ';
>  
> -        if (cpu->value->CPU == monitor_get_cpu_index()) {
> +        if (cpu->value->cpu_index == monitor_get_cpu_index()) {
>              active = '*';
>          }
>  
> -        monitor_printf(mon, "%c CPU #%" PRId64 ":", active, cpu->value->CPU);
> -
> -        switch (cpu->value->arch) {
> -        case CPU_INFO_ARCH_X86:
> -            monitor_printf(mon, " pc=0x%016" PRIx64, cpu->value->u.x86.pc);
> -            break;
> -        case CPU_INFO_ARCH_PPC:
> -            monitor_printf(mon, " nip=0x%016" PRIx64, cpu->value->u.ppc.nip);
> -            break;
> -        case CPU_INFO_ARCH_SPARC:
> -            monitor_printf(mon, " pc=0x%016" PRIx64,
> -                           cpu->value->u.q_sparc.pc);
> -            monitor_printf(mon, " npc=0x%016" PRIx64,
> -                           cpu->value->u.q_sparc.npc);
> -            break;
> -        case CPU_INFO_ARCH_MIPS:
> -            monitor_printf(mon, " PC=0x%016" PRIx64, cpu->value->u.q_mips.PC);
> -            break;
> -        case CPU_INFO_ARCH_TRICORE:
> -            monitor_printf(mon, " PC=0x%016" PRIx64, cpu->value->u.tricore.PC);
> -            break;
> -        default:
> -            break;
> -        }
> -
> -        if (cpu->value->halted) {
> -            monitor_printf(mon, " (halted)");
> -        }
> -
> -        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
> +        monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
> +                       cpu->value->cpu_index);
> +        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
>      }
>  
> -    qapi_free_CpuInfoList(cpu_list);
> +    qapi_free_CpuInfoFastList(cpu_list);
>  }
>  
>  static void print_block_info(Monitor *mon, BlockInfo *info,
> diff --git a/monitor.c b/monitor.c
> index f499250..db57241 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1055,7 +1055,7 @@ int monitor_set_cpu(int cpu_index)
>      return 0;
>  }
>  
> -CPUState *mon_get_cpu(void)
> +static CPUState *mon_get_cpu_sync(bool synchronize)
>  {
>      CPUState *cpu;
>  
> @@ -1074,10 +1074,17 @@ CPUState *mon_get_cpu(void)
>          monitor_set_cpu(first_cpu->cpu_index);
>          cpu = first_cpu;
>      }
> -    cpu_synchronize_state(cpu);
> +    if (synchronize) {
> +        cpu_synchronize_state(cpu);
> +    }
>      return cpu;
>  }
>  
> +CPUState *mon_get_cpu(void)
> +{
> +    return mon_get_cpu_sync(true);
> +}
> +
>  CPUArchState *mon_get_cpu_env(void)
>  {
>      CPUState *cs = mon_get_cpu();
> @@ -1087,7 +1094,7 @@ CPUArchState *mon_get_cpu_env(void)
>  
>  int monitor_get_cpu_index(void)
>  {
> -    CPUState *cs = mon_get_cpu();
> +    CPUState *cs = mon_get_cpu_sync(false);
>  
>      return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>  }
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
