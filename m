Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF8C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EB22067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlXc9bv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EB22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOjg-0005lN-5x
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jCOii-0005Kk-Hz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jCOiZ-0000gA-TA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:21:56 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jCOiZ-0000d3-KD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:21:47 -0400
Received: by mail-lj1-x243.google.com with SMTP id w1so6661602ljh.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=79OHKgNVg5IiTjP/EryhR/on7yjmd+OeOqFhBOB19Rg=;
 b=hlXc9bv7wKtJYos/CvmIf1aWytTx7tjjvZA7MyZXi7udPi5CdammboSrae1hgCitp/
 MSpq1qvYRN9mFEXkFN/xNTTmmao3V3GjlW0KxdQXRUqYqGp5IwObLZ7yB+renP8z+pfN
 tTWRkIMDIS1GZe95+PfMemVe3rr1Kwnkd636g3iGRWP+yiHdYGH7FrFNCkkgIeRsEdxg
 L1z1MSWPXkvi5ST+LYKisjEtlJI83foQzqkY8AUQk+nrdOaavjVDuTxl3sWpnDBKyxpA
 I+Y+/KkkggsGEGEO3b8x79C2+nvBFhV0SVSG0v4dMd8b9iZmSihZqNyIYhxl61ZhaL+L
 SMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=79OHKgNVg5IiTjP/EryhR/on7yjmd+OeOqFhBOB19Rg=;
 b=Up5E6TWpHMXJcSVtgbYhMQIVOH+uPmP/neNRtEDy8cfDmJR7Vu3+fN2xCTdR53mfup
 I2+PozE8l3kbDAz4S0GkasuGLUdHxmrDOkxCH1fvGTXLNxZgolgNbuKY1+B+w7RZBZt0
 3mFFyrsWx3/papZmOBBB1XRUoLloJ5QpxdTFFDGHfR5oS4wmKHcJiFhOkt1htNZo/kc1
 qcTougY2wER3Vf8Ybm+hKO8BrqWV8omzUwDgJQLIu+4zGEi8fg+6WjeNHRMv9X7I/kVn
 URr2knNAZrAglXuO+ht1YVBvnKJzQR24/AjR4K+PVnTgsI7K9x9hHAiqXvyPKQMdcMko
 RO4w==
X-Gm-Message-State: ANhLgQ14I03y4kgUpSBiszU6ucGEzE+MvEiSU28DIJuQmiq2bN6AJMSH
 3d6pmVjmQ7XZsOSl/5ruWbDpLMMg36gWb611u1jZPQ==
X-Google-Smtp-Source: ADFU+vtcIZFKaUxv+zzMf8n7cOQduYtCadrIv8wfIOW4HDImubBu1ngGLVdiQB+7d6huEorOiDcjWc0JqvkBbK9RrNg=
X-Received: by 2002:a05:651c:2c1:: with SMTP id
 f1mr5239338ljo.125.1584022905409; 
 Thu, 12 Mar 2020 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-3-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-3-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Mar 2020 15:21:34 +0100
Message-ID: <CACRpkda1JAnC=Feb39GeKEEP6q8Qwpsth6J+4OKj6A8S3YAUyQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpiolib: Add support for GPIO line table lookup
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

I'm sorry for the slow review, it's a large patch set and
takes some time to sit down and review, and see whether my
earlier comments have been addressed.

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIOs can only be referred to by GPIO controller and offset in
> GPIO lookup tables.
>
> Add support for looking them up by line name.
> Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
> that this field can have two meanings, and update the kerneldoc and
> GPIO_LOOKUP*() macros.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

I will try to understand why this change is necessary to implement
the gpio aggregator (probablt I will comment that on the other
patches like "aha now I see it" or so, but it would help a lot if the
commit message
would state the technical reason to why we need to do this change,
like what it is that you want to do and why you cannot do it without
this change.

Yours,
Linus Walleij

