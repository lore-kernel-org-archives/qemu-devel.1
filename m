Received: from eggs.gnu.org ([209.51.188.92]:45017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBbbY-0005Vd-08
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBbbV-0007mE-RP
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:50:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58005 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBbbV-0007if-1p
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:50:41 -0400
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=hG_3htcguRp11NGx3pZP5QY8V6r1kYONYxbcE+NkmQ8Q@mail.gmail.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <451d1a6d-1b81-7e81-b9ae-2152544ec165@rt-rk.com>
Date: Wed, 3 Apr 2019 10:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hG_3htcguRp11NGx3pZP5QY8V6r1kYONYxbcE+NkmQ8Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: amarkovic@wavecomp.com, qemu-devel@nongnu.org, richard.henderson@linaro.org, aurelien@aurel32.net, arikalo@wavecomp.com


On 3.4.19. 01:25, Aleksandar Markovic wrote:
>
>
> On Apr 2, 2019 5:20 PM, "Mateja Marjanovic"=20
> <mateja.marjanovic@rt-rk.com <mailto:mateja.marjanovic@rt-rk.com>> wrot=
e:
> >
> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com=20
> <mailto:Mateja.Marjanovic@rt-rk.com>>
> >
> > Optimize set of MSA instructions ILVEV, using directly
>
> Use full instruction names, with the only exception of possible=20
> Bachus-Naur forms... again.
>
I will, I didn't change it from some of the previous versions.
>
> > tcg registers and performing logic on them instead of
> > using helpers.
> >
> > In the following table, the first column is the performance
> > before this patch. The second represents the performance,
> > after converting from helpers to tcg, but without using
> > tcg_gen_deposit function. The third one is the solution
> > which is implemented in this patch.
> >
> > =C2=A0instr=C2=A0 =C2=A0 ||=C2=A0 =C2=A0before=C2=A0 =C2=A0 || no-dep=
osit ||=C2=A0 with-deposit
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0ilvev.b=C2=A0 ||=C2=A0 126.92 ms=C2=A0 ||=C2=A0 24.52 ms=C2=A0 =
||=C2=A0 24.43 ms
> > =C2=A0ilvev.h=C2=A0 ||=C2=A0 =C2=A093.67 ms=C2=A0 ||=C2=A0 23.92 ms=C2=
=A0 ||=C2=A0 23.86 ms
> > =C2=A0ilvev.w=C2=A0 ||=C2=A0 117.86 ms=C2=A0 ||=C2=A0 23.83 ms=C2=A0 =
||=C2=A0 22.17 ms
> > =C2=A0ilvev.d=C2=A0 ||=C2=A0 =C2=A045.49 ms=C2=A0 ||=C2=A0 19.74 ms=C2=
=A0 ||=C2=A0 19.71 ms
> >
> > The solution with deposit is suggested by Richard Henderson.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com=20
> <mailto:mateja.marjanovic@rt-rk.com>>
> > ---
>
> The byte and halfword cases of this patch most likely produce highly=20
> unoptimized code for cases:
>
> wd =3D=3D wt =3D=3D ws
> wd =3D=3D wt !=3D ws
> wd !=3D ws =3D=3D wt
> wd =3D=3D ws !=3D wt
>
> Please take these cases into account.
>
> The same for patch 1/2.
>
Maybe, but if I put if statements asking are the registers the same,
it would affect the performance significantly in all cases. If some
registers were equal, it would be faster, but if not, just those if=20
statements
would slow things down.
>
> Thanks,
> Aleksandar
>
Thanks,
Mateja

> > =C2=A0target/mips/helper.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 -
> > =C2=A0target/mips/msa_helper.c |=C2=A0 =C2=A09 ----
> > =C2=A0target/mips/translate.c=C2=A0 | 105=20
> ++++++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A03 files changed, 104 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/mips/helper.h b/target/mips/helper.h
> > index 02e16c7..82f6a40 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32,=20
> i32, i32)
> > =C2=A0DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> > -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
> > =C2=A0DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> > index a7ea6aa..d5c3842 100644
> > --- a/target/mips/msa_helper.c
> > +++ b/target/mips/msa_helper.c
> > @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
> > =C2=A0 =C2=A0 =C2=A0} while (0)
> > =C2=A0MSA_FN_DF(ilvr_df)
> > =C2=A0#undef MSA_DO
> > -
> > -#define MSA_DO(DF)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \
> > -=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwx->DF[2*i]=C2=A0 =C2=A0=3D pwt->DF[2*i=
];=C2=A0 \
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwx->DF[2*i+1] =3D pws->DF[2*i];=C2=A0 \
> > -=C2=A0 =C2=A0 } while (0)
> > -MSA_FN_DF(ilvev_df)
> > -#undef MSA_DO
> > -
> > =C2=A0#undef MSA_LOOP_COND
> >
> > =C2=A0#define MSA_LOOP_COND(DF) \
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 04406d6..e26c6a6 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -28974,6 +28974,94 @@ static inline void gen_ilvod_d(CPUMIPSState=20
> *env, uint32_t wd,
> > =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws=
 * 2 + 1]);
