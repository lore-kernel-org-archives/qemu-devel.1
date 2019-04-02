Received: from eggs.gnu.org ([209.51.188.92]:46747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBMsT-0002Nt-LG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBMsR-0005z8-DN
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:07:13 -0400
Received: from mail-eopbgr820108.outbound.protection.outlook.com
	([40.107.82.108]:2512
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBMsQ-0005t7-Ts
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:07:11 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 2 Apr 2019 17:07:07 +0000
Message-ID: <BN6PR2201MB1251EDD95B45D5553187A510C6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>,
	<9d208883-c16b-e24a-7aa3-97688897acc2@redhat.com>
In-Reply-To: <9d208883-c16b-e24a-7aa3-97688897acc2@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize ILVEV.<B|H=
|W|D> MSA instructions
>
> Hi Mateja,
>
> On 4/2/19 5:15 PM, Mateja Marjanovic wrote:
> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> >
> > Optimize set of MSA instructions ILVEV, using directly
> > tcg registers and performing logic on them instead of
> > using helpers.
>
> Maybe you can still let this previous comment (if still valid):
>
>   Performance measurement is done by executing the
>   instructions large number of times on a computer
>   with Intel Core i7-3770 CPU @ 3.40GHz=D78.
>

Agreed.

> >
> > In the following table, the first column is the performance
> > before this patch. The second represents the performance,
> > after converting from helpers to tcg, but without using
> > tcg_gen_deposit function. The third one is the solution
> > which is implemented in this patch.
>
> You are describing the "no-deposit" which refers to a previous series
> but won't be accessible in the git repository.
>
> I think this table is useful in the cover of this series, and in the
> commit message you should use || before || after || and drop the
> "no-deposit" case.
>
> >
> >  instr    ||   before    || no-deposit ||  with-deposit
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >  ilvev.b  ||  126.92 ms  ||  24.52 ms  ||  24.43 ms
> >  ilvev.h  ||   93.67 ms  ||  23.92 ms  ||  23.86 ms
> >  ilvev.w  ||  117.86 ms  ||  23.83 ms  ||  22.17 ms
> >  ilvev.d  ||   45.49 ms  ||  19.74 ms  ||  19.71 ms
> >
> > The solution with deposit is suggested by Richard Henderson.
> >
>

I think the table should remain in the commit message, to keep it
visible in the git logs.

You could insert the "no-deposit" source code of gen_ilvev_w()
in the commit message, for reference reasons - it is not a too
large function.

Thanks,
Aleksandar

> The gitdm parsable form is:
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > ---
> >  target/mips/helper.h     |   1 -
> >  target/mips/msa_helper.c |   9 ----
> >  target/mips/translate.c  | 105 +++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  3 files changed, 104 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/mips/helper.h b/target/mips/helper.h
> > index 02e16c7..82f6a40 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32=
, i32)
> >  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
> >  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
> >  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> > -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
> >  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
> >  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
> >  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> > diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> > index a7ea6aa..d5c3842 100644
> > --- a/target/mips/msa_helper.c
> > +++ b/target/mips/msa_helper.c
> > @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
> >      } while (0)
> >  MSA_FN_DF(ilvr_df)
> >  #undef MSA_DO
> > -
> > -#define MSA_DO(DF)                      \
> > -    do {                                \
> > -        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
> > -        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
> > -    } while (0)
> > -MSA_FN_DF(ilvev_df)
> > -#undef MSA_DO
> > -
> >  #undef MSA_LOOP_COND
> >
> >  #define MSA_LOOP_COND(DF) \
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 04406d6..e26c6a6 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -28974,6 +28974,94 @@ static inline void gen_ilvod_d(CPUMIPSState *e=
nv, uint32_t wd,
> >      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
> >  }
> >
> > +/*
> > + * [MSA] ILVEV.B wd, ws, wt
> > + *
> > + *   Vector Interleave Even (byte data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> > +                               uint32_t ws, uint32_t wt)
> > +{
> > +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> > +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> > +    const uint64_t mask =3D 0x00ff00ff00ff00ffULL;
> > +
> > +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> > +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> > +    tcg_gen_shli_i64(t2, t2, 8);
> > +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> > +
>
> Richard, is it cheaper to use another register to keep the constant mask
> (here reused 4x)?
>
> Such:
>
>        TCGv_i64 mask =3D tcg_const_i64(0x00ff00ff00ff00ffULL);
>
>        tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>        tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>        tcg_gen_shli_i64(t2, t2, 8);
>        tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>
> > +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> > +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>
> Here use tcg_gen_and_i64() too.
>
> > +    tcg_gen_shli_i64(t2, t2, 8);
> > +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> > +
>
>        tcg_temp_free_i64(mask);
>
> > +    tcg_temp_free_i64(t1);
> > +    tcg_temp_free_i64(t2);
>
> Mateja: Can you test for perf easily?
>
> > +}
> > +
> > +/*
> > + * [MSA] ILVEV.H wd, ws, wt
> > + *
> > + *   Vector Interleave Even (halfword data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> > +                               uint32_t ws, uint32_t wt)
> > +{
> > +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> > +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> > +    const uint64_t mask =3D 0x0000ffff0000ffffULL;
> > +
> > +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> > +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> > +    tcg_gen_shli_i64(t2, t2, 16);
> > +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> > +
> > +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> > +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> > +    tcg_gen_shli_i64(t2, t2, 16);
> > +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> > +
> > +    tcg_temp_free_i64(t1);
> > +    tcg_temp_free_i64(t2);
>
> Very similiar to gen_ilvev_b(), changing the mask and shift. Maybe worth
> a refactor.
>
> > +}
> > +
> > +/*
> > + * [MSA] ILVEV.W wd, ws, wt
> > + *
> > + *   Vector Interleave Even (word data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> > +                               uint32_t ws, uint32_t wt)
> > +{
> > +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> > +    const uint64_t mask =3D 0x00000000ffffffffULL;
> > +
> > +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> > +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[ws * 2], 32, 32=
);
> > +
> > +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> > +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], t1, msa_wr_d[ws * 2 + 1]=
, 32, 32);
> > +
> > +    tcg_temp_free_i64(t1);
> > +}
> > +
> > +/*
> > + * [MSA] ILVEV.D wd, ws, wt
> > + *
> > + *   Vector Interleave Even (Double data elements)
> > + *
> > + */
> > +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> > +                               uint32_t ws, uint32_t wt)
> > +{
> > +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> > +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> > +}
> > +
> >  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
> >  {
> >  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
> > @@ -29130,7 +29218,22 @@ static void gen_msa_3r(CPUMIPSState *env, Disa=
sContext *ctx)
> >          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
> >          break;
> >      case OPC_ILVEV_df:
> > -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
> > +        switch (df) {
> > +        case DF_BYTE:
> > +            gen_ilvev_b(env, wd, ws, wt);
> > +            break;
> > +        case DF_HALF:
> > +            gen_ilvev_h(env, wd, ws, wt);
> > +            break;
> > +        case DF_WORD:
> > +            gen_ilvev_w(env, wd, ws, wt);
> > +            break;
> > +        case DF_DOUBLE:
> > +            gen_ilvev_d(env, wd, ws, wt);
> > +            break;
> > +        default:
> > +            assert(0);
> > +        }
> >          break;
> >      case OPC_BINSR_df:
> >          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
> >
>
> Thanks,
>
> Phil.
>

________________________________________
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Sent: Tuesday, April 2, 2019 6:19:19 PM
To: Mateja Marjanovic; qemu-devel@nongnu.org
Cc: Aleksandar Rikalo; richard.henderson@linaro.org; Aleksandar Markovic; a=
urelien@aurel32.net
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize ILVEV.<B|H|W=
|D> MSA instructions

Hi Mateja,

On 4/2/19 5:15 PM, Mateja Marjanovic wrote:
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Optimize set of MSA instructions ILVEV, using directly
> tcg registers and performing logic on them instead of
> using helpers.

Maybe you can still let this previous comment (if still valid):

  Performance measurement is done by executing the
  instructions large number of times on a computer
  with Intel Core i7-3770 CPU @ 3.40GHz=D78.

>
> In the following table, the first column is the performance
> before this patch. The second represents the performance,
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is the solution
> which is implemented in this patch.

You are describing the "no-deposit" which refers to a previous series
but won't be accessible in the git repository.

I think this table is useful in the cover of this series, and in the
commit message you should use || before || after || and drop the
"no-deposit" case.

>
>  instr    ||   before    || no-deposit ||  with-deposit
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  ilvev.b  ||  126.92 ms  ||  24.52 ms  ||  24.43 ms
>  ilvev.h  ||   93.67 ms  ||  23.92 ms  ||  23.86 ms
>  ilvev.w  ||  117.86 ms  ||  23.83 ms  ||  22.17 ms
>  ilvev.d  ||   45.49 ms  ||  19.74 ms  ||  19.71 ms
>
> The solution with deposit is suggested by Richard Henderson.
>

The gitdm parsable form is:

Suggested-by: Richard Henderson <richard.henderson@linaro.org>

> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |   1 -
>  target/mips/msa_helper.c |   9 ----
>  target/mips/translate.c  | 105 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 104 insertions(+), 11 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 02e16c7..82f6a40 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, =
i32)
>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index a7ea6aa..d5c3842 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
>      } while (0)
>  MSA_FN_DF(ilvr_df)
>  #undef MSA_DO
> -
> -#define MSA_DO(DF)                      \
> -    do {                                \
> -        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
> -        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
> -    } while (0)
> -MSA_FN_DF(ilvev_df)
> -#undef MSA_DO
> -
>  #undef MSA_LOOP_COND
>
>  #define MSA_LOOP_COND(DF) \
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 04406d6..e26c6a6 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -28974,6 +28974,94 @@ static inline void gen_ilvod_d(CPUMIPSState *env=
, uint32_t wd,
>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
>  }
>
> +/*
> + * [MSA] ILVEV.B wd, ws, wt
> + *
> + *   Vector Interleave Even (byte data elements)
> + *
> + */
> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    const uint64_t mask =3D 0x00ff00ff00ff00ffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t2, t2, 8);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> +

