Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F39FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687B0222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APs4BFJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687B0222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2D9S-00084d-K2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2D8N-0006zG-Qp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2D8M-0000g8-PH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:19 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2D8M-0000ec-I1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:18 -0500
Received: by mail-ot1-x341.google.com with SMTP id h9so5263842otj.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 03:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W26slry5BFEVljsqaQF9ltZ7YecO7l1WLKeSFmaYBdY=;
 b=APs4BFJdXbbjjU4+DkzlL+jhMr7dOXKT1geAvgeeDjcscCHxMZwZ+S6w5E3oWvHnMx
 JpWQhtHFTE2qg0que9zrJB8ufv4jINe3PqP2Gn5tcN8T0QcIZNx/WhHc8H8xjs7l3ju3
 JI4+sBh+wKTLMMugWvhd6mGBSYfAJU/RxzDb8Ixv80HF1bOxGLB1G4BZbo6ERJaN3Bqq
 znB67rAJtdFzTdVAGG4iLNXzfeweDLnY7V6IpUETU+krn4zFGc0FXSV31Bz4+G8frxLa
 h6kqzr5YNmk7gY77ZRV4iRfSLDzz23DQT9AD5s99X3E9RiELTlPlbbGT3pk43lhjzoTj
 jbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W26slry5BFEVljsqaQF9ltZ7YecO7l1WLKeSFmaYBdY=;
 b=dTiiOr3pnLXdn/WqFdAjeTu6YWgsEN3Zs03EjsIshI0PrdKejQrywVnqFkcQdw/XmR
 IgB7R/XMgCcurhR5E3z877cknVIk/fmaQV/oRaMpyvkkwHgdNAP+nBgp46HWpaWFvxu/
 5PW0dbkYqt+1y7OQKHdekc10+ZxyiLTwDlw/7PzLyLJBD/m0x1xLvLbFm45HZR5DuvsP
 yagrwVn/rMKoq3p8dHEJBBicRGXfhX606MwmiupSawMupMBcLbfHp2hZ2OF/2NR9QcPD
 mxY6PkBxnuSV2RnmPz4meVGV9zoTweqbwNbCLVFCffbMal2I9x03zh/tC2AUXhwCS1vF
 Po3A==
X-Gm-Message-State: APjAAAWiMpVxx17tlDd2VNUys5Wrwdagj7GabWIdE32AH29Qx49ZxfIL
 U2MMldZswtocMWk1+Ir711YRhcQ4RfLAKuM80l0ocQ==
X-Google-Smtp-Source: APXvYqzm3tJ0Jt5XVYe4ZoD2eX3QUGBjX5UISrtERREKqMLMf/yh1YlsXee9MGMfk3CMSKPAMSYwq2VHu7IKNS1un3U=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr12373571otq.221.1581595097243; 
 Thu, 13 Feb 2020 03:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20200206183437.3979-1-linux@roeck-us.net>
In-Reply-To: <20200206183437.3979-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 11:58:06 +0000
Message-ID: <CAFEAcA-onKuSidzf43090M7R=b4krbVfyvFUBwFRPGAGdBdmGQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: ast2400/ast2500: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 18:34, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Initialize EHCI controllers on AST2400 and AST2500 using the existing
> TYPE_PLATFORM_EHCI. After this change, booting ast2500-evb into Linux
> successfully instantiates a USB interface.
>
> ehci-platform 1e6a3000.usb: EHCI Host Controller
> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
> ehci-platform 1e6a3000.usb: irq 21, io mem 0x1e6a3000
> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.05
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: EHCI Host Controller
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>




Applied to target-arm.next, thanks.

-- PMM

