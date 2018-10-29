Received: from eggs.gnu.org ([2001:4830:134:3::10]:34802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9Mk-0000tm-2k
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9Me-0003rG-6Y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:22:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH9Mc-0003na-CP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5-v6so9156172wrt.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:21:53 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-70-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-70-cota@braap.org>
Date: Mon, 29 Oct 2018 15:21:50 +0000
Message-ID: <878t2gaicx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 70/71] cpus-common: move exclusive_idle
 higher in the file
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

> This will simplify the following commit's diff.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  cpus-common.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 232cb12c46..ad8a8ef535 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -73,6 +73,15 @@ static void finish_safe_work(CPUState *cpu)
>      cpu_exec_end(cpu);
>  }
>
> +/* Wait for pending exclusive operations to complete.  The CPU list lock
> +   must be held.  */
> +static inline void exclusive_idle(void)
> +{
> +    while (pending_cpus) {
> +        qemu_cond_wait(&exclusive_resume, &qemu_cpu_list_lock);
> +    }
> +}
> +
>  void cpu_list_add(CPUState *cpu)
>  {
>      qemu_mutex_lock(&qemu_cpu_list_lock);
> @@ -200,15 +209,6 @@ void async_run_on_cpu_no_bql(CPUState *cpu, run_on_c=
pu_func func,
>      queue_work_on_cpu(cpu, wi);
>  }
>
> -/* Wait for pending exclusive operations to complete.  The CPU list lock
> -   must be held.  */
> -static inline void exclusive_idle(void)
> -{
> -    while (pending_cpus) {
> -        qemu_cond_wait(&exclusive_resume, &qemu_cpu_list_lock);
> -    }
> -}
> -
>  /* Start an exclusive operation.
>     Must only be called from outside cpu_exec.  */
>  void start_exclusive(void)


--
Alex Benn=C3=A9e
