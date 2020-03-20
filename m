Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC0C43332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4526C20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+sjbXEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJyI-0006M4-F9
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFJxV-0005jp-J2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFJxU-0001pq-8q
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:53:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFJxU-0001p2-36
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:53:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id j17so4679417wru.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eCJqdy4lQnsVrkn6WM4N9GFa0OUSfsOg/iYSPDxW8KI=;
 b=A+sjbXEMH0ttD7lqBdaYWatmp6joSjUv+ZcC6D9C5j4XquysI63D6EECLFro1MNk6y
 FK7415vu1uea/joKLSkASgcjAcJLdpH7QiRW3IzkVfhCcO6GG/1nCG5N4+G2ia5j029J
 1h5F5JhLbtIZCn9sPstYNBjJFK/Edio8wSkcSi0bOhrCFAUSS3mcrlyhJ0HRbp6Lh3OJ
 cfvav6vLUI3gT+aOoTch3f6yLKcpnsNueOtMQ918GWu2fHfmyGV4mmhXlWOCSr/01Yp6
 tKRXaLrNnxB6ayb9ad5O08/dv4O+guOTW7Hvkb65GVf/0hQJvgLvoareCwlaF7r4wGAz
 P4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eCJqdy4lQnsVrkn6WM4N9GFa0OUSfsOg/iYSPDxW8KI=;
 b=UI4PXft341e1fJRMhZemgrypzmUxG/wdDAm0r+msxzhryYEGmSrK3viSPSGL3JJNIm
 7KSRqn34H7SgZ5MpHRM525KcBnsQGgWRvYxpEKCcs/mYYtDjSQer4wKbSYZnrmTXcoma
 yukZi9suNAaOqQR7x6LgBw3xgEbrBOWgbZvT0Guw7Uy1uQEBMEAkE+Y1RONQScjP+rYu
 3WljDlliMxIP36Ut76jBHKI/+fYy7bVk4Wenb8ulW5IQxp4dZH7bO9sI5BbWZXApN+CE
 biUYge54qHVY7gpQgvc9RTyQ53x02XTg2UK5axpDkLend3BQhC2ghPAZ31wQ3Gawmwh7
 atTg==
X-Gm-Message-State: ANhLgQ3wkVyHlFQQ7aWo3bPOmA1fKZsPKC2pB0PgLnxTebg6EX59hvK4
 ZaCUyHoTbOVt1//n6LvAqTFMtsIitu69GfSjMR8=
X-Google-Smtp-Source: ADFU+vsR+ZhpPJupR18kaUPw24aW78VcyKAVI/5wWeoRZFMnSyzcvrOQWJFN1+nY/6T/8Z1IcZY/4e1YgrrsnxoUiSU=
X-Received: by 2002:adf:ba48:: with SMTP id t8mr11930884wrg.329.1584719594603; 
 Fri, 20 Mar 2020 08:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200320114522.16273-1-alex.bennee@linaro.org>
In-Reply-To: <20200320114522.16273-1-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 20 Mar 2020 16:53:02 +0100
Message-ID: <CAHiYmc4uskWbmVo0c_TuKLP_vM1WQ-w+UBW-EdHE8rp+eV+9Vg@mail.gmail.com>
Subject: Re: [RFC PATCH for 5.0] configure: disable MTTCG for MIPS guests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 20. =D0=BC=D0=B0=D1=80 2020. =D1=83 12:45 Alex Benn=C3=
=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> While debugging check-acceptance failures I found an instability in
> the mips64el test case. Briefly the test case:
>

Alex, following up Philippe's hint, do you see failures while using
32-bit targets?

Thanks,
Aleksandar

>   retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
>     -display none -vga none -serial mon:stdio \
>     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>     -cpu I6400 -smp 8 -vga std \
>     -append "printk.time=3D0 clocksource=3DGIC console=3Dtty0 console=3Dt=
tyS0 panic=3D-1" \
>     --no-reboot
>
> Reports about a 9% failure rate:
>
>   Results summary:
>   0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
>   -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
>   Ran command 100 times, 91 passes
>
> When re-run with "--accel tcg,thread=3Dsingle" the instability goes
> away.
>
>   Results summary:
>   0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviatio=
n)
>   Ran command 100 times, 100 passes
>
> Which seems to indicate there is some aspect of the MIPS MTTCG fixes
> that has been missed. Ideally we would fix that but I'm afraid I don't
> have time to investigate and am not super familiar with the
> architecture anyway.
>
> I've disabled all the mips guests as I assume it's a fundamental
> synchronisation primitive that is broken but I haven't tested them all
> (there are a lot!).
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index 206d22c5153..002792d21dc 100755
> --- a/configure
> +++ b/configure
> @@ -7832,19 +7832,19 @@ case "$target_name" in
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips|mipsel)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"
>      TARGET_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>    ;;
>    mipsn32|mipsn32el)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips64|mips64el)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
> --
> 2.20.1
>

