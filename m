Received: from eggs.gnu.org ([2001:4830:134:3::10]:57540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flCk7-0006FU-Qm
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flCk3-00077n-1r
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:30:11 -0400
Received: from mail-by2nam05on0718.outbound.protection.outlook.com
	([2a01:111:f400:fe52::718]:11440
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flCk2-00073F-JW
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:30:06 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 2 Aug 2018 12:29:42 +0000
Message-ID: <BN7PR08MB48688BC84CBE8C74D095A46AC62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-46-git-send-email-aleksandar.markovic@rt-rk.com>,
	<599465e2-9620-61a4-9a73-a8464c06cbab@linaro.org>
In-Reply-To: <599465e2-9620-61a4-9a73-a8464c06cbab@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 45/76] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi, Richard,

We are going to remove obsoleted helpers, that was just an honest mistake m=
ade in a rush.

For unprotected access to gpr, we are going to insert if(reg1 !=3D 0) in tw=
o places.

However, it looks there is a bigger problem now in SCWP. QEMU crashes with =
this message:

/qemu/tcg/tcg.c:2862: tcg fatal error

This happens in user mode only, system mode case runs fine.

the problem seems to appear as a consequence of using tcg_gen_brcond_*(().

Do you have any idea what are we doing wrong here?

> +static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
> +                    uint32_t reg1, uint32_t reg2)
> +{
> +    TCGv taddr =3D tcg_temp_new();
> +    TCGv lladdr =3D tcg_temp_new();
> +    TCGv_i64 tval =3D tcg_temp_new_i64();
> +    TCGv_i64 llval =3D tcg_temp_new_i64();
> +    TCGv_i64 val =3D tcg_temp_new_i64();
> +    TCGv tmp1 =3D tcg_temp_new();
> +    TCGv tmp2 =3D tcg_temp_new();
> +    TCGLabel *lab_fail =3D gen_new_label();
> +    TCGLabel *lab_done =3D gen_new_label();
> +
> +    gen_base_offset_addr(ctx, taddr, base, offset);
> +
> +    tcg_gen_ld_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
> +    tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);
> +
> +    gen_load_gpr(tmp1, reg1);
> +    gen_load_gpr(tmp2, reg2);
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    tcg_gen_concat_tl_i64(tval, tmp2, tmp1);
> +#else
> +    tcg_gen_concat_tl_i64(tval, tmp1, tmp2);
> +#endif
> +
> +    tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
> +    tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
> +                               ctx->mem_idx, MO_64);
> +    tcg_gen_movi_tl(cpu_gpr[reg1], 1);
> +    tcg_gen_brcond_i64(TCG_COND_EQ, val, llval, lab_done);
> +
> +    gen_set_label(lab_fail);
> +
> +    tcg_gen_movi_tl(cpu_gpr[reg1], 0);
> +
> +    gen_set_label(lab_done);
> +    tcg_gen_movi_tl(lladdr, -1);
> +    tcg_gen_st_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
> +}
> +

Regards,
Aleksandar=