> > =C2=A0}
> >
> > +/*
> > + * [MSA] ILVEV.B wd, ws, wt
> > + *
> > + *=C2=A0 =C2=A0Vector Interleave Even (byte data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ws, uint32_t wt)
> > +{
> > +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();
> > +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();
> > +=C2=A0 =C2=A0 const uint64_t mask =3D 0x00ff00ff00ff00ffULL;
> > +
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> > +=C2=A0 =C2=A0 tcg_gen_shli_i64(t2, t2, 8);
> > +=C2=A0 =C2=A0 tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> > +
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> > +=C2=A0 =C2=A0 tcg_gen_shli_i64(t2, t2, 8);
> > +=C2=A0 =C2=A0 tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> > +
> > +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);
> > +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);
> > +}
> > +
> > +/*
> > + * [MSA] ILVEV.H wd, ws, wt
> > + *
> > + *=C2=A0 =C2=A0Vector Interleave Even (halfword data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ws, uint32_t wt)
> > +{
> > +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();
> > +=C2=A0 =C2=A0 TCGv_i64 t2 =3D tcg_temp_new_i64();
> > +=C2=A0 =C2=A0 const uint64_t mask =3D 0x0000ffff0000ffffULL;
> > +
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> > +=C2=A0 =C2=A0 tcg_gen_shli_i64(t2, t2, 16);
> > +=C2=A0 =C2=A0 tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> > +
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> > +=C2=A0 =C2=A0 tcg_gen_shli_i64(t2, t2, 16);
> > +=C2=A0 =C2=A0 tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> > +
> > +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);
> > +=C2=A0 =C2=A0 tcg_temp_free_i64(t2);
> > +}
> > +
> > +/*
> > + * [MSA] ILVEV.W wd, ws, wt
> > + *
> > + *=C2=A0 =C2=A0Vector Interleave Even (word data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ws, uint32_t wt)
> > +{
> > +=C2=A0 =C2=A0 TCGv_i64 t1 =3D tcg_temp_new_i64();
> > +=C2=A0 =C2=A0 const uint64_t mask =3D 0x00000000ffffffffULL;
> > +
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> > +=C2=A0 =C2=A0 tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[ws =
* 2], 32,=20
> 32);
> > +
> > +=C2=A0 =C2=A0 tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> > +=C2=A0 =C2=A0 tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], t1, msa_wr_d=
[ws * 2 +=20
> 1], 32, 32);
> > +
> > +=C2=A0 =C2=A0 tcg_temp_free_i64(t1);
> > +}
> > +
> > +/*
> > + * [MSA] ILVEV.D wd, ws, wt
> > + *
> > + *=C2=A0 =C2=A0Vector Interleave Even (Double data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ws, uint32_t wt)
> > +{
> > +=C2=A0 =C2=A0 tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]=
);
> > +=C2=A0 =C2=A0 tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> > +}
> > +
> > =C2=A0static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
> > =C2=A0{
> > =C2=A0#define MASK_MSA_3R(op)=C2=A0 =C2=A0 (MASK_MSA_MINOR(op) | (op =
& (0x7 << 23)))
> > @@ -29130,7 +29218,22 @@ static void gen_msa_3r(CPUMIPSState *env,=20
> DisasContext *ctx)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_msa_mod_s_df(cpu_env, td=
f, twd, tws, twt);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0case OPC_ILVEV_df:
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_msa_ilvev_df(cpu_env, tdf, tw=
d, tws, twt);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (df) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_BYTE:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_ilvev_b(env, wd, ws, w=
t);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_HALF:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_ilvev_h(env, wd, ws, w=
t);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_WORD:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_ilvev_w(env, wd, ws, w=
t);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DF_DOUBLE:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_ilvev_d(env, wd, ws, w=
t);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0case OPC_BINSR_df:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_msa_binsr_df(cpu_env, td=
f, twd, tws, twt);
> > --
> > 2.7.4
> >
> >
>
