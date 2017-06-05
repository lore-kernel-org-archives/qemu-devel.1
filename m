Received: from eggs.gnu.org ([2001:4830:134:3::10]:52886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dHtdg-00042f-VU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dHtdc-0002sh-Qq
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:09:52 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dHtdc-0002s0-Hz
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:09:48 -0400
Received: by mail-wm0-x234.google.com with SMTP id d73so26649261wma.0
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 08:09:46 -0700 (PDT)
References: <20170602130518.22943-1-alex.bennee@linaro.org>
	<20170602130518.22943-4-alex.bennee@linaro.org>
	<d2c59ba0-6b90-4dba-f7af-087a66d43142@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d2c59ba0-6b90-4dba-f7af-087a66d43142@redhat.com>
Date: Mon, 05 Jun 2017 16:10:07 +0100
Message-ID: <87shjeh3n4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qom/cpu: remove host_tid field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/06/2017 15:05, Alex Bennée wrote:
>> This was only used by the gdbstub and even then was only being set for
>> subsequent threads. Rather the continue duplicating the number just
>> make the gdbstub get the information from TaskState structure.
>>
>> Now the tid is correctly reported for all threads the bug I was seeing
>> with "vCont;C04:0;c" packets is fixed as the correct tid is reported
>> to gdb.
>>
>> I moved cpu_gdb_index into the gdbstub to facilitate easy access to
>> the TaskState which is used elsewhere in gdbstub.
>
> I think bsd-user does not have ts_tid?

I'll test the build on BSD, I think I have a VM somewhere.

>
> Thanks,
>
> Paolo
>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>
>> ---
>> v3
>>   - fix merge, did move of function in previous commit
>> ---
>>  gdbstub.c            | 3 ++-
>>  include/qom/cpu.h    | 2 --
>>  linux-user/syscall.c | 1 -
>>  3 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 57befe16e2..45a3a0b16b 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -63,7 +63,8 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
>>  static inline int cpu_gdb_index(CPUState *cpu)
>>  {
>>  #if defined(CONFIG_USER_ONLY)
>> -    return cpu->host_tid;
>> +    TaskState *ts = (TaskState *) cpu->opaque;
>> +    return ts->ts_tid;
>>  #else
>>      return cpu->cpu_index + 1;
>>  #endif
>> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
>> index 55214ce131..909e7ae994 100644
>> --- a/include/qom/cpu.h
>> +++ b/include/qom/cpu.h
>> @@ -266,7 +266,6 @@ struct qemu_work_item;
>>   * @nr_cores: Number of cores within this CPU package.
>>   * @nr_threads: Number of threads within this CPU.
>>   * @numa_node: NUMA node this CPU is belonging to.
>> - * @host_tid: Host thread ID.
>>   * @running: #true if CPU is currently running (lockless).
>>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>>   * valid under cpu_list_lock.
>> @@ -321,7 +320,6 @@ struct CPUState {
>>      HANDLE hThread;
>>  #endif
>>      int thread_id;
>> -    uint32_t host_tid;
>>      bool running, has_waiter;
>>      struct QemuCond *halt_cond;
>>      bool thread_kicked;
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 925ae11ea6..003943b736 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -6219,7 +6219,6 @@ static void *clone_func(void *arg)
>>      thread_cpu = cpu;
>>      ts = (TaskState *)cpu->opaque;
>>      info->tid = gettid();
>> -    cpu->host_tid = info->tid;
>>      task_settid(ts);
>>      if (info->child_tidptr)
>>          put_user_u32(info->tid, info->child_tidptr);
>>


--
Alex Bennée
