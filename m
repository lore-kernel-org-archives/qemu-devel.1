Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A1C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB3320679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qASDpPRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB3320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQLL-0003Wz-JO
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPEb-0000QO-1Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPEZ-0002er-PA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:53:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPEZ-0002de-Dk
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:53:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id k11so2488617wrl.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AIb1WKsTOi8bJgkrxKedSjdxQTfUUDhKhIP+0sv0Jz0=;
 b=qASDpPRIdojCF4v//w3qlYWN1elv9kMJ5QoK0ETF0u6PJV4NkLpDxMFGo5i7HmmrV7
 GP5p+b9wupHDZWMUu1OnPkJwXlIiYThJFQVH6gn+ERqecJBUqTen99APgNhj1uDB1GKu
 M+01FUZheYPo2ndMZi0gOao1sDSRw4q30/kVwtMtvKU9B1mZtuLLKj2nuCpS5TcaMCyn
 1+aAQ5TaYomDFczaJJqFvrZ5LM5MkdvGPiCxGO9lmyLeaJFydPuc0gpDvU1O+KdeEEcG
 pAy1tAufc3QrouVqati43TYEQNJRXmPHIFTMbptnvJW3jZsHRhbGYkUNqfZgOACgSD0S
 54Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AIb1WKsTOi8bJgkrxKedSjdxQTfUUDhKhIP+0sv0Jz0=;
 b=IIh7u+bypyJftbW22uDUdxrBcgYErw2R4tp/H8ody14ZNSHkUF+OJ6hHiIBumouH/9
 jIsctZQPhgNpTQUGWxSvRS0akHszTx9crRnLdhPjc8JX+EMrWggYKB4Ec1cZPkWdsA77
 Ftu8d6PXUxST815ULNIUlUeZe83osISeI/R1TXLVjoGJI22HSbQIYBZfhzVCG0QCMcjF
 bsHdt+D06kFKVKPCp38V7O0PrV6Se0qShB2R2NGl+BG8X5BKxiqo+lbAzy7Lt+hayEvt
 3zbiZX7ECMSvJi8xaL1ugoVvKNPmnxg3MUb4Jahgurb8TnpJncUtrZUd8bPlS3DQEU5d
 9TKA==
X-Gm-Message-State: APjAAAWHucfzCi4jLAGW8Fo6UL3eAGJi/shDRTmj3nq7Et/PTBc35XA7
 BC+p0H0dGht6nCr3S0UGjTdmWQ==
X-Google-Smtp-Source: APXvYqzyDiT+Q245Tvnbbfi8irOzS+SxLoSDeIFfHIVj+LZFWkgrvT45JhoSYYqrx3Yk/z1h7+nX7A==
X-Received: by 2002:a5d:6ad2:: with SMTP id u18mr9137311wrw.63.1560430417943; 
 Thu, 13 Jun 2019 05:53:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x11sm3801650wmg.23.2019.06.13.05.53.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 05:53:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EDEC91FF87;
 Thu, 13 Jun 2019 13:53:36 +0100 (BST)
References: <20190516144733.32399-1-peter.maydell@linaro.org>
 <20190516144733.32399-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190516144733.32399-4-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 13:53:36 +0100
Message-ID: <87h88teje7.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 3/4] hw/arm/boot: Avoid
 placing the initrd on top of the kernel
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> We currently put the initrd at the smaller of:
>  * 128MB into RAM
>  * halfway into the RAM
> (with the dtb following it).
>
> However for large kernels this might mean that the kernel
> overlaps the initrd. For some kinds of kernel (self-decompressing
> 32-bit kernels, and ELF images with a BSS section at the end)
> we don't know the exact size, but even there we have a
> minimum size. Put the initrd at least further into RAM than
> that. For image formats that can give us an exact kernel size, this
> will mean that we definitely avoid overlaying kernel and initrd.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  hw/arm/boot.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 935be3b92a5..e441393fdf5 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -999,20 +999,6 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>      if (info->nb_cpus =3D=3D 0)
>          info->nb_cpus =3D 1;
>
> -    /*
> -     * We want to put the initrd far enough into RAM that when the
> -     * kernel is uncompressed it will not clobber the initrd. However
> -     * on boards without much RAM we must ensure that we still leave
> -     * enough room for a decent sized initrd, and on boards with large
> -     * amounts of RAM we must avoid the initrd being so far up in RAM
> -     * that it is outside lowmem and inaccessible to the kernel.
> -     * So for boards with less  than 256MB of RAM we put the initrd
> -     * halfway into RAM, and for boards with 256MB of RAM or more we put
> -     * the initrd at 128MB.
> -     */
> -    info->initrd_start =3D info->loader_start +
> -        MIN(info->ram_size / 2, 128 * 1024 * 1024);
> -
>      /* Assume that raw images are linux kernels, and ELF images are not.=
  */
>      kernel_size =3D arm_load_elf(info, &elf_entry, &elf_low_addr,
>                                 &elf_high_addr, elf_machine, as);
> @@ -1064,6 +1050,26 @@ static void arm_setup_direct_kernel_boot(ARMCPU *c=
pu,
>      }
>
>      info->entry =3D entry;
> +
> +    /*
> +     * We want to put the initrd far enough into RAM that when the
> +     * kernel is uncompressed it will not clobber the initrd. However
> +     * on boards without much RAM we must ensure that we still leave
> +     * enough room for a decent sized initrd, and on boards with large
> +     * amounts of RAM we must avoid the initrd being so far up in RAM
> +     * that it is outside lowmem and inaccessible to the kernel.
> +     * So for boards with less  than 256MB of RAM we put the initrd
> +     * halfway into RAM, and for boards with 256MB of RAM or more we put
> +     * the initrd at 128MB.
> +     * We also refuse to put the initrd somewhere that will definitely
> +     * overlay the kernel we just loaded, though for kernel formats which
> +     * don't tell us their exact size (eg self-decompressing 32-bit kern=
els)
> +     * we might still make a bad choice here.
> +     */
> +    info->initrd_start =3D info->loader_start +
> +        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
> +    info->initrd_start =3D TARGET_PAGE_ALIGN(info->initrd_start);
> +
>      if (is_linux) {
>          uint32_t fixupcontext[FIXUP_MAX];


--
Alex Benn=C3=A9e

