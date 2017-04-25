Received: from eggs.gnu.org ([2001:4830:134:3::10]:49171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d32RU-0004df-R5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d32RP-00054Z-UC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:31:52 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d32RP-00053j-Nd
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:31:47 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w50so87710402wrc.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:31:47 -0700 (PDT)
References: <20170411105031.28904-1-alex.bennee@linaro.org>
	<20170411105031.28904-3-alex.bennee@linaro.org>
	<5280a17f-833c-33b8-256f-3083482d58b9@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5280a17f-833c-33b8-256f-3083482d58b9@redhat.com>
Date: Tue, 25 Apr 2017 16:32:13 +0100
Message-ID: <87a874bj0i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] cpus: dump TLB flush counts as
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: bobby.prani@gmail.com, rth@twiddle.net, stefanha@redhat.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/04/2017 18:50, Alex Bennée wrote:
>> This can be pre-processed later from the trace file.
>
> What about skipping this patch, and instead adding five trace points
>
> trace_tlb_flush_self(int vcpu)
> trace_tlb_flush_async_schedule(int from, int to)
> trace_tlb_flush_async_work(int vcpu)
> trace_tlb_flush_synced_schedule(int vcpu)
> trace_tlb_flush_synced_work(int vcpu)
>
> The disadvantage is that the TLB flush counts are not emitted in "info
> tcg", but the resulting information is finer-grained and the offline
> accumulation of tracepoints can provide the same information.

In principle I agree. It depends if people find the console based TCG
information useful or not.

I could macro-up something that would use counters when tracing is not
enabled and prompt users to use the tracing interface in the console
when it is.

>
> Paolo
>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  cpus.c       | 6 ++++++
>>  trace-events | 3 +++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 740b8dc3f8..fae7344df5 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -50,6 +50,8 @@
>>  #include "qapi-event.h"
>>  #include "hw/nmi.h"
>>  #include "sysemu/replay.h"
>> +#include "exec/cputlb.h"
>> +#include "trace-root.h"
>>
>>  #ifdef CONFIG_LINUX
>>
>> @@ -1252,6 +1254,10 @@ static int tcg_cpu_exec(CPUState *cpu)
>>      int64_t ti;
>>  #endif
>>
>> +    trace_tlb_flush_stats(tlb_self_flush_count,
>> +                          tlb_async_flush_count,
>> +                          tlb_synced_flush_count);
>> +
>>  #ifdef CONFIG_PROFILER
>>      ti = profile_getclock();
>>  #endif
>> diff --git a/trace-events b/trace-events
>> index b07a09ba95..fc23e15d25 100644
>> --- a/trace-events
>> +++ b/trace-events
>> @@ -94,6 +94,9 @@ disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
>>  disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
>>  disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
>>
>> +# cpus.c
>> +tlb_flush_stats(int self, int async, int synced) "self:%d async:%d synced:%d"
>> +
>>  # translate-all.c
>>  translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
>>
>>


--
Alex Bennée
