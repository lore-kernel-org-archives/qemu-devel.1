Received: from eggs.gnu.org ([209.51.188.92]:47188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwPBl-0004RO-3J
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwPBi-0002j1-VZ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:33:16 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwPBf-0002gs-EH
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:33:13 -0500
Received: by mail-wr1-x441.google.com with SMTP id i16so17107788wrs.13
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:33:09 -0800 (PST)
References: <20190219233421.388-1-richard.henderson@linaro.org>
	<20190219233421.388-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190219233421.388-4-richard.henderson@linaro.org>
Date: Wed, 20 Feb 2019 10:33:07 +0000
Message-ID: <87zhqq4un0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/arm: Rely on hflags correct
 in cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This is the payoff.
>
> From perf record -g data of ubuntu 18 boot and shutdown:
>
> BEFORE:
>
> -   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
>    - 20.22% helper_lookup_tb_ptr
>       + 10.05% tb_htable_lookup
>       - 9.13% cpu_get_tb_cpu_state
>            3.20% aa64_va_parameters_both
>            0.55% fp_exception_el
>
> -   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
>    - 6.96% cpu_get_tb_cpu_state
>         3.63% aa64_va_parameters_both
>         0.60% fp_exception_el
>         0.53% sve_exception_el
>
> AFTER:
>
> -   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
>    - 13.03% helper_lookup_tb_ptr
>       + 11.19% tb_htable_lookup
>         0.55% cpu_get_tb_cpu_state
>
>      0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state
>
>      0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64
>
> Before, helper_lookup_tb_ptr is the second hottest function in the
> application, consuming almost a quarter of the runtime.  Within the
> entire execution, cpu_get_tb_cpu_state consumes about 12%.
>
> After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
> with consumption dropping to a sixth of the runtime.  Within the
> entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
> supporting function to rebuild hflags also consumes about 1%.
>
> Assertions are retained for --enable-debug-tcg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Retain asserts for future debugging.
> ---
>  target/arm/helper.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 909535a3e3..990a87876f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -14034,19 +14034,29 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *en=
v, uint32_t el)
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> -    int current_el =3D arm_current_el(env);
> -    uint32_t flags;
> +    uint32_t flags =3D env->hflags;
>      uint32_t pstate_for_ss;
>
> +#ifdef CONFIG_DEBUG_TCG
> +    {
> +        int el =3D arm_current_el(env);
> +        uint32_t check_flags;
> +        if (is_a64(env)) {
> +            check_flags =3D rebuild_hflags_a64(env, el);
> +        } else {
> +            check_flags =3D rebuild_hflags_a32(env, el);
> +        }
> +        g_assert_cmphex(flags, =3D=3D, check_flags);
> +    }
> +#endif
> +
>      *cs_base =3D 0;
> -    if (is_a64(env)) {
> +    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
>          *pc =3D env->pc;
> -        flags =3D rebuild_hflags_a64(env, current_el);
>          flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          pstate_for_ss =3D env->pstate;
>      } else {
>          *pc =3D env->regs[15];
> -        flags =3D rebuild_hflags_a32(env, current_el);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
>          pstate_for_ss =3D env->uncached_cpsr;


--
Alex Benn=C3=A9e
