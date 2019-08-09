Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDAEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2242166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gw/EjmUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2242166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1al-0007uw-Tg
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw1aO-0007Un-Ul
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw1aO-0006dW-1O
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:53:24 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw1aN-0006d3-R2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:53:23 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so37099950otq.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hMAhzyrfHYLadJw8f0Y2bUMH55PFmvfr6jInpGKWT2E=;
 b=Gw/EjmUJEAO7aR+gDtV4ps0OZzQP6sL1ghK6qn00ZrXhSD/rGew1Lc9qRZK16yg+Wt
 7WYoJvdicVlndBgkhtKfaev9pGhEBA+YQI3PPfK5RdlnvaxHmrUOlCqxRAaJaqw0+OAr
 vcn4+QifksqK+koVZdmyoYfxKNc90iM05uYQ3c/PlyHhlzMmrx5Y7qL1Y+YND87wcDfo
 LO+bgiIUBWs2AXraE0q7BbQ6RV8/Ohkej/x+0uJrG+ESt2C/960EG4py7WwoiDRiMNq6
 eHlG9vs9bJytPuhc2AcmDgoj846ckYMw1RFkpzgwHT0zvd0iDzbp1zC1EIRMypIT4YZ0
 x/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hMAhzyrfHYLadJw8f0Y2bUMH55PFmvfr6jInpGKWT2E=;
 b=QyxTFRaQGBf4JftOOhFku6L2S3wMrGp/9otSBERY6GoTk0uFORTV2xBCM8dYwq7Gik
 FM8ewsfjXAQx47IyWqwvu/3/KvwCWU44juPdBYoNReHDuQzaJnu+IlsW4F0RCbykxq9q
 yD8VFhjBL6k0HZRny/98kNNtBVxXwOary1/k3eBqJ1M0utjZiMjjmbwy293A5Mdei/os
 wqT/3axQM+BL//763yMpmOX0E6Vr4fPIEIhSRIlLORfqX/srfZQtz1aJq7/+vkECY8IB
 VxjhLZJAGKe3831e1+s6I3Iw9PJJw6qLOdJAE+cwksOMD1tErs8FnHmPo3KAFtRdOU9n
 uHMA==
X-Gm-Message-State: APjAAAUmjmFaZmDQnXlfEkBmpYu+KKjTDx5tsRvtx0fxmKRyRHvLvI+j
 2dRq/US+nHwmrgwCUFylmvfw0NR0DxpK91pUoTxG7N2C
X-Google-Smtp-Source: APXvYqwocxdkSgjFnkfaq7/wadWuMSPkX4cGhlb2S1KYKCFfnin/2oku9GctW9fQfnX3h0J4cgWEcVJN2hdCihNloUI=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr15619285otj.97.1565344401934; 
 Fri, 09 Aug 2019 02:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190305165051.26860-1-peter.maydell@linaro.org>
 <20190305165051.26860-10-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-10-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 10:53:11 +0100
Message-ID: <CAFEAcA8vfxjW6hVnKiBu7jeiFSGXzqdaQ_ytUXgEwJ91JLDf=g@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 09/22] target/arm: Implement ARMv8.5-CondM
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Mar 2019 at 16:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20190301200501.16533-9-richard.henderson@linaro.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index fcf79321e2f..9fe0844a828 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -309,7 +309,7 @@ static void aarch64_max_initfn(Object *obj)
>          t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
>          t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
>          t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
> -        t = FIELD_DP64(t, ID_AA64ISAR0, TS, 1);
> +        t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2); /* v8.5-CondM */
>          cpu->isar.id_aa64isar0 = t;
>
>          t = cpu->isar.id_aa64isar1;

Hi -- it's just been pointed out to me that if our 'max' CPU
supports v8.5-CondM then we ought to be setting the HWCAP2_FLAGM2
bit in the hwcaps for linux-user mode. (Maybe we implemented this
before the kernel defined the hwcap bit?)

I guess we should also cross check whether there are any other
recently introduced hwcap bits we now should be setting.

thanks
-- PMM

