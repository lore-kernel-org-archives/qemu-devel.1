Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C919C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3A520872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt/pw74B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3A520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWOb-0008Fg-5A
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlWNw-0007f9-46
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlWNt-0008GJ-L2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:33:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlWNr-0008BU-M2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:33:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id p17so5679749wrf.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=39woM0j5lf0uBKLgSEDshN1WgwmH5wV5KmAet4fGrrs=;
 b=kt/pw74BXdnT/WG+AWkomQuE9siDbXoLRKpnZsKbhXN9IVVcNJhcHsD16dXNyCWYFG
 +dhQe25S/dOYXP4mE26brbum5G/XKvPfrMKtzygbeS5MzXFAHWDhUmFuNrSA0Q0bka1Z
 UAzCKspr4Z0+kmkrJvK1bL9TEjzGlqT58Su8ynjxN5YXsbUgeA2UeHqgvIxd9afq+hE9
 zkJUkJUoi6l0Og52g3iKw1/gJJbAxqX5Ok9cXZf99wHdIdVkgxQteJURRKIS5PsGdCxy
 Gi0KbuphquBkVIawftHSfxOwTGrHM949HQfumvcdyUoG+gs+Sz3fe/PX9K5P0RPrk5Tp
 qG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=39woM0j5lf0uBKLgSEDshN1WgwmH5wV5KmAet4fGrrs=;
 b=GmFTE7TEGvbNBrVgvoE4rWpWneydMNegYLaDeaFwMxAiunE2/uaNNWyMLOZBFq97MB
 J2TkRJjo3eQyzDeSwtoa7/JE63yrGY/S8lDkkNrjuGMDoqeE35SkYVBjP94OuU/ZhdcF
 QQD1580zkawQBEHPuC/S7BnJCU6Jje6pxz+PXQQEMb48nf4ONrPnht4Ajn6GNj+pL2K1
 D3dZ3wV79voVqWX4E6vqa4IRy1BChNpxUZNNxMJ+ltEJMYouAdpOjoWP2hbTb53scMOp
 sJXVQNYLQwh8kf4actnALW7kv28wrP3Qqx1LjXolHuf2oZZpVz/9YK4IrsW+lG70ZHdy
 i1/A==
X-Gm-Message-State: APjAAAUDYEGXVC3XLxfsNLZPolqMX5RrjJz3bCsCB8XvlR3ddm7TcSM9
 TEVEn3cevaUPkGer96pJ0YFtJQ==
X-Google-Smtp-Source: APXvYqzLUFX/V/YpFgG3u0rNe/sgL76P+iN8BGH1T/BEbU77ErgWuFGPIQ0R44JS2G2ax/vmbqEpbQ==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr4478902wre.248.1562841178256; 
 Thu, 11 Jul 2019 03:32:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y16sm9477116wrg.85.2019.07.11.03.32.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 03:32:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 298401FF87;
 Thu, 11 Jul 2019 11:32:57 +0100 (BST)
References: <20190710172437.628-1-alex.bennee@linaro.org>
 <f85b75f3-f903-7bad-d43e-a545cafdb57d@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <f85b75f3-f903-7bad-d43e-a545cafdb57d@linaro.org>
Date: Thu, 11 Jul 2019 11:32:57 +0100
Message-ID: <87ef2weu92.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for 4.1] target/arm: report ARMv8.2 FP16
 for ARM -cpu max
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 1836078@bugs.launchpad.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/10/19 7:24 PM, Alex Benn=C3=A9e wrote:
>> When we converted to using feature bits in 602f6e42cfbf we missed out
>> the fact (dp && arm_dc_feature(s, ARM_FEATURE_V8)) was supported for
>> -cpu max configurations. This caused a regression in the GCC test
>> suite. Fix this by setting the appropriate FP16 bits in mvfr1.FPHP.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1836078
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/cpu.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index e75a64a25a..0a0a202fe3 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2452,6 +2452,10 @@ static void arm_max_initfn(Object *obj)
>>              t =3D FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
>>              cpu->isar.id_isar6 =3D t;
>>
>> +            t =3D cpu->isar.mvfr1;
>> +            t =3D FIELD_DP32(t, MVFR1, FPHP, 2);     /* v8.2 FP16 */
>
> The comment is wrong.  This is not full v8.2 FP16 support (which would be=
 value
> 3, plus a change to SIMDHP), but v8.0 support for double<->half
> conversions.

Good catch - will fix in v2.
>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e

