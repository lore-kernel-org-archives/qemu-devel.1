Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0091C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90F221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJK4Hwo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19I3-0003u9-LO
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i19Fd-0001Sh-Ta
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i19Fb-0004bJ-7i
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:05:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i19Fb-0004aT-0i
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:05:07 -0400
Received: by mail-ot1-x344.google.com with SMTP id m24so8642061otp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3V5IMwDRdJxEHaCpGw2y6KqCjyfmiyL4t/7PUYITS3c=;
 b=dJK4Hwo7sT7nUFxqN8b/r6F2b21//5H/pTet9eMpEIiJ2OnsB6kAG+IiypGE/ZHOS1
 3irTdV/pS9+w2Zt+ONRr36iVuiFQrlk7d6wIoZxp73sUjoyR0rul2H6LfoDUSWZUhhRR
 NOqigikV2t8hVeHOLsNKc8UWPaSUVmRyxEsnwly1ezKgAoGf676J0vP06c8Hl0xm8E5+
 WqEIx5qMzh4L/1cqNxFM5B9dttJLpmFvpJJ2Kd4UNW8N5T/T7j5sbrRKAgmqrhsdZiz5
 7+pGil+2BT1tI/HntGv7V9vaMn479yv+fmIhfwhLB9tUb6aqjWJBx2dpfWFTAsj2fTUp
 pSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3V5IMwDRdJxEHaCpGw2y6KqCjyfmiyL4t/7PUYITS3c=;
 b=c/2InOW9Ev4qcjHoy8mzWyfxskw+7pGNWHv/wA7Lu/pisi/lSZE2t6mkSz+m+Whjyi
 wfBFceMTGGavM+Xu2obARYh8FdnTh60JPPasParvfX/5Djvtp+AIjQjUH6kMWbyV5mIO
 yjClPoHzqGd5YrwfkVNYZ5jb6QxbsirGitMsG8WJ54Tzk258Gw9Kh/GCy2Iiz8wjp4bq
 Fs9275xNUOdvQhy+z700sGM+y++ozdRRWeKN+ISnP8wT7hlg/BBWcffD24KaiKFpzwNr
 9Qkh2okuEOwVelrf5kD8NCzl2ja/l78gggf5MwqPWNT+lof2shi0hsz3VuHrjg9ofcSW
 SeIQ==
X-Gm-Message-State: APjAAAWSfJH7oviib8OPbk83qO+9PbcAKYBXoTB8p9OeWXFvrtL2/XHq
 hqrgoaQyKq0dn4JesBzoBADeCHUBdYKAhXIwhDHVYg==
X-Google-Smtp-Source: APXvYqzpA7jOyqtFDWLOVDCn5Ye4Ujo5RlOVlYINskAmyFG7orMVH08KHpr+cnQnvYuHEuEyibkP6FgyyKuxNVSKjN4=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr4198136oti.91.1566565505695; 
 Fri, 23 Aug 2019 06:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-20-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 14:04:54 +0100
Message-ID: <CAFEAcA8Q3ujQFtZfLXTsbKBxUQAHCPo0i_TpdX9KcmnNUY04Eg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 19/68] target/arm: Convert T32 ADDW/SUBW
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 24 +++++++++++++-----------
>  target/arm/a32.decode  |  1 +
>  target/arm/t32.decode  | 19 +++++++++++++++++++
>  3 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index cb6296dc12..0e51289928 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7626,6 +7626,11 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
>   * Constant expanders for the decoders.
>   */
>
> +static int negate(DisasContext *s, int x)
> +{
> +    return -x;
> +}
> +
>  static int times_2(DisasContext *s, int x)
>  {
>      return x * 2;
> @@ -7975,6 +7980,12 @@ static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
>  #undef DO_ANY2
>  #undef DO_CMP2
>
> +static bool trans_ADR(DisasContext *s, arg_ri *a)
> +{
> +    store_reg_bx(s, a->rd, add_reg_for_lit(s, 15, a->imm));
> +    return true;
> +}
> +
>  /*
>   * Multiply and multiply accumulate
>   */
> @@ -10670,17 +10681,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                          }
>                          store_reg(s, rd, tmp);
>                      } else {
> -                        /* Add/sub 12-bit immediate.  */
> -                        if (insn & (1 << 23)) {
> -                            imm = -imm;
> -                        }
> -                        tmp = add_reg_for_lit(s, rn, imm);
> -                        if (rn == 13 && rd == 13) {
> -                            /* ADD SP, SP, imm or SUB SP, SP, imm */
> -                            store_sp_checked(s, tmp);
> -                        } else {
> -                            store_reg(s, rd, tmp);
> -                        }
> +                        /* Add/sub 12-bit immediate, in decodetree */
> +                        goto illegal_op;

We seem to have lost the store_sp_checked() handling ?

>                      }
>                  }
>              } else {
> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> index c7f156be6d..aac991664d 100644
> --- a/target/arm/a32.decode
> +++ b/target/arm/a32.decode
> @@ -30,6 +30,7 @@
>  &rrrr            rd rn rm ra
>  &rrr             rd rn rm
>  &rr              rd rm
> +&ri              rd imm
>  &r               rm
>  &i               imm
>  &msr_reg         rn r mask

Should this change be in some other patch ?

> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index 5116c6165a..be4e5f087c 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -27,6 +27,7 @@
>  &rrrr            !extern rd rn rm ra
>  &rrr             !extern rd rn rm
>  &rr              !extern rd rm
> +&ri              !extern rd imm
>  &r               !extern rm
>  &i               !extern imm
>  &msr_reg         !extern rn r mask
> @@ -121,6 +122,24 @@ SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
>  }
>  RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
>
> +# Data processing (plain binary immediate)
> +
> +%imm12_26_12_0   26:1 12:3 0:8
> +%neg12_26_12_0   26:1 12:3 0:8 !function=negate
> +@s0_rri_12       .... ... .... . rn:4 . ... rd:4 ........ \
> +                 &s_rri_rot imm=%imm12_26_12_0 rot=0 s=0
> +
> +{
> +  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
> +                 &ri imm=%imm12_26_12_0
> +  ADD_rri        1111 0.1 0000 0 .... 0 ... .... ........     @s0_rri_12
> +}
> +{
> +  ADR            1111 0.1 0101 0 1111 0 ... rd:4 ........ \
> +                 &ri imm=%neg12_26_12_0
> +  SUB_rri        1111 0.1 0101 0 .... 0 ... .... ........     @s0_rri_12
> +}
> +
>  # Multiply and multiply accumulate
>
>  @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
> --
> 2.17.1


thanks
-- PMM

