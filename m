Received: from eggs.gnu.org ([209.51.188.92]:50061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgFJ-0000t4-As
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmgFI-0003Np-Mc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:44:45 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmgFI-0003Ms-FM
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:44:44 -0500
Received: by mail-wr1-x436.google.com with SMTP id l9so6707350wrt.13
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:44:44 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-5-cota@braap.org>
Date: Thu, 24 Jan 2019 14:44:42 +0000
Message-ID: <87pnsmyv1h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 04/38] translate-all: use
 cpu_in_exclusive_work_context() in tb_flush
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

> tb_flush will be called by the plugin module from a safe
> work environment. Prepare for that.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 038d82fdb5..62d5e13185 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1269,8 +1269,13 @@ void tb_flush(CPUState *cpu)
>  {
>      if (tcg_enabled()) {
>          unsigned tb_flush_count =3D atomic_mb_read(&tb_ctx.tb_flush_coun=
t);
> -        async_safe_run_on_cpu(cpu, do_tb_flush,
> -                              RUN_ON_CPU_HOST_INT(tb_flush_count));
> +
> +        if (cpu_in_exclusive_work_context(cpu)) {
> +            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
> +        } else {
> +            async_safe_run_on_cpu(cpu, do_tb_flush,
> +                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
> +        }
>      }
>  }


--
Alex Benn=C3=A9e
