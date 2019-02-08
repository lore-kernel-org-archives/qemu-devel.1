Received: from eggs.gnu.org ([209.51.188.92]:43760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs7cC-0005Ls-4Z
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs7cA-0000Ip-U5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:58:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs7c9-0000Fw-02
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:58:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so3874804wrs.8
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 06:58:42 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-73-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-73-cota@braap.org>
Date: Fri, 08 Feb 2019 14:58:40 +0000
Message-ID: <87y36ql42n.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 72/73] cpu: add async_run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Some async jobs do not need the BQL.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 14 ++++++++++++++
>  cpus-common.c     | 39 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 30ed2fae0b..bb0729f969 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -884,9 +884,23 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func,=
 run_on_cpu_data data);
>   * @data: Data to pass to the function.
>   *
>   * Schedules the function @func for execution on the vCPU @cpu asynchron=
ously.
> + * See also: async_run_on_cpu_no_bql()
>   */
>  void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_da=
ta data);
>
> +/**
> + * async_run_on_cpu_no_bql:
> + * @cpu: The vCPU to run on.
> + * @func: The function to be executed.
> + * @data: Data to pass to the function.
> + *
> + * Schedules the function @func for execution on the vCPU @cpu asynchron=
ously.
> + * This function is run outside the BQL.
> + * See also: async_run_on_cpu()
> + */
> +void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
> +                             run_on_cpu_data data);
> +

So we now have a locking/scheduling hierarchy that goes:

  - run_on_cpu - synchronously wait until target cpu has done the thing
  - async_run_on_cpu - schedule work on cpu at some point (soon) resources =
protected by BQL
  - async_run_on_cpu_no_bql - as above but only protected by cpu_lock
  - async_safe_run_on_cpu - as above but locking (probably) not required as=
 everything else asleep

So the BQL is only really needed to manipulate data that is shared
across multiple vCPUs like device emulation or other state shared across
multiple vCPUS. For all "just do it over there" cases we should be able
to stick to cpu locks.

It would be nice if we could expand the documentation in
multi-thread-tcg.txt to cover this in long form for people trying to
work out the best thing to use.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  /**
>   * async_safe_run_on_cpu:
>   * @cpu: The vCPU to run on.
> diff --git a/cpus-common.c b/cpus-common.c
> index 1241024b2c..5832a8bf37 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -109,6 +109,7 @@ struct qemu_work_item {
>      run_on_cpu_func func;
>      run_on_cpu_data data;
>      bool free, exclusive, done;
> +    bool bql;
>  };
>
>  /* Called with the CPU's lock held */
> @@ -155,6 +156,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, =
run_on_cpu_data data)
>      wi.done =3D false;
>      wi.free =3D false;
>      wi.exclusive =3D false;
> +    wi.bql =3D true;
>
>      cpu_mutex_lock(cpu);
>      queue_work_on_cpu_locked(cpu, &wi);
> @@ -179,6 +181,21 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func=
 func, run_on_cpu_data data)
>      wi->func =3D func;
>      wi->data =3D data;
>      wi->free =3D true;
> +    wi->bql =3D true;
> +
> +    queue_work_on_cpu(cpu, wi);
> +}
> +
> +void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
> +                             run_on_cpu_data data)
> +{
> +    struct qemu_work_item *wi;
> +
> +    wi =3D g_malloc0(sizeof(struct qemu_work_item));
> +    wi->func =3D func;
> +    wi->data =3D data;
> +    wi->free =3D true;
> +    /* wi->bql initialized to false */
>
>      queue_work_on_cpu(cpu, wi);
>  }
> @@ -323,6 +340,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_=
func func,
>      wi->data =3D data;
>      wi->free =3D true;
>      wi->exclusive =3D true;
> +    /* wi->bql initialized to false */
>
>      queue_work_on_cpu(cpu, wi);
>  }
> @@ -347,6 +365,7 @@ static void process_queued_cpu_work_locked(CPUState *=
cpu)
>               * BQL, so it goes to sleep; start_exclusive() is sleeping t=
oo, so
>               * neither CPU can proceed.
>               */
> +            g_assert(!wi->bql);
>              if (has_bql) {
>                  qemu_mutex_unlock_iothread();
>              }
> @@ -357,12 +376,22 @@ static void process_queued_cpu_work_locked(CPUState=
 *cpu)
>                  qemu_mutex_lock_iothread();
>              }
>          } else {
> -            if (has_bql) {
> -                wi->func(cpu, wi->data);
> +            if (wi->bql) {
> +                if (has_bql) {
> +                    wi->func(cpu, wi->data);
> +                } else {
> +                    qemu_mutex_lock_iothread();
> +                    wi->func(cpu, wi->data);
> +                    qemu_mutex_unlock_iothread();
> +                }
>              } else {
> -                qemu_mutex_lock_iothread();
> -                wi->func(cpu, wi->data);
> -                qemu_mutex_unlock_iothread();
> +                if (has_bql) {
> +                    qemu_mutex_unlock_iothread();
> +                    wi->func(cpu, wi->data);
> +                    qemu_mutex_lock_iothread();
> +                } else {
> +                    wi->func(cpu, wi->data);
> +                }
>              }
>          }
>          cpu_mutex_lock(cpu);


--
Alex Benn=C3=A9e
