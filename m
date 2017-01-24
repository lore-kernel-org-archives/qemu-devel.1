Received: from eggs.gnu.org ([2001:4830:134:3::10]:40349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW7nL-0006h8-Vd
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW7nH-00054h-AN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:34:24 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW7nH-00054X-3s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:34:19 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so199712368wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 12:34:19 -0800 (PST)
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-19-alex.bennee@linaro.org>
	<3604b49c-6d3b-5525-9a26-8226f4d2f8c9@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3604b49c-6d3b-5525-9a26-8226f4d2f8c9@twiddle.net>
Date: Tue, 24 Jan 2017 20:34:16 +0000
Message-ID: <87k29k9ozb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 18/27] cputlb: introduce
 tlb_flush_*_all_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org


Richard Henderson <rth@twiddle.net> writes:

> On 01/19/2017 09:04 AM, Alex Bennée wrote:
>> +/* flush_all_helper: run fn across all cpus
>> + *
>> + * If the wait flag is set then the src cpu's helper will be queued as
>> + * "safe" work and the loop exited creating a synchronisation point
>> + * where all queued work will be finished before execution starts
>> + * again.
>> + */
>> +static void flush_all_helper(CPUState *src, bool wait,
>> +                             run_on_cpu_func fn, run_on_cpu_data d)
>> +{
>> +    CPUState *cpu;
>> +
>> +    if (!wait) {
>> +        CPU_FOREACH(cpu) {
>> +            if (cpu != src) {
>> +                async_run_on_cpu(cpu, fn, d);
>> +            } else {
>> +                g_assert(qemu_cpu_is_self(src));
>> +                fn(src, d);
>> +            }
>> +        }
>> +    } else {
>> +        CPU_FOREACH(cpu) {
>> +            if (cpu != src) {
>> +                async_run_on_cpu(cpu, fn, d);
>> +            } else {
>> +                async_safe_run_on_cpu(cpu, fn, d);
>> +            }
>> +
>> +        }
>> +        cpu_loop_exit(src);
>> +    }
>> +}
>
> What's the rationale for not having the target do the exit itself?  Surely it
> can tell, and simple end the TB after the insn.

It's more for the global sync functionality. I wanted to keep all the
guts of re-starting the loop with the correct async_safe_work all in one
place with a defined API for the guests rather than have them all do it
themselves.

For the common case of not needing to sync across the cores I agree the
guest is perfectly able to end the TB so its safe work completes next.
In fact the ARM helper calls do exactly that.

--
Alex Bennée
