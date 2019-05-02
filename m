Received: from eggs.gnu.org ([209.51.188.92]:51207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hM1GJ-0004T1-Cj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 22:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hM1GH-0008CN-G6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 22:15:51 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hM1GG-00087U-EY
	for qemu-devel@nongnu.org; Wed, 01 May 2019 22:15:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id e24so329913pfi.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 19:15:47 -0700 (PDT)
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<20190502004420.GD13618@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f1ec028-0bfd-d571-6a34-b8f3adc35a13@ozlabs.ru>
Date: Thu, 2 May 2019 12:15:40 +1000
MIME-Version: 1.0
In-Reply-To: <20190502004420.GD13618@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] monitor: Add dump-stack
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: armbru@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com



On 02/05/2019 10:44, David Gibson wrote:
> On Wed, May 01, 2019 at 03:35:21PM +1000, Suraj Jitindar Singh wrote:
>> Add a monitor command "dump-stack" to be used to dump the stack for the
>> current cpu.
> 
> So, you can already get guest backtraces by using the gdbstub

Not in the field - this requires QEMU to run with -s which is not
usually the case.

But since we almost always deal with QEMUs run by libvirt and HMP/QMP is
always available, one could write a script doing QMP's
"human-monitor-command x/16g" or "virsh qemu-monitor-command --hmp
x/16g" to read the guest memory and MSR:LE and dump the stack with the
exception frame.


> functionality.  I can see some benefit in allowing this more easily
> through hmp, but whether it's worth the code size, I'm less certain.

It still seems easier than running an external script talking to HMP/QMP
as you would not want to write such script in bash but rather in a
better language which might not be installed on the client machine (like
missing python3 on many RHEL :) ). Thanks,



>>
>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> ---
>>  hmp-commands.hx   | 13 +++++++++++++
>>  hmp.h             |  1 +
>>  include/qom/cpu.h | 10 ++++++++++
>>  monitor.c         | 12 ++++++++++++
>>  qom/cpu.c         | 10 ++++++++++
>>  5 files changed, 46 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 9b4035965c..965ccdea28 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -862,6 +862,19 @@ ETEXI
>>      },
>>  
>>  STEXI
>> +@item dump-stack
>> +@findex dump-stack
>> +dump stack of the cpu
>> +ETEXI
>> +    {
>> +        .name           = "dump-stack",
>> +        .args_type      = "",
>> +        .params         = "",
>> +        .help           = "dump stack",
>> +        .cmd            = hmp_dumpstack,
>> +    },
>> +
>> +STEXI
>>  @item pmemsave @var{addr} @var{size} @var{file}
>>  @findex pmemsave
>>  save to disk physical memory dump starting at @var{addr} of size @var{size}.
>> diff --git a/hmp.h b/hmp.h
>> index 43617f2646..e6edf1215c 100644
>> --- a/hmp.h
>> +++ b/hmp.h
>> @@ -51,6 +51,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict);
>>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
>> +void hmp_dumpstack(Monitor *mon, const QDict *qdict);
>>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
>>  void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
>>  void hmp_cont(Monitor *mon, const QDict *qdict);
>> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
>> index 08abcbd3fe..f2e83e9918 100644
>> --- a/include/qom/cpu.h
>> +++ b/include/qom/cpu.h
>> @@ -181,6 +181,7 @@ typedef struct CPUClass {
>>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>>                             uint8_t *buf, int len, bool is_write);
>>      void (*dump_state)(CPUState *cpu, FILE *, int flags);
>> +    void (*dump_stack)(CPUState *cpu, FILE *f);
>>      GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
>>      void (*dump_statistics)(CPUState *cpu, int flags);
>>      int64_t (*get_arch_id)(CPUState *cpu);
>> @@ -568,6 +569,15 @@ enum CPUDumpFlags {
>>  void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>>  
>>  /**
>> + * cpu_dump_stack:
>> + * @cpu: The CPU whose stack is to be dumped.
>> + * @f: If non-null, dump to this stream, else to current print sink.
>> + *
>> + * Dumps CPU stack.
>> + */
>> +void cpu_dump_stack(CPUState *cpu, FILE *f);
>> +
>> +/**
>>   * cpu_dump_statistics:
>>   * @cpu: The CPU whose state is to be dumped.
>>   * @flags: Flags what to dump.
>> diff --git a/monitor.c b/monitor.c
>> index 9b5f10b475..dbec2e4376 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1299,6 +1299,18 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>>      }
>>  }
>>  
>> +void hmp_dumpstack(Monitor *mon, const QDict *qdict)
>> +{
>> +    CPUState *cs = mon_get_cpu();
>> +
>> +    if (!cs) {
>> +        monitor_printf(mon, "No CPU available\n");
>> +        return;
>> +    }
>> +
>> +    cpu_dump_stack(cs, NULL);
>> +}
>> +
>>  #ifdef CONFIG_TCG
>>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>>  {
>> diff --git a/qom/cpu.c b/qom/cpu.c
>> index 3c5493c96c..0dc10004f4 100644
>> --- a/qom/cpu.c
>> +++ b/qom/cpu.c
>> @@ -230,6 +230,16 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
>>      }
>>  }
>>  
>> +void cpu_dump_stack(CPUState *cpu, FILE *f)
>> +{
>> +    CPUClass *cc = CPU_GET_CLASS(cpu);
>> +
>> +    if (cc->dump_stack) {
>> +        cpu_synchronize_state(cpu);
>> +        cc->dump_stack(cpu, f);
>> +    }
>> +}
>> +
>>  void cpu_dump_statistics(CPUState *cpu, int flags)
>>  {
>>      CPUClass *cc = CPU_GET_CLASS(cpu);
> 

-- 
Alexey
