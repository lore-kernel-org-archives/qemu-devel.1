Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B4C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B4F20658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0W2Bnoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B4F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAGj-0003um-Si
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAG0-0003Ny-8j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAFz-0003yp-8g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:19:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAFz-0003jw-0e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:19:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id a49so18413005otc.11
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+PoEOXEBpQkNeh3emDDls5uAWutZ7pcSClgHt7CSvr4=;
 b=a0W2BnoqzActavmd1mYsJRHLs3qOvzetk1FbCz7c9Pxqu9prH5T7u5GhaWZDKdqXcb
 J5kSaAfcmco/mD9UvUgho2IkwQdjPaung5Ti7yahSk8Xe8GVwJVM1qBl7R6GQxwSp+OM
 j8wVzMApyiMA0gr88eO57lEjQPhOojM7o1nZpkxZJoEN6Z1/sjl+8+U3gExLOtyVdsm1
 GkZe7oFVqPF1bEmz8GZBRYxykvlntYquUfT1oe90wC0ovwtnh7SgICXrUShm0zhTJDuM
 B3ZkSo6l+qtb3Y9Aj0Tt9xt4LW5NPrUqVBKcJnSlhYZuzxfzpwzzioAPdAf6Y1L1SO1w
 MfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+PoEOXEBpQkNeh3emDDls5uAWutZ7pcSClgHt7CSvr4=;
 b=FCRf8FW2wHBWoZrwZdZLbv148nqhM9QXJBmDJr5cnvwapTumvmVyQStRxkokg+wctR
 7L31hAvdTIAZ15qLhLtTDbIVwcVyhwV7+ZOEYhau5aFZtRG/zDopRS4UjLc1sPcsAc2E
 qw4Lx4lqOlJjbpiZsmvGb7Rb9mum2zAifASRl8XKnVLjoc/FBbtkqUY10j2E8f/LS6NT
 AL+qlqp49Pjw9SQoj2I1IuSFMPZc8SUpLxLVJnjP8Or31W9b4jS3+FZ6bBVzZQVr6/Qf
 FdVAPh4T0nMKfSwEuJPtEe1rIVw73egBaWhCm3Zf6BMlLA+vOxHblfPTQmb0jhWr0XY3
 TWbw==
X-Gm-Message-State: ANhLgQ2MLQR58SiUb2fDPU4fvT7JUdfohPSQFWyYO9MCcifrnIbrBaB3
 64ISGM8vwBwC0karmc94Sp0nSzFBYDhWekNSNTxS3A==
X-Google-Smtp-Source: ADFU+vsP3RFsJ4x2CoGvtIKLgI7gnRnB6Kg8CRZ9eScUUc9dg23uYZPokML098uaCvuO8tehX0OaUId4U8CWGS6Iskg=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr3261522otk.232.1584443972621; 
 Tue, 17 Mar 2020 04:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200313160215.28155-1-linux@roeck-us.net>
In-Reply-To: <20200313160215.28155-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 11:19:21 +0000
Message-ID: <CAFEAcA-Ep07yOjzUvb0AXnStEkomoki+rmhKRg0as3Dcf+J88g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/pxa2xx: Do not wire up OHCI for PXA255
To: Guenter Roeck <linux@roeck-us.net>
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

On Fri, 13 Mar 2020 at 16:02, Guenter Roeck <linux@roeck-us.net> wrote:
>
> PXA255 does not support a USB OHCI controller, so don't wire it up.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/arm/pxa2xx.c | 3 ---
>  1 file changed, 3 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM

