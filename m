Received: from eggs.gnu.org ([2001:4830:134:3::10]:53916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvHAL-0006EF-EU
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvHAI-0003Wd-6u
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:38:05 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56738)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cvHAH-0003VT-QE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:38:02 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-9-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-9-alex.bennee@linaro.org>
Date: Tue, 4 Apr 2017 08:37:57 +0300
Message-ID: <000101d2ad05$9de02580$d9a07080$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] cpus: don't credit executed
 instructions before they have run
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

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Outside of the vCPU thread icount time will only be tracked against
> timers_state.qemu_icount. We no longer credit cycles until they have
> completed the run. Inside the vCPU thread we adjust for passage of
> time by looking at how many have run so far. This is only valid inside
> the vCPU thread while it is running.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  cpus.c            | 27 +++++++++++++++++++++------
>  include/qom/cpu.h |  1 +
>  2 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 87638a75d2..3d18374b0e 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -223,6 +223,15 @@ void qemu_tcg_configure(QemuOpts *opts, Error =
**errp)
>      }
>  }
>=20
> +/* The current number of executed instructions is based on what we
> + * originally budgeted minus the current state of the decrementing
> + * icount counters in extra/u16.low.
> + */
> +static int64_t cpu_get_icount_executed(CPUState *cpu)
> +{
> +    return cpu->icount_budget - (cpu->icount_decr.u16.low + =
cpu->icount_extra);
> +}
> +
>  int64_t cpu_get_icount_raw(void)
>  {
>      int64_t icount;
> @@ -234,7 +243,8 @@ int64_t cpu_get_icount_raw(void)
>              fprintf(stderr, "Bad icount read\n");
>              exit(1);
>          }
> -        icount -=3D (cpu->icount_decr.u16.low + cpu->icount_extra);
> +        /* Take into account what has run */
> +        icount +=3D cpu_get_icount_executed(cpu);
>      }
>      return icount;

As far, as I understand, this one will return the same value in iothread
until vCPU thread finishes cpu_exec?
This value will not jump forward and backward, but still will not allow
making execution deterministic.

Consider the following scenarios:

First:
vCPU            iothread
access HW       ----
...             access HW in timer

Second:
vCPU            iothread
...             access HW in timer
access HW       ----

These scenarios will generate the same order of events in the log.
Synchronization checkpoint in iothread will try to write already
executed instructions, but it does not have access to current_cpu
and the icount value will point to the "past" - it will have less
instructions than already executed.

That is why you see "negative" instruction count event.

>  }
> @@ -1195,7 +1205,10 @@ static void prepare_icount_for_run(CPUState =
*cpu)
>=20
>          count =3D tcg_get_icount_limit();
>=20
> -        timers_state.qemu_icount +=3D count;
> +        /* To calculate what we have executed so far we need to know
> +         * what we originally budgeted to run this cycle */
> +        cpu->icount_budget =3D count;
> +
>          decr =3D (count > 0xffff) ? 0xffff : count;
>          count -=3D decr;
>          cpu->icount_decr.u16.low =3D decr;
> @@ -1206,16 +1219,18 @@ static void prepare_icount_for_run(CPUState =
*cpu)
>  static void process_icount_data(CPUState *cpu)
>  {
>      if (use_icount) {
> -        /* Fold pending instructions back into the
> -           instruction counter, and clear the interrupt flag.  */
> -        timers_state.qemu_icount -=3D (cpu->icount_decr.u16.low
> -                        + cpu->icount_extra);
> +        /* Account for executed instructions */
> +        timers_state.qemu_icount +=3D cpu_get_icount_executed(cpu);
>=20
>          /* We must be under BQL here as cpu_exit can tweak
>             icount_decr.u32 */
>          g_assert(qemu_mutex_iothread_locked());
> +
> +        /* Reset the counters */
>          cpu->icount_decr.u32 =3D 0;
>          cpu->icount_extra =3D 0;
> +        cpu->icount_budget =3D 0;
> +
>          replay_account_executed_instructions();
>      }
>  }
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index c3292efe1c..5d10359c8f 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -332,6 +332,7 @@ struct CPUState {
>      /* updates protected by BQL */
>      uint32_t interrupt_request;
>      int singlestep_enabled;
> +    int64_t icount_budget;
>      int64_t icount_extra;
>      sigjmp_buf jmp_env;
>=20
> --
> 2.11.0


Pavel Dovgalyuk
