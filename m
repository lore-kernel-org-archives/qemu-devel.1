Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD0DC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796312146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ar7wxNAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796312146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuHa-0005Sk-PO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42492)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuEt-0003Gp-7K
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuEr-0004Vq-FM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:12:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhuEp-0004Rs-AN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:12:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so13085811otk.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LPSeQWkfs5J4+0aio5LX6XJr8pFDPxJtfyKxsNBQOXc=;
 b=ar7wxNAd1hV8I8OWCnekf7cL+dmWJr7iva24/6oUtkVZCXec86qh+pfkQNiHo/eYah
 54Ff4IWziohKYeKcE3OBhjaPXC3u1gYYr3Mvq6i3ab/7Ac/MhDuqRXFuzFt8Ab7JGVdF
 LpRimq2ccUAdB5rE/zICa240Y0PqZ4oRV/Amei86KPQfwbau1hRZZqq7+vVJHAP7+Vci
 2FDgj67jU6NY9i2rxFUV1HVeQRBwwa5fjuMbTi/gnLMFOucMCHBFqo5gpucTaJ9LajBx
 cRXNIBD1uStr6NTfkkSm9m4JjFSBXntrhounCNhAu3aRbSWyChScccICnlKB9JV6/fFQ
 nQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LPSeQWkfs5J4+0aio5LX6XJr8pFDPxJtfyKxsNBQOXc=;
 b=DhnSJPYELrM5WgNNFZs7aH3OGxXr4ay8T0v2EyzhHtK0FBUlpQcbtNop/wuv8MwbiW
 mnguppqTjY0Ujn+adPShPhdGGP58t+4tuN5dxHR6f3Li33Fwo5W3X7aHgG/5cqPy2u/k
 5SCHpXwoItqHIakvbqFBOthQg3o4iFx5UYcTo2LTgrbwTkA40wXyOcPOOGhFM0DyotvZ
 qw2/S0R6wv6pjVANbfTKUg1hwqWczyI4ph5nG5+BY0ejdQWiSQuWa+uglRRFHMFBiv+T
 eDkqGLldMjYuiyIaIkmx+AHGmAxeiI62Di2hYfEHHzk7H9jf2V8ALT/2/rR97uW5PHPY
 1MXQ==
X-Gm-Message-State: APjAAAVwMCmw/PwQsvYtGbc7XyfbFHUtoc9a8UX56aIP98bPSmMVtPS3
 vx9Ydt95GhPM6Hab68XDoABAr9OFX7Uab7Z1Aqu82w==
X-Google-Smtp-Source: APXvYqxDTRR2e7ElKcPx+aWg94dfoL9e+S4RSvPrOUhG5g3QYMmusr/VnveyVqiTL8Cct0Dc+hoZpMqHOFPLB2opPHk=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr8164673otk.221.1561979565628; 
 Mon, 01 Jul 2019 04:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190618125844.4863-1-drjones@redhat.com>
In-Reply-To: <20190618125844.4863-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 12:12:34 +0100
Message-ID: <CAFEAcA8ujpMTwBackhT5V3hN77e0V=PFO3+0pvXu5mnuNok7zA@mail.gmail.com>
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: fix direct kernel boot with
 initrd
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 13:59, Andrew Jones <drjones@redhat.com> wrote:
>
> Fix the condition used to check whether the initrd fits
> into RAM; in some cases if an initrd was also passed on
> the command line we would get an error stating that it
> was too big to fit into RAM after the kernel. Despite the
> error the loader continued anyway, though, so also add an
> exit(1) when the initrd is actually too big.
>
> Fixes: 852dc64d665f ("hw/arm/boot: Diagnose layouts that put initrd or
> DTB off the end of RAM")
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/boot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

