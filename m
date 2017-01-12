Received: from eggs.gnu.org ([2001:4830:134:3::10]:44658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRaSr-0007il-CM
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRaSm-0005u4-DL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:10:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484167250-16089-1-git-send-email-thuth@redhat.com>
Date: Thu, 12 Jan 2017 09:10:21 +0100
In-Reply-To: <1484167250-16089-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Wed, 11 Jan 2017 21:40:50 +0100")
Message-ID: <87tw94em1e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] monitor: Fix crashes when using HMP
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> When running certain HMP commands ("info registers", "info cpustats"
> or dumping virtual memory) with the "none" machine, QEMU crashes
> with a segmentation fault. This happens because the "none" machine does
> not have any CPUs by default,

"Sachen gibt's!"

>                               but these HMP commands did not check for
> a valid CPU pointer yet. Add such a check now and print a message
> about the missing CPU instead.

Have you checked uses of first_cpu elsewhere?  Out of scope for this
patch, of course.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  monitor.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 0841d43..0103979 100644
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

Why are the following dereferences safe?

   CPUArchState *mon_get_cpu_env(void)
   {
       return mon_get_cpu()->env_ptr;
   }

   int monitor_get_cpu_index(void)
   {
       return mon_get_cpu()->cpu_index;
   }

> @@ -1043,7 +1046,13 @@ int monitor_get_cpu_index(void)
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
> @@ -1076,7 +1085,13 @@ static void hmp_info_history(Monitor *mon, const QDict *qdict)
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
> @@ -1235,6 +1250,12 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
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
> @@ -1264,7 +1285,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>          flags = msr_le << 16;
>          flags |= env->bfd_mach;
>  #endif
> -        monitor_disas(mon, mon_get_cpu(), addr, count, is_physical, flags);
> +        monitor_disas(mon, cs, addr, count, is_physical, flags);
>          return;
>      }
>  
> @@ -1303,7 +1324,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>          if (is_physical) {
>              cpu_physical_memory_read(addr, buf, l);
>          } else {
> -            if (cpu_memory_rw_debug(mon_get_cpu(), addr, buf, l, 0) < 0) {
> +            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
>                  monitor_printf(mon, " Cannot access memory\n");
>                  break;
>              }
