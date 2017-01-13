Received: from eggs.gnu.org ([2001:4830:134:3::10]:34144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS1Ew-0002lX-8k
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS1Et-00011U-2O
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:45:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484309555-1935-1-git-send-email-thuth@redhat.com>
Date: Fri, 13 Jan 2017 13:45:47 +0100
In-Reply-To: <1484309555-1935-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Fri, 13 Jan 2017 13:12:35 +0100")
Message-ID: <87k29zruv8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] monitor: Fix crashes when using HMP
 commands without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Thomas Huth <thuth@redhat.com> writes:

> When running certain HMP commands ("info registers", "info cpustats",
> "info tlb", "nmi", "memsave" or dumping virtual memory) with the "none"
> machine, QEMU crashes with a segmentation fault. This happens because the
> "none" machine does not have any CPUs by default, but these HMP commands
> did not check for a valid CPU pointer yet. Add such checks now, so we get
> an error message about the missing CPU instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v4:
>  - Added some more target-specifc checks (for "info tlb" for example)
>  v3:
>  - Use UNASSIGNED_CPU_INDEX instead of hard-coded -1
>  v2:
>  - Added more checks to cover "nmi" and "memsave", too
>
>  hmp.c                   |  8 +++++++-
>  monitor.c               | 42 ++++++++++++++++++++++++++++++++++--------
>  target/i386/monitor.c   | 16 +++++++++++++++-
>  target/ppc/monitor.c    |  4 ++++
>  target/sh4/monitor.c    |  5 +++++
>  target/sparc/monitor.c  |  4 ++++
>  target/xtensa/monitor.c |  4 ++++
>  7 files changed, 73 insertions(+), 10 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index b869617..b1c503a 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1013,8 +1013,14 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>      const char *filename = qdict_get_str(qdict, "filename");
>      uint64_t addr = qdict_get_int(qdict, "val");
>      Error *err = NULL;
> +    int cpu_index = monitor_get_cpu_index();
>  
> -    qmp_memsave(addr, size, filename, true, monitor_get_cpu_index(), &err);
> +    if (cpu_index < 0) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    qmp_memsave(addr, size, filename, true, cpu_index, &err);
>      hmp_handle_error(mon, &err);
>  }
>  
> diff --git a/monitor.c b/monitor.c
> index 0841d43..bf488e9 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1025,6 +1025,9 @@ int monitor_set_cpu(int cpu_index)
>  CPUState *mon_get_cpu(void)
>  {
>      if (!cur_mon->mon_cpu) {
> +        if (!first_cpu) {
> +            return NULL;
> +        }
>          monitor_set_cpu(first_cpu->cpu_index);
>      }
>      cpu_synchronize_state(cur_mon->mon_cpu);
> @@ -1033,17 +1036,27 @@ CPUState *mon_get_cpu(void)
>  
>  CPUArchState *mon_get_cpu_env(void)
>  {
> -    return mon_get_cpu()->env_ptr;
> +    CPUState *cs = mon_get_cpu();
> +
> +    return cs ? cs->env_ptr : NULL;
>  }
>  
>  int monitor_get_cpu_index(void)
>  {
> -    return mon_get_cpu()->cpu_index;
> +    CPUState *cs = mon_get_cpu();
> +
> +    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>  }
>  
>  static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>  {
> -    cpu_dump_state(mon_get_cpu(), (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
> +    CPUState *cs = mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +    cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
>  }
>  
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
> @@ -1076,7 +1089,13 @@ static void hmp_info_history(Monitor *mon, const QDict *qdict)
>  
>  static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>  {
> -    cpu_dump_statistics(mon_get_cpu(), (FILE *)mon, &monitor_fprintf, 0);
> +    CPUState *cs = mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +    cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
>  }
>  
>  static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
> @@ -1235,6 +1254,12 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
>      uint64_t v;
> +    CPUState *cs = mon_get_cpu();
> +
> +    if (!cs && (format == 'i' || !is_physical)) {
> +        monitor_printf(mon, "Can not dump without CPU\n");
> +        return;
> +    }
>  
>      if (format == 'i') {
>          int flags = 0;
> @@ -1264,7 +1289,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>          flags = msr_le << 16;
>          flags |= env->bfd_mach;
>  #endif
> -        monitor_disas(mon, mon_get_cpu(), addr, count, is_physical, flags);
> +        monitor_disas(mon, cs, addr, count, is_physical, flags);
>          return;
>      }
>  
> @@ -1303,7 +1328,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>          if (is_physical) {
>              cpu_physical_memory_read(addr, buf, l);
>          } else {
> -            if (cpu_memory_rw_debug(mon_get_cpu(), addr, buf, l, 0) < 0) {
> +            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
>                  monitor_printf(mon, " Cannot access memory\n");
>                  break;
>              }
> @@ -2186,11 +2211,12 @@ expr_error(Monitor *mon, const char *fmt, ...)
>  static int get_monitor_def(target_long *pval, const char *name)
>  {
>      const MonitorDef *md = target_monitor_defs();
> +    CPUState *cs = mon_get_cpu();
>      void *ptr;
>      uint64_t tmp = 0;
>      int ret;
>  
> -    if (md == NULL) {
> +    if (cs == NULL || md == NULL) {
>          return -1;
>      }
>  
> @@ -2217,7 +2243,7 @@ static int get_monitor_def(target_long *pval, const char *name)
>          }
>      }
>  
> -    ret = target_get_monitor_def(mon_get_cpu(), name, &tmp);
> +    ret = target_get_monitor_def(cs, name, &tmp);
>      if (!ret) {
>          *pval = (target_long) tmp;
>      }
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 468aa07..77ead60 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -210,6 +210,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      CPUArchState *env;
>  
>      env = mon_get_cpu_env();
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>  
>      if (!(env->cr[0] & CR0_PG_MASK)) {
>          monitor_printf(mon, "PG disabled\n");
> @@ -529,6 +533,10 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>      CPUArchState *env;
>  
>      env = mon_get_cpu_env();
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>  
>      if (!(env->cr[0] & CR0_PG_MASK)) {
>          monitor_printf(mon, "PG disabled\n");

This one

   static target_long monitor_get_pc(const struct MonitorDef *md, int val)
   {
       CPUArchState *env = mon_get_cpu_env();
       return env->eip + env->segs[R_CS].base;
   }

doesn't need a check because it's called only from get_monitor_def(),
and that one checks mon_get_cpu() first.

> @@ -624,7 +632,13 @@ const MonitorDef *target_monitor_defs(void)
>  
>  void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
>  {
> -    x86_cpu_dump_local_apic_state(mon_get_cpu(), (FILE *)mon, monitor_fprintf,
> +    CPUState *cs = mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +    x86_cpu_dump_local_apic_state(cs, (FILE *)mon, monitor_fprintf,
>                                    CPU_DUMP_FPU);
>  }
>  
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index c2d0806..b8f30e9 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c

Same argument for monitor_get_ccr(), monitor_get_decr(),
monitor_get_tbu(), monitor_get_tbl().

> @@ -62,6 +62,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 = mon_get_cpu_env();
>  
> +    if (!env1) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>      dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
>  }
>  
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 426e5d4..4c7f36c 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -44,6 +44,11 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      CPUArchState *env = mon_get_cpu_env();
>      int i;
>  
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
>      monitor_printf (mon, "ITLB:\n");
>      for (i = 0 ; i < ITLB_SIZE ; i++)
>          print_tlb (mon, i, &env->itlb[i]);
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 7cc1b0f..f3ca524 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -32,6 +32,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 = mon_get_cpu_env();
>  
> +    if (!env1) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>      dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
>  }
>  

Same argument for monitor_get_psr(), monitor_get_reg().

> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index f3fa4cd..2ee2b5b 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -31,5 +31,9 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 = mon_get_cpu_env();
>  
> +    if (!env1) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
>      dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
