Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5189C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A496B2229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5aRxbpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A496B2229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvP0q-0003Sf-Ti
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvP0E-0002gI-JO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvP0D-0002np-BQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:41:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvP0D-0002mf-6C
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:41:29 -0400
Received: by mail-ot1-x342.google.com with SMTP id n5so106934631otk.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=seT5bS1XVLLNb234RRSJDRVSlZw3nYUA98fmigb9IeA=;
 b=X5aRxbpOI1CEgnp9V7XoYAyrqmlXGLr9qvqvG6zIwSxqKFngaL5UGpDW0YRSXx8/Qg
 bkC/oimF+AwUpmyIw5BfAnDpIYtGJ7y9DlhBRMwfh6ZSjXZE3AZjrme3hgHcrpDUpEnt
 pWuYmLkqjKKF8OOq3kX7DvgYhrOZub+qqyUnw4RLTqYy4nWSEzyZbMNXQkt9NXanAmlz
 kb2Oh7YnKPBEOxtxFCToY9ryvhTdutZC8XaSbyH6rTW0Z6Vr6eE0vDXjPQGTbpp7qtj1
 43yuQTIk/+6KZjWvLcUYyF2B3hTek5QVBkIjzgXTetQ81Rb4qaQsnqGlP6aZ8gHDRXxD
 ZBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=seT5bS1XVLLNb234RRSJDRVSlZw3nYUA98fmigb9IeA=;
 b=Yx8oMoES8tCg6LS2vsYK27x+9MfVBDBlQHDqKITPiyBMcLoQEu0LEYUCVe1H92bXjE
 2XHR1SmWFXBhn9YruZpc+ea1JU8E612fXMqbLvqcCkAMF8vc5grK/I68aEptsoG0ohYU
 PnQKUIqlPFb8ndegcTEE0D/TP4+RndzAVU5VJJ/rCtlhR98odA16MiVIKDN5q3YqV8xi
 g9YMbsZo/oagNSpo7YB+WsEsZ84ao4sh1WVLTdj/pTqXiD6uVkCs/HQrPtEb/wFXggr9
 wlgdr5KHGz2Z4+jwBtql6L8tylX0G1/BS/71J/UguFF75t5XMW7wevDdKTCkRr+tbKe1
 dYFg==
X-Gm-Message-State: APjAAAViG+aPkkQ4n5hcKqeUniMm0wxPiwAsEGuDvOeu8ViwKS6Fn7OO
 6ZIZPrEuCFWg7YXpmwCk1slgwlKZxiFXMT2LyInrqA==
X-Google-Smtp-Source: APXvYqz4LKkOHxUDFoAR1p3J08VwHbg6lRm5W27B5Qoy4cqWxWr3fMx4cFyddNkEEJ6sok/ke2h1vQEE5yXzWTp61w0=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr9084343oti.91.1565196088343; 
 Wed, 07 Aug 2019 09:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190807145939.1281-1-palmer@sifive.com>
In-Reply-To: <20190807145939.1281-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 17:41:17 +0100
Message-ID: <CAFEAcA9YeuvQPnvG1+Cdb+-JbsbKaRpa0Frv5zz+Vb3q0prAeQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for 4.1] RISC-V: Ignore the S and U
 extensions when formatting ISA strings
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 at 16:02, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The ISA strings we're providing from QEMU aren't actually legal RISC-V
> ISA strings, as both the S and U extensions cannot exist as
> single-letter extensions and must instead be multi-letter strings.
> We're still using the ISA strings inside QEMU to track the availiable
> extensions, so this patch just strips out the S and U extensions when
> formatting ISA strings.
>
> This boots Linux on top of 4.1-rc3, which no longer has the U extension
> in /proc/cpuinfo.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
> This is another late one, but I'd like to target it for 4.1 as we're
> providing illegal ISA strings and I don't want to bake that into a bunch
> of other code.
> ---
>  target/riscv/cpu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20ad7..4df14433d789 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -501,7 +501,22 @@ char *riscv_isa_string(RISCVCPU *cpu)
>      char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
>      for (i = 0; i < sizeof(riscv_exts); i++) {
>          if (cpu->env.misa & RV(riscv_exts[i])) {
> -            *p++ = qemu_tolower(riscv_exts[i]);
> +            char lower = qemu_tolower(riscv_exts[i]);
> +            switch (lower) {
> +            case 's':
> +            case 'u':
> +                /*
> +                 * The 's' and 'u' extensions shouldn't be passed in the device
> +                 * tree, but we still use them internally to track extension
> +                 * sets.  Here we just explicitly remove them when formatting
> +                 * an ISA string.
> +                 */
> +                break;
> +
> +            default:
> +                *p++ = qemu_tolower(riscv_exts[i]);

 *p++ = lower;  ?

thanks
-- PMM

