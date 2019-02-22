Received: from eggs.gnu.org ([209.51.188.92]:48211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxEkz-0007MR-Lv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxEky-0006jM-J7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:37:05 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxEky-0006Om-Cl
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:37:04 -0500
Received: by mail-oi1-x244.google.com with SMTP id j135so2309355oib.13
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 09:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20190222170936.13268-1-peter.maydell@linaro.org>
	<20190222170936.13268-3-peter.maydell@linaro.org>
In-Reply-To: <20190222170936.13268-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 17:36:29 +0000
Message-ID: <CAFEAcA-YCosZjWEiLC6cc8Z7rfOUQMLYZJX48MKOYuZNQQVR_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Gate "miscellaneous FP"
 insns by ID register field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On Fri, 22 Feb 2019 at 17:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> There is a set of VFP instructions which we implement in
> disas_vfp_v8_insn() and gate on the ARM_FEATURE_V8 bit.
> These were all first introduced in v8 for A-profile, but in
> M-profile they appeared in v7M. Gate them on the MVFR2
> FPMisc field instead, and rename the function appropriately.

> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b7702fb49f7..af8f9e669b8 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -3357,7 +3357,7 @@ static const uint8_t fp_decode_rm[] = {
>      FPROUNDING_NEGINF,
>  };
>
> -static int disas_vfp_v8_insn(DisasContext *s, uint32_t insn)
> +static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
>  {
>      uint32_t rd, rn, rm, dp = extract32(insn, 8, 1);
>

Oops, I forgot to commit this part of the change:

@@ -3361,10 +3361,6 @@ static int disas_vfp_misc_insn(DisasContext *s,
uint32_t insn)
 {
     uint32_t rd, rn, rm, dp = extract32(insn, 8, 1);

-    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
-        return 1;
-    }
-
     if (dp) {
         VFP_DREG_D(rd, insn);
         VFP_DREG_N(rn, insn);

thanks
-- PMM
