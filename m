Received: from eggs.gnu.org ([2001:4830:134:3::10]:54802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvHC9-00079A-Jz
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvHC6-0004L3-Gb
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:39:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56900)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvHC6-0004Kk-3o
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:39:54 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-8-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-8-alex.bennee@linaro.org>
Date: Tue, 4 Apr 2017 08:39:53 +0300
Message-ID: <000201d2ad05$e28626d0$a7927470$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v1 7/9] cpus: move icount preparation
 out of tcg_exec_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>

I guess you are trying to fix the sympthoms of the case
when iothread is trying to access instruction count.

Maybe the solution is providing access to current_cpu for the iothread
coupled with your patch 8?

Pavel Dovgalyuk


> -----Original Message-----
> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Sent: Monday, April 03, 2017 3:45 PM
> To: dovgaluk@ispras.ru; rth@twiddle.net; pbonzini@redhat.com
> Cc: peter.maydell@linaro.org; qemu-devel@nongnu.org; =
mttcg@listserver.greensocs.com;
> fred.konrad@greensocs.com; a.rigo@virtualopensystems.com; =
cota@braap.org;
> bobby.prani@gmail.com; nikunj@linux.vnet.ibm.com; Alex Benn=C3=A9e; =
Peter Crosthwaite
> Subject: [RFC PATCH v1 7/9] cpus: move icount preparation out of =
tcg_exec_cpu
>=20
> As icount is only supported for single-threaded execution due to the
> requirement for determinism let's remove it from the common
> tcg_exec_cpu path.
>=20
> Also remove the additional fiddling which shouldn't be required as the
> icount counters should all be rectified as you enter the loop.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  cpus.c | 67 =
+++++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 21 deletions(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 18b1746770..87638a75d2 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1179,47 +1179,66 @@ static void handle_icount_deadline(void)
>      }
>  }
>=20
> -static int tcg_cpu_exec(CPUState *cpu)
> +static void prepare_icount_for_run(CPUState *cpu)
>  {
> -    int ret;
> -#ifdef CONFIG_PROFILER
> -    int64_t ti;
> -#endif
> -
> -#ifdef CONFIG_PROFILER
> -    ti =3D profile_getclock();
> -#endif
>      if (use_icount) {
>          int64_t count;
>          int decr;
> -        timers_state.qemu_icount -=3D (cpu->icount_decr.u16.low
> -                                    + cpu->icount_extra);
> -        cpu->icount_decr.u16.low =3D 0;
> -        cpu->icount_extra =3D 0;
> +
> +        /* These should always be cleared by process_icount_data =
after
> +         * each vCPU execution. However u16.high can be raised
> +         * asynchronously by =
cpu_exit/cpu_interrupt/tcg_handle_interrupt
> +         */
> +        g_assert(cpu->icount_decr.u16.low =3D=3D 0);
> +        g_assert(cpu->icount_extra =3D=3D 0);
> +
> +
>          count =3D tcg_get_icount_limit();
> +
>          timers_state.qemu_icount +=3D count;
>          decr =3D (count > 0xffff) ? 0xffff : count;
>          count -=3D decr;
>          cpu->icount_decr.u16.low =3D decr;
>          cpu->icount_extra =3D count;
>      }
> -    qemu_mutex_unlock_iothread();
> -    cpu_exec_start(cpu);
> -    ret =3D cpu_exec(cpu);
> -    cpu_exec_end(cpu);
> -    qemu_mutex_lock_iothread();
> -#ifdef CONFIG_PROFILER
> -    tcg_time +=3D profile_getclock() - ti;
> -#endif
> +}
> +
> +static void process_icount_data(CPUState *cpu)
> +{
>      if (use_icount) {
>          /* Fold pending instructions back into the
>             instruction counter, and clear the interrupt flag.  */
>          timers_state.qemu_icount -=3D (cpu->icount_decr.u16.low
>                          + cpu->icount_extra);
> +
> +        /* We must be under BQL here as cpu_exit can tweak
> +           icount_decr.u32 */
> +        g_assert(qemu_mutex_iothread_locked());
>          cpu->icount_decr.u32 =3D 0;
>          cpu->icount_extra =3D 0;
>          replay_account_executed_instructions();
>      }
> +}
> +
> +
> +static int tcg_cpu_exec(CPUState *cpu)
> +{
> +    int ret;
> +#ifdef CONFIG_PROFILER
> +    int64_t ti;
> +#endif
> +
> +#ifdef CONFIG_PROFILER
> +    ti =3D profile_getclock();
> +#endif
> +    qemu_mutex_unlock_iothread();
> +    cpu_exec_start(cpu);
> +    ret =3D cpu_exec(cpu);
> +    cpu_exec_end(cpu);
> +    qemu_mutex_lock_iothread();
> +#ifdef CONFIG_PROFILER
> +    tcg_time +=3D profile_getclock() - ti;
> +#endif
>      return ret;
>  }
>=20
> @@ -1306,7 +1325,13 @@ static void *qemu_tcg_rr_cpu_thread_fn(void =
*arg)
>=20
>              if (cpu_can_run(cpu)) {
>                  int r;
> +
> +                prepare_icount_for_run(cpu);
> +
>                  r =3D tcg_cpu_exec(cpu);
> +
> +                process_icount_data(cpu);
> +
>                  if (r =3D=3D EXCP_DEBUG) {
>                      cpu_handle_guest_debug(cpu);
>                      break;
> --
> 2.11.0
