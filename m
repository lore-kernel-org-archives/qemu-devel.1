Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CDDC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D66206F8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWy/ZGIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D66206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlwh-0004N7-5Y
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHlw5-0003nz-Uj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHlw4-0003vX-Ms
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:09:57 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHlw4-0003qT-6i
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:09:56 -0400
Received: by mail-oi1-x241.google.com with SMTP id u20so3550337oic.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o+GzuiCKy/baE0bsoPkIfWsSEgMxRYKFOaKs/pOEY2M=;
 b=MWy/ZGIbauoio9QkdKU1+O9D2gTEKJUh7Zbl5WpoAdVWoBlwAfMcKxx8zHUBN1dLmS
 AaFFH+WfO6oXJf1GzDeBCk+pMxCvTl1njd9mOFtI5HQD8fXue5D4KPkVdGkuVJcNJsaa
 b04ag00vNF/ahVaJXLECb2NrTWlzsRz7fLY3/YPnALuXJLBZ4560RryKhEkp1VYd8/5k
 vqw+gzeZWJCqsDw3pfzt/RlqIGg6m4G5DkwBN4Je5CnWq5A0iU18UVtD+0m+Ux6i/1bT
 fVeD2pj7PXIEv9JXCLQ2+qzKuPd2EgIO7Lo+7W7kxiNdg3dwdsY7IEXTmzMwCkFH+saZ
 6sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o+GzuiCKy/baE0bsoPkIfWsSEgMxRYKFOaKs/pOEY2M=;
 b=ueDeIlHboy820lmwnZhSv0UBXXmpWzNTjrYKM4EqS4uhCLrzR2IKh3ocm10GNjAZdF
 YU5Cin05Z3W85gf+yFq2H4uQQbn1g3WVKDkYHjVfpAx/T6SGQiyyOrRlYZbelE272mD9
 gVl6xopFJmlj4B3h0Ao3Mffv3UdrLB96QcgPaZiuWJ7M5lnBFOchl/X0tuWWwixt1A9r
 GTQY7O7uymFHGHmoO+Yk84zaLQ5tG7R7K65RqfJvwWGdtFRNMDb/HfsYR5wCNMu2MgOr
 DNUnE552d3DcKYfE9zFoQInMAVVModYdGtiOswRvKWonOHJvS3iiQzImPjqdw+y8yfmX
 VZQw==
X-Gm-Message-State: ANhLgQ0QJ8ii142/PdyUuqxGUXBafU+DXe4tpq0vY/DpfUxZGbKjDgxB
 IDVKkNa+Du+tLKKC3hQ+7Kc9TaxiikWao6Wfni4vCg==
X-Google-Smtp-Source: ADFU+vtYgkB0Zd6ap1aBBijoA0IxCMX0p+SXb12fmrq/lkIcBPXELgHjBwUOFPvDwnnBlzHp6w0D4/GHzNFp334Cwp4=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr3174471oij.48.1585303794689; 
 Fri, 27 Mar 2020 03:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-6-alex.bennee@linaro.org>
In-Reply-To: <20200327094945.23768-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2020 10:09:43 +0000
Message-ID: <CAFEAcA8RvbdHMWCe101CyTWcA7T28-MtYwMFNZ5Fnh2=SuKcDw@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] fpu/softfloat: avoid undefined behaviour when
 normalising empty sigs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 at 09:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The undefined behaviour checker pointed out that a shift of 64 would
> lead to undefined behaviour.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 301ce3b537b..444d35920dd 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -3834,9 +3834,14 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int=
32_t *zExpPtr,
>  {
>      int8_t shiftCount;
>
> -    shiftCount =3D clz64(aSig);
> -    *zSigPtr =3D aSig<<shiftCount;
> -    *zExpPtr =3D 1 - shiftCount;
> +    if (aSig) {
> +        shiftCount =3D clz64(aSig);
> +        *zSigPtr =3D aSig << shiftCount;
> +        *zExpPtr =3D 1 - shiftCount;
> +    } else {
> +        *zSigPtr =3D 0;
> +        *zExpPtr =3D 1 - 64;
> +    }
>  }

Ah yes, I saw this one in Coverity: CID 1421991.

RTH marked the Coverity issue as a false positive with the rationale
"=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BFWe assume an out-of-range shift count =
is merely IMPLEMENTATION DEFINED
 and not UNDEFINED (in the Arm ARM sense), and so cannot turn a 0 value
 into a non-zero value."
but I think I disagree with that. We can assume that for the TCG IR
where we get to define shift semantics because we're doing the codegen,
but we can't assume it in C code, because it's not included in the set
of extended guarantees provided by -fwrapv as far as I know.

That said, is it valid for this function to be called with a zero
aSig value ? I think all these normalizeFloat*Subnormal() functions
assume non-zero sig input, and the only callsite where it's not clearly
obvious that this is obvious that the sig input is non-zero is the call to
normalizeFloatx80Subnormal() from addFloatx80Sigs(). So perhaps we
just need to check and fix that callsite ??

thanks
-- PMM

