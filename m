Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAA1C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D6221927
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMMiTUR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D6221927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6UZ-0000if-81
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6Sn-0007wp-E9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6Sl-00070t-7R
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:30:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP6Sk-00070Q-VO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:29:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id s202so13658629oih.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oGJOVBGJvfaMOoRlOR4xTYYglnsU4W7X8ab/ejSvg2k=;
 b=mMMiTUR2tFxMc5b0yZb/Z6s96kn3F4LTMhaz6kLWtUA7z4Goa96R56cD6VX5GN0cCM
 IPrFFKaJZvde/dirPmj44u1wgxmaQFMgNYw8E02nMU9704Knq7A0UNfnvf7CbruTQ1Tf
 STQI2KUeZ1fCQfa0jdrkizSzEuRYaNmOzazp/+B2953uuXTkgv64IAcEdpNsjDTVaSNf
 xAERRGCD9X5+MdwGw7iMgw0TjkUBLV8snOsoa1Nc4AS9XNO/RQpQTsonY/2ooY+KHQaU
 1ttageNleMrAfyCxXE4QwDOIXI+GEeUoMf++mkrdifmuA4yPpc+2xM667oQxIxLtlNBl
 7vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oGJOVBGJvfaMOoRlOR4xTYYglnsU4W7X8ab/ejSvg2k=;
 b=fFSyEY4zBM7gd7nOPEb7X8mIZbWNYCnxQvUI1TCucd3kj9bJPJUmvlT2u3/aZktE8X
 3VrSjO1pRwh9qtX8t49TBMyvZeZQqURXMDVriJqHr1oeKTTJQcOnlvqreI2y7p5SJVsR
 jgbGekVbVzInozqJfyNhvMi/7n2Mv5S5/GnZ+d+b/UeJEWfU7cgua5B5chrQ2T0t+QAQ
 jA/v78PIdwPqE8voms+bO2bS09aOvwosr55JL2U3/AkCSwkdUrJzk8NNi6RXqCCFAL/6
 AQcnmfQR6r6dIKJFLV1rOHPvuyD/i+JFOexCiFMyVAtQvpSvt7gJTtyiDY4onDVVOYhM
 BHWQ==
X-Gm-Message-State: AGi0PuZALLcplQxa4LXFIR0b/onfzEVoxV6BCaKMBf5tnr5NviCrz+AH
 sYgOdQBdF9PVEDGeaecF+8Pif830K+6nhZOw4dy0KA==
X-Google-Smtp-Source: APiQypKzE57KEL24Iszq6C3xexErKkYaNEtwUbOviDrPwUuGMnPqow1fHR/+m3RJkZd8dbQGEmRHjiJK+mNH0j6ik6U=
X-Received: by 2002:aca:170e:: with SMTP id j14mr3260651oii.163.1587050997832; 
 Thu, 16 Apr 2020 08:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200322211919.11335-1-linux@roeck-us.net>
 <20200322211919.11335-9-linux@roeck-us.net>
In-Reply-To: <20200322211919.11335-9-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 16:29:46 +0100
Message-ID: <CAFEAcA9drmvK5aiCtugLFABKf9t+XMkt6AhS75VhzABzXVMhGQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] hw/arm/fsl-imx7: Connect watchdog interrupts
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 21:19, Guenter Roeck <linux@roeck-us.net> wrote:
>
> i.MX7 supports watchdog pretimeout interupts. With this commit,
> the watchdog in mcimx7d-sabre is fully operational, including
> pretimeout support.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

> diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
> index 47826da2b7..da977f9ffb 100644
> --- a/include/hw/arm/fsl-imx7.h
> +++ b/include/hw/arm/fsl-imx7.h
> @@ -228,6 +228,11 @@ enum FslIMX7IRQs {
>      FSL_IMX7_USB2_IRQ     = 42,
>      FSL_IMX7_USB3_IRQ     = 40,
>
> +    FSL_IMX7_WDOG1_IRQ    = 78,
> +    FSL_IMX7_WDOG2_IRQ    = 79,
> +    FSL_IMX7_WDOG3_IRQ    = 10,
> +    FSL_IMX7_WDOG4_IRQ    = 109,

irq 10 for wdog3 seems to match the kernel's dts, but it's
a bit weird that it's way out of the range of the others.
Did you sanity check it against the imx7 data sheet and/or
real h/w behaviour that it's not a typo for
one-hundred-and-something? (108 would be the obvious guess...)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

