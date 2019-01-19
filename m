Received: from eggs.gnu.org ([209.51.188.92]:41215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gkehq-0000yn-KC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 19:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gkehm-00022S-QB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 19:41:50 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gkehk-0001yF-TF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 19:41:46 -0500
Received: by mail-ot1-x342.google.com with SMTP id w25so15987647otm.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 16:41:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <25a587c0-b1a3-7a0b-9d9f-3d1bf2a86182@wavecomp.com>
References: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1546533252-26601-6-git-send-email-aleksandar.markovic@rt-rk.com>
	<25a587c0-b1a3-7a0b-9d9f-3d1bf2a86182@wavecomp.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Jan 2019 01:41:40 +0100
Message-ID: <CAL1e-=j_mnpDnPAfb9MnDkj1Vv07EVR3GWBC5eYYDOJnZ7yQJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/8] target/mips: Provide R/W access to
 SAARI and SAAR CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <smarkovic@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

On Thursday, January 17, 2019, Stefan Markovic <smarkovic@wavecomp.com>
wrote:

>
> On 3.1.19. 17:34, Aleksandar Markovic wrote:
> > From: Yongbok Kim <yongbok.kim@mips.com>
> >
> > Provide R/W access to SAARI and SAAR CP0 registers.
> >
> > Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >   target/mips/cpu.h       |  1 +
> >   target/mips/helper.h    |  6 +++++
> >   target/mips/internal.h  |  1 +
> >   target/mips/op_helper.c | 50 +++++++++++++++++++++++++++++++++++++
> >   target/mips/translate.c | 66 ++++++++++++++++++++++++++++++
> ++++++++++++++++---
> >   5 files changed, 120 insertions(+), 4 deletions(-)
>
>
> Reviewed-by: Stefan Markovic <smarokvic@wavecomp.com>
>
>
The whole series contains this wrong address, but the pull request is fine.

Also, I expected much better and more detailed review, you logged four
whole days on the reviewing, and here is your result. Disappointing!



> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index 1c2c682..185702d 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -901,6 +901,7 @@ struct CPUMIPSState {
> >       uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
> >       uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in
> CP0_TCStatus */
> >       uint64_t insn_flags; /* Supported instruction set */
> > +    int saarp;
> >
> >       /* Fields up to this point are cleared by a CPU reset */
> >       struct {} end_reset_fields;
> > diff --git a/target/mips/helper.h b/target/mips/helper.h
> > index c23e4e5..8872c46 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -65,6 +65,8 @@ DEF_HELPER_1(mftc0_tcschedule, tl, env)
> >   DEF_HELPER_1(mfc0_tcschefback, tl, env)
> >   DEF_HELPER_1(mftc0_tcschefback, tl, env)
> >   DEF_HELPER_1(mfc0_count, tl, env)
> > +DEF_HELPER_1(mfc0_saar, tl, env)
> > +DEF_HELPER_1(mfhc0_saar, tl, env)
> >   DEF_HELPER_1(mftc0_entryhi, tl, env)
> >   DEF_HELPER_1(mftc0_status, tl, env)
> >   DEF_HELPER_1(mftc0_cause, tl, env)
> > @@ -87,6 +89,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
> >   DEF_HELPER_1(dmfc0_lladdr, tl, env)
> >   DEF_HELPER_1(dmfc0_maar, tl, env)
> >   DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
> > +DEF_HELPER_1(dmfc0_saar, tl, env)
> >   #endif /* TARGET_MIPS64 */
> >
> >   DEF_HELPER_2(mtc0_index, void, env, tl)
> > @@ -131,6 +134,9 @@ DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
> >   DEF_HELPER_2(mtc0_hwrena, void, env, tl)
> >   DEF_HELPER_2(mtc0_pwctl, void, env, tl)
> >   DEF_HELPER_2(mtc0_count, void, env, tl)
> > +DEF_HELPER_2(mtc0_saari, void, env, tl)
> > +DEF_HELPER_2(mtc0_saar, void, env, tl)
> > +DEF_HELPER_2(mthc0_saar, void, env, tl)
> >   DEF_HELPER_2(mtc0_entryhi, void, env, tl)
> >   DEF_HELPER_2(mttc0_entryhi, void, env, tl)
> >   DEF_HELPER_2(mtc0_compare, void, env, tl)
> > diff --git a/target/mips/internal.h b/target/mips/internal.h
> > index 8b1b245..8f6fc91 100644
> > --- a/target/mips/internal.h
> > +++ b/target/mips/internal.h
> > @@ -61,6 +61,7 @@ struct mips_def_t {
> >       target_ulong CP0_EBaseWG_rw_bitmask;
> >       uint64_t insn_flags;
> >       enum mips_mmu_types mmu_type;
> > +    int32_t SAARP;
> >   };
> >
> >   extern const struct mips_def_t mips_defs[];
> > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> > index d1f1d1a..409c136 100644
> > --- a/target/mips/op_helper.c
> > +++ b/target/mips/op_helper.c
> > @@ -938,6 +938,22 @@ target_ulong helper_mfc0_count(CPUMIPSState *env)
> >       return count;
> >   }
> >
> > +target_ulong helper_mfc0_saar(CPUMIPSState *env)
> > +{
> > +    if ((env->CP0_SAARI & 0x3f) < 2) {
> > +        return (int32_t) env->CP0_SAAR[env->CP0_SAARI & 0x3f];
> > +    }
> > +    return 0;
> > +}
> > +
> > +target_ulong helper_mfhc0_saar(CPUMIPSState *env)
> > +{
> > +    if ((env->CP0_SAARI & 0x3f) < 2) {
> > +        return env->CP0_SAAR[env->CP0_SAARI & 0x3f] >> 32;
> > +    }
> > +    return 0;
> > +}
> > +
> >   target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
> >   {
> >       int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
> > @@ -1059,6 +1075,14 @@ target_ulong helper_dmfc0_watchlo(CPUMIPSState
> *env, uint32_t sel)
> >   {
> >       return env->CP0_WatchLo[sel];
> >   }
> > +
> > +target_ulong helper_dmfc0_saar(CPUMIPSState *env)
> > +{
> > +    if ((env->CP0_SAARI & 0x3f) < 2) {
> > +        return env->CP0_SAAR[env->CP0_SAARI & 0x3f];
> > +    }
> > +    return 0;
> > +}
> >   #endif /* TARGET_MIPS64 */
> >
> >   void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
> > @@ -1598,6 +1622,32 @@ void helper_mtc0_count(CPUMIPSState *env,
> target_ulong arg1)
> >       qemu_mutex_unlock_iothread();
> >   }
> >
> > +void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
> > +{
> > +    uint32_t target = arg1 & 0x3f;
> > +    if (target <= 1) {
> > +        env->CP0_SAARI = target;
> > +    }
> > +}
> > +
> > +void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
> > +{
> > +    uint32_t target = env->CP0_SAARI & 0x3f;
> > +    if (target < 2) {
> > +        env->CP0_SAAR[target] = arg1 & 0x00000ffffffff03fULL;
> > +    }
> > +}
> > +
> > +void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
> > +{
> > +    uint32_t target = env->CP0_SAARI & 0x3f;
> > +    if (target < 2) {
> > +        env->CP0_SAAR[target] =
> > +            (((uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
> > +            (env->CP0_SAAR[target] & 0x00000000ffffffffULL);
> > +    }
> > +}
> > +
> >   void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
> >   {
> >       target_ulong old, val, mask;
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 6af292f..b0b926f 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -2501,6 +2501,7 @@ typedef struct DisasContext {
> >       bool mrp;
> >       bool nan2008;
> >       bool abs2008;
> > +    bool saar;
> >   } DisasContext;
> >
> >   #define DISAS_STOP       DISAS_TARGET_0
> > @@ -6498,6 +6499,17 @@ static void gen_mfhc0(DisasContext *ctx, TCGv
> arg, int reg, int sel)
> >               goto cp0_unimplemented;
> >           }
> >           break;
> > +    case CPO_REGISTER_09:
> > +        switch (sel) {
> > +        case 7:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mfhc0_saar(arg, cpu_env);
> > +            rn = "SAAR";
> > +            break;
> > +        default:
> > +            goto cp0_unimplemented;
> > +        }
> > +        break;
> >       case CPO_REGISTER_17:
> >           switch (sel) {
> >           case 0:
> > @@ -6568,6 +6580,16 @@ static void gen_mthc0(DisasContext *ctx, TCGv
> arg, int reg, int sel)
> >               goto cp0_unimplemented;
> >           }
> >           break;
> > +    case CPO_REGISTER_09:
> > +        switch (sel) {
> > +        case 7:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mthc0_saar(cpu_env, arg);
> > +            rn = "SAAR";
> > +            break;
> > +        default:
> > +            goto cp0_unimplemented;
> > +        }
> >       case CPO_REGISTER_17:
> >           switch (sel) {
> >           case 0:
> > @@ -6954,7 +6976,16 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,
> int reg, int sel)
> >               ctx->base.is_jmp = DISAS_EXIT;
> >               rn = "Count";
> >               break;
> > -        /* 6,7 are implementation dependent */
> > +        case 6:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
> > +            rn = "SAARI";
> > +            break;
> > +        case 7:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mfc0_saar(arg, cpu_env);
> > +            rn = "SAAR";
> > +            break;
> >           default:
> >               goto cp0_unimplemented;
> >           }
> > @@ -7659,7 +7690,16 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg,
> int reg, int sel)
> >               gen_helper_mtc0_count(cpu_env, arg);
> >               rn = "Count";
> >               break;
> > -        /* 6,7 are implementation dependent */
> > +        case 6:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mtc0_saari(cpu_env, arg);
> > +            rn = "SAARI";
> > +            break;
> > +        case 7:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mtc0_saar(cpu_env, arg);
> > +            rn = "SAAR";
> > +            break;
> >           default:
> >               goto cp0_unimplemented;
> >           }
> > @@ -8404,7 +8444,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv
> arg, int reg, int sel)
> >               ctx->base.is_jmp = DISAS_EXIT;
> >               rn = "Count";
> >               break;
> > -        /* 6,7 are implementation dependent */
> > +        case 6:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
> > +            rn = "SAARI";
> > +            break;
> > +        case 7:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_dmfc0_saar(arg, cpu_env);
> > +            rn = "SAAR";
> > +            break;
> >           default:
> >               goto cp0_unimplemented;
> >           }
> > @@ -9092,7 +9141,16 @@ static void gen_dmtc0(DisasContext *ctx, TCGv
> arg, int reg, int sel)
> >               gen_helper_mtc0_count(cpu_env, arg);
> >               rn = "Count";
> >               break;
> > -        /* 6,7 are implementation dependent */
> > +        case 6:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mtc0_saari(cpu_env, arg);
> > +            rn = "SAARI";
> > +            break;
> > +        case 7:
> > +            CP0_CHECK(ctx->saar);
> > +            gen_helper_mtc0_saar(cpu_env, arg);
> > +            rn = "SAAR";
> > +            break;
> >           default:
> >               goto cp0_unimplemented;
> >           }
>
