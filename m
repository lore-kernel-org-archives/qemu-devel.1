Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77838C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BE720B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMd5Ozrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BE720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQa4-00042j-HI
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbP9C-0004KE-SQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbP9B-00063N-7r
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:48:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbP99-00060N-BP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:48:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so20637674wrm.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+sPrlQBSejOtMk2OomKgV+4pROv1OHc9FKMYuqyMSIc=;
 b=MMd5OzrmDExwkKSnC/kRtmChRXk4opDc1gaolSNRT+6lJYnEXBVGY/KDGAeJNN3czT
 QE9uT6P8pLhteAE7EY7qUec6sAeEI4UHGlOO9DvyLv2x8LAKgDt8eQTSnd8Uzwo2iY6/
 QbwVNoGtzk6FBTVD5pMtYyyIadUex6/BhqBkPVYDgc/LTBbDfVW+VSRX5AfW7BG+x8lg
 FlytxZ0P05uyF45DJlghzElKgQPwnSWj+u9P//53Q6IJ+tdbTmBZxO9BqfYBEvhUY4oW
 OQ17MEmqKetLBrW/bym/mewkKxQm5TXLogDoLZm8rtCTgaugH5r3y3hPdZv8W111x1Me
 zmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+sPrlQBSejOtMk2OomKgV+4pROv1OHc9FKMYuqyMSIc=;
 b=XrDkKU+hP7EUJv8m4Hwkz9Nx2ZDS304BxNCwi8UXRlGy3U93OvKOHdQirNQwQN17Mu
 m9ubN2XlUZLjevtkpmGYtk4Es1hROT6JX+tKS7wtYfW4zLURFIPuskq7je7AfFGjw/yf
 nNiA6vz/DzBIpj5M6O8QUE1D5tLaqEyWYBQturCxPswY1ML6A+Gt5UQivBlqcJ29Mjlt
 RUkqeGhHP3qbXFNASEG7Gtjs0kTtbUPhYYM9bondhobDfumBgkhm3u/3LAdJTMvo2/HZ
 p9tA2T+kJdrA0zbXstx8yG7Qaaz2iO9Pgq92TCVblFTYBQtT7RKL2SME4QYPDWAU+Rom
 GKFw==
X-Gm-Message-State: APjAAAXqg5sw04DY2UgKbwtT+ccy2528Unl91iTo4r2VYbt00ZXTyjNI
 3L9FhCau3q0nzUc6d03PO4pzyA==
X-Google-Smtp-Source: APXvYqw4MBn+9sUvyWO9diOYuK+aSzMS8iynObWujULU3C4yp9aQCm+0aawA2PMhBY5RoAw63fHp0A==
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr10049966wrw.98.1560430080879; 
 Thu, 13 Jun 2019 05:48:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t140sm6040929wmt.0.2019.06.13.05.48.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 05:48:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D14631FF87;
 Thu, 13 Jun 2019 13:47:59 +0100 (BST)
References: <20190516144733.32399-1-peter.maydell@linaro.org>
 <20190516144733.32399-3-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190516144733.32399-3-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 13:47:59 +0100
Message-ID: <87imt9ejnk.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/arm/boot: Diagnose layouts that
 put initrd or DTB off the end of RAM
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

> We calculate the locations in memory where we want to put the
> initrd and the DTB based on the size of the kernel, since they
> come after it. Add some explicit checks that these aren't off the
> end of RAM entirely.
>
> (At the moment the way we calculate the initrd_start means that
> it can't ever be off the end of RAM, but that will change with
> the next commit.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/boot.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 0bb9a7d5b5c..935be3b92a5 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1055,11 +1055,25 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
>          error_report("could not load kernel '%s'", info->kernel_filename=
);
>          exit(1);
>      }
> +
> +    if (kernel_size > info->ram_size) {
> +        error_report("kernel '%s' is too large to fit in RAM "
> +                     "(kernel size %d, RAM size %" PRId64 ")",
> +                     info->kernel_filename, kernel_size, info->ram_size);
> +        exit(1);
> +    }
> +
>      info->entry =3D entry;
>      if (is_linux) {
>          uint32_t fixupcontext[FIXUP_MAX];
>
>          if (info->initrd_filename) {
> +
> +            if (info->initrd_start >=3D ram_end) {
> +                error_report("not enough space after kernel to load init=
rd");
> +                exit(1);
> +            }
> +
>              initrd_size =3D load_ramdisk_as(info->initrd_filename,
>                                            info->initrd_start,
>                                            ram_end - info->initrd_start, =
as);
> @@ -1075,6 +1089,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *c=
pu,
>                               info->initrd_filename);
>                  exit(1);
>              }
> +            if (info->initrd_start + initrd_size > info->ram_size) {
> +                error_report("could not load initrd '%s': "
> +                             "too big to fit into RAM after the kernel",
> +                             info->initrd_filename);
> +            }
>          } else {
>              initrd_size =3D 0;
>          }
> @@ -1110,6 +1129,10 @@ static void arm_setup_direct_kernel_boot(ARMCPU *c=
pu,
>              /* Place the DTB after the initrd in memory with alignment. =
*/
>              info->dtb_start =3D QEMU_ALIGN_UP(info->initrd_start + initr=
d_size,
>                                             align);
> +            if (info->dtb_start >=3D ram_end) {
> +                error_report("Not enough space for DTB after kernel/init=
rd");
> +                exit(1);
> +            }
>              fixupcontext[FIXUP_ARGPTR_LO] =3D info->dtb_start;
>              fixupcontext[FIXUP_ARGPTR_HI] =3D info->dtb_start >> 32;
>          } else {


--
Alex Benn=C3=A9e

