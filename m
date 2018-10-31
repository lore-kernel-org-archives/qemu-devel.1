Received: from eggs.gnu.org ([2001:4830:134:3::10]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHotM-00028P-3X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHotB-0001i8-3p
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:42:28 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHot8-0001ek-5U
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:42:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id 189-v6so14809871wmw.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:42:18 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-9-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-9-cota@braap.org>
Date: Wed, 31 Oct 2018 11:42:15 +0000
Message-ID: <87k1ly8hrc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 09/71] cris: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> And fix the temp leak along the way.
>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/cris/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 4ae1c04daf..0ccb65fbed 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -2833,8 +2833,9 @@ static int dec_rfe_etc(CPUCRISState *env, DisasCont=
ext *dc)
>      cris_cc_mask(dc, 0);
>
>      if (dc->op2 =3D=3D 15) {
> -        tcg_gen_st_i32(tcg_const_i32(1), cpu_env,
> -                       -offsetof(CRISCPU, env) + offsetof(CPUState, halt=
ed));
> +        TCGv_i32 tmp =3D tcg_const_i32(1);
> +        gen_helper_cpu_halted_set(cpu_env, tmp);
> +        tcg_temp_free_i32(tmp);
>          tcg_gen_movi_tl(env_pc, dc->pc + 2);
>          t_gen_raise_exception(EXCP_HLT);
>          return 2;


--
Alex Benn=C3=A9e
