Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B1ECDE20
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7003220678
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsAZQWy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7003220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Mhp-0005j6-Ka
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Mgo-0004zF-IS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Mgn-0004Jp-IJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:51:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8Mgm-0004HG-O4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:51:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id 21so25579823otj.11
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4VXWTXPZBNfSwhiAsVVlgTszhcEdm6hMqLTDpdFLRHU=;
 b=xsAZQWy6B2UCaj+PHVuUO1ZlAjXLIb5vmRntH8qz/V8O9P+jYi1wmdQJyossnb6FP3
 IbNIq0MT9XOuZuM93AlxVzQDDMULhOmFSfLD0tFWCRHq0lD7U0o0Sj7Oph/UBJFoJacv
 SkT5AT+4TSaD/sQrYFhVHaULGD7yu7HVM5tslf4jjthbvEyHsein13DTvFZDwDxFrxLL
 i5d5mKhrb/GjRn5JhbF8ypgK6cSGs0ByinGyr6pbpjtNJzCTWRkuze+LJf3q5JZnVpDJ
 lpvZcvx2hFEQ/H6K0p+JrNtNr0ZQY5zyfFTBuXTJdqjJABovHLOkztjvSbG4jmDDQH7F
 RNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4VXWTXPZBNfSwhiAsVVlgTszhcEdm6hMqLTDpdFLRHU=;
 b=EsQEaC6qKWwtGkCITJ0aqupVWD8SvCURqmwRJ3YC1dZvjzpDl74+Edb7GM0hpAVXa7
 dcqo8cG4lTkyBP8nzQfwVx8SnlHAxKKeNxN4D1zvi/KWXSDV+MsztMjFad64HHIEDHHw
 8XjVTbwiPPQdjiEtXnrqUQBfOlgbLjSz9IDD/+qFpxbNXZkndoHPXYlcdJ2+Ap2Eih3q
 JtNo0Paw57cz8J9TN3WupJFSKdId3/flia+hel6yQSkW4eOORWZUIWd+9GOR7ZXE4ZOF
 Ojd98logqRbWX8TbtIkwdQb7b8n7rriYxBNoEF++pPHOsJsQ6LORhN2jpwjRP/fnsXvf
 DhFQ==
X-Gm-Message-State: APjAAAV10Ub4ImLECNWDE4q3FxR0H0tx10MYjpLV0wv5q123LF8Ph7/B
 pLcRknzTO0N5VKEn+Ym8roHOydvvPx8S6dGOGR88Yg==
X-Google-Smtp-Source: APXvYqyUe5yd9CENp7xBletpyzu1tSfvZk4cbqVmedEOFwh/sqraRX5epPmfkrvG6pGROdgNFUL1pja9eskTkVyH2ig=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr33442349otk.221.1568285458447; 
 Thu, 12 Sep 2019 03:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-3-peter.maydell@linaro.org> <87r24lztgq.fsf@linaro.org>
In-Reply-To: <87r24lztgq.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 11:50:47 +0100
Message-ID: <CAFEAcA_s1aYO6ZK2pkrrc+YrdCoUww0H_RTOjvaH8z1FOemP0w@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/13] target/arm/arm-semi:
 Always set some kind of errno for failed calls
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 11:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > If we fail a semihosting call we should always set the
> > semihosting errno to something; we were failing to do
> > this for some of the "check inputs for sanity" cases.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> although:
>
> > ---
> >  target/arm/arm-semi.c | 45 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> > index 03e60105c05..51b55816faf 100644
> > --- a/target/arm/arm-semi.c
> > +++ b/target/arm/arm-semi.c
> > @@ -232,11 +232,13 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, =
gdb_syscall_complete_cb cb,
> >  #define GET_ARG(n) do {                                 \
> >      if (is_a64(env)) {                                  \
> >          if (get_user_u64(arg ## n, args + (n) * 8)) {   \
> > -            return -1;                                  \
> > +            errno =3D EFAULT;                             \
> > +            return set_swi_errno(ts, -1);               \
>
> This looks a little queasy given ts is NULL for the softmmu version. I
> wonder (depending on your approach to -smp for 1/13) if we should just
> pass the ARMCPU down to the helper?

NULL is fine because the softmmu version of set_swi_errno() doesn't
do anything with it anyway, right?

thanks
-- PMM

