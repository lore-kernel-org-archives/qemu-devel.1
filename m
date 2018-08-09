Received: from eggs.gnu.org ([2001:4830:134:3::10]:52089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnpFJ-0003gf-ML
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnpFE-0000I3-6g
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:01:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnpFD-0000Hj-Mv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:01:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id v14-v6so5904238wro.5
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 11:01:07 -0700 (PDT)
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809042206.15726-9-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 19:01:05 +0100
Message-ID: <87bmabpggu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/20] target/arm: Pass in current_el to fp
 and sve_exception_el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> We are going to want to determine whether sve is enabled
> for EL than current.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Are these patches meant to apply to origin/master or on top of the
user-mode fixes? This didn't apply for me:


> @@ -12385,11 +12382,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
>      ARMMMUIdx mmu_idx =3D core_to_arm_mmu_idx(env, cpu_mmu_index(env, fa=
lse));
> -    int fp_el =3D fp_exception_el(env);
> +    int current_el =3D arm_current_el(env);
> +    int fp_el =3D fp_exception_el(env, current_el);
>      uint32_t flags;
>
>      if (is_a64(env)) {
> -        int sve_el =3D sve_exception_el(env);
> +        int sve_el =3D sve_exception_el(env, current_el);
>          uint32_t zcr_len;
>
>          *pc =3D env->pc;
> @@ -12404,7 +12402,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>          if (sve_el !=3D 0 && fp_el =3D=3D 0) {
>              zcr_len =3D 0;
>          } else {
> -            int current_el =3D arm_current_el(env);
>              ARMCPU *cpu =3D arm_env_get_cpu(env);
>
>              zcr_len =3D cpu->sve_max_vq - 1;

++<<<<<<< HEAD
 +            int current_el =3D arm_current_el(env);
++=3D=3D=3D=3D=3D=3D=3D
+             ARMCPU *cpu =3D arm_env_get_cpu(env);

--
Alex Benn=C3=A9e
