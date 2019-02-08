Received: from eggs.gnu.org ([209.51.188.92]:35687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4EW-0008Vy-S6
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4EW-0006hI-2E
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:22:12 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs4EV-0006gZ-Ry
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:22:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so3033306wml.2
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:22:11 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-62-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-62-cota@braap.org>
Date: Fri, 08 Feb 2019 11:22:09 +0000
Message-ID: <878syqmsny.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 61/73] cpu: call .cpu_has_work with the
 CPU lock held
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

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qom/cpu.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 4a87c1fef7..96a5d0cb94 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -85,7 +85,8 @@ struct TranslationBlock;
>   * @parse_features: Callback to parse command line arguments.
>   * @reset: Callback to reset the #CPUState to its initial state.
>   * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
> - * @has_work: Callback for checking if there is work to do.
> + * @has_work: Callback for checking if there is work to do. Called with =
the
> + * CPU lock held.
>   * @do_interrupt: Callback for interrupt handling.
>   * @do_unassigned_access: Callback for unassigned access handling.
>   * (this is deprecated: new targets should use do_transaction_failed ins=
tead)
> @@ -795,9 +796,16 @@ const char *parse_cpu_model(const char *cpu_model);
>  static inline bool cpu_has_work(CPUState *cpu)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    bool ret;
>
>      g_assert(cc->has_work);
> -    return cc->has_work(cpu);
> +    if (cpu_mutex_locked(cpu)) {
> +        return cc->has_work(cpu);
> +    }
> +    cpu_mutex_lock(cpu);
> +    ret =3D cc->has_work(cpu);
> +    cpu_mutex_unlock(cpu);
> +    return ret;
>  }
>
>  /**


--
Alex Benn=C3=A9e
