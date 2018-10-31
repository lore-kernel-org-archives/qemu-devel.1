Received: from eggs.gnu.org ([2001:4830:134:3::10]:37845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHoum-0003jc-P6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHouj-0003SG-Gd
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:44:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHouj-0003Rk-A0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:43:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id h2-v6so10963966wmb.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:43:57 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-11-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-11-cota@braap.org>
Date: Wed, 31 Oct 2018 11:43:54 +0000
Message-ID: <87h8h28hol.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 11/71] m68k: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/m68k/translate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index ae3651b867..d55e707cf6 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -43,7 +43,6 @@
>  #undef DEFO32
>  #undef DEFO64
>
> -static TCGv_i32 cpu_halted;
>  static TCGv_i32 cpu_exception_index;
>
>  static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
> @@ -79,9 +78,6 @@ void m68k_tcg_init(void)
>  #undef DEFO32
>  #undef DEFO64
>
> -    cpu_halted =3D tcg_global_mem_new_i32(cpu_env,
> -                                        -offsetof(M68kCPU, env) +
> -                                        offsetof(CPUState, halted), "HAL=
TED");
>      cpu_exception_index =3D tcg_global_mem_new_i32(cpu_env,
>                                                   -offsetof(M68kCPU, env)=
 +
>                                                   offsetof(CPUState, exce=
ption_index),
> @@ -4637,6 +4633,7 @@ DISAS_INSN(halt)
>  DISAS_INSN(stop)
>  {
>      uint16_t ext;
> +    TCGv_i32 tmp;
>
>      if (IS_USER(s)) {
>          gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
> @@ -4646,7 +4643,9 @@ DISAS_INSN(stop)
>      ext =3D read_im16(env, s);
>
>      gen_set_sr_im(s, ext, 0);
> -    tcg_gen_movi_i32(cpu_halted, 1);
> +    tmp =3D tcg_const_i32(1);
> +    gen_helper_cpu_halted_set(cpu_env, tmp);
> +    tcg_temp_free_i32(tmp);
>      gen_exception(s, s->pc, EXCP_HLT);
>  }


--
Alex Benn=C3=A9e
