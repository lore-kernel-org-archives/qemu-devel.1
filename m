Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E9C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771D72173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNhxXKNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771D72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18p5-0005G3-6p
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18Zz-0000s4-JZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18Zy-0003lB-Jv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:22:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18Zy-0003kl-FN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:22:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id e12so8545915otp.10
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o32if9KIl7NyCZWNh4NVIxXwCu4ZcDKquMI9BUjQ/WM=;
 b=MNhxXKNu0B1DFMyoivCMUQ8jtZ7YEBIBFjMEoIn1T4voa7emDSco0OHIPI5yWhQo3t
 ZQOTzy9x2/23UpIDHhmByi6HqpUItmOuhyubEz6pZhyhBo7dkRCzzmllnR+OmsTN00VD
 iirIUSl9G2u0neDpzS7DLiHaDT+iRmpaqrGJq0n1O72FuPhaxteqeGJjo7D+sFCqHME+
 g6R6lppba/aaQ9IyS0Bz32eeUNaRja9tSRvo+A7MUcnglgikftrYPBkcyKYP/yF9XMR/
 aGwoYA2x/+0sHSip4MxkqaaapNzyJLIQiCTzZGke2IzOmh4j3jqReRPZO+9R2GqQoaA4
 3COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o32if9KIl7NyCZWNh4NVIxXwCu4ZcDKquMI9BUjQ/WM=;
 b=b0+Jn0wnME6dKBX+kjV/LwZiWd2uXtvLhAnF0hCPymZZWPzfNEvKBS+PzAC1MfYYP3
 UqOmK4WSOu3oqvUDTYaLMKT2rPYYBSkguPsjJRc33ulgRKR4nAHmKwjn/+fcFLXx77LR
 CIDm2O/oEG1KyoUC0Hl//R9PcLC5qGQJFgOWCPiZ3RW16G6PfTPqv9BAouBjuaF+vrMp
 Gl61JLmyIlh4WINi6oVXnd641SrMd91MDt8kMSjqWE/o/rzzSofcFfNtmwdb4fHIskOf
 urtE/VmzLRt9bKc8oVLo5b85kSFp6QlhKULVwi3hsTC5qzAIXpFeLuB1sYuRzqf1cvcS
 auNw==
X-Gm-Message-State: APjAAAWK9lfXDzAqKm8/vmidwTFl1b+gPeDQvK6ZohzD76tqhqAIHUqM
 sAKVb6iV9QzndYmaO97ExW7J8UCaVHns2Nr3T3Yp+A==
X-Google-Smtp-Source: APXvYqwg8xUMyDArzLi5n2YanCRMKxjf3VExEjzPV8bKw9iITgEcvCrQjVr/sU/Uz8RScOZkHCoFtjXPpHVeJEWnAW4=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr4059140otp.232.1566562925964; 
 Fri, 23 Aug 2019 05:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-12-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:21:55 +0100
Message-ID: <CAFEAcA9ac+uwWQ5ETj+6=UM+E4_18p38ODWzdkFiRJEF3Spx6A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 11/68] target/arm: Simplify op_smlawx
 for SMLAW*
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
> By shifting the 16-bit input left by 16, we can align the desired
> portion of the 48-bit product and use tcg_gen_muls2_i32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

