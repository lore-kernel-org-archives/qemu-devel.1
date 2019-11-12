Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B274C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA5D222C6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQZZco5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA5D222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXxD-00047d-3f
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUXwR-0003gV-Kd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUXwQ-0002FS-B9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:18:51 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUXwQ-0002F6-59
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:18:50 -0500
Received: by mail-ot1-x341.google.com with SMTP id z25so1295020oti.5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rOgG7g0fUpWkSxwi1ZuN5aF5aug0YRRdxm2j1Zs5G4U=;
 b=TQZZco5o87NECWK1pHPXf9TAg0sBQ3GF+yN1Gx6/oRsqhWMJL/tyb5pOHcHuP2gFje
 IBcEn/IF4BCiaq30PQsKJYBU7mXKnOKc7QZJysE37LMEHV/oXAZzoEg8hffmaFUk6j0I
 Kfmet7DR0Wm0oUlnv+LwVgaMbWzbhxepi1dartGh8Y0M/rWbYytMs050osN3SQZypGR5
 EDIUQXkmqOzIxlkvDzOteItIEfyF/8QH8CSgAX05udPPbzAmrVqC9faWCMetokw1AGaf
 PFPyYd3tzhEmtrrXc8knRQbD7sPNo2WSygq/8j5SrkTz1Fu/m+uo/DMN54JSPkhRVdV3
 RX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rOgG7g0fUpWkSxwi1ZuN5aF5aug0YRRdxm2j1Zs5G4U=;
 b=TxYWqeepDeJEBF8CCTMqxUB+PYzrs7xXKRUOmkSC/439YjhpDJsnN51XNcC8Q9CZ7o
 Norp0GjjUbZ5jdpVDgDpuCZ21T71aVI6NeoI3nBH3xF5EPvFdcR5Z3S9tZhXSLd9VGLQ
 b/nUm6LuEhzDWGzQc/nUnQ8ys6uHlxwJe2IGuPAcFWSO4XObkFBo5Uei+7LA4TdiiuEE
 juWodnAmZ/r3yX5VXg461odqC/3HxW3AUcep+v6zeAF/B0hV85wJoNqK6foO4KfRnrG9
 rVOfmzCmPZET302EKq+q6SNB1nA0zcGjH2+l3854wqWzWVHHlIN4SJ5qPbyD6mSKqAti
 ML5g==
X-Gm-Message-State: APjAAAUyvnysnI7/tMIiJx/2IF/iAltuUxYPSR7cxrVB8kINSq19tHsg
 eZ0kYdzSZJ44OI85eOfdDGpeVhm3sxZo1B3UnIO6tz7p/hM=
X-Google-Smtp-Source: APXvYqxcjJF9WIm7OuD/KGdreTbyAPOig/KX+JJsZVFqjOhF7WzmbVt1+hACai2703mbiWz/43PD5VlBjapb8mbHqlQ=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr23647292otk.91.1573571928924; 
 Tue, 12 Nov 2019 07:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20191025090841.10299-1-christophe.lyon@linaro.org>
In-Reply-To: <20191025090841.10299-1-christophe.lyon@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 15:18:37 +0000
Message-ID: <CAFEAcA-daHKRq0Srs81cws=ZT2_WM84RiNBnT-cYWT1NoMs0og@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: Add support for cortex-m7 CPU
To: Christophe Lyon <christophe.lyon@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 10:08, Christophe Lyon
<christophe.lyon@linaro.org> wrote:
>
> This is derived from cortex-m4 description, adding DP support and FPv5
> instructions with the corresponding flags in isar and mvfr2.
>
> Checked that it could successfully execute
> vrinta.f32 s15, s15
> while cortex-m4 emulation rejects it with "illegal instruction".
>
> Signed-off-by: Christophe Lyon <christophe.lyon@linaro.org>
> ---
>  target/arm/cpu.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 13813fb..ccae849 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1954,6 +1954,37 @@ static void cortex_m4_initfn(Object *obj)
>      cpu->isar.id_isar6 = 0x00000000;
>  }
>
> +static void cortex_m7_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +    cpu->midr = 0x411fc272; /* r1p2 */
> +    cpu->pmsav7_dregion = 8;
> +    cpu->isar.mvfr0 = 0x10110221;
> +    cpu->isar.mvfr1 = 0x12000011;
> +    cpu->isar.mvfr2 = 0x00000040;
> +    cpu->id_pfr0 = 0x00000030;
> +    cpu->id_pfr1 = 0x00000200;
> +    cpu->id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x00100030;
> +    cpu->id_mmfr1 = 0x00000000;
> +    cpu->id_mmfr2 = 0x01000000;
> +    cpu->id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01101110;
> +    cpu->isar.id_isar1 = 0x02112000;
> +    cpu->isar.id_isar2 = 0x20232231;
> +    cpu->isar.id_isar3 = 0x01111131;
> +    cpu->isar.id_isar4 = 0x01310132;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I've put this in my list of patches to queue for 5.0.

thanks
-- PMM

