Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86148C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5083B21744
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGtitOTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCpF-0004X5-Fo
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyCoW-00040H-FS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyCoV-0004bi-89
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:17:00 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyCoV-0004am-23
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:16:59 -0400
Received: by mail-ot1-x344.google.com with SMTP id o101so4736204ota.8
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YTBGy8hY8j2dBBvtOvP3BdhLLmRMvjqHIRqhjQwRHow=;
 b=XGtitOTCY/4NTLjMx54tzmTquH+yFUJgii3uDqYduwZAu4DvVXWUXpdU2HMiMaxLVG
 Qx9eI0N1lnbwZPrAKxRqeIssEym2dCBfeiiIr3EOnVvYMtEzacGkaWQ5eeIplrNsfg4w
 ipk+rMs/QIghqNrrY8oqzcaH/dOnoge14irFVTPREjSfsBEpyRuJ2ijsSXpDrCfIsBPP
 IaSxLmDuIgbNL/TrpwehIWH+QX0zyCogVPpIuZ86CxJlxrkBhRNzzBcbnxBdTKUDC+jp
 EjbggW0n7FuoUNQWZOq5WRHVyYxy/ZhmNqeB7VOVBlSs8UaHnuGvfa3+SZUFyJ5BXGOu
 DthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YTBGy8hY8j2dBBvtOvP3BdhLLmRMvjqHIRqhjQwRHow=;
 b=anrkt5LTjTtXzRZPlGQezUnqBLpni5/GrP5HgrEQIYAua0f2iYqt+EdplGEtlXj+DQ
 IZ3Zno1dad6Ujkp+ktW3R8rJBLpa49Y/MsZ8163oNWK/+MtwV7Po7+EYXaILHV0Bj9uQ
 WMvJCYdSlc8sUzWQrJ13qZwZD44d3aifVcODVTR5LS0B+w+YMDtjf1/qIDYwL1Km5vbt
 Pt00y51l3MsCuD/auI/fWQjnRNIfl8umEFZGsf3szeCp4MVAnx/Y5i1XLZavKpl5wyuv
 BD9Xp8Aetr8iGj3eO5bIuQrEx1JCU5ORmbIVhTTm6+DqmiUGVDcbYOBl7tKNqfkocvpz
 WJnw==
X-Gm-Message-State: APjAAAXZi0UXVeKCV+cXp7tG1G4yXVKgOrGWQIGFyPchYi4GfBU6zP+5
 sk56y8Ezfn0bDuZvq9m9i9Un2z0i4yqs5PTeHvla7A==
X-Google-Smtp-Source: APXvYqygoyjx7IcFazlxEovEZdnVc5MuUWal2qtWWQtzfqpCQjhT+YPDPsl5cX2RLrjQOn+aTm/DpsmeQkmLyJUM2g8=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr3006080otc.135.1565864218040; 
 Thu, 15 Aug 2019 03:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202616.13782-1-richard.henderson@linaro.org>
 <20190808202616.13782-8-richard.henderson@linaro.org>
In-Reply-To: <20190808202616.13782-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2019 11:16:46 +0100
Message-ID: <CAFEAcA8exvd3khkNhw2JnJWHdkFH5O=ut7LvN9Tz5H0ZTg95Sw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm: Use tcg_gen_extrh_i64_i32
 to extract the high word
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

On Thu, 8 Aug 2019 at 21:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Separate shift + extract low will result in one extra insn
> for hosts like RISC-V, MIPS, and Sparc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 77154be743..9e103e4fad 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1761,8 +1761,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
>              if (insn & ARM_CP_RW_BIT) {                         /* TMRRC */
>                  iwmmxt_load_reg(cpu_V0, wrd);
>                  tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
> -                tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
> -                tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
> +                tcg_gen_extrh_i64_i32(cpu_R[rdhi], cpu_V0);
>              } else {                                    /* TMCRR */
>                  tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
>                  iwmmxt_store_reg(cpu_V0, wrd);

This patch is fine, but I noticed while reviewing it that tcg/README
labels both the extrl_i64_i32 and extrh_i64_i32 operations as
"for 64-bit hosts only". Presumably that's a documentation error,
since we're not guarding the existing uses of the extrl_i64_i32
here with any kind of ifdeffery to restrict them to 64-bit hosts ?

thanks
-- PMM

