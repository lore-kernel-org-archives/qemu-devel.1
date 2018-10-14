Received: from eggs.gnu.org ([2001:4830:134:3::10]:48612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBogh-0005xK-MS
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBogd-0005Bv-Iz
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:16:39 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBogd-0005BZ-DT
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:16:35 -0400
Received: by mail-yb1-f195.google.com with SMTP id p74-v6so6803589ybc.9
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 15:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539362376-12010-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-15-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 15 Oct 2018 00:16:22 +0200
Message-ID: <CAAdtpL5kx-0+tVfvOSLjnnVtSi9bUox6Ccy2VqGBKxkVgz5L9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 14/28] target/mips: Extend WatchHi
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Oct 12, 2018 at 6:58 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> WatchHi is extended by the field MemoryMapID with the GINVT
> instruction. The field is accessible by MTHC0/MFHC0 in 32-bit
> architectures and DMTC0/DMFC0 in 64-bit architectures.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  2 +-
>  target/mips/helper.h    |  3 +++
>  target/mips/machine.c   |  2 +-
>  target/mips/op_helper.c | 23 +++++++++++++++++++++--
>  target/mips/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 65 insertions(+), 5 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 5e45e97..10c3813 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -531,7 +531,7 @@ struct CPUMIPSState {
>      uint64_t CP0_LLAddr_rw_bitmask;
>      int CP0_LLAddr_shift;
>      target_ulong CP0_WatchLo[8];
> -    int32_t CP0_WatchHi[8];
> +    uint64_t CP0_WatchHi[8];
>  #define CP0WH_ASID 16
>      target_ulong CP0_XContext;
>      int32_t CP0_Framemask;
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index c23e4e5..0ec500a 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -76,6 +76,7 @@ DEF_HELPER_1(mfc0_maar, tl, env)
>  DEF_HELPER_1(mfhc0_maar, tl, env)
>  DEF_HELPER_2(mfc0_watchlo, tl, env, i32)
>  DEF_HELPER_2(mfc0_watchhi, tl, env, i32)
> +DEF_HELPER_2(mfhc0_watchhi, tl, env, i32)
>  DEF_HELPER_1(mfc0_debug, tl, env)
>  DEF_HELPER_1(mftc0_debug, tl, env)
>  #ifdef TARGET_MIPS64
> @@ -87,6 +88,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
>  DEF_HELPER_1(dmfc0_lladdr, tl, env)
>  DEF_HELPER_1(dmfc0_maar, tl, env)
>  DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
> +DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
>  #endif /* TARGET_MIPS64 */
>
>  DEF_HELPER_2(mtc0_index, void, env, tl)
> @@ -153,6 +155,7 @@ DEF_HELPER_2(mthc0_maar, void, env, tl)
>  DEF_HELPER_2(mtc0_maari, void, env, tl)
>  DEF_HELPER_3(mtc0_watchlo, void, env, tl, i32)
>  DEF_HELPER_3(mtc0_watchhi, void, env, tl, i32)
> +DEF_HELPER_3(mthc0_watchhi, void, env, tl, i32)
>  DEF_HELPER_2(mtc0_xcontext, void, env, tl)
>  DEF_HELPER_2(mtc0_framemask, void, env, tl)
>  DEF_HELPER_2(mtc0_debug, void, env, tl)
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 70a8909..5d558c1 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -292,7 +292,7 @@ const VMStateDescription vmstate_mips_cpu = {
>          VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),
>          VMSTATE_UINT64(env.lladdr, MIPSCPU),
>          VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),
> -        VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
> +        VMSTATE_UINT64_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),

Don't this break migration?

>          VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Framemask, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Debug, MIPSCPU),
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index af130f6..3d86c60 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -991,7 +991,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
>
>  target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
>  {
> -    return env->CP0_WatchHi[sel];
> +    return (int32_t) env->CP0_WatchHi[sel];
> +}
> +
> +target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
> +{
> +    return env->CP0_WatchHi[sel] >> 32;
>  }
>
>  target_ulong helper_mfc0_debug(CPUMIPSState *env)
> @@ -1059,6 +1064,11 @@ target_ulong helper_dmfc0_watchlo(CPUMIPSState *env, uint32_t sel)
>  {
>      return env->CP0_WatchLo[sel];
>  }
> +
> +target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
> +{
> +    return env->CP0_WatchHi[sel];
> +}
>  #endif /* TARGET_MIPS64 */
>
>  void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
> @@ -1818,11 +1828,20 @@ void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
>
>  void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
>  {
> -    int mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
> +    uint64_t mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
> +    if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
> +        mask |= 0xFFFFFFFF00000000ULL; /* MMID */
> +    }
>      env->CP0_WatchHi[sel] = arg1 & mask;
>      env->CP0_WatchHi[sel] &= ~(env->CP0_WatchHi[sel] & arg1 & 0x7);
>  }
>
> +void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
> +{
> +    env->CP0_WatchHi[sel] = ((uint64_t) (arg1) << 32) |
> +                            (env->CP0_WatchHi[sel] & 0x00000000ffffffffULL);

Or:

env->CP0_WatchHi[sel] = deposit64(env->CP0_WatchHi[sel], 32, 32, arg1);

> +}
> +
>  void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
>  {
>      target_ulong mask = (1ULL << (env->SEGBITS - 7)) - 1;
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 5e508d5..c7eaee7 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5223,6 +5223,25 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              goto cp0_unimplemented;
>          }
>          break;
> +    case 19:
> +        switch (sel) {
> +        case 0:
> +        case 1:
> +        case 2:
> +        case 3:
> +        case 4:
> +        case 5:
> +        case 6:
> +        case 7:
> +            /* upper 32 bits are only available when Config5MI != 0 */
> +            /* CP0_CHECK(ctx->mi); */

What about this check?

> +            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_WatchHi[sel]), 0);
> +            rn = "WatchHi";
> +            break;
> +        default:
> +            goto cp0_unimplemented;
> +        }
> +        break;
>      case 28:
>          switch (sel) {
>          case 0:
> @@ -5295,6 +5314,25 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              goto cp0_unimplemented;
>          }
>          break;
> +    case 19:
> +        switch (sel) {
> +        case 0:
> +        case 1:
> +        case 2:
> +        case 3:
> +        case 4:
> +        case 5:
> +        case 6:
> +        case 7:
> +            /* upper 32 bits are only available when Config5MI != 0 */
> +            /* CP0_CHECK(ctx->mi); */
> +            gen_helper_0e1i(mthc0_watchhi, arg, sel);
> +            rn = "WatchHi";
> +            break;
> +        default:
> +            goto cp0_unimplemented;
> +        }
> +        break;
>      case 28:
>          switch (sel) {
>          case 0:
> @@ -7293,7 +7331,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 6:
>          case 7:
>              CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
> -            gen_helper_1e0i(mfc0_watchhi, arg, sel);
> +            gen_helper_1e0i(dmfc0_watchhi, arg, sel);
>              rn = "WatchHi";
>              break;
>          default:
> --
> 2.7.4
>
>
