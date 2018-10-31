Received: from eggs.gnu.org ([2001:4830:134:3::10]:44429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHpEl-0005N5-En
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHpEi-0006Nc-2z
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:04:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHpEh-0006J4-Kz
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:04:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id n5-v6so16155839wrw.12
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:04:30 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-14-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-14-cota@braap.org>
Date: Wed, 31 Oct 2018 12:04:27 +0000
Message-ID: <87bm7a8gqc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 14/71] cpu: define cpu_halted helpers
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

> cpu->halted will soon be protected by cpu->lock.
> We will use these helpers to ease the transition,
> since right now cpu->halted has many direct callers.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qom/cpu.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 11cbf21f00..aeed63a705 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -487,6 +487,30 @@ bool cpu_mutex_locked(const CPUState *cpu);
>   */
>  bool no_cpu_mutex_locked(void);
>
> +static inline uint32_t cpu_halted(CPUState *cpu)
> +{
> +    uint32_t ret;
> +
> +    if (cpu_mutex_locked(cpu)) {
> +        return cpu->halted;
> +    }
> +    cpu_mutex_lock(cpu);
> +    ret =3D cpu->halted;
> +    cpu_mutex_unlock(cpu);
> +    return ret;
> +}
> +
> +static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
> +{
> +    if (cpu_mutex_locked(cpu)) {
> +        cpu->halted =3D val;
> +        return;
> +    }
> +    cpu_mutex_lock(cpu);
> +    cpu->halted =3D val;
> +    cpu_mutex_unlock(cpu);
> +}
> +
>  static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
>  {
>      unsigned int i;


--
Alex Benn=C3=A9e
