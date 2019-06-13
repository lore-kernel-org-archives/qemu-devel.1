Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730AC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDFB20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMnS37uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDFB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQ81-0001GG-Kd
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPGN-0002fg-8N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPGL-0004MB-Md
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:55:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPGL-0004LH-CL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:55:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so20717451wrs.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+F2TWhc+HKNyKWIdddihUlH8b9oXFudISMexw7IvKJQ=;
 b=ZMnS37ufYRHiXBPVxJl8oDVVMyY8uMNrvSfYBLPZI4Fbj+XXoNdisd2pkjMnGepoBe
 wfD8IvH9q1IIM5bpvW1guTG4zY5ImQ82jw8L74UE7UCLGQr1+QA+j14ygTuvSTWo9Aju
 DmRUMOGFLCeMxf2BYrZyRfEAb3iNGs9eHuoRs/L2JiaGwzNRsBK5goSQ3qRyynvM9PJ7
 eajtM9aUPBl57pZDt7XVvJTijl5iqouEmIPgdVTZHZFSV3pYDfneZGPRaA8y7Tk6G+S0
 bxBeF3K5/zPycx8XJYGMKttZkn4La4kWD7YM4PnFoxL1hhYwoFigJvo6U25Z//5N58gF
 EaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+F2TWhc+HKNyKWIdddihUlH8b9oXFudISMexw7IvKJQ=;
 b=R8z5oe3tHK4T/k/4O+Vyq86vnMo+Cr8mMjEZDwU2ip51S/76IrX7R3cHEYRnshfBe2
 v6VZIQeKQvxj7bgxyMQKqRHL0T6Oe7HpG7uUj4RBrBrvKsqEqd/NMAWil5ra+I2Bp52c
 cJFpwFCxneC/65ECqJyUf9bYarktvnXyR33ebl7KFJSRaLZyjufgnMMAfa9XH4A2Dgmy
 wBveISi5R6x/TellqJC5XyBuICnskv9Zr4Lov55Z/l+j/uxinjehyeoAh121CbapgHUs
 lMebDlWrZcWJGzwL/Hp7HixGNcLflPyH9msUwk4jvPoo3epNlrDTNGA/GjQHfX8uc48m
 AkeA==
X-Gm-Message-State: APjAAAUbtOicx48k5nE3nSdzSEZYIJIMevD/X2MyfvmfwaairUMLruYT
 FtfEqJ9nIRUxjWrdy3NMovkilg==
X-Google-Smtp-Source: APXvYqxPN1HC+WE40LmIKlLF7SyxDOY70O2zWJyZTQy0MMShdQbdRPvXZ2/kHvscopGp3/EMoL7jng==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr59082978wrs.105.1560430528359; 
 Thu, 13 Jun 2019 05:55:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 67sm3144252wmd.38.2019.06.13.05.55.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 05:55:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 61B421FF87;
 Thu, 13 Jun 2019 13:55:27 +0100 (BST)
References: <20190516144733.32399-1-peter.maydell@linaro.org>
 <20190516144733.32399-5-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190516144733.32399-5-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 13:55:27 +0100
Message-ID: <87ftodejb4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/arm/boot: Honour image size
 field in AArch64 Image format kernels
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

> Since Linux v3.17, the kernel's Image header includes a field image_size,
> which gives the total size of the kernel including unpopulated data
> sections such as the BSS). If this is present, then return it from
> load_aarch64_image() as the true size of the kernel rather than
> just using the size of the Image file itself. This allows the code
> which calculates where to put the initrd to avoid putting it in
> the kernel's BSS area.
>
> This means that we should be able to reliably load kernel images
> which are larger than 128MB without accidentally putting the
> initrd or dtb in locations that clash with the kernel itself.
>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1823998
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/boot.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index e441393fdf5..fc6f37ba6cf 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -910,6 +910,7 @@ static uint64_t load_aarch64_image(const char *filena=
me, hwaddr mem_base,
>                                     hwaddr *entry, AddressSpace *as)
>  {
>      hwaddr kernel_load_offset =3D KERNEL64_LOAD_ADDR;
> +    uint64_t kernel_size =3D 0;
>      uint8_t *buffer;
>      int size;
>
> @@ -937,7 +938,10 @@ static uint64_t load_aarch64_image(const char *filen=
ame, hwaddr mem_base,
>           * is only valid if the image_size is non-zero.
>           */
>          memcpy(&hdrvals, buffer + ARM64_TEXT_OFFSET_OFFSET, sizeof(hdrva=
ls));
> -        if (hdrvals[1] !=3D 0) {
> +
> +        kernel_size =3D le64_to_cpu(hdrvals[1]);
> +
> +        if (kernel_size !=3D 0) {
>              kernel_load_offset =3D le64_to_cpu(hdrvals[0]);
>
>              /*
> @@ -955,12 +959,21 @@ static uint64_t load_aarch64_image(const char *file=
name, hwaddr mem_base,
>          }
>      }
>
> +    /*
> +     * Kernels before v3.17 don't populate the image_size field, and
> +     * raw images have no header. For those our best guess at the size
> +     * is the size of the Image file itself.
> +     */
> +    if (kernel_size =3D=3D 0) {
> +        kernel_size =3D size;
> +    }
> +
>      *entry =3D mem_base + kernel_load_offset;
>      rom_add_blob_fixed_as(filename, buffer, size, *entry, as);
>
>      g_free(buffer);
>
> -    return size;
> +    return kernel_size;
>  }
>
>  static void arm_setup_direct_kernel_boot(ARMCPU *cpu,


--
Alex Benn=C3=A9e

