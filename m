Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19730C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE4C206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIsJc2XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE4C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOFdX-0007q2-1F
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jOFcg-0007At-QP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jOFcf-0005jj-Oj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:04:42 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jOFcf-0005jR-Ki; Tue, 14 Apr 2020 03:04:41 -0400
Received: by mail-io1-xd42.google.com with SMTP id n20so12141838ioa.4;
 Tue, 14 Apr 2020 00:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JzEKBDC8MCFs6RzlQYo+6BPJPoODwW8SiaUozInCHTk=;
 b=VIsJc2XQnUhAI3zLm1/k5e1jLgkypVjZzqcEKIzwbgkepMU0nc4J8uxr1YViXoe4qW
 ea1MxO/xo2aG5KjkBJtQxr4PHJU2b6nDsKH/fa1qpgdfy/Lg3KhRItuxilq4+1tIWN8C
 Bzz0cfUZoJ4bk4fZJV/LKGlakXAw6m1m6OieCWZCQcVM5A0jMaY4zuJsFhL1W3gOGLc3
 hwu51EmCiKMgVGsJL6S0M00NXRrQqItoIIiSv1lRlb1fiK+2MTwdTgm797tU6NSsEUZp
 +my733TdOXm2pM8vrodDzRRCR5bqhorQTAUxODtdN08KfgbEkmdGNhjcU5xx3XeW3FDQ
 RN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JzEKBDC8MCFs6RzlQYo+6BPJPoODwW8SiaUozInCHTk=;
 b=L0GqjyQGdZPl0/9vnzZuG7RTcQXWXfYdXetkHhWB594N3on95PWOpMgkKG5mpz+Xf5
 Ao9VqwariFFgNs6x1PrdDNHn/CPF9zNJc/E6JsvyAQ0X5L3GsmGcws1oGWTqBQa0EwWn
 F5iHt82Xi0o+Yof4tzc0MH/7jpM2p3yiD3jX2IC9EIWjTEiHEHqCFGvQ5mcO7o4BNvsN
 ehzOQwPpHQjaXoxi6Ry2z5XhZJL3hHV43LomF+oL+7oXWtrW773QnTB8fQr3+gPvC3BM
 fPJxwmybcKp8mdKAcjSGeDit8u3QUvIDIbu1Skauw7YrXcWZu/0NEaE6zismKFVgYJ46
 epmw==
X-Gm-Message-State: AGi0PuaTMC+WnM4stOBscdaPe21jBRU23lC63iFyXSV3Y+fbWwJSJnXe
 NthORDn8sE1uShlI7Hk89EK5VO7BWGcqIMEUEKQ=
X-Google-Smtp-Source: APiQypKOXg1pDYsnKX5T/HDlgdfc462rxjvDpSxjQ/1YOkWbLj7Wt3UiE/mFZqKQzbLgYILbVx5NwunUi8xME88hQ94=
X-Received: by 2002:a02:9445:: with SMTP id a63mr19377779jai.10.1586847880360; 
 Tue, 14 Apr 2020 00:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200326230838.31112-1-richard.henderson@linaro.org>
 <20200326230838.31112-22-richard.henderson@linaro.org>
 <CABoDooNE=R_jQjg-dZrdaK-atmuQ4XjMkGjKnmebKvuXcTpDQg@mail.gmail.com>
 <ae2cb680-2200-e9cb-afa1-e55593ef6d6d@linaro.org>
In-Reply-To: <ae2cb680-2200-e9cb-afa1-e55593ef6d6d@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 14 Apr 2020 09:04:36 +0200
Message-ID: <CABoDooMBkn-knRM70HmMqiSHrif7DjDKkZAr+j3ZLsEY6noGeA@mail.gmail.com>
Subject: Re: [PATCH 21/31] target/arm: Implement SVE2 integer absolute
 difference and accumulate long
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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

On Tue, Apr 14, 2020 at 1:19 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/13/20 9:15 AM, Laurent Desnogues wrote:
> > On Fri, Mar 27, 2020 at 12:18 AM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > [...]
> >> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> >> index a3653007ac..a0995d95c7 100644
> >> --- a/target/arm/sve_helper.c
> >> +++ b/target/arm/sve_helper.c
> >> @@ -1216,6 +1216,30 @@ DO_ZZZ_NTB(sve2_eoril_d, uint64_t,     , DO_EOR)
> >>
> >>  #undef DO_ZZZ_NTB
> >>
> >> +#define DO_ABAL(NAME, TYPE, TYPEN) \
> >> +void HELPER(NAME)(void *vd, void *va, void *vn, void *vm, uint32_t desc) \
> >> +{                                                              \
> >> +    intptr_t i, opr_sz = simd_oprsz(desc);                     \
> >> +    int sel1 = (simd_data(desc) & 1) * sizeof(TYPE);           \
> >> +    int sel2 = (simd_data(desc) & 2) * (sizeof(TYPE) / 2);     \
> >> +    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
> >> +        TYPE nn = (TYPEN)(*(TYPE *)(vn + i) >> sel1);          \
> >> +        TYPE mm = (TYPEN)(*(TYPE *)(vm + i) >> sel2);          \
> >> +        TYPE aa = *(TYPE *)(va + i);                           \
> >> +        *(TYPE *)(vd + i) = DO_ABD(nn, mm) + aa;               \
> >> +    }                                                          \
> >> +}
> >
> > ABAL is either top or bottom not a mix of two.  So only sel1 is needed
> > and its multiplicand should be the number of bits of TYPEN.
>
> Yep.
>
> > vd is both a source and a destination so a temporary should be used.
>
> In what way am I not?  Both sources are read before the write.  The operands
> are all in columns of the wide type (unlike the addp case you pointed out).

You're right, sorry.

Laurent

