Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE8C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F038D229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaM9Y9W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F038D229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxOI-00062T-Ua
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53575)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqxO0-0005Nf-4G
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqxNw-00085h-O7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:23:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqxNw-0007q7-H3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:23:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so53959578wru.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5syRzHBd0hS1eg74YAUjS6Fm6x06oZRpisifNi6S0Wk=;
 b=CaM9Y9W+FHaRlGFImXf8rhdxt9QoxoYG242BWpbtbkCDucbbKYgzLI3CzCgc2ylrW2
 iTDBl10nMqOq/iIRKPVneDNOIegoQAc8zGKV6luMAURjs5SsvRUmvykO25Yatrv801i4
 NwEXSVT1EROrw+bAqqVrOe/Yfh6ny+/BV+LmiysKGi+X+EV1efRQzvuN4QOFMs3aGIDh
 YIoHgpaBBT8z4IH4P1Wd/+DqdniBldtIh0rbx3NRhYGhtWy8SEjqKWgE5g1SYgom1Gcy
 r09nldXgT39scZp+lbOrvnFQt6QMfEfl1YZrHHfAsSUeDVCTgDoyT474G33GRpigAL9R
 ytTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5syRzHBd0hS1eg74YAUjS6Fm6x06oZRpisifNi6S0Wk=;
 b=VxTvgAHn5qHrouOF1lCEVBoRn7a5nmFmd1bstJKI7+yi3QxNGv076mlhkhfRXsSzKi
 iR4vO/HaAX7d5KNP/YgYUoUYXkwItkOyUEbTeR296dcJwSpPU0QRDqvrJWLUcI+ue/93
 +O1daPZbKBuFYCXuFVYMdF7c2r+evM1rWEJfiW6UaJ5ln/QwcM43SEpXkIMET+i+H/2W
 fHnmdObJUJ1brgdy11MJzOMYIk2H5Wod4Z2PGP0Z4FZ/jMzrVFRmScxyObDAfrspBMCw
 XOxjRMcDTpGe7bD/Iz/yRLsphJuAh/ROGBPKNJ0pmY26S69keZwoR9excf/n6CIs7C96
 tYuw==
X-Gm-Message-State: APjAAAWBUGkWKv+2C9gzTAU725eKvIXfeNipq7fUxQkBu+fDd42Bhm0U
 mE+mWb7cWExnHCLo46nRjakYJA==
X-Google-Smtp-Source: APXvYqxH2ZJKhp5CkHx5DcRGVb+oGi8qzc08bahxwC2HHRYGsg0A+SPXTdpDK4qouQ73M0NY+3f2ow==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr14059202wrp.245.1564136611986; 
 Fri, 26 Jul 2019 03:23:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c1sm113811536wrh.1.2019.07.26.03.23.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 03:23:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 097981FF87;
 Fri, 26 Jul 2019 11:23:31 +0100 (BST)
References: <20190722151804.25467-1-peter.maydell@linaro.org>
 <20190722151804.25467-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190722151804.25467-3-peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 11:23:30 +0100
Message-ID: <87wog5gkm5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.1? 2/2] hw/arm/boot: Further improve
 initrd positioning code
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
Cc: Mark Rutland <mark.rutland@arm.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> In commit e6b2b20d9735d4ef we made the boot loader code try to avoid
> putting the initrd on top of the kernel.  However the expression used
> to calculate the start of the initrd:
>
>     info->initrd_start =3D info->loader_start +
>         MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
>
> incorrectly uses 'kernel_size' as the offset within RAM of the
> highest address to avoid.  This is incorrect because the kernel
> doesn't start at address 0, but slightly higher than that.  This
> means that we can still incorrectly end up overlaying the initrd on
> the kernel in some cases, for example:
>
> * The kernel's image_size is 0x0a7a8000
> * The kernel was loaded at   0x40080000
> * The end of the kernel is   0x4A828000
> * The DTB was loaded at      0x4a800000
>
> To get this right we need to track the actual highest address used
> by the kernel and use that rather than kernel_size. We already
> set image_low_addr and image_high_addr for ELF images; set them
> also for the various other image types we support, and then use
> image_high_addr as the lowest allowed address for the initrd.
> (We don't use image_low_addr, but we set it for consistency
> with the existing code path for ELF files.)
>
> Fixes: e6b2b20d9735d4ef
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/boot.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index b7b31753aca..c2b89b3bb9b 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -988,7 +988,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>      int is_linux =3D 0;
>      uint64_t elf_entry;
>      /* Addresses of first byte used and first byte not used by the image=
 */
> -    uint64_t image_low_addr, image_high_addr;
> +    uint64_t image_low_addr =3D 0, image_high_addr =3D 0;
>      int elf_machine;
>      hwaddr entry;
>      static const ARMInsnFixup *primary_loader;
> @@ -1041,17 +1041,29 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
>          uint64_t loadaddr =3D info->loader_start + KERNEL_NOLOAD_ADDR;
>          kernel_size =3D load_uimage_as(info->kernel_filename, &entry, &l=
oadaddr,
>                                       &is_linux, NULL, NULL, as);
> +        if (kernel_size >=3D 0) {
> +            image_low_addr =3D loadaddr;
> +            image_high_addr =3D image_low_addr + kernel_size;
> +        }
>      }
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
>          kernel_size =3D load_aarch64_image(info->kernel_filename,
>                                           info->loader_start, &entry, as);
>          is_linux =3D 1;
> +        if (kernel_size >=3D 0) {
> +            image_low_addr =3D entry;
> +            image_high_addr =3D image_low_addr + kernel_size;
> +        }
>      } else if (kernel_size < 0) {
>          /* 32-bit ARM */
>          entry =3D info->loader_start + KERNEL_LOAD_ADDR;
>          kernel_size =3D load_image_targphys_as(info->kernel_filename, en=
try,
>                                               ram_end - KERNEL_LOAD_ADDR,=
 as);
>          is_linux =3D 1;
> +        if (kernel_size >=3D 0) {
> +            image_low_addr =3D entry;
> +            image_high_addr =3D image_low_addr + kernel_size;
> +        }
>      }
>      if (kernel_size < 0) {
>          error_report("could not load kernel '%s'", info->kernel_filename=
);
> @@ -1083,7 +1095,10 @@ static void arm_setup_direct_kernel_boot(ARMCPU *c=
pu,
>       * we might still make a bad choice here.
>       */
>      info->initrd_start =3D info->loader_start +
> -        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
> +        MIN(info->ram_size / 2, 128 * 1024 * 1024);
> +    if (image_high_addr) {
> +        info->initrd_start =3D MAX(info->initrd_start, image_high_addr);
> +    }
>      info->initrd_start =3D TARGET_PAGE_ALIGN(info->initrd_start);
>
>      if (is_linux) {


--
Alex Benn=C3=A9e

