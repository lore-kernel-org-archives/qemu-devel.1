Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545EBC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A732087E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpx+NqfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zv2-0006fR-A7
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7zty-00067K-28
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7ztx-000827-14
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:31:05 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7ztw-00081T-TI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:31:04 -0400
Received: by mail-ot1-x341.google.com with SMTP id g25so20800155otl.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 03:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9gJ2FWRKLN27Ge6JM2F8ps8I6Cl1NUkfZtdNCQG6NF0=;
 b=bpx+NqfGle3+MQSSGEeUZG2RJpQAL7wJkuTpljtmu0p+ztAcFOByU/fDr97u/xoF8V
 K/nMGMdR8QDR4X1Xjp4pr2JgwVonigkl/mwOw1V2p5SZXcX5FcPL10V0ZMiGVOWc+5Fk
 oabZ9RrqEGHuOu1Nn/sDuTgw4JY5hiRFw7iVR6aiFrbDcm3vsa8EEoBdQHG22L/W/zXL
 XjgvDYHu/n2jTzbsqfh+DjqAwcqWvLvE4HVcFHkOJXuZBcGSzsvScJhj6ttPTFlP4FMB
 nreBY1z/c39Pb2to1KALIs7WHlIP7bpJLp/kKqLnMf5q9gzxv05bW72EqmXEhq42U/td
 Xp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9gJ2FWRKLN27Ge6JM2F8ps8I6Cl1NUkfZtdNCQG6NF0=;
 b=ToAnrXntcQM8+Il//JFUjjgiY9A1BxxCGOqVxsrGNV8VWtbg4s7t6UKzP6Jb0/fFH+
 TGkxlkfhhtDb+fu/pj0NXNqCtUZbTgUf77pUqI0TXhZjqbS6gcVTMYCgZuTRROM3gVq+
 i5yhYPlCVrX13XordZfCV9JKU1+JjWi4H4n123nvGShuyaPdMoLw7XtUWOLfq9tHZXC6
 zNbHYMmN8+Ad2GYEEGpKC1W/B8vsDVU92Dk+JNqma6tZAn1QHbskQ9g5okb5824nc/Z7
 BjGbSsqCt+SyQDjcOw8i8XrI5ZjTTmS2fEZVQjwNSVnl8z5J6nWIsEftGJd3aBbVACia
 qL1g==
X-Gm-Message-State: APjAAAVZXEYO9kTQiTjPO5rJmr2uwtkSlpGT7LXo0Ma5sV5cZ0WTDqOd
 Xq5ivbrq1+0WTFVnlSr3LQJY2UaYPGQ+UG1r4eDHuw==
X-Google-Smtp-Source: APXvYqyQwKnTo2wYJwZUuvMyGNFY9TaCOtRHL4Kjw+EnmrjxvY4rpzb6+VI9Fjn7AmLxNcjtjAOTn6XZ0LS3boWo6QQ=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr26025117otq.97.1568197862908; 
 Wed, 11 Sep 2019 03:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190904070506.1052-1-clg@kaod.org>
In-Reply-To: <20190904070506.1052-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2019 11:30:51 +0100
Message-ID: <CAFEAcA9AJVBqfy1MFEdekz66vrR_8Wcm7LMEoBhU3xje6Zo1gA@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 00/10] Aspeed: machine extensions and fixes
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 08:05, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> This series improves the current models of the Aspeed machines in QEMU
> and adds new ones. It also prepares ground for the models of the
> Aspeed AST2600 SoC by calculating the model typenames using the SoC
> name.
>
> You will find patches for :
>
>  - DMA support for the SMC controller, now using address_space_stl/ldl_le
>  - GPIO v5 model from Rashmica
>
> Thanks,
>
> C.
>
> Christian Svensson (1):
>   aspeed/smc: Calculate checksum on normal DMA
>
> C=C3=A9dric Le Goater (7):
>   aspeed: Remove unused SoC definitions
>   aspeed: Use consistent typenames
>   aspeed/smc: Add support for DMAs
>   aspeed/smc: Add DMA calibration settings
>   aspeed/smc: Inject errors in DMA checksum
>   aspeed/scu: Introduce per-SoC SCU types
>   aspeed/scu: Introduce a aspeed_scu_get_apb_freq() routine
>
> Rashmica Gupta (2):
>   hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
>   aspeed: add a GPIO controller to the SoC



Applied to target-arm.next, thanks.

-- PMM

