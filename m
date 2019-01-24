Received: from eggs.gnu.org ([209.51.188.92]:49991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgFA-0000lD-EZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgF8-0003DS-BN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:44:36 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmgF6-000349-AJ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:44:33 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so6710987wrr.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:44:25 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-4-cota@braap.org>
Date: Thu, 24 Jan 2019 14:44:22 +0000
Message-ID: <87r2d2yv21.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 03/38] cpu: introduce
 cpu_in_exclusive_work_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 13 +++++++++++++
>  cpus-common.c     |  2 ++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 772cc960fe..fab18089db 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -349,6 +349,7 @@ struct CPUState {
>      bool thread_kicked;
>      bool crash_occurred;
>      bool exit_request;
> +    bool in_exclusive_work_context;

I'm not sure if I meant this or in_exclusive_context and push the flag
into start/end_exclusive. But let's see how it shakes out:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      uint32_t cflags_next_tb;
>      /* updates protected by BQL */
>      uint32_t interrupt_request;
> @@ -913,6 +914,18 @@ void async_run_on_cpu_no_bql(CPUState *cpu, run_on_c=
pu_func func,
>   */
>  void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_c=
pu_data data);
>
> +/**
> + * cpu_in_exclusive_work_context()
> + * @cpu: The vCPU to check
> + *
> + * Returns true if @cpu is an exclusive work context, which has
> + * previously been queued via async_safe_run_on_cpu().
> + */
> +static inline bool cpu_in_exclusive_work_context(const CPUState *cpu)
> +{
> +    return cpu->in_exclusive_work_context;
> +}
> +
>  /**
>   * qemu_get_cpu:
>   * @index: The CPUState@cpu_index value of the CPU to obtain.
> diff --git a/cpus-common.c b/cpus-common.c
> index 232cb12c46..d6ea42c80c 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -370,7 +370,9 @@ static void process_queued_cpu_work_locked(CPUState *=
cpu)
>                  qemu_mutex_unlock_iothread();
>              }
>              start_exclusive();
> +            cpu->in_exclusive_work_context =3D true;
>              wi->func(cpu, wi->data);
> +            cpu->in_exclusive_work_context =3D false;
>              end_exclusive();
>              if (has_bql) {
>                  qemu_mutex_lock_iothread();


--
Alex Benn=C3=A9e
