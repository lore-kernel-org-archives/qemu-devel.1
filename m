Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98300C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67135206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpLqZ7+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67135206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6s1-0002PC-J7
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6rQ-0001lo-0j
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs6rO-0000QL-L5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:42:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs6rO-0000Pd-Fr
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:42:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so56750420otq.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sN+B8p3nt+elIHLIEIxGmV1cowNIOR5qOFD2eryaUOE=;
 b=ZpLqZ7+mr16jZy6lWFjcr+TelKJWl9614jdeC/BErJZKX7ooooEXVeEFvTDS4t6XOg
 lz2cqZAyxcRRjT1p1R+0q6PZZ0av6kHtq0H4GPtcVzD5EvLW71+ew7jS1WivA3ZSItis
 COVcCmB1WG+QAjIFc+OUbbbJeHjsruO8Fy+iS8cCGuK36qndyDteLVqZ02LumOTVs+I2
 4mqAoBbM6POxo/cmkj2m3DKi6l/t5cOYUDnI7lwDRiXUiMhbhuEzTm48pQgNqYAJz1x3
 tMxCq8Y7LnFa1+zezBOlvwZAcBULYuOz2VBIInP+E1+hUHezV636fXNOnIJ9TS4eitYS
 IA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sN+B8p3nt+elIHLIEIxGmV1cowNIOR5qOFD2eryaUOE=;
 b=m5yseqnTfap2XljHQMohz6U8z/8+g3AfQlp95Ua7yBG4TQbYVUH2kM3TlalNMfb8Xp
 3SIuqu4J+fk0Yy4eUQfC0UVCF/JTBoVbJFYukw52L2UOjO91+6D58yh1t2ztFLyADCeG
 OP6QubarR/HAjUvhGvk1i1WhmOVgCVIeaujzuIb3IAQtcvBFdvj4FVOOY5r7ABbtNfOI
 qPYg3JC6OPOhei/9GSjkiVigsF42JLMptQCJ3iQItx+Tw5pm7XcMTXTo0rpqsTI4K+dA
 O6+8gkrQzpAxtppsHGCTsw6CscrNIU9H/nsLyj0NxZZDTOTdb29fbZLQpr2GwitQZBjY
 iYXg==
X-Gm-Message-State: APjAAAUbdy3gPZuD/hIureYzM03szyKqxJQ4Cpp54QZmz3v0tgs3fPLf
 mGpaOyO0m+bPMG/6oS/u3AFosr0RigN8gd0SuFgsXg==
X-Google-Smtp-Source: APXvYqzSK+LaWBoH4zBo4atgXa0APGABiUIpgZV84J7J7U4hZ/sOPvN7osp63+qs2QVlhuMp3Sx57Hd4dgNNn7agMkc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr23340197oti.91.1564411365349; 
 Mon, 29 Jul 2019 07:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 15:42:34 +0100
Message-ID: <CAFEAcA82MOZ4ZJmQtte=LchMGT9grkWKBUwxPe9GMMRgh-wR-g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
 decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the infrastructure that will become the new decoder.
> No instructions adjusted so far.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c       | 45 +++++++++++++++++++++++++++++++++++-
>  target/arm/Makefile.objs     | 18 +++++++++++++++
>  target/arm/a32-uncond.decode | 23 ++++++++++++++++++
>  target/arm/a32.decode        | 23 ++++++++++++++++++
>  target/arm/t32.decode        | 20 ++++++++++++++++
>  5 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/a32-uncond.decode
>  create mode 100644 target/arm/a32.decode
>  create mode 100644 target/arm/t32.decode
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 36419025db..4738b91957 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7715,6 +7715,33 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
>      }
>  }
>
> +/*
> + * Include the generated decoders.
> + * Note that the T32 decoder reuses some of the trans_* functions
> + * initially declared by the A32 decoder, which results in duplicate
> + * declaration warnings.  Suppress them.
> + */
> +
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic push
> +# pragma GCC diagnostic ignored "-Wredundant-decls"
> +# ifdef __clang__
> +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> +# endif
> +#endif
> +
> +#include "decode-a32.inc.c"
> +#include "decode-a32-uncond.inc.c"
> +#include "decode-t32.inc.c"
> +
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic pop
> +#endif

I'm not a great fan of having to use the diagnostic pragmas --
they seem a bit ugly and not very robust. Is this the only way?

> +
> +/*
> + * Legacy decoder.
> + */
> +
>  static void disas_arm_insn(DisasContext *s, unsigned int insn)
>  {
>      unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
> @@ -7733,7 +7760,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>          return;
>      }
>      cond = insn >> 28;
> -    if (cond == 0xf){
> +
> +    if (cond == 0xf) {
>          /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
>           * choose to UNDEF. In ARMv5 and above the space is used
>           * for miscellaneous unconditional instructions.

This whitespace fixup should probably be in its own patch.

> @@ -7741,6 +7769,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>          ARCH(5);
>
>          /* Unconditional instructions.  */
> +        if (disas_a32_uncond(s, insn)) {
> +            return;
> +        }
> +        /* fall back to legacy decoder */
> +
>          if (((insn >> 25) & 7) == 1) {
>              /* NEON Data processing.  */
>              if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> @@ -7953,6 +7986,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>
>      arm_skip_unless(s, cond);
>
> +    if (disas_a32(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      if ((insn & 0x0f900000) == 0x03000000) {
>          if ((insn & (1 << 21)) == 0) {
>              ARCH(6T2);
> @@ -9440,6 +9478,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>          ARCH(6T2);
>      }
>
> +    if (disas_t32(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      rn = (insn >> 16) & 0xf;
>      rs = (insn >> 12) & 0xf;
>      rd = (insn >> 8) & 0xf;

> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> new file mode 100644
> index 0000000000..2d84a02861
> --- /dev/null
> +++ b/target/arm/a32.decode
> @@ -0,0 +1,23 @@
> +# A32 conditional instructions
> +#
> +#  Copyright (c) 2019 Linaro, Ltd
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/licenses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
> +# All of the insn that have a COND field in insn[31:28] are here.
> +# All insns that have 0xf in insn[31:28] are in a32u.decode.

"a32-uncond.decode"

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

