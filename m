Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104DE208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUDWv0sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104DE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iajQi-000496-3Y
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaj6a-0000PN-2g
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 11:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaj6X-0000Pm-Od
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 11:26:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaj6X-0000Gm-I0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 11:26:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id 77so4059637oty.6
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z1hrNlxhG3/CT2CKsfxZWWikkXq7jsv0gPXS7BSZZsM=;
 b=sUDWv0smmBB9rB84ErwldnHcDUeeR5d9YSrSQ6lD4PAJV7BQK5FID/U48+FyOqEe4M
 icQhw2lS4VRUkk8H80ZkgjtTNOJWFtYrP1Ajifj8b+QCSVccBotP+Va7HUsXOCIQaXPb
 N9tojxlSmGXBMvRXnXRQnSbOtFlD8JzHLTYJR8DC6v4rUDtkVd69y6711YplcaPfJUGS
 aiIgRxa0SJ689LIFo+MUVmWypkL2kryVrY7HzcDh8dLe/CCvzIihHgxN7c1HFxFTYSHI
 pWd5sgN2CapxF4cVgoMrs3YvJ9f+1EMwyGxA7s7TOzHcW0U4Uy9NN1d8fhhdjXrojve7
 x8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z1hrNlxhG3/CT2CKsfxZWWikkXq7jsv0gPXS7BSZZsM=;
 b=cFYMxhm5H+S0BNoHm1BJX401suPL5S+2VxyS2htco6e/EeEer2jfU7OPyM7WWV3+Ap
 EtznQf9oIbgt9f+z5m+OVNClvu29pXWlOmIEv/AsBEtpp1lVRDwyCZRGdsp9pkVtRQLo
 3ppTgZeai8rMsVp/a7urQweCbJLDRc4aVIsfDZLC854GWDrJVcQt64dNiiXUuHx4V77k
 gEr6oqYqpJ6HHNKrAyPYhnSgmrg08Yro0Boa6a3kxyrynKBM3/rwhug6X17XZWWznv/c
 i80f28oasEnwSXlN9LeFQOQYQkMdQxCC+2AmFfcFXogn0e7f87ey4uN0c7f8CxHIFiA4
 JejA==
X-Gm-Message-State: APjAAAVSvrTuhfxPu597rL8MLgCCKGqettWKXYjhqQ4EG6s4V+P5D2XM
 yaLjRFBsBEYIjKzkskIXUzOYYcpRxRuxyfgBZMQH7g==
X-Google-Smtp-Source: APXvYqy3or4/PakF7C1Ad9rQCKyVOMz2N28gcsmIm8lIE7mYqzlVJAEwAS2mLlk4D43FBoctlXaShuobB7oe1m83P60=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr11900898otk.91.1575044806521; 
 Fri, 29 Nov 2019 08:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20191127132430.3681-1-alex.bennee@linaro.org>
 <38416b79-0068-6703-759b-2015b271801d@redhat.com>
In-Reply-To: <38416b79-0068-6703-759b-2015b271801d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 16:26:34 +0000
Message-ID: <CAFEAcA9+Lr2KPANu4Fz_LQK-P0YMu9+qKhUsqOme-AsxSGVQYg@mail.gmail.com>
Subject: Re: [PATCH for 4.2?] .travis.yml: drop xcode9.4 from build matrix
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 13:52, Thomas Huth <thuth@redhat.com> wrote:
>
> On 27/11/2019 14.24, Alex Benn=C3=A9e wrote:
> > It's broken so it's no longer helping. The latest Xcode is covered by
> > Cirrus.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  .travis.yml | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index c09b6a00143..445b0646c18 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -237,13 +237,7 @@ matrix:
> >          - TEST_CMD=3D""
> >
> >
> > -    # MacOSX builds
> > -    - env:
> > -        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS}"
> > -      os: osx
> > -      osx_image: xcode9.4
> > -      compiler: clang
> > -
> > +    # MacOSX builds - cirrus.yml also tests some MacOS builds includin=
g latest Xcode
>
> Ack for removing xcode9.4, it's also constantly failing for me, which is
> quite annoying.
>
> Additionally, the xcode9.4 runs on macOS 10.13, which we do not
> officially support anymore in QEMU (we only support the latest two
> releases).
>
> But maybe instead of removing the entry completely, you could replace it
> with "xcode11.2" instead if that works? See:

For purposes of 4.2 I've applied this patch-as is (since we're
going to get an rc4 anyway, and this is a simple change which
will stop travis complaining about the 4.2 stable branch in
future). We can look at xcode11.2 for 5.0.

thanks
-- PMM

