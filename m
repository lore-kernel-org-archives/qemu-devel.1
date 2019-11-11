Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D207C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED10220659
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ex6f9vIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED10220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU85A-0007fC-3K
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 06:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iU84X-000781-4u
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iU84V-0007tB-UR
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:41:28 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iU84V-0007sn-OY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:41:27 -0500
Received: by mail-ot1-x342.google.com with SMTP id t4so11007485otr.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AtPSNj6z0S1pVpexbPs9ZLnCorH702J0Ex7uyj4ZEY8=;
 b=ex6f9vIbsRDhKRZeqp2h9DrOxKpraMvCR5q+S7CizPIXJrCnVhbsJG0WuAs+5/ATfh
 SUqbMHkNbGNIIcYOMC7Dg/PUKkD0KTnMEDufMOiMsJsPQai+/CYhDbLfJs2wL+HYVqD4
 rofxtgc95mMRqPSLnXwBELY0PiFzwxdKb4gAwXh59EuloNqq7fR9w0+CoaDc8ubzNKqN
 6pbZ2qRPnQ0q5X7xrWUp9VX8eOj0a9wfhzYrg+QibJt5+jGFSqlI/xtEkLgq9n/FmSPL
 MZIt6Rj2/Oqt8/vIpJPcBeU3+fovLvyU8+rv6YEmVSNNk8fv9wYpZSl1pqA60L6np552
 ftTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AtPSNj6z0S1pVpexbPs9ZLnCorH702J0Ex7uyj4ZEY8=;
 b=URiES9cd/0qMp1Xib1rI1Obzgma/Dv56QNMwfj/TQZrefKi3eY5rSgf4mIQEClP9YB
 TZegE1x50O6T6Os/odLocicIrahKYF7cxD09eJKRHflxcrJs8QkXADEGrulIel9XpO6W
 cumd46R1sg7MuGGaTidqNdCcs+DALM3j+9DZswRbeMm/oeQBqR06+ObdHioTYC05NMyS
 K3uqQtQZj+5mZjzkUk9dxR5boTUenALo9tTkrCqjtKfGyHNiXyQBeIP9DrIwgwv1sWwo
 WcUWVav1XTudIjsVVwnu242vxA2yCZ/naAVFzxd8DPQtUVhdaqebcco2N2iPD9EL6vff
 r8qA==
X-Gm-Message-State: APjAAAWujJDexvfDyyeqzEeh8jqQNufer67Bp0WWCFia/pSQZIsiM5kV
 lgnKSGiUxy0O7fj2rRxsXeMHkdLNrhGf2kQLUWjZhQ==
X-Google-Smtp-Source: APXvYqxD6gNLqRXQRRB9a1ZZ7u6VRxGqEW/2t31QBuQuKt37hVRTfdGAox5sqP37WFVYXU628STAhCNkVRZcSNgUww4=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr21584489otg.232.1573472486652; 
 Mon, 11 Nov 2019 03:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20191104151137.81931-1-clement.deschamps@greensocs.com>
In-Reply-To: <20191104151137.81931-1-clement.deschamps@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 11:41:15 +0000
Message-ID: <CAFEAcA93tmw3GJWz-7hrLAc3YSzfDtTwNL-GY9OoeUBDcGHNqw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: Set NSACR.{CP11,
 CP10} in dummy SMC setup routine
To: Clement Deschamps <clement.deschamps@greensocs.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 Nov 2019 at 15:12, Clement Deschamps
<clement.deschamps@greensocs.com> wrote:
>
> Set the NSACR CP11 and CP10 bits, to allow FPU access in Non-Secure state
> when using dummy SMC setup routine. Otherwise an AArch32 kernel will UNDEF as
> soon as it tries to use the FPU.
>
> This fixes kernel panic when booting raspbian on raspi2.
>
> Successfully tested with:
>   2017-01-11-raspbian-jessie-lite.img
>   2018-11-13-raspbian-stretch-lite.img
>   2019-07-10-raspbian-buster-lite.img
>
> See also commit ece628fcf6 that fixes the issue when *not* using the
> dummy SMC setup routine.
>
> Fixes: fc1120a7f5
> Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
> ---
>  hw/arm/boot.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index ef6724960c..8fb4a63606 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -240,6 +240,9 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
>      };
>      uint32_t board_setup_blob[] = {
>          /* board setup addr */
> +        0xee110f51, /* mrc     p15, 0, r0, c1, c1, 2  ;read NSACR */
> +        0xe3800b03, /* orr     r0, #0xc00             ;set CP11, CP10 */
> +        0xee010f51, /* mcr     p15, 0, r0, c1, c1, 2  ;write NSACR */
>          0xe3a00e00 + (mvbar_addr >> 4), /* mov r0, #mvbar_addr */
>          0xee0c0f30, /* mcr     p15, 0, r0, c12, c0, 1 ;set MVBAR */
>          0xee110f11, /* mrc     p15, 0, r0, c1 , c1, 0 ;read SCR */
> --
> 2.23.0

Yep. The boot.c logic sets NSACR.{CP11,CP10} for booting a
Linux kernel unless (a) the board says we should boot the
kernel in Secure mode or (b) this is the primary CPU and
the board requires the board_setup code to run in Secure mode.
In that case the board_setup code must set NSACR in the same
way that it is responsible for dropping down to NS.

This affects highbank and raspi, which are the only boards
that set info->secure_board_setup; both of those use the
arm_write_secure_board_setup_dummy_smc(), so this fix is
all we should need.

I plan to fold in this comment update:

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 7f4d0ca7cdf..ce2b48b88bc 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -107,9 +107,12 @@ struct arm_boot_info {
     void (*write_board_setup)(ARMCPU *cpu,
                               const struct arm_boot_info *info);

-    /* If set, the board specific loader/setup blob will be run from secure
+    /*
+     * If set, the board specific loader/setup blob will be run from secure
      * mode, regardless of secure_boot. The blob becomes responsible for
-     * changing to non-secure state if implementing a non-secure boot
+     * changing to non-secure state if implementing a non-secure boot,
+     * including setting up EL3/Secure registers such as the NSACR as
+     * required by the Linux booting ABI before the switch to non-secure.
      */
     bool secure_board_setup;

and tweak the commit message to mention highbank, when I
apply it to target-arm.next.

thanks
-- PMM

