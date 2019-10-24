Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1777ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D535D20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8Vs+o2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D535D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZuu-0004dC-JL
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iNZPD-0007bs-2D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iNZPC-0003q9-0Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:27:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iNZPA-0003pt-W9; Thu, 24 Oct 2019 05:27:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id v6so1862187wmj.0;
 Thu, 24 Oct 2019 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=xJZGkKh8fZ9kCKCk45SiDZFkdbshXyCaxMtp65tdQig=;
 b=i8Vs+o2MncpWwXW9pGHNXaGee3eJpV+p7x5qDVvjUKpn+nV3oSkkkiBU5Gd9rgv6Rl
 KAciwuw2d6oZT08ozqHF7D1ByoB2zyjA9iaeyhd8URh0OaB447MVturdrPWxXg2ySoty
 jQhh2yrA5ll2DOx/pwFCbMnXC1F4BgzbkXUqHJsD4uu8oHUNAwI/O7lOqddTBWq2uoYZ
 GSpG4BI4OPKb8YlPFM+mtRTCOsSQKLWDsBsRHZVv1cOcv1KjloUTluADeKoPeeotfcGT
 5/z2Gop1fUzyVMYPOFcgjfWHn7kw00XE98Q7gMpmAkLWY3r8Mgq200+qzjTFgSWJihXR
 Vi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=xJZGkKh8fZ9kCKCk45SiDZFkdbshXyCaxMtp65tdQig=;
 b=fKx5ivCbbkNdukdvxyJMFE4+PbX8rTBxkvJUXgO5IluInkEae6M2FPOb2Ff9KoxPEd
 t5QW+hkE5kXM5xjrviam7MA5l1pmralrh5rTqeT2erR1TkiAUz/j6riXFxUvBLU5yE5o
 7BwrBhmmzCaCFRHDqSMS8B7Qyq/1sR9Bjfr7D3WB+nL4uog8uL18FlPYW2vkD9+OOiyp
 RXdYNjoF6gGclhKoXg7zTHw6J3XhXtCdT4zFAEUMCXHPLMt32g1iLfAlM5SzKDEtqfVv
 yHAyZBAa13avcJwK0zpo4OoPid7H2lGG3QmfnRN5MlGqdURjhWpYKtjiNW3dCckWKIlL
 YACA==
X-Gm-Message-State: APjAAAUJTJbqJUEnhkq3dt6d1yY+xChsITWycAe7mVf/Jd/bp6a7uePj
 9Ocs27oM6SKc9HEVsnFzTcU=
X-Google-Smtp-Source: APXvYqwZm4vS68Ia3SBxO+IooRdOjahmeTTwTL6dYG952S/wsq6XvJoZWtAptXGMXgJycECOqQ11gg==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3734821wme.4.1571909259765;
 Thu, 24 Oct 2019 02:27:39 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:9c00:d5b4:db5f:bfb4:fdb?
 ([2a01:c22:b04f:9c00:d5b4:db5f:bfb4:fdb])
 by smtp.gmail.com with ESMTPSA id l14sm9632811wrr.37.2019.10.24.02.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 02:27:39 -0700 (PDT)
Message-ID: <c88659d6aa590f1ea20bfd86636e14710e8813fb.camel@gmail.com>
Subject: Re: [PATCH 15/19] tests/boot_linux_console: Extract the gunzip()
 helper
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, 
 qemu-devel@nongnu.org
Date: Thu, 24 Oct 2019 11:23:29 +0200
In-Reply-To: <20190926173428.10713-16-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-16-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El jue, 26-09-2019 a las 19:34 +0200, Philippe Mathieu-Daudé escribió:
> We are going to use the same pattern. Instead of keeping
> copy/pasting this code, extract as a local function.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 8a9a314ab4..079590f0c8 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -19,6 +19,11 @@ from avocado.utils import process
>  from avocado.utils import archive
>  
>  
> +def gunzip(in_pathname_gz, out_pathname):
> +    with gzip.open(in_pathname_gz, 'rb') as f_in:
> +        with open(out_pathname, 'wb') as f_out:
> +            shutil.copyfileobj(f_in, f_out)
> +
>  class BootLinuxConsole(Test):
>      """
>      Boots a Linux kernel and checks that the console is operational
> and the
> @@ -166,10 +171,7 @@ class BootLinuxConsole(Test):
>          initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
>          initrd_path_gz = self.fetch_asset(initrd_url,
> asset_hash=initrd_hash)
>          initrd_path = self.workdir + "rootfs.cpio"
> -
> -        with gzip.open(initrd_path_gz, 'rb') as f_in:
> -            with open(initrd_path, 'wb') as f_out:
> -                shutil.copyfileobj(f_in, f_out)
> +        gunzip(initrd_path_gz, initrd_path)
>  
>          self.vm.set_machine('malta')
>          self.vm.set_console()
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


