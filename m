Received: from eggs.gnu.org ([2001:4830:134:3::10]:42217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fYpcn-0000s3-RW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fYpcm-0003Sr-Hf
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:23:29 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:46247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fYpcm-0003S4-Bm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:23:28 -0400
Received: by mail-ot0-x22b.google.com with SMTP id v24-v6so9223593otk.13
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 02:23:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-3-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-3-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 29 Jun 2018 11:23:26 +0200
Message-ID: <CABoDooPNXufYFJGtGuici2Gq-_PybFgk1yX7=8-pme2j0-7fOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] target/arm: Fix SVE system register
 access checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hello,

On Fri, Jun 29, 2018 at 2:15 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Leave ARM_CP_SVE, removing ARM_CP_FPU; the sve_access_check
> produced by the flag already includes fp_access_check.  If
> we also check ARM_CP_FPU the double fp_access_check asserts.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks for taking care of it,

Laurent

> ---
>  target/arm/helper.c        | 8 ++++----
>  target/arm/translate-a64.c | 5 ++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b19c7ace78..a855da045b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4393,7 +4393,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static const ARMCPRegInfo zcr_el1_reginfo = {
>      .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
>      .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
> -    .access = PL1_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
> +    .access = PL1_RW, .type = ARM_CP_SVE,
>      .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
>      .writefn = zcr_write, .raw_writefn = raw_write
>  };
> @@ -4401,7 +4401,7 @@ static const ARMCPRegInfo zcr_el1_reginfo = {
>  static const ARMCPRegInfo zcr_el2_reginfo = {
>      .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
>      .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
> -    .access = PL2_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
> +    .access = PL2_RW, .type = ARM_CP_SVE,
>      .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[2]),
>      .writefn = zcr_write, .raw_writefn = raw_write
>  };
> @@ -4409,14 +4409,14 @@ static const ARMCPRegInfo zcr_el2_reginfo = {
>  static const ARMCPRegInfo zcr_no_el2_reginfo = {
>      .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
>      .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
> -    .access = PL2_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
> +    .access = PL2_RW, .type = ARM_CP_SVE,
>      .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore
>  };
>
>  static const ARMCPRegInfo zcr_el3_reginfo = {
>      .name = "ZCR_EL3", .state = ARM_CP_STATE_AA64,
>      .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 2, .opc2 = 0,
> -    .access = PL3_RW, .type = ARM_CP_SVE | ARM_CP_FPU,
> +    .access = PL3_RW, .type = ARM_CP_SVE,
>      .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[3]),
>      .writefn = zcr_write, .raw_writefn = raw_write
>  };
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index f986340832..45a6c2a3aa 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1633,11 +1633,10 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>      default:
>          break;
>      }
> -    if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
> -        return;
> -    }
>      if ((ri->type & ARM_CP_FPU) && !fp_access_check(s)) {
>          return;
> +    } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
> +        return;
>      }
>
>      if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
> --
> 2.17.1
>
>
