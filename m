Received: from eggs.gnu.org ([209.51.188.92]:49199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwBpv-0004Ak-Q7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwBpm-0000Jn-Np
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:17:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwBpm-0000JC-9W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:17:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id n2so11245445wrw.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:17:41 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
	<20190214040652.4811-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190214040652.4811-5-richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 20:17:39 +0000
Message-ID: <8736oj5y8s.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
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

\o/

Running my own silly pigz benchmark:

Before:
  Time (mean =C2=B1 =CF=83):     66.035 s =C2=B1  1.425 s

After:
  Time (mean =C2=B1 =CF=83):     57.191 s =C2=B1  0.675 s

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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3c8724883d..1bdb87267e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -13894,21 +13894,16 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *en=
v, uint32_t el)
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> -    int current_el =3D arm_current_el(env);
> -    uint32_t flags;
> +    uint32_t flags =3D env->hflags;
>      uint32_t pstate_for_ss;
>
>      *cs_base =3D 0;
> -    if (is_a64(env)) {
> +    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
>          *pc =3D env->pc;
> -        flags =3D rebuild_hflags_a64(env, current_el);
> -        assert(flags =3D=3D env->hflags);

While debugging I came up with this monstrosity:

    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
#ifdef CONFIG_DEBUG_TCG
        static uint32_t tb_state =3D 0;
        uint32_t recalc_flags =3D rebuild_hflags_a64(env, arm_current_el(en=
v));
        tb_state++;
        if (flags !=3D recalc_flags) {
            fprintf(stderr, "%s: flags %#x, should be %#x (%#x/%d)\n", __fu=
nc__,
                    flags, recalc_flags, flags ^ recalc_flags, tb_state);
            abort();
        }
#endif
        *pc =3D env->pc;
        flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
        pstate_for_ss =3D env->pstate;
    } else {

I suspect given cached flags are common about the translator it might be
worth coming up with a nicer macro to encapsulate the check for
DEBUG_TCG builds.

>          flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          pstate_for_ss =3D env->pstate;
>      } else {
>          *pc =3D env->regs[15];
> -        flags =3D rebuild_hflags_a32(env, current_el);
> -        assert(flags =3D=3D env->hflags);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
>          pstate_for_ss =3D env->uncached_cpsr;

--
Alex Benn=C3=A9e
