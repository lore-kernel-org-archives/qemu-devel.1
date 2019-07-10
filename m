Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F422C004EF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA8D20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8uY0QyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA8D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9Dr-0004ID-EE
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hl9D5-0003qx-QT
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hl9D4-0004wO-PY
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:48:23 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hl9D4-0004s8-HS
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:48:22 -0400
Received: by mail-ed1-x543.google.com with SMTP id w20so1573501edd.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V5t6SotKs6cZ6ijkO0HwVeZ62+FJrDDjXc0QtzhWc90=;
 b=p8uY0QyHhjyPFvHg2J9Xld3ViwLDnhmHlACtmOG6qFLeLPjETkXZWcQOWVCGIC7o1U
 fFuP6wEAJuKQXwGNz0gyvAzVasPvRR9oVWFA72Bi3JJqESURxb3XCFlsjZ6WF2QPywfE
 0gzDkWn6H9ASwnO0tE4vi3vcmzqJ5r8MZMAZz8K2xgpNTGMuz0bLVdn98I1n8Pa8hl/h
 UaC9Wyx3XhE6T/WwIOpyJSM2nWgfjYIAUgibJKgSlZ2wX3cizRFxspcENIUaXs28ke66
 X5rW8QfFYZG6v6lzuJtS356Pgi+ApQSeBjgI8g8yURAkoYnK8dP5yKCYslPDp9GAwCmC
 yIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V5t6SotKs6cZ6ijkO0HwVeZ62+FJrDDjXc0QtzhWc90=;
 b=CtJUYuT0SM81iOxVEM9A/5xeaLYASo9S2o+rlmLWcwP8R353FX/hSyEwOmW4EskcUE
 NQ4A8oKs5OL5bRFO+ZrNpgkvSTqAJvYRtuTL3s+D8YF63jh8CpSt8xZKB+3oW8VdSuqs
 a2JGXlEOCsBM2I5KgzvdotbNVtF6NXONN2mByxtrxiiUpTrKoH0kTu9NxCMcEEDfE2WF
 ojIDrVOJceIFjU+fkI/Vek1Lv3MmM2LeUDYuG0R2IZIH8nRxB+fxVg5Eg+JpOGl/x9vh
 1LYt5HKydEbIl5Y77hfum0H1J5FaYGTXO+m3zedTJXYrMihJ9q/F7ZLDidWkgj12AUnD
 wdog==
X-Gm-Message-State: APjAAAXpmTw/729xU5TYVFQk//Fy/L/QzT+5MpIildxkWgp8jfARKtfv
 s1ZRyqgFXrb8zAjxLi/MeYYykxNKWjMJ1DN0nnp36A==
X-Google-Smtp-Source: APXvYqyI+hsh3CFE1wuJDDhhYZeleZnSXLzF+RGoRTUfFU7pf6c/GKr8x9T9BsIm1m+GtuENfbR5tf8wnU5YP0GM0ms=
X-Received: by 2002:a50:ba78:: with SMTP id 53mr28273248eds.6.1562752099033;
 Wed, 10 Jul 2019 02:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190709184823.4135-1-richard.henderson@linaro.org>
 <CAL1e-=i7Paug3G4xFCVRpH=NadNti1oG9y8n7geUJeGDoizc4w@mail.gmail.com>
In-Reply-To: <CAL1e-=i7Paug3G4xFCVRpH=NadNti1oG9y8n7geUJeGDoizc4w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 10 Jul 2019 11:48:07 +0200
Message-ID: <CAFXwXrn4S-Xtd=3Yv2JaqK1fmkYHHQf6VOcc+VsDxgVr05pPXA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Fix output of extract2 opcodes
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jul 2019 at 11:22, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> On Jul 9, 2019 8:56 PM, "Richard Henderson" <richard.henderson@linaro.org> wrote:
> >
> > The aarch64 argument ordering for the operands is big-endian,
> > whereas the tcg argument ordering is little-endian.  Use REG0
> > so that we honor the rZ constraints.
> >
> > Fixes: 464c2969d5d
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
>
> The commit message looks more like a list of some random items than logical explanation of the code change. Improve it.

Vague and non-constructive comments like this are and will continue to
be ignored.

If you want to review a patch, then you're going to have to actually
read it.  There are two obvious changes in the one line patch.  Each
sentence describes the reason for each change.  There is no subtle
complex problem here.

r~

>
> Regards,
> Aleksandar
>
> >  tcg/aarch64/tcg-target.inc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> > index b0f8106642..0713448bf5 100644
> > --- a/tcg/aarch64/tcg-target.inc.c
> > +++ b/tcg/aarch64/tcg-target.inc.c
> > @@ -2226,7 +2226,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
> >
> >      case INDEX_op_extract2_i64:
> >      case INDEX_op_extract2_i32:
> > -        tcg_out_extr(s, ext, a0, a1, a2, args[3]);
> > +        tcg_out_extr(s, ext, a0, REG0(2), REG0(1), args[3]);
> >          break;
> >
> >      case INDEX_op_add2_i32:
> > --
> > 2.17.1
> >
> >

