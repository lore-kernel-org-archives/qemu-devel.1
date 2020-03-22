Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D8C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB59206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e57Mb/5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB59206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG818-0002ry-AT
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jG7zV-0001oJ-Oi
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jG7zU-0002SG-Lm
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:18:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jG7zU-0002Rw-Gl
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:18:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id a49so11444227otc.11
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SccDaBvCs9PxfYuAd//3zvF4kjFbX92N+sKnDM9ICNg=;
 b=e57Mb/5E5FeYl+oiBwtaBQhRshKdYaYLw5g5qZmmmjOsOyKeP0Y2l73YBIf0CpkIJb
 QthLjxPPzAxGPJ28afE6pfvcdRfUur7UhD6vMZ3sItpi7os+UPsvROEf6/r0n4EEccu2
 8E43+TCYohHhBa4vafNpdi8mhsdXyddSE+oQ6EH6B9hXQmwPhugMUzWx2+c/GFjBtrhq
 vHUcazsv6Tw0FzXA24GASkIQ5iBwtC2pJy6anewHxEDmTtcAB6rQjICwTlCLEigaytub
 6rVv63LMaFu99e1zHuqZLJOoxi6K4ufQa7Dk3sjEMxzyA4bUMMVgYc0Sl3atIQxz1Q/Q
 z/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SccDaBvCs9PxfYuAd//3zvF4kjFbX92N+sKnDM9ICNg=;
 b=EwLJ+Az620UtksQ9E+x1Xwz0P8S6I44W1VVc4Go5Px14YRkJqRWiJjIIY9RfEgO8Rh
 rc5IYAmx1qwpzlHRtmHgxN65CyekNPlQkmSmBvcL+BbR33M3LffBCaHqLlRxCVc2GAsK
 c+lC1lhkpMq8mWe1A6tzSk8gU8CV0c0CvO7Jy3za0lQcSGMjLuHypCTRHenpTk+SwK4b
 LgmgodlMhhhX21nMYLR2emHMuG2TS/pYl3KARsvC14K5/6fLiiYMO6mqxost2+L+U7fm
 CJUaofXBqbAAH3ozKEw8xhEKqKwjCu+6jnUwoGEx2vQQJhxFA3w3X6IqUrbLszoGIewI
 bDNw==
X-Gm-Message-State: ANhLgQ3SzfRCuJwcn1nV/mJxdu8G/idzZ03S5FwXyWLFu4Sd3oyT20/3
 8bAzF5DKGD8BL6eI4HKDDoa4oLjOdRRch46RP84lmQ==
X-Google-Smtp-Source: ADFU+vs9ZpKbR0MnsWQpXEnOM7mDIqzQKb2/6UggM8hMV2yiuB8uWGZDbMC76jCgtF26CyBlemAOQTOjk2TBDlUV1yY=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr14752099ota.221.1584911919780; 
 Sun, 22 Mar 2020 14:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200322205439.15231-1-nieklinnenbank@gmail.com>
 <20200322205439.15231-2-nieklinnenbank@gmail.com>
In-Reply-To: <20200322205439.15231-2-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 21:18:28 +0000
Message-ID: <CAFEAcA-dr4_tTevqJmjEy1_W5Thv1c+8ETf=-R2jTeBp-1HmOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/misc/allwinner-h3-dramc: enforce 64-bit multiply
 when calculating row mirror address
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Sun, 22 Mar 2020 at 20:54, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The allwinner_h3_dramc_map_rows function simulates row addressing behavior
> when bootloader software attempts to detect the amount of available SDRAM.
>
> Currently the line that calculates the 64-bit address of the mirrored row
> uses a signed 32-bit multiply operation that in theory could result in the
> upper 32-bit be all 1s. This commit ensures that the row mirror address
> is calculated using only 64-bit operations.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  hw/misc/allwinner-h3-dramc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
> index 2b5260260e..f9f05b5384 100644
> --- a/hw/misc/allwinner-h3-dramc.c
> +++ b/hw/misc/allwinner-h3-dramc.c
> @@ -85,8 +85,8 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
>
>      } else if (row_bits_actual) {
>          /* Row bits not matching ram_size, install the rows mirror */
> -        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
> -                                                  bank_bits)) * page_size);
> +        hwaddr row_mirror = s->ram_addr + ((1UL << (row_bits_actual +
> +                                                    bank_bits)) * page_size);

This needs to be a "ULL" suffix... (I just sent a different email
with the rationale).

thanks
-- PMM

