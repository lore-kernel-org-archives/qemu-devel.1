Received: from eggs.gnu.org ([2001:4830:134:3::10]:58349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVkB3-0006If-3g
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVkB1-0007ju-VL
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:21:17 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVkB1-0007ja-RV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:21:15 -0500
Received: by mail-qt0-x244.google.com with SMTP id n13so19488747qtc.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:21:15 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-19-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3604b49c-6d3b-5525-9a26-8226f4d2f8c9@twiddle.net>
Date: Mon, 23 Jan 2017 11:21:11 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-19-alex.bennee@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/19/2017 09:04 AM, Alex Bennée wrote:
> +/* flush_all_helper: run fn across all cpus
> + *
> + * If the wait flag is set then the src cpu's helper will be queued as
> + * "safe" work and the loop exited creating a synchronisation point
> + * where all queued work will be finished before execution starts
> + * again.
> + */
> +static void flush_all_helper(CPUState *src, bool wait,
> +                             run_on_cpu_func fn, run_on_cpu_data d)
> +{
> +    CPUState *cpu;
> +
> +    if (!wait) {
> +        CPU_FOREACH(cpu) {
> +            if (cpu != src) {
> +                async_run_on_cpu(cpu, fn, d);
> +            } else {
> +                g_assert(qemu_cpu_is_self(src));
> +                fn(src, d);
> +            }
> +        }
> +    } else {
> +        CPU_FOREACH(cpu) {
> +            if (cpu != src) {
> +                async_run_on_cpu(cpu, fn, d);
> +            } else {
> +                async_safe_run_on_cpu(cpu, fn, d);
> +            }
> +
> +        }
> +        cpu_loop_exit(src);
> +    }
> +}

What's the rationale for not having the target do the exit itself?  Surely it
can tell, and simple end the TB after the insn.


r~
