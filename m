Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF538C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854602072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIJiaCIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854602072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJB2-00084W-M9
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGJAF-0007IT-IU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGJAE-0004tE-Gr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:14:31 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGJAE-0004sx-Ah
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:14:30 -0400
Received: by mail-ot1-x341.google.com with SMTP id 111so12590713oth.13
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EUWJ8GOUn9hwL9Yz9puJR4/8Y57GGwK7T665TeWw/8I=;
 b=tIJiaCIspPeTW5n9OrlzwUfFhBOuPl/1pL/04Ktl0AK/brzBkIqnMyJL5Lzocly3ov
 7ogIqCl7zjdhaCN/YJIaa3vBv6/B/cXYa+A829jOXuRn/McGBgKSoCnHtrBhyRpvmAtm
 7Aeo6lGiMZNhqXNdHZHS0iWkMZVuTBftpsC0VuRxaIS6CrtoHWoNOp8Uvb4ccE12X0ce
 SdYsuT/8ekbJwPr/STTj9WfF94VIxYU93V5OfuHVBZEuWsPQq2sGTW2VOcT96orJsHB3
 7twNhx88W9Yfj38W4z3Vpl8hI+Asa711j212iSDJtziN/14WV3bMKuXYUWkD5ZW9JODf
 PH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EUWJ8GOUn9hwL9Yz9puJR4/8Y57GGwK7T665TeWw/8I=;
 b=hApIbg/TlhlCETI0jyn7xGf0ZUPmATigHwIuyAI+KsjTwOXNrtzMP7fVFVMWoICdTg
 CEXqIMvqqHjJJwWmpfoiwDGhr7Al0SRo/8YEp/cOxhTHf8gFGO9rKXlGJpoyzCzRHizF
 QHO5BRN3WnjI7WvxTMND1W40/PUSBL682HdZDsBOQl0JEDWzFaveVzndQxxFrF2eqOyV
 tGDAphmxvmey0wl4spx7mp/5omE0RhAhJbkKKWvlsiNLLR99v6Z3U65D8dQeGWpDX2uj
 K0dzoUBLz7j/9Fe//KS9dZj2jGAU3nCiGzDlFw5aVnkwJRgKiTB7XqCq2O+muoJsYYbM
 3r9Q==
X-Gm-Message-State: ANhLgQ0b9f3bAeth9Asm9EeB6UbOyCG3CdOkvP76zNHfI3kCTsi7mCqi
 HSi+b+eYbCcW8ET9DdG8hLhyLXfa+/YfxH/WkY9Enw==
X-Google-Smtp-Source: ADFU+vu2NgZba60ZfGG1HNi0EfkbjNlevuof+s038ZZF/JPAU7nmbcOorNGGNTF4+aM8Y/abK2oFoTq1dRHhgZ7o/z4=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr2183048oth.135.1584954869501; 
 Mon, 23 Mar 2020 02:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200320053923.20565-1-clg@kaod.org>
In-Reply-To: <20200320053923.20565-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 09:14:18 +0000
Message-ID: <CAFEAcA9BTThqvOofRR4g_vbdgVkMf0083cy6jj3vE3Mevu09kg@mail.gmail.com>
Subject: Re: [PATCH] aspeed/smc: Fix DMA support for AST2600
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 05:39, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Recent firmwares uses SPI DMA transfers in U-Boot to load the
> different images (kernel, initrd, dtb) in the SoC DRAM. The AST2600
> FMC model is missing the masks to be applied on the DMA registers
> which resulted in incorrect values. Fix that and wire the SPI
> controllers which have DMA support on the AST2600.
>
> Fixes: bcaa8ddd081c ("aspeed/smc: Add AST2600 support")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed_ast2600.c |  6 ++++++
>  hw/ssi/aspeed_smc.c     | 15 +++++++++++++--
>  hw/ssi/trace-events     |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM

