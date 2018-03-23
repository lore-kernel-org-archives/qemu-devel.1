Received: from eggs.gnu.org ([2001:4830:134:3::10]:60293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNTw-0004Gd-U9
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNTv-0008GZ-Tg
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:15:48 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezNTv-0008Fj-Nn
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:15:47 -0400
Received: by mail-oi0-x241.google.com with SMTP id 6-v6so6968277oip.8
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 07:15:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322215833.7713-3-laurent@vivier.eu>
References: <20180322215833.7713-1-laurent@vivier.eu>
	<20180322215833.7713-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 14:15:26 +0000
Message-ID: <CAFEAcA9XAZA66kSdgSWs2bcT_86yqrzhrn6Gtce7z+QWorS5kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.13 2/5] linux-user: remove unneeded
 #ifdef in signal.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 22 March 2018 at 21:58, Laurent Vivier <laurent@vivier.eu> wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 2c08ca14cf..514145b299 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -253,17 +253,15 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
>      return 0;
>  }
>
> -#if !defined(TARGET_OPENRISC) && !defined(TARGET_NIOS2)
>  /* Just set the guest's signal mask to the specified value; the
>   * caller is assumed to have called block_signals() already.
>   */
> -static void set_sigmask(const sigset_t *set)
> +static __attribute__((unused)) void set_sigmask(const sigset_t *set)
>  {
>      TaskState *ts = (TaskState *)thread_cpu->opaque;
>
>      ts->signal_mask = *set;
>  }
> -#endif
>
>  /* siginfo conversion */
>
> @@ -533,8 +531,7 @@ static void force_sig(int sig)
>   * up the signal frame. oldsig is the signal we were trying to handle
>   * at the point of failure.
>   */
> -#if !defined(TARGET_RISCV)
> -static void force_sigsegv(int oldsig)
> +static __attribute__((unused)) void force_sigsegv(int oldsig)
>  {
>      if (oldsig == SIGSEGV) {
>          /* Make sure we don't try to deliver the signal again; this will
> @@ -545,8 +542,6 @@ static void force_sigsegv(int oldsig)
>      force_sig(TARGET_SIGSEGV);
>  }
>
> -#endif
> -
>  /* abort execution with signal */
>  static void QEMU_NORETURN dump_core_and_abort(int target_sig)
>  {

I don't think this is the right approach. In both of these
cases, the fact that the function is unused is a red flag that
there is a bug in the signal emulation code for those guest CPUs.
If the guest CPU code isn't calling set_sigmask() it is failing
to correctly handle the sigmask field in the ucontext on
signal return, and if it's not calling force_sigsegv() then
it's doing something wrong with the handling of "we couldn't
write to the signal frame" on signal entry.

I think it's worth keeping the #ifdef as a flag and
a list of what targets we need to fix.

(The "riscv isn't using force_sigsegv()" fix looks like it should be
trivial -- their setup_rt_frame() has the code path but it's
incorrectly trying to do this by hand rather than calling
force_sigsegv().)

thanks
-- PMM
