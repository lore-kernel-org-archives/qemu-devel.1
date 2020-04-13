Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D16DC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F362063A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmuAY6sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F362063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO1es-0006KK-3U
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 12:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jO1eG-0005fc-Ej
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jO1eF-0005dr-He
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:09:24 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jO1eF-0005dT-Di; Mon, 13 Apr 2020 12:09:23 -0400
Received: by mail-io1-xd43.google.com with SMTP id i19so9814525ioh.12;
 Mon, 13 Apr 2020 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6zzYFmntnypYkZL8T/VhiKG1nc4HF35zN8ul5ipSsiQ=;
 b=gmuAY6sOFARZwsD5xGK6yQ1qKibzfPITzJ14I4YMcs8zY0+KSATmFxVSF+Vg/WUxr9
 ZCLJwgGknIwHZ4MSDbqAtpGxkg8M5w916LZ4aCLbWgdib+jqCTYVH+lsR8fUfMaxf3BH
 qq+o5krAETEWtaV17KLV2m0PLjQxQOqKU37FXKqEGR89a9m/0NClXMrequaWiIUUIpYe
 yZyDx9QoPzIBulaW92fBgGpbiMfM10NeKbCs3tiwgpv4bts6t8A5tqE8dqaNNjMNpjLj
 LnyiU6H7iVjulBMcG4qUcylsmAAFMmU2cWIlBE5EY/OOkAz1JgcaDgNa5IuNFm1/n5Jw
 kG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6zzYFmntnypYkZL8T/VhiKG1nc4HF35zN8ul5ipSsiQ=;
 b=QdCmE7DCyioU6q7xhbmnrnOfXM4XVap5zKRAaqPjmxlMWkatoj7qBHRED9LF/cqw4r
 2F9YnLWLI+vQjxkzImfbGo4e0fwiWktIu+9N6IK0a01b6hIV6TJzTE6d5t/HWhyM3tbO
 GldzHBYTfwQQXy8oJvv3GAGRwCbl2LmIf1EoJZh5W4GWF/xEX4ELbWX2bryMNXdX+Pvf
 dOMKG22QOfUUNPTawAlx1xrI1s40oQQpvYoG1+Xcx4xyoX++Y9bmBzQWKLTeGB9hK3qx
 m2dV/+8mgaF4R+SpvEZXg2XGZZd5AeJmL+bT9bvW+pu+iX+HYMfwX8OUl3YaXO5DrwFp
 T2aA==
X-Gm-Message-State: AGi0PubaAbOkFVokltXb9Ows8Sj6mmcMJa6PboM4lpZMqh7KWgFeB7zq
 boBZKZ9nw2dYhToQRzJqYUTh5R7nONcY9+XL5OE=
X-Google-Smtp-Source: APiQypJdB85qasYujTK6yhUK6MKTLtRj4dpDwERVWw0UhSM7wAMS3MO8ojeuKSqN8L6mjSj4wUXJKLPzRF0go8Ds1dM=
X-Received: by 2002:a5e:9b13:: with SMTP id j19mr16937896iok.86.1586794162572; 
 Mon, 13 Apr 2020 09:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200326230838.31112-1-richard.henderson@linaro.org>
 <20200326230838.31112-12-richard.henderson@linaro.org>
In-Reply-To: <20200326230838.31112-12-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 13 Apr 2020 18:09:18 +0200
Message-ID: <CABoDooNLXi7TOJ7nBDiyMAZi4BvC6nyD-oD5FWgXY2t4bxtkfQ@mail.gmail.com>
Subject: Re: [PATCH 11/31] target/arm: Implement SVE2 integer add/subtract long
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

On Fri, Mar 27, 2020 at 12:09 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
[...]
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index bee00eaa44..7d7a59f620 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1088,6 +1088,49 @@ DO_ZZW(sve_lsl_zzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
>  #undef DO_ZPZ
>  #undef DO_ZPZ_D
>
> +/*
> + * Three-operand expander, unpredicated, in which the two inputs are
> + * selected from the top or bottom half of the wide column.
> + */
> +#define DO_ZZZ_TB(NAME, TYPE, TYPEN, OP) \
> +void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
> +{                                                              \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                     \
> +    int sel1 = (simd_data(desc) & 1) * sizeof(TYPE);           \
> +    int sel2 = (simd_data(desc) & 2) * (sizeof(TYPE) / 2);     \
> +    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
> +        TYPE nn = (TYPEN)(*(TYPE *)(vn + i) >> sel1);          \
> +        TYPE mm = (TYPEN)(*(TYPE *)(vm + i) >> sel2);          \
> +        *(TYPE *)(vd + i) = OP(nn, mm);                        \
> +    }                                                          \
> +}

For sel1/sel2 the multiplicand should be the number of bits in TYPEN.

Laurent

