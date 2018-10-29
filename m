Received: from eggs.gnu.org ([2001:4830:134:3::10]:34336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHAW7-0000sh-HX
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHAW1-000651-93
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHAVx-0005yy-Ey
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id g9-v6so9427966wrq.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:35:34 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-6-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-6-cota@braap.org>
Date: Mon, 29 Oct 2018 16:35:32 +0000
Message-ID: <87y3ag90dn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 06/71] cpu: introduce
 process_queued_cpu_work_locked
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

> This completes the conversion to cpu_mutex_lock/unlock in the file.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  cpus-common.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 3fccee5585..c2ad554d54 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -337,20 +337,19 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cp=
u_func func,
>      queue_work_on_cpu(cpu, wi);
>  }
>
> -void process_queued_cpu_work(CPUState *cpu)
> +/* Called with the CPU's lock held */
> +static void process_queued_cpu_work_locked(CPUState *cpu)
>  {
>      struct qemu_work_item *wi;
>      bool has_bql =3D qemu_mutex_iothread_locked();
>
> -    qemu_mutex_lock(&cpu->lock);
>      if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
> -        qemu_mutex_unlock(&cpu->lock);
>          return;
>      }
>      while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
>          wi =3D QSIMPLEQ_FIRST(&cpu->work_list);
>          QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
> -        qemu_mutex_unlock(&cpu->lock);
> +        cpu_mutex_unlock(cpu);
>          if (wi->exclusive) {
>              /* Running work items outside the BQL avoids the following d=
eadlock:
>               * 1) start_exclusive() is called with the BQL taken while a=
nother
> @@ -376,13 +375,19 @@ void process_queued_cpu_work(CPUState *cpu)
>                  qemu_mutex_unlock_iothread();
>              }
>          }
> -        qemu_mutex_lock(&cpu->lock);
> +        cpu_mutex_lock(cpu);
>          if (wi->free) {
>              g_free(wi);
>          } else {
>              atomic_mb_set(&wi->done, true);
>          }
>      }
> -    qemu_mutex_unlock(&cpu->lock);
>      qemu_cond_broadcast(&cpu->cond);
>  }
> +
> +void process_queued_cpu_work(CPUState *cpu)
> +{
> +    cpu_mutex_lock(cpu);
> +    process_queued_cpu_work_locked(cpu);
> +    cpu_mutex_unlock(cpu);
> +}


--
Alex Benn=C3=A9e