Richard, is it cheaper to use another register to keep the constant mask
(here reused 4x)?

Such:

       TCGv_i64 mask =3D tcg_const_i64(0x00ff00ff00ff00ffULL);

       tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
       tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
       tcg_gen_shli_i64(t2, t2, 8);
       tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);

> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);

Here use tcg_gen_and_i64() too.

> +    tcg_gen_shli_i64(t2, t2, 8);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> +

       tcg_temp_free_i64(mask);

> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);

Mateja: Can you test for perf easily?

> +}
> +
> +/*
> + * [MSA] ILVEV.H wd, ws, wt
> + *
> + *   Vector Interleave Even (halfword data elements)
> + *
> + */
> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    const uint64_t mask =3D 0x0000ffff0000ffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t2, t2, 16);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t2, t2, 16);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);

Very similiar to gen_ilvev_b(), changing the mask and shift. Maybe worth
a refactor.

> +}
> +
> +/*
> + * [MSA] ILVEV.W wd, ws, wt
> + *
> + *   Vector Interleave Even (word data elements)
> + *
> + */
> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    const uint64_t mask =3D 0x00000000ffffffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[ws * 2], 32, 32);
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], t1, msa_wr_d[ws * 2 + 1], =
32, 32);
> +
> +    tcg_temp_free_i64(t1);
> +}
> +
> +/*
> + * [MSA] ILVEV.D wd, ws, wt
> + *
> + *   Vector Interleave Even (Double data elements)
> + *
> + */
> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> +}
> +
>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>  {
>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
> @@ -29130,7 +29218,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
>          break;
>      case OPC_ILVEV_df:
> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
> +        switch (df) {
> +        case DF_BYTE:
> +            gen_ilvev_b(env, wd, ws, wt);
> +            break;
> +        case DF_HALF:
> +            gen_ilvev_h(env, wd, ws, wt);
> +            break;
> +        case DF_WORD:
> +            gen_ilvev_w(env, wd, ws, wt);
> +            break;
> +        case DF_DOUBLE:
> +            gen_ilvev_d(env, wd, ws, wt);
> +            break;
> +        default:
> +            assert(0);
> +        }
>          break;
>      case OPC_BINSR_df:
>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
>

Thanks,

Phil.
