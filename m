Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F1FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C87B2072C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU72Uekj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C87B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO1qC-0005aQ-HN
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jO1p4-0004R5-By
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jO1p3-0002Gy-Aa
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:20:34 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:46055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jO1p3-0002G8-5p; Mon, 13 Apr 2020 12:20:33 -0400
Received: by mail-il1-x141.google.com with SMTP id i2so8124095ils.12;
 Mon, 13 Apr 2020 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FrlZ2Og4Gk2rDGcvN4xoQ+RCSEwEyV8v9+mVj65fNVY=;
 b=aU72UekjHI2jP8suG7Hx2B+ZZYabYxmgjehwnc45drjHkuZmnm+ckS7gc/MSLOlKnY
 XzhRrK/D0rvvU/19gqmrEC0lCf2QTVr69rpXMeKqf5U4xTUMiUFxHyi2mSTnevWMcDFU
 HcgCkgZx9XF3xR+e/v1opxesxSeZcCTYTHVBsOxXKqz86DPpSdgKDtuy9tQge4mK166b
 8d59wHiMTCGW1UWmaT63U/3yFIgaCmBFHvBxHX6JItI4cS5jMrzQ0oVuzpXT0MVNxEGi
 zraJRyx04Ix0/XW2vaNjzhaOdvErCqL5oRBBDMMyHk2WqwRFrN/SLelllnMEWWcGfggj
 fF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FrlZ2Og4Gk2rDGcvN4xoQ+RCSEwEyV8v9+mVj65fNVY=;
 b=q6V1plYVtALD6rpYmRIgwEv0RAE4qTGoIT9giTnd2B2dtYDd2KeimSvpGQav2sVdFZ
 JEmMnzEBhRu+SIjz1OPJC4nKtoZhcWei42ESZxcR3Qd1JB1/na0apW95Rk3U5I3sqLzV
 vv/rOaVcFydsfTXYpEr3WGCanTqP4cqoPkR2U0w0XIt7w+ofevG/nc4Gx1GWH1q3eUx3
 cUQxrDa1BwQQo0npTSzTSKf6RYPPwkT4E+XKmMfvB8B5wEZvERxrufcmmV0N47t6vHq3
 O3Qmw2bDTguVd8Q8MHrDsIwZh6orQTHw+D2uZ4WQ3vHjYAJLaVYgrirOVBi9zh3g5d1h
 oPOQ==
X-Gm-Message-State: AGi0PuZV9dhEKA+sl/7++gLZluySvrIZfg/U08KZdi/+486gyVsO+hdL
 6by///NsdxtPJ98Bv2UCQ0CqJlkQwJX3r1Lo//8=
X-Google-Smtp-Source: APiQypKQnFgaXtpfumW2EzJFsw/PIzskLTc81E0dFA9H49pwR3fvYCh3kTc2ToX/EaD+fUXQQYuhBsivPT+csy0O9Qw=
X-Received: by 2002:a92:da8a:: with SMTP id u10mr18738648iln.241.1586794832022; 
 Mon, 13 Apr 2020 09:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200326230838.31112-1-richard.henderson@linaro.org>
 <20200326230838.31112-21-richard.henderson@linaro.org>
In-Reply-To: <20200326230838.31112-21-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 13 Apr 2020 18:20:27 +0200
Message-ID: <CABoDooNtOgV=gWGVpo6OJppiLtJWFhEpWsvU5rqw68MZP1Sorg@mail.gmail.com>
Subject: Re: [PATCH 20/31] target/arm: Implement SVE2 complex integer add
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: rajav@quicinc.com, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 12:20 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
[...]
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index b5afa34efe..a3653007ac 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1289,6 +1289,48 @@ DO_BITPERM(sve2_bgrp_d, uint64_t, bitgroup)
>
>  #undef DO_BITPERM
>
> +#define DO_CADD(NAME, TYPE, H, ADD_OP, SUB_OP)                  \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
> +{                                                               \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                      \
> +    int sub_r = simd_data(desc);                                \
> +    if (sub_r) {                                                \
> +        for (i = 0; i < opr_sz; i += 2 * sizeof(TYPE)) {        \
> +            TYPE acc_r = *(TYPE *)(vn + H(i));                  \
> +            TYPE acc_i = *(TYPE *)(vn + H(i + sizeof(TYPE)));   \
> +            TYPE el2_r = *(TYPE *)(vm + H(i));                  \
> +            TYPE el2_i = *(TYPE *)(vm + H(i + sizeof(TYPE)));   \
> +            acc_r = SUB_OP(acc_r, el2_i);                       \
> +            acc_i = ADD_OP(acc_i, el2_r);                       \
> +            *(TYPE *)(vd + H(i)) = acc_r;                       \
> +            *(TYPE *)(vd + H(i + sizeof(TYPE))) = acc_i;        \
> +        }                                                       \
> +    } else {                                                    \
> +        for (i = 0; i < opr_sz; i += 2 * sizeof(TYPE)) {        \
> +            TYPE acc_r = *(TYPE *)(vn + H(i));                  \
> +            TYPE acc_i = *(TYPE *)(vn + H(i + sizeof(TYPE)));   \
> +            TYPE el2_r = *(TYPE *)(vm + H(i));                  \
> +            TYPE el2_i = *(TYPE *)(vm + H(i + sizeof(TYPE)));   \
> +            acc_r = ADD_OP(acc_r, el2_i);                       \
> +            acc_i = SUB_OP(acc_i, el2_r);                       \
> +            *(TYPE *)(vd + H(i)) = acc_r;                       \
> +            *(TYPE *)(vd + H(i + sizeof(TYPE))) = acc_i;        \
> +        }                                                       \
> +    }                                                           \
> +}

The then/else branches of if (sub_r) are swapped.

Laurent

