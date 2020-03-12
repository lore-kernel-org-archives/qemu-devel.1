Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02072C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10BE20650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPO+ikxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10BE20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOl2-0006eB-T1
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jCOk5-0006B5-VX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jCOk5-00044z-0g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:23:21 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jCOk4-00043W-PX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:23:20 -0400
Received: by mail-lj1-x244.google.com with SMTP id g12so6666671ljj.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Dt+A0XYoM4z0Muyh4Z1oK3OQIHOd+TenS7WS4Spt8M=;
 b=kPO+ikxEgegYspLtVJSTdDZGCrznn2iZHcCDSpipCfIKchWvbMXImnOGvH1GmkJfoD
 KcE6fvz9RgDqdCcl4OhN7O0CjnJ+M6liGFX7kS02szV8Mo1+CU8jkrhYkKZ+cX6rh0Qw
 H/nnJeTMB5ClokfZT4zcoYejI5wYd4XBiBYB1T5WDgosR4K8w/H85ETqh8BS+y3N6LvM
 5Y95Pb1xYZfEjIrgLVRhecU/tTp74SEk3Ps55TNUzCeR9gXSB6amj6Kc+BpjDlZq6zaG
 WIiIfQNErmoQIOMBgKTJD8wyx6zy8TH+bDi310hmLvyph1kUIo4otwnn+KNf7P9k3532
 g2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Dt+A0XYoM4z0Muyh4Z1oK3OQIHOd+TenS7WS4Spt8M=;
 b=bdwZdqYD13fpg5YnpRmps25EMWPHB+VzSPeXktiXCaPW3lSUbk2um8aul4OBDPOE0t
 5LBB7gW0F5QMmVEyLoPARJRZAjIVjOIvP/8Nc9PaODeNNJYBqjHuc04RNJd8ju1ZlMbJ
 M6KuKL5QpqMm//rwt3V6zYJIpOV35MB6gbdmoRT8Ei5vgAy7lr/Pd5rjqGuvBU3G915X
 4tS1pf5u2RmCgUkUU8dC3obWINxuqDhMcQ2H1NqqegOTDhMoySLq5gVQ4fyxb38A9WdR
 O7mQGtKcgKTxBln/nDfb8vs+Yq+g6e7U6sTVAQqI28UfMjAkqgt/vPtlC/TIOhFG3f61
 7UtQ==
X-Gm-Message-State: ANhLgQ0JwaXSjwVUrs7HmDuqFWdo0N/giwtIkkVXYa0gnAYA2Oelipkw
 /ysiRc+biRdKWhRPpg19IYxToxQAqmsfHoUMZO/eCg==
X-Google-Smtp-Source: ADFU+vv7LNhuqWt6huv0FXgE1q4FBl/D6hN2gAx1rsopSHV4jlVMS8grUwQme6vafr3oWKM7JsBOgEJp0guAr/W7u10=
X-Received: by 2002:a05:651c:2049:: with SMTP id
 t9mr5600275ljo.39.1584022999468; 
 Thu, 12 Mar 2020 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-2-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-2-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Mar 2020 15:23:08 +0100
Message-ID: <CACRpkdZGKB9opaOFT8Yz-tfE9vcCVeF9EvvBi7jWWuAAh3C_FA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] gpiolib: Add support for gpiochipN-based table
 lookup
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIO controllers can only be referred to by label in GPIO
> lookup tables.
>
> Add support for looking them up by "gpiochipN" name, with "N" the
> corresponding GPIO device's ID number.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Just like with patch 2/5 I have the same problem here that
the commit message doesn't state the technical reason why
we need to change this and support the device name in these
tables and not just labels.

(Possibly again I will realize it...)

Yours,
Linus Walleij

