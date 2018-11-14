Received: from eggs.gnu.org ([2001:4830:134:3::10]:41818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMtNP-00077m-Jr
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMtNI-0003iQ-Ta
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:30:31 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMtNI-0003dp-Fn
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:30:24 -0500
Received: by mail-wm1-x344.google.com with SMTP id q26so4373204wmf.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:30:21 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-2-cota@braap.org>
Date: Wed, 14 Nov 2018 11:30:19 +0000
Message-ID: <877ehfew1g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 01/48] cpu: introduce run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> This allows us to queue synchronous CPU work without the BQL.
>
> Will gain a user soon.

This is also in the cpu-lock series right?

>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 13 +++++++++++++
>  cpus-common.c     | 28 ++++++++++++++++++++++------
>  2 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 204bc94056..863aa2bff1 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -877,6 +877,19 @@ bool cpu_is_stopped(CPUState *cpu);
>   */
>  void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data dat=
a);
>
> +/**
> + * run_on_cpu_no_bql
> + * @cpu: The vCPU to run on.
> + * @func: The function to be executed.
> + * @data: Data to pass to the function.
> + *
> + * Schedules the function @func for execution on the vCPU @cpu.
> + * This function is run outside the BQL.
> + * See also: run_on_cpu()
> + */
> +void run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
> +                       run_on_cpu_data data);
> +
>  /**
>   * async_run_on_cpu:
>   * @cpu: The vCPU to run on.
> diff --git a/cpus-common.c b/cpus-common.c
> index cffb2b71ac..b478fc8741 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -144,7 +144,8 @@ static void queue_work_on_cpu(CPUState *cpu, struct q=
emu_work_item *wi)
>      cpu_mutex_unlock(cpu);
>  }
>
> -void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data dat=
a)
> +static void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
> +                          run_on_cpu_data data, bool bql)
>  {
>      struct qemu_work_item wi;
>      bool has_bql =3D qemu_mutex_iothread_locked();
> @@ -152,12 +153,16 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func=
, run_on_cpu_data data)
>      g_assert(no_cpu_mutex_locked());
>
>      if (qemu_cpu_is_self(cpu)) {
> -        if (has_bql) {
> -            func(cpu, data);
> +        if (bql) {
> +            if (has_bql) {
> +                func(cpu, data);
> +            } else {
> +                qemu_mutex_lock_iothread();
> +                func(cpu, data);
> +                qemu_mutex_unlock_iothread();
> +            }
>          } else {
> -            qemu_mutex_lock_iothread();
>              func(cpu, data);
> -            qemu_mutex_unlock_iothread();
>          }
>          return;
>      }
> @@ -172,7 +177,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, =
run_on_cpu_data data)
>      wi.done =3D false;
>      wi.free =3D false;
>      wi.exclusive =3D false;
> -    wi.bql =3D true;
> +    wi.bql =3D bql;
>
>      cpu_mutex_lock(cpu);
>      queue_work_on_cpu_locked(cpu, &wi);
> @@ -189,6 +194,17 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func,=
 run_on_cpu_data data)
>      }
>  }
>
> +void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data dat=
a)
> +{
> +    do_run_on_cpu(cpu, func, data, true);
> +}
> +
> +void
> +run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data d=
ata)
> +{
> +    do_run_on_cpu(cpu, func, data, false);
> +}
> +
>  void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_da=
ta data)
>  {
>      struct qemu_work_item *wi;


--
Alex Benn=C3=A9e
