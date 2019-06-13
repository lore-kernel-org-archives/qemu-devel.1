Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18484C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8ED421743
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2KzPewb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8ED421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQTQ-0008So-Rw
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39963)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbP5f-0001uG-2q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbP5d-0002yT-C2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:44:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbP5d-0002w6-2G
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:44:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so10035859wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bWf86UNpovPCoQpQgWuroPjwHFnqm9AKrsXtUD2nR1U=;
 b=A2KzPewbKXFlYS2zQEIFMrtnqWqQVn7IVvfxJ01XkiIJ/v68mGdkQSHHoTuOM9qVvP
 2r9JjWHYBYgGduuhkpevXsZKcHxoH2z/Pdhtxg5zqyGApTtuvmQDeE9BVE1EIvM70939
 kZB/9NhGDr88a9dEZTNQY+jdTu9Thr2hID0DiewXEvycawmi+RH8WQra8LdELMdwWcrm
 kJ6AvQ9DZI+D5C9QoPRM66BcKTV4KJkKZZze823rad94UJyxqoQJELpK3w3XgkMjOanP
 8n1w5WHb/OgoRlndXRes2izKj4hycvYjOWTS7ziKy70ZXLWqZR9AzkpbKd24VVe/OnfS
 RsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bWf86UNpovPCoQpQgWuroPjwHFnqm9AKrsXtUD2nR1U=;
 b=OETieOHadoKQ4fPpKO8k+0e8oJPl8l2h9xrmFBlbkU9YduLCV5xthLCFadVKpYsTW+
 AxWC9wvRJB/HXKLEspqSBq0u6OjwD1dvoM0aYp3LVUWoFuaL+lfk3GsCr4BPcnnSkt4l
 fMMriBSBjFXoX8kfO8L07Km8pR9dYgeniZNmx62Lr8EUnwPeGfqiFcy8K5MIAnrpiIVZ
 SOqL4kIQVJM1HhTDkWDi3wITExDs/8NJ4lmLV0G2r9lM/zWnTB47kBr5RjNosiXyQk0i
 GmEmIBmqdGOcpguEwctFuTFG0XABytqO2YeyHO1y8YjRcDfL4IvtblWzVPWeFcG862Qf
 KYUg==
X-Gm-Message-State: APjAAAW5uERBeLpp3hq1fWDE556mSnhv8bHs+Z5mUyKB8p04YeBRzEfs
 qIZR1M8OF+JqjgsGrKgmasGsvg==
X-Google-Smtp-Source: APXvYqzwV8WSgo3pZKrOI8moVaxBLpOJ+lL9DOXdQIHVk9QiCwIfFrmkdEnks3ReFwdjEEZAbl6Pjw==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr3542351wmg.54.1560429862551; 
 Thu, 13 Jun 2019 05:44:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s12sm2618649wmh.34.2019.06.13.05.44.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 05:44:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E1EC1FF87;
 Thu, 13 Jun 2019 13:44:21 +0100 (BST)
References: <20190516144733.32399-1-peter.maydell@linaro.org>
 <20190516144733.32399-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190516144733.32399-2-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 13:44:21 +0100
Message-ID: <87k1dpejtm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/arm/boot: Don't assume RAM
 starts at address zero
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

> In the Arm kernel/initrd loading code, in some places we make the
> incorrect assumption that info->ram_size can be treated as the
> address of the end of RAM, as for instance when we calculate the
> available space for the initrd using "info->ram_size - info->initrd_start=
".
> This is wrong, because many Arm boards (including "virt") specify
> a non-zero info->loader_start to indicate that their RAM area
> starts at a non-zero physical address.
>
> Correct the places which make this incorrect assumption.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/boot.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index a830655e1af..0bb9a7d5b5c 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -976,6 +976,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>      int elf_machine;
>      hwaddr entry;
>      static const ARMInsnFixup *primary_loader;
> +    uint64_t ram_end =3D info->loader_start + info->ram_size;
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          primary_loader =3D bootloader_aarch64;
> @@ -1047,8 +1048,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cp=
u,
>          /* 32-bit ARM */
>          entry =3D info->loader_start + KERNEL_LOAD_ADDR;
>          kernel_size =3D load_image_targphys_as(info->kernel_filename, en=
try,
> -                                             info->ram_size - KERNEL_LOA=
D_ADDR,
> -                                             as);
> +                                             ram_end - KERNEL_LOAD_ADDR,=
 as);
>          is_linux =3D 1;
>      }
>      if (kernel_size < 0) {
> @@ -1062,12 +1062,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
>          if (info->initrd_filename) {
>              initrd_size =3D load_ramdisk_as(info->initrd_filename,
>                                            info->initrd_start,
> -                                          info->ram_size - info->initrd_=
start,
> -                                          as);
> +                                          ram_end - info->initrd_start, =
as);
>              if (initrd_size < 0) {
>                  initrd_size =3D load_image_targphys_as(info->initrd_file=
name,
>                                                       info->initrd_start,
> -                                                     info->ram_size -
> +                                                     ram_end -
>                                                       info->initrd_start,
>                                                       as);
>              }


--
Alex Benn=C3=A9e

