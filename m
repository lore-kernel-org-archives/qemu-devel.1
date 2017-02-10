Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccA4e-0004mp-O4
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccA4a-0004VX-NT
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:13:12 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccA4a-0004V8-Fd
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:13:08 -0500
Received: by mail-wr0-x229.google.com with SMTP id k90so106185364wrc.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 04:13:06 -0800 (PST)
References: <20170210014519.12413-1-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170210014519.12413-1-bobby.prani@gmail.com>
Date: Fri, 10 Feb 2017 12:13:19 +0000
Message-ID: <871sv6xmzk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> The current method of executing atomic code in a guest uses
> cpu_exec_step_atomic() from the outermost loop. This causes an abort()
> when single stepping over atomic code since debug exception longjmp
> will point to the the setlongjmp in cpu_exec(). Another issue with
> this mechanism is that the flags which were set in atomic execution
> will be lost since we do not call cpu_exec_enter().

I should not the original patch (which is still in my tree so I guess I
should squash it) says:

  The patch enables handling atomic code in the guest. This should be
  preferably done in cpu_handle_exception(), but the current assumptions
  regarding when we can execute atomic sections cause a deadlock.


> The following patch moves atomic exception handling to the exception
> handler where all these issues are taken care of. The change in
> start_exclusive() is necessary since now the cpu in atomic execution
> will have its running flag set, but we do not want to count it as
> pending.
>
> Thanks to Alex for helping me debug the issue.
>
> CC: Alex Bennée <alex.bennee@linaro.org>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpu-exec.c    | 2 ++
>  cpus-common.c | 2 +-
>  cpus.c        | 4 ----
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/cpu-exec.c b/cpu-exec.c
> index b0ddada8c1..dceacfc5dd 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -427,6 +427,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>              *ret = cpu->exception_index;
>              if (*ret == EXCP_DEBUG) {
>                  cpu_handle_debug_exception(cpu);
> +            } else if (*ret == EXCP_ATOMIC) {
> +                cpu_exec_step_atomic(cpu);
>              }
>              cpu->exception_index = -1;
>              return true;
> diff --git a/cpus-common.c b/cpus-common.c
> index 59f751ecf9..7b859752ea 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -192,7 +192,7 @@ void start_exclusive(void)
>      smp_mb();
>      running_cpus = 0;
>      CPU_FOREACH(other_cpu) {
> -        if (atomic_read(&other_cpu->running)) {
> +        if (atomic_read(&other_cpu->running) &&
> !qemu_cpu_is_self(other_cpu)) {

The comment above reads:

  Must only be called from outside cpu_exec.

So we need to revise this comment. Is this really a limitation or was it
originally the design goal?

>              other_cpu->has_waiter = true;
>              running_cpus++;
>              qemu_cpu_kick(other_cpu);
> diff --git a/cpus.c b/cpus.c
> index e1b82bcd49..981f23d52b 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1461,10 +1461,6 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                   */
>                  g_assert(cpu->halted);
>                  break;
> -            case EXCP_ATOMIC:
> -                qemu_mutex_unlock_iothread();
> -                cpu_exec_step_atomic(cpu);
> -                qemu_mutex_lock_iothread();
>              default:
>                  /* Ignore everything else? */
>                  break;


--
Alex Bennée
