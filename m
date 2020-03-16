Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E50C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2885320658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cimJ94KA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2885320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsXU-0002i8-At
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDq7c-0001r4-2R
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDq7a-0005m7-Ub
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:49:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDq7a-0005eK-Ld
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:49:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id d62so17751682oia.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0BPAOx1/3Y43ZDSJ8uw6g5y1l1TmUkqMPb5e7PhkswE=;
 b=cimJ94KAHgRlJsFyrs6LXutuGxspRTOuybbi9s3moNs0h/+90gGAOluRkyTowoh9cs
 OnSVzL/8f9NolP1aCgL+HXLNCFAC5JfpaHWbnJ2hStICc/ZJ7FyO9HQEgCTry2CpXHaq
 Uwd9ngxb0/0AMcaRK16ydU7YI0XnqjlGBHk5JRHjQhVcCAD26NnrbxrXglpQvEXbPMVQ
 2xm0KVAQo+JvZNpHzcy0HYR3DL19O+FFip1Wsn3OJrs/s8JLU/Yf9WnpLkWKs0vAPDZH
 H+S1+NehcmkXKWpu2X8sMUcWAWevAaRkxU1S9F5MzRBPB1Ai7JPFVcr3d82ghIz0Ncu6
 NESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0BPAOx1/3Y43ZDSJ8uw6g5y1l1TmUkqMPb5e7PhkswE=;
 b=RH+MtVaWjN8+Fnl7mdhsKNa4kdWZLTBC6IpT29izekW23Pk4X0IygfBPQ3HNaSDPrV
 oCZHKPvGWnJiCgVr/ojgNJG59+HoX5xI6LylDD2u2yhYyC3rqXXB2OKUbBaYqD4/4Oo7
 2ty5OLgET4aH95yzqGk/mvLmaLm/HAOCOaL43b0izb4sbIPJ7/OXr8R54BY5kuAtCvE7
 eIYpMuR5AfUc7XVr20VypGePUP54LrYmtD0BymFnf1km6g6xYJfJylCuVRAkcLRYu7CA
 IgaQz0thiJ733AIsUQx18gS45mDa1f4fqcvJE41Avi4IWEVYqFd62VuHBIhshgvgK7Ts
 dlGw==
X-Gm-Message-State: ANhLgQ2je73BzdFou8mpIg9h08x4USr4a6X2PdTq5vYh39r89XEKoPyJ
 E50O9v+3yITnhcUjM4i3I/gUJM9u/Xu2+XzdSi8DFg==
X-Google-Smtp-Source: ADFU+vt/QED6DsSfKGm+fDkzvJQnEVoxo4uf/dxDx7YElNnMINxMB+74+rqO7iByD4LEo9ntaT2Tm6565Y91iKgKUvE=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr16680662oib.146.1584366573501; 
 Mon, 16 Mar 2020 06:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-12-philmd@redhat.com>
In-Reply-To: <20200316120049.11225-12-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 13:49:22 +0000
Message-ID: <CAFEAcA-jidDwoZCgf+xKjqHm8xo87iGr6pGtOcWp5iAcWrHETQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] hw/semihosting: Make the feature depend of TCG, and
 allow to disable it
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 13:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The semihosting feature is only meaningful when using TCG.
>
> So far only the ARM/MIPS/LM32 provide the semihosting feature.

Also m68k, nios2, xtensa. riscv eventually but not yet upstream.

>
> Do not enable it by default, and let the few targets requiring
> it to manually select it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/semihosting/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
> index efe0a30734..06e9262af2 100644
> --- a/hw/semihosting/Kconfig
> +++ b/hw/semihosting/Kconfig
> @@ -1,3 +1,5 @@
>
>  config SEMIHOSTING
> -       bool
> +    bool
> +    depends on TCG
> +    default n

OK, this is the "do not enable by default" -- where is
the "but do enable by default for the targets that use it"
part of the config change ?

thanks
-- PMM

