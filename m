Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B541C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF965206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQPAxczn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF965206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNvM-00072m-6s
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCNuF-0006Ue-Fr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCNuE-0006jS-8X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:29:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCNuE-0006j0-30
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:29:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id d62so5413828oia.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrgliAOD75JBwgphw9tAqzWq3jSycyMTqEcr6pnK2S4=;
 b=wQPAxczn3bmwUGqzxIAB4h1Bltb+UlJa21Ak9OgReVI33jhfLLeUX/A59iveWPKxnJ
 f9nb7MVBtSj0vMrEqNtKC73cG89ALf2H01RZwf5k/kkceIy5gWBp1riNUBTssFBkFlE4
 goOfJYONSNNn+RCRDUhneKuJBNM2t6OpGe08LLRyvuW1E+EFSbEdXv/C4yPVZpF88PoU
 EvWMbUDOCZMA4+bEZbjj154dr3SWKC+Dar7YWJRv20wu80j4LmDtFVLlCeLSxM4hNOkT
 ppltK7ycM01ASqhODrH2VAJxrXnMntPkkG6ABw/bVdqVBR68q8IFFu2gP0VRzIG5PY5N
 /uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrgliAOD75JBwgphw9tAqzWq3jSycyMTqEcr6pnK2S4=;
 b=cw5EZrdI95NnPOtF/aZjEf/ruZJegd7cnSfInjBxq7PQNcMilNsdo+rdD+igfIuoS/
 ABuRmSeco5TIDS04to+bJ0OfZQ/+goCS01Kq4MNuqakIZ+LmjPcQHrtgYDzWshGu/OUK
 t8/Umk0fSKSdFhz7iJV50DhCpsdAt1zoz053R6ihjVnuZ/6OJ8oiGKG9OHkTzbHs82G5
 E5oHbs9jCJB721e28b5kHyBxzz8w3by0si1prso+QUg4khRLRrTY1J1qedeB01BxEPqu
 2IirIBsqo6h0A+v1GgqWYQi3sH10ga3Vsw/5Q2QAGhbrx0zh/LUajZ8AlkW6caQerx7i
 D1zw==
X-Gm-Message-State: ANhLgQ3x8OkaSUNxwxzxKQ83biiBlGf/3Azr22OOg2tmQ0dSd+jpg+BE
 5FkjdCOrTnCLHVS0bZ7HyOtyfnBLc60RzC9Tt7VxtA==
X-Google-Smtp-Source: ADFU+vszZHCvea7p4aVK4/n78bt6Dwcy0eg6EdOg9n0QSyRE2drTlmOnCAstTQbz0VRTsKc6rmwDVtZEV/uzFo/gXvs=
X-Received: by 2002:aca:c608:: with SMTP id w8mr2674971oif.163.1584019785006; 
 Thu, 12 Mar 2020 06:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200310210434.31544-1-linux@roeck-us.net>
 <20200310210434.31544-4-linux@roeck-us.net>
In-Reply-To: <20200310210434.31544-4-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 13:29:34 +0000
Message-ID: <CAFEAcA9itKNV6c07wm_4dJiGtHMLXCFt+A-W5xC5DX1Wxfu30w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/arm/fsl-imx6: Wire up USB controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 21:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> With this patch, the USB controllers on 'sabrelite' are detected
> and can be used to boot the system.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

> +    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
> +        static const int FSL_IMX6_USBn_IRQ[] = {
> +            FSL_IMX6_USB_OTG_IRQ,
> +            FSL_IMX6_USB_HOST1_IRQ,
> +            FSL_IMX6_USB_HOST2_IRQ,
> +            FSL_IMX6_USB_HOST3_IRQ,
> +        };
> +
> +        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
> +                                 &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
> +                        FSL_IMX6_USBPHY1_ADDR + i * 0x1000);

Are you sure these addresses are right? Four of these starting
at USBPHY1_ADDR means the last one clashes with what we define
as "FSL_IMX6_SNVSHP_ADDR 0x020CC000".

I only have the i.MX 6Dual/6Quad reference manual to hand,
so maybe this imx6 variant is different, but that document
says there are 4 USB controllers but only 2 PHY blocks.

thanks
-- PMM

