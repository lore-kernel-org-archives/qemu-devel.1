Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdM9o-0001pf-10
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdM9i-0004mz-VB
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:19:28 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdM9i-0004me-Qs
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:19:22 -0500
Received: by mail-qt0-x243.google.com with SMTP id w20so14518282qtb.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 11:19:21 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
	<20170213121017.12907-13-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0d990570-8318-7bba-c10c-cfe0387fdd1b@twiddle.net>
Date: Tue, 14 Feb 2017 06:19:10 +1100
MIME-Version: 1.0
In-Reply-To: <20170213121017.12907-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 12/24] tcg: handle EXCP_ATOMIC
 exception for system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 02/13/2017 11:10 PM, Alex Bennée wrote:
> @@ -239,9 +240,16 @@ static void cpu_exec_step(CPUState *cpu)
>                       1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
>      tb->orig_tb = NULL;
>      tb_unlock();
> -    /* execute the generated code */
> -    trace_exec_tb_nocache(tb, pc);
> -    cpu_tb_exec(cpu, tb);
> +
> +    cc->cpu_exec_enter(cpu);
> +
> +    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
> +        /* execute the generated code */
> +        trace_exec_tb_nocache(tb, pc);
> +        cpu_tb_exec(cpu, tb);
> +    }

I don't understand this, since cpu_tb_exec has its own sigsetjmp.  Where is the 
exception supposed to come from that escapes?

> +                } else if (r == EXCP_ATOMIC) {
> +                    qemu_mutex_unlock_iothread();
> +                    cpu_exec_step_atomic(cpu);
> +                    qemu_mutex_lock_iothread();
...
> +            case EXCP_ATOMIC:
> +                qemu_mutex_unlock_iothread();
> +                cpu_exec_step_atomic(cpu);
> +                qemu_mutex_lock_iothread();


I just noticed this, but if you have to do a v13, it might be best to move 
these locks inside cpu_exec_step_atomic, as with tcg_cpu_exec.  Otherwise leave 
it for later.


r~
