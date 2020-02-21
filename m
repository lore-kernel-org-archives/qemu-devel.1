Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C9DC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A482067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHPanR9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A482067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Ans-0004Xp-Of
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AlB-00022d-LE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AlA-0003dz-LH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:02:37 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5AlA-0003dm-G4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:02:36 -0500
Received: by mail-oi1-x244.google.com with SMTP id z2so2040573oih.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BPprKegcKiXE/RIVcSob040jFDwvy+Y0T7ts8ETA4Bc=;
 b=GHPanR9Lg8ciZj7XCmK9wc6m9uI9ZCsnwvBTOTr3HEt6SrE/T7egghQLeVVdNXIjbM
 WJm/EvIQl1gtrVn8Qvr2PFO9KBdtSjcWEZ2kP1hmBQC9VXsx2GEl9BEICBCJpDWVB/MD
 xC0f9Bmlrvm3VtrFtL+8zpgfpaL1j0xQTT1vRDIZGq2mBXoPRrC1fv8DZAtYE9vzMLZ6
 A+J3xiFPeR3LSHmCdj6gG8mSL7k8FYDQQAQtQLuWigf7cXb4aTSei+M6oG7cWv1HKqG+
 YR5Jv7pByfqfSAJap77sB4U/U0+4Mgvxdmnk84bXi23LX520AqnsZtI2CSediqoZY/0k
 hcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BPprKegcKiXE/RIVcSob040jFDwvy+Y0T7ts8ETA4Bc=;
 b=ibwWSk8BtYBTBZBk+oNEY/EJ8JhakU53/evr6FCocW2pWTRqWxaafUTEF2T5GsB2/4
 83FX9yIB6Qckw2dUy3uauPnSVKt5hROMB3Pdu4zZn9u4kLgIICDvm+QelY6FXv3poJR/
 /u79Ja0VtTc88zSI3CKwO8Wi1/6kXE2RUhxcCbCd7B0tqM9evPAxsKOP6ubqhViOFk4+
 as4GreLIbrwPzNXPCCE1UCfLAP7vY1Y1sulNxw9lf1OHIujltmf3SAh3HTIgt5dgqRXM
 2/b83c2PGtQpdhD9A7GMJs767fmZFp8Cj/J6hv2l0BZOaFqwF9jhFckID5DdEEQrF1aF
 7Ijw==
X-Gm-Message-State: APjAAAUxnGCGC9u5kM923yPgD3sGKx06rcZiihqhFMmd+c4W9Ehle69/
 OtV44bOPrevSOUVKcIlvxfBJ8/yQhC066SoEAJScVQ==
X-Google-Smtp-Source: APXvYqydF1qXBwP0G/AIwAH/R92oKGY7IBTvxZ6v6kW6LALbzK7j59V3yp+uXwm9Wot15wQJULojGXVkifckd1g/pU8=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2629432oiy.170.1582300955848; 
 Fri, 21 Feb 2020 08:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-4-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 16:02:24 +0000
Message-ID: <CAFEAcA8qjx8_+3+bwbc8KrN2pfEPnV22V6ypTC6HoCDN1qx7Sg@mail.gmail.com>
Subject: Re: [PATCH 03/19] target/arm: Use isar_feature_aa32_simd_r32 more
 places
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Many uses of ARM_FEATURE_VFP3 are testing for the number of simd
> registers implemented.  Use the proper test vs MVCR0.SIMDReg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

