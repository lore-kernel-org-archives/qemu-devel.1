Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF3AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFF3222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShX+Extn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFF3222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrfU-0005w9-ML
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUreq-0005R1-Ul
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrep-0003Xa-Lq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:22:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUreo-0003Wg-LA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:21:58 -0500
Received: by mail-wr1-x444.google.com with SMTP id i12so2131055wro.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h778VlmNFlAxz7rsto+8uif3uW1hIAf0AZ2+xBgeotc=;
 b=ShX+Extn2n1TRzYJz23rsb3qT1eX8JKe4wnHQd9dsJtB/n72ycuX5FChHA+K3A888E
 2mLmcyvMadPs28csBmReNJJQAV3PTdFUNGW/J0F8DhWUPtzpXxu/T1bIkdqt2rB+/+Ts
 32nOPmT2++HSzfzR6VQetvSBWryyMhpeWsWY8s/1F9527EF4/fugNNnVdfW5U98C0hv2
 V/gQ/VNvKiyBJB9VAhtykH7j55BfCvUbG/C5wshDDZB8wbKLkSC8AcYer0e0W0xXkusQ
 KhAZc7W/FHPJJ9s5s0yviK+kuWaFvX13AMY38uldGSE2KLqR5gYGW2FpBdCCnmnrUxDu
 1liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h778VlmNFlAxz7rsto+8uif3uW1hIAf0AZ2+xBgeotc=;
 b=UJWArV8zEG1AmWV6v6RZFMvybB0FIxRX5xJhR9hk9+SEUBRLNqid8nlv+WEJizEHxX
 PijKDdAzpJJmxapAJ3vx+qDOD9HKazqhi9KY3YN2bdoKQTdszr/9UME9Hnkg6evv6aoo
 yrmQM/05Y7q9cQ+zTWxsEBxPScxiqCOFImC0St8EnDkxU+/+4M+Xq7WX8QLkgPVCogVb
 W1yhTyWKavcaLty0LSGrgXErua8VoCNxXF2ZowmnGFCWE6N91b8wUOWwuDECidGbWLs6
 3eTg9aU0JY5ecJBHvMAOyJTG2dZ/MMFAi9zMnCxzxpfxMfI9Vn2Q2Mqf347WCL56TiSy
 O40w==
X-Gm-Message-State: APjAAAWWGP8m7yCsrh/k+ad+hKFy3fq+rc9H1NNMvH6ZEVi3SBF4Gm8E
 ti5zHaU5huJW2HmJcj62H1YgQg==
X-Google-Smtp-Source: APXvYqzEw1q1bjHuVDlVILQ6OveTdmRhz3Wp6pK8Gaz+fV/AtIWrUYMiV+g9S1ze/u3iZsRJOcI6Sw==
X-Received: by 2002:a05:6000:12d1:: with SMTP id
 l17mr2513981wrx.261.1573647716844; 
 Wed, 13 Nov 2019 04:21:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm2731029wrs.91.2019.11.13.04.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 04:21:55 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 192A11FF87;
 Wed, 13 Nov 2019 12:21:55 +0000 (GMT)
References: <20191113005201.19005-1-joel@jms.id.au>
 <20191113005201.19005-2-joel@jms.id.au>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v2 1/4] aspeed/sdmc: Make ast2600 default 1G
In-reply-to: <20191113005201.19005-2-joel@jms.id.au>
Date: Wed, 13 Nov 2019 12:21:55 +0000
Message-ID: <87a7907yqk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joel Stanley <joel@jms.id.au> writes:

> Most boards have this much.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/misc/aspeed_sdmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index f3a63a2e01db..2df3244b53c8 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -208,10 +208,10 @@ static int ast2600_rambits(AspeedSDMCState *s)
>      }
>
>      /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
> +    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
>                  s->ram_size);
> -    s->ram_size =3D 512 << 20;
> -    return ASPEED_SDMC_AST2600_512MB;
> +    s->ram_size =3D 1024 << 20;

FWIW units.h has some nice #defines to wrap this stuff:

 s->ram_size =3D 1024 * MiB

Not a blocker though:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +    return ASPEED_SDMC_AST2600_1024MB;
>  }
>
>  static void aspeed_sdmc_reset(DeviceState *dev)


--
Alex Benn=C3=A9e

