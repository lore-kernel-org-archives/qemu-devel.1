Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cS0BI-0007lM-7j
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cS0BF-0006r8-1H
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:38:04 -0500
References: <1484224732-1345-1-git-send-email-thuth@redhat.com>
	<877f609rkd.fsf@dusky.pond.sub.org>
	<03307c8a-b802-861a-fa8c-0af78df41c8a@redhat.com>
	<87k29z4cgp.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <13275c28-83f5-32ad-583c-311775c7d0c9@redhat.com>
Date: Fri, 13 Jan 2017 12:37:56 +0100
MIME-Version: 1.0
In-Reply-To: <87k29z4cgp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] monitor: Fix crashes when using HMP
 commands without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 13.01.2017 08:59, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 12.01.2017 17:22, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> When running certain HMP commands ("info registers", "info cpustats",
>>>> "nmi", "memsave" or dumping virtual memory) with the "none" machine,
>>>> QEMU crashes with a segmentation fault. This happens because the "none"
>>>> machine does not have any CPUs by default, but these HMP commands did
>>>> not check for a valid CPU pointer yet. Add such checks now, so we get
>>>> an error message about the missing CPU instead.
>>>>
>>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  v3:
>>>>  - Use UNASSIGNED_CPU_INDEX instead of hard-coded -1
>>>>  v2:
>>>>  - Added more checks to cover "nmi" and "memsave", too
>>>>
>>>>  hmp.c     |  8 +++++++-
>>>>  monitor.c | 37 +++++++++++++++++++++++++++++++------
>>>>  2 files changed, 38 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hmp.c b/hmp.c
>>>> index b869617..b1c503a 100644
>>>> --- a/hmp.c
>>>> +++ b/hmp.c
>>>> @@ -1013,8 +1013,14 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>>>>      const char *filename = qdict_get_str(qdict, "filename");
>>>>      uint64_t addr = qdict_get_int(qdict, "val");
>>>>      Error *err = NULL;
>>>> +    int cpu_index = monitor_get_cpu_index();
>>>>  
>>>> -    qmp_memsave(addr, size, filename, true, monitor_get_cpu_index(), &err);
>>>> +    if (cpu_index < 0) {
>>>> +        monitor_printf(mon, "No CPU available\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    qmp_memsave(addr, size, filename, true, cpu_index, &err);
>>>>      hmp_handle_error(mon, &err);
>>>>  }
>>>>  
>>>> diff --git a/monitor.c b/monitor.c
>>>> index 0841d43..17121ff 100644
>>>> --- a/monitor.c
>>>> +++ b/monitor.c
>>>> @@ -1025,6 +1025,9 @@ int monitor_set_cpu(int cpu_index)
>>>>  CPUState *mon_get_cpu(void)
>>>>  {
>>>>      if (!cur_mon->mon_cpu) {
>>>> +        if (!first_cpu) {
>>>> +            return NULL;
>>>> +        }
>>>>          monitor_set_cpu(first_cpu->cpu_index);
>>>>      }
>>>>      cpu_synchronize_state(cur_mon->mon_cpu);
>>>> @@ -1033,17 +1036,27 @@ CPUState *mon_get_cpu(void)
>>>>  
>>>>  CPUArchState *mon_get_cpu_env(void)
>>>>  {
>>>> -    return mon_get_cpu()->env_ptr;
>>>> +    CPUState *cs = mon_get_cpu();
>>>> +
>>>> +    return cs ? cs->env_ptr : NULL;
>>>>  }
>>>>  
>>>>  int monitor_get_cpu_index(void)
>>>>  {
>>>> -    return mon_get_cpu()->cpu_index;
>>>> +    CPUState *cs = mon_get_cpu();
>>>> +
>>>> +    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>>>>  }
>>>>  
>>>>  static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>>>>  {
>>>> -    cpu_dump_state(mon_get_cpu(), (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
>>>> +    CPUState *cs = mon_get_cpu();
>>>> +
>>>> +    if (!cs) {
>>>> +        monitor_printf(mon, "No CPU available\n");
>>>> +        return;
>>>> +    }
>>>> +    cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
>>>>  }
>>>>  
>>>>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>>>> @@ -1076,7 +1089,13 @@ static void hmp_info_history(Monitor *mon, const QDict *qdict)
>>>>  
>>>>  static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>>>>  {
>>>> -    cpu_dump_statistics(mon_get_cpu(), (FILE *)mon, &monitor_fprintf, 0);
>>>> +    CPUState *cs = mon_get_cpu();
>>>> +
>>>> +    if (!cs) {
>>>> +        monitor_printf(mon, "No CPU available\n");
>>>> +        return;
>>>> +    }
>>>> +    cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
>>>>  }
>>>>  
>>>>  static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>>>> @@ -1235,6 +1254,12 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>>>>      int l, line_size, i, max_digits, len;
>>>>      uint8_t buf[16];
>>>>      uint64_t v;
>>>> +    CPUState *cs = mon_get_cpu();
>>>> +
>>>> +    if (!cs && (format == 'i' || !is_physical)) {
>>>> +        monitor_printf(mon, "Can not dump without CPU\n");
>>>> +        return;
>>>> +    }
>>>
>>> This is basically "if (we're going to dereference cs)".  Not so nice, in
>>> particular since the dereferences are hidden inside mon_get_cpu_env()
>>> calls.  I guess it'll do.
>>>
>>>>  
>>>>      if (format == 'i') {
>>>>          int flags = 0;
>>>> @@ -1264,7 +1289,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>>>>          flags = msr_le << 16;
>>>>          flags |= env->bfd_mach;
>>>>  #endif
>>>> -        monitor_disas(mon, mon_get_cpu(), addr, count, is_physical, flags);
>>>> +        monitor_disas(mon, cs, addr, count, is_physical, flags);
>>>>          return;
>>>>      }
>>>>  
>>>> @@ -1303,7 +1328,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>>>>          if (is_physical) {
>>>>              cpu_physical_memory_read(addr, buf, l);
>>>>          } else {
>>>> -            if (cpu_memory_rw_debug(mon_get_cpu(), addr, buf, l, 0) < 0) {
>>>> +            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
>>>>                  monitor_printf(mon, " Cannot access memory\n");
>>>>                  break;
>>>>              }
>>>
>>> What about get_monitor_def()?
>>>
>>>     $ qemu-system-x86_64 --nodefaults -S -display none -M none -monitor stdio
>>>     QEMU 2.8.50 monitor - type 'help' for more information
>>>     (qemu) p $pc
>>>     Segmentation fault (core dumped)
>>
>> Oh, I saw that get_monitor_def() uses mon_get_cpu_env(), but I only
>> checked with qemu-system-m68k where "p $pc" simply prints "unknown
>> register" when you run it with the "none" machine ... that's why I
>> assumed that no fixes would be needed here.
>>
>>> Likewise, info tlb, info mem, ... 
>>
>> These seem to be target specific, too, so I think they could go into a
>> separate patch instead. If it's OK for you, I'd like to keep my current
>> patch as it is, and add these items to
>> http://qemu-project.org/BiteSizedTasks instead - since these are all
>> non-urgent problems that should be easy to fix for newcomers, too.
> 
> I'm not into rejecting partial fixes to blackmail for more complete
> fixes.  But let's add a FIXME comment next to mon_get_cpu(), to record
> the issue in the source code, and not just the web site.

Hmm, I just changed my mind. Before I respin the patch with a FIXME
comment + update the website, I think it's faster if I just add those
missing checks directly. ... so I'll send a v4 with those checks added...

 Thomas
