Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE1C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5ED2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHBIx+l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5ED2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jth-0000z9-IW
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jsV-0007pQ-Ss
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jsV-0007KG-0S
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:55 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jsU-0007IP-RO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:54 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so10007231oie.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wgFa7yBWDk5Brv+NVClMgEkZR56+nUWQrhcRGazyjU0=;
 b=HHBIx+l3pvHmKyE2yY/wLMDDwYCVK4nCjmLqNhfMQFpVtIrsLOyEpinYpzN/f1rWQF
 F+PnjUJy0dvy1XfrpQn2sJWZ3+lgmBms3YjstangqrbKT1ctR4VURcMnPhTL0yOWI2/J
 yW1cHR7TTKtBkUxkp8ar9LyxAXDT9EMsTGiH0RQgdumhS2EqZQIvQNN5TIewifE2/ueE
 mZOEccgvcmIHB5sV+te3haqvyOLZ9ZRjKW7M6GuFLF2dPq3WPYOBNickxQGMkPg5m93M
 e3rj9LDsZyIhIfH0JbCrj2QCKgm103AKB4vK1FTU83fMFtHCCY3ahJliZtIsspJlekTF
 4yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wgFa7yBWDk5Brv+NVClMgEkZR56+nUWQrhcRGazyjU0=;
 b=EN6ST+5A7XLSjC4wiTNB0G06m+mjijxLM1eiNJUGhjjKz8fhGmb2YPqnbD9Wb60l8d
 VZBQXsmHV2akSHAuuWVSIgR1htsMBmw6riInMQzE6xQrkFcvFrHSsvxAeqHVrJGeR5zN
 M+3//03EIm3i7ZXMTedklaU8yN1w1vxkohJEIqbLxERfK3agNOMJCXksldu0mn1MyOe6
 CiemvIaHar41pzLuoypFyc1sLbQ9UIoKD5ZZHCpTsZU4X3+kac9CktyN30qDMEs9jtzY
 8LwMAc7awYxb5+6iT/hkBjKmgXe5Hqlh6Bhj4fH/U6UNXrs1jWnNiy3XLCYu6ivXEoN8
 854Q==
X-Gm-Message-State: APjAAAXtzUszk7uTNZYJAf1Eyo/5gbacFKtraejnctAAyw0GtYH/qHvZ
 BX4hSmtyf4/1xC6rJ10W/onkz/HKZS1Sv+Tp63Oxlw==
X-Google-Smtp-Source: APXvYqwAgxwE17oWh2aoeuIXFnPe1NAhEvdCa0Lj8J1wtKIj4/ObcBqL80FWsaNjZfgk4qhdrCnvAo1NxIj09C58zBw=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr10892037oic.48.1583150934004; 
 Mon, 02 Mar 2020 04:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
 <20200225031414.15649-3-richard.henderson@linaro.org>
In-Reply-To: <20200225031414.15649-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 12:08:43 +0000
Message-ID: <CAFEAcA_NhOBjdiQH7MCkZDDRa8Uy2xUJdO2-OPHEayo9TUA0zA@mail.gmail.com>
Subject: Re: [PATCH 4/8] target/arm: Move helper_dc_zva to helper-a64.c
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Tue, 25 Feb 2020 at 03:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is an aarch64-only function.  Move it out of the shared file.
> This patch is code movement only.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

