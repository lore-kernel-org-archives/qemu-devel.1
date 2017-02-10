Received: from eggs.gnu.org ([2001:4830:134:3::10]:54874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cc9TF-0007CP-24
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cc9TB-0002hV-U5
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:34:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cc9TB-0002hG-LA
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:34:29 -0500
References: <20170210014519.12413-1-bobby.prani@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52c93dcc-2577-e81f-867c-6159c1f61e91@redhat.com>
Date: Fri, 10 Feb 2017 12:34:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170210014519.12413-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 10/02/2017 02:45, Pranith Kumar wrote:
> The current method of executing atomic code in a guest uses
> cpu_exec_step_atomic() from the outermost loop. This causes an abort()
> when single stepping over atomic code since debug exception longjmp
> will point to the the setlongjmp in cpu_exec(). Another issue with
> this mechanism is that the flags which were set in atomic execution
> will be lost since we do not call cpu_exec_enter().
>=20
> The following patch moves atomic exception handling to the exception
> handler where all these issues are taken care of. The change in
> start_exclusive() is necessary since now the cpu in atomic execution
> will have its running flag set, but we do not want to count it as
> pending.
>=20
> Thanks to Alex for helping me debug the issue.
>=20
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpu-exec.c    | 2 ++
>  cpus-common.c | 2 +-
>  cpus.c        | 4 ----
>  3 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/cpu-exec.c b/cpu-exec.c
> index b0ddada8c1..dceacfc5dd 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -427,6 +427,8 @@ static inline bool cpu_handle_exception(CPUState *c=
pu, int *ret)
>              *ret =3D cpu->exception_index;
>              if (*ret =3D=3D EXCP_DEBUG) {
>                  cpu_handle_debug_exception(cpu);
> +            } else if (*ret =3D=3D EXCP_ATOMIC) {
> +                cpu_exec_step_atomic(cpu);

I think you can unlock/lock the iothread here, and also call
cpu_exec_end/start to work around the limitation in start_exclusive.

Paolo

>              }
>              cpu->exception_index =3D -1;
>              return true;
> diff --git a/cpus-common.c b/cpus-common.c
> index 59f751ecf9..7b859752ea 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -192,7 +192,7 @@ void start_exclusive(void)
>      smp_mb();
>      running_cpus =3D 0;
>      CPU_FOREACH(other_cpu) {
> -        if (atomic_read(&other_cpu->running)) {
> +        if (atomic_read(&other_cpu->running) && !qemu_cpu_is_self(othe=
r_cpu)) {
>              other_cpu->has_waiter =3D true;
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
>=20
