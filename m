Received: from eggs.gnu.org ([2001:4830:134:3::10]:52556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cfqdJ-0000q4-5x
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cfqdF-00009s-8O
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:16:13 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cfqdF-00009M-0n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:16:09 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v77so56602795wmv.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 08:16:08 -0800 (PST)
References: <20170220145335.591-1-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170220145335.591-1-bobby.prani@gmail.com>
Date: Mon, 20 Feb 2017 16:16:13 +0000
Message-ID: <87fuj8x2gi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mttcg: Set jmp_env to handle exit from
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> tb_gen_code() can exit execution using cpu_exit_loop() when it cannot
> allocate new tb's. To handle this, we need to properly set the jmp_env
> pointer ahead of calling tb_gen_code().
>
> CC:Alex Bennée <alex.bennee@linaro.org>
> CC: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpu-exec.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 97d79612d9..4b70988b24 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -236,23 +236,22 @@ static void cpu_exec_step(CPUState *cpu)
>
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>      tb_lock();
> -    tb = tb_gen_code(cpu, pc, cs_base, flags,
> -                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
> -    tb->orig_tb = NULL;
> -    tb_unlock();
> -
> -    cc->cpu_exec_enter(cpu);
> -

It occurs to me we are also diverging in our locking pattern from
tb_find which takes mmap_lock first. This is a NOP for system emulation
but needed for user-emulation (for which we can do cpu_exec_step but not
cpu_exec_nocache).

>      if (sigsetjmp(cpu->jmp_env, 0) == 0) {
> +        tb = tb_gen_code(cpu, pc, cs_base, flags,
> +                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
> +        tb->orig_tb = NULL;
> +        tb_unlock();
> +
> +        cc->cpu_exec_enter(cpu);
>          /* execute the generated code */
>          trace_exec_tb_nocache(tb, pc);
>          cpu_tb_exec(cpu, tb);
> -    }
> +        cc->cpu_exec_exit(cpu);
>
> -    cc->cpu_exec_exit(cpu);
> -    tb_lock();
> -    tb_phys_invalidate(tb, -1);
> -    tb_free(tb);
> +        tb_lock();
> +        tb_phys_invalidate(tb, -1);
> +        tb_free(tb);
> +    }
>      tb_unlock();
>  }


--
Alex Bennée
