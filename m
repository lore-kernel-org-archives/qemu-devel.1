Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7788FC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E4E2082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq8+c/Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E4E2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbfMC-00076p-K9
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 02:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbfJU-0004xG-Vd
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbfJT-0007EP-O2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:03:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hbfJT-0007Dc-GI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:03:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so1520199ote.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 23:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Zc3WFoSIpJZsoKUeXoP8nsyARD2kXjhD0KMzhQHas38=;
 b=aq8+c/PtMob0Ta3LN6oEd/rIuvK8OrDhQiGUxCuHyv++83atETzL1bXRkkjNc2K70O
 syYkkuAX0JJ44oBGTDOZ6LgmCO+c+hJhe6T0gYsPCuNppi7wdVHPCYv4u16TxdKmzHUV
 LcNajTAYjsE2YNtT5+DXaHx4Fsmyu9LaTy46cY0KilISM0f2hSpp7mxOqdtz5WE1YVXC
 wopgqXXKI1tchiViqx0iGc9ShD3Oo7J0hX6E+lrHdrmjFSyLNR7LMyn6lvbbFk1mUAE3
 ktNjHFxdBuehg42DF0xqBobc21xNA/vBQXZVrumaecYbBeXP0VbKKrtlN1lAFU1nxLte
 W55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Zc3WFoSIpJZsoKUeXoP8nsyARD2kXjhD0KMzhQHas38=;
 b=tgp/IvjT9n5EYOxzoErhJivEIyUhZ9wubOC4NxkPJS+7ru23DCMTl7kvSFXmAu+aOC
 LrTDZoykAng/QRl7DgsFKI7wHWmHRprbAwRGLaDvl/BanyBqJ/U0EtrzH55hOqUpkSZx
 95jTaZcXSp3k85ofbkpuRmUfsQBiiqEr/QlAjmcdmKlINd74BS67TFBr8QS5Nc0xxIYr
 /ahGIUYQ+nH3v2PL3cqWD6OT2wFXbDEpeCB8f4JW6HykmtsFppLLJj4fc4rRYl4+mOCs
 oV8Li5yHtR8Zv36c7qratQH01A/eZW97Zb2/GPmPj+0iB+pr92McE1n/E887bukgHlND
 NyWA==
X-Gm-Message-State: APjAAAU6WnAlLjp1WDGGkHnDuJuB/gb9/D1FYitOwc0TUZgzC+b7DnzW
 80qArElZx+Bb01YIqd5svAmlf97bDuf7qfBueko=
X-Google-Smtp-Source: APXvYqz1dKSr2cud26kzmvHZknxEApY4g38g+COSaga78kPwjLGK3vAmJvwNt5daBxzpqfInWo3N2q9fWac7rdVfMD8=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr6051378otr.295.1560492226426; 
 Thu, 13 Jun 2019 23:03:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 23:03:45
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 23:03:45
 -0700 (PDT)
In-Reply-To: <CAL1e-=iHb5khAaQeV1za8SnW=9O8mP-xg=t2Eaw818Yc9zdPPw@mail.gmail.com>
References: <20190613041619.32102-1-richard.henderson@linaro.org>
 <20190613041619.32102-2-richard.henderson@linaro.org>
 <CAL1e-=iHb5khAaQeV1za8SnW=9O8mP-xg=t2Eaw818Yc9zdPPw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 14 Jun 2019 08:03:45 +0200
Message-ID: <CAL1e-=hQG9roHkg5vf364_A5eit1McpwWAuHYj5Sqaz=KVzK3Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/1] tcg: Fix typos in helper_gvec_sar{8, 32,
 64}v
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 14, 2019 7:22 AM, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com=
>
wrote:
>
>
> On Jun 13, 2019 6:16 AM, "Richard Henderson" <richard.henderson@linaro.or=
g>
wrote:
> >

I just noticed that this patch is already applied to the upstream - no pull
request, no waiting time for community review -

> > The loop is written with scalars, not vectors.
> > Use the correct type when incrementing.
> >
> > Fixes: 5ee5c14cacd
> > Reported-by: Laurent Vivier <lvivier@redhat.com>
> > Tested-by: Laurent Vivier <lvivier@redhat.com>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
>
> This is certainly not a case of =E2=80=9Ctypo=E2=80=9D (which would mean =
that you
accidentally typed =E2=80=9Cvec8=E2=80=9D instead od =E2=80=9Cint8_t=E2=80=
=9D). So, change the title to
=E2=80=9Ctcg: Fix loop step in
> helper_gvec_sar{8, 32, 64}v=E2=80=9D or similar.
>
> >  accel/tcg/tcg-runtime-gvec.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.=
c
> > index 3b6052fe97..51cb29ca79 100644
> > --- a/accel/tcg/tcg-runtime-gvec.c
> > +++ b/accel/tcg/tcg-runtime-gvec.c
> > @@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b,
uint32_t desc)
> >      intptr_t oprsz =3D simd_oprsz(desc);
> >      intptr_t i;
> >
> > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> > +    for (i =3D 0; i < oprsz; i +=3D sizeof(int8_t)) {
> >          uint8_t sh =3D *(uint8_t *)(b + i) & 7;
> >          *(int8_t *)(d + i) =3D *(int8_t *)(a + i) >> sh;
> >      }
> > @@ -898,7 +898,7 @@ void HELPER(gvec_sar32v)(void *d, void *a, void *b,
uint32_t desc)
> >      intptr_t oprsz =3D simd_oprsz(desc);
> >      intptr_t i;
> >
> > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec32)) {
> > +    for (i =3D 0; i < oprsz; i +=3D sizeof(int32_t)) {
> >          uint8_t sh =3D *(uint32_t *)(b + i) & 31;
> >          *(int32_t *)(d + i) =3D *(int32_t *)(a + i) >> sh;
> >      }
> > @@ -910,7 +910,7 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b,
uint32_t desc)
> >      intptr_t oprsz =3D simd_oprsz(desc);
> >      intptr_t i;
> >
> > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> > +    for (i =3D 0; i < oprsz; i +=3D sizeof(int64_t)) {
> >          uint8_t sh =3D *(uint64_t *)(b + i) & 63;
> >          *(int64_t *)(d + i) =3D *(int64_t *)(a + i) >> sh;
> >      }
> > --
> > 2.17.1
> >
> >
