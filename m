Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD0C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0FB2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+fO9zK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0FB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDmYg-0002uK-H4
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDmLr-00082P-Ak
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDmLp-0005Yw-7H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:48:03 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDmLo-0005NM-Uc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:48:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id k26so17223851otr.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t+WFlt0ezqgTB4mKPhyjViAQcajdgombL4lkcC71VL0=;
 b=n+fO9zK7Myp76OYx9XR8wYXmn7TD5q5Yp9Dzsa/mQVzM5AEeyApm7/amcSozL6+xuy
 fB+TM18N2QlWZsZYTVBn9pWeoTWI4K6bcsk/2TRT6aiCKvJc2iaY7FMV+gCGeYh6uxeq
 TT5T1au2xCQpbJRcHsQFVLRBhaLLxNHF1wuPclTySaXg0YbegnZetjMS8ChLHa7jNPtg
 58R6SPlleCAzK1Ctk8woET1qoM0nhqF0VFUy+fDfHbfKRgRH7UFMlxqE9/MYb4UKs154
 4Pr/9Zn4+l52z2DV0LS4ZyfrSLaqM05d0Z5DCd0zxze5l9IsVwgKMUQ5FipQryzmmY2n
 uRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t+WFlt0ezqgTB4mKPhyjViAQcajdgombL4lkcC71VL0=;
 b=MBl3Ia33vuuHMWCWGongfT/XxO1niwx8a0ykQcu3RF+oZRNswLbaZIvwn3xF3dSHcM
 FlQQTA/9SPTPVtvV9GGKvzLZBLAb9P08cmxMClXXAmC3JT5d12ZU+gb85k6tAXx2z/pR
 ZctasnNQm+RQ1roX/smQulxRyVts/LlcwGbiSfQxHaInFqUR/Mm5rF0DxDwX+zbQYnQw
 a0RrpLQ/F4pTssP4GobCeZqrsI9liZ1DQJphMntFtzfsbJn0ZAlCM2Z6zKKS0pTwkpS5
 pS1L6bk7gCPROeX8KGyBI3Yw6cP6p7kDEpHniyNfGNxlcO1T//qeRkmwIgdYbCLGh0Y3
 XyWw==
X-Gm-Message-State: ANhLgQ1eaMpRpC64xESvuKQI/7C8ZM3ynpMdbISTf7UKU9vjnXoN9+4B
 83l3oakmbGqKN7TPMU2fIjrCNClc7XYTdSrX4OezOQ==
X-Google-Smtp-Source: ADFU+vsj7zCvnl9g6TEk7mae7tNLRFlXEw/bZEq5N02ZBGe09Jy9gPcJWLJZqw+GsnezzHJaUoJ5DO8/tqOxi9otmTc=
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr20512644ott.97.1584352079961; 
 Mon, 16 Mar 2020 02:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134859.9547-1-f4bug@amsat.org>
In-Reply-To: <20200315134859.9547-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 09:47:48 +0000
Message-ID: <CAFEAcA9_hn8-Lmr9m9QkdDhMD2a1=CkGoJ-ox-9EpdmPHRubFg@mail.gmail.com>
Subject: Re: [PATCH] target/rx/cpu: Use address_space_ldl() to read reset
 vector address
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 15 Mar 2020 at 13:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> The RX code flash is not a Masked ROM but a EEPROM (electrically
> erasable programmable flash memory).
> When implementing the flash hardware, the rom_ptr() returns NULL
> and the reset vector is not set.
> Instead, use the address_space ld/st API to fetch the reset vector
> address from the code flash.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Based-on: <20200315132810.7022-1-f4bug@amsat.org>
>
> Same issue might occurs in Cortex-M arm_cpu_reset()

rom_ptr() does not mean "I'm trying to get this from ROM",
it means "I'm trying to get this from a user-supplied ELF
file or similar which hasn't been loaded into guest memory
yet". (This is a workaround for a reset ordering issue where
CPU reset happens before rom_reset() runs.)

Removing the usage of rom_ptr() altogether here doesn't
look right -- have you tested the case where the initial
reset vector contents are provided via -kernel or
-device loader,... ?

thanks
-- PMM

