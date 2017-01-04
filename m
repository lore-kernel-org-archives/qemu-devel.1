Received: from eggs.gnu.org ([2001:4830:134:3::10]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cOqTS-0002uG-Q9
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 13:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cOqTP-0007dd-NQ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 13:39:46 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cOqTP-0007d8-G6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 13:39:43 -0500
Received: by mail-wm0-x236.google.com with SMTP id t79so464070908wmt.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 10:39:43 -0800 (PST)
References: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
Date: Wed, 04 Jan 2017 18:39:40 +0000
Message-ID: <874m1e655f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: always start with
 parallel_cpus set to true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Henderson <rth@twiddle.net>


Laurent Vivier <laurent@vivier.eu> writes:

> We always need real atomics, as we can have shared memory between
> processes.
>
> A good test case is the example from futex(2), futex_demo.c:
>
> the use case is
>
>     mmap(...);
>     fork();
>
>     Parent and Child:
>
>     while(...)
>         __sync_bool_compare_and_swap(...)
>         ...
>         futex(...)
>
> In this case we need real atomics in __sync_bool_compare_and_swap(),
> but as parallel_cpus is set to 0, we don't have.
>
> We also revert "b67cb68 linux-user: enable parallel code generation on clone"
> as parallel_cpus in unconditionally set now.
>
> Of course, this doesn't fix atomics that are emulated using
> cpu_loop_exit_atomic() as we can't stop virtual CPUs from another
> processes.

This seems a bit of a hit for something that might never get called.
Could we not move b67cb68 out of the thread fork leg and do it for any
fork? After all the tb_flush will ensure that all code by both parent
and child will be using full atomics at that point?

>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 8 --------
>  translate-all.c      | 4 ++++
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b77503..db697c0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6164,14 +6164,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>          sigfillset(&sigmask);
>          sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
>
> -        /* If this is our first additional thread, we need to ensure we
> -         * generate code for parallel execution and flush old translations.
> -         */
> -        if (!parallel_cpus) {
> -            parallel_cpus = true;
> -            tb_flush(cpu);
> -        }
> -
>          ret = pthread_create(&info.thread, &attr, clone_func, &info);
>          /* TODO: Free new CPU state if thread creation failed.  */
>
> diff --git a/translate-all.c b/translate-all.c
> index 3dd9214..0b0bb09 100644
> --- a/translate-all.c
> +++ b/translate-all.c
> @@ -142,7 +142,11 @@ static void *l1_map[V_L1_MAX_SIZE];
>
>  /* code generation context */
>  TCGContext tcg_ctx;
> +#ifdef CONFIG_USER_ONLY
> +bool parallel_cpus = true;
> +#else
>  bool parallel_cpus;
> +#endif
>
>  /* translation block context */
>  #ifdef CONFIG_USER_ONLY


--
Alex Bennée
