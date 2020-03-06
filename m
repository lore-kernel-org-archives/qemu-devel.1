Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C83A2084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUl9SOWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C83A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEO4-00045j-5R
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAENT-0003eZ-6z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAENS-00064L-1q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:55:03 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAENR-00061I-S2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:55:01 -0500
Received: by mail-ot1-x342.google.com with SMTP id a20so2686520otl.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e3qdzPEzYh/psCshjtqs+9dIo5AYc68+lyvS5V/ldNU=;
 b=TUl9SOWbYOMuhKMIKHBOVH08Oepv2Gc9kupYV5cRRivDFp/xx+Q/QjnsHsj4aDfhTr
 v7wteYvB8LlnPos4e0R0g+qEA2eoPDbTFfKCovMGLGxbpCmheRtB6uM1QZvdnwFbTxxd
 RnSRoksuQGf8GGFw/7+Dzkobtwf0Yd/bA1DpEXobLp7DLZMW4vHrrYLf+0HQ1J4n+zWj
 GkzpJ9zWDs/6Sdh4eWWlm/kVXna+50kcYGe9Zh7GTTo+8M60vi48B4q56nQnQpCtp2kf
 CpTIsRYxIoI5zKX5qhHKpYmTPjk3vsckfuhr3CLNN4pOZuNBKhXwc6hY+2fAJDBHOs5r
 JO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e3qdzPEzYh/psCshjtqs+9dIo5AYc68+lyvS5V/ldNU=;
 b=b0IVs5RjAk1y7oymnUrcX2FE224yNry+QDzMF5AM3B4RoVq92z1Yp7D3dNSgAvzXG1
 DEqyzv5ozFKv4z+IuMogYTTfI61M3qwXA4Dg36aXmcczC/X/t0cZ/HlgixBzF1X9g78f
 N36AeLr6DcxTgyDSo3HCuSseJET+Zyr43w9DgJXegx18th4QCBTz37RaWrVIqrnLN60j
 KytUEpXlX4SkNX7Q9K5vtwaCPaK7Ms+zDGeV83uAAQLMomKcJHWy/AGF8CbQSvBlX0Mh
 8mDypCC2ZI890W2Q/XXJF/tHCAAOJKWJr3asmfS3dDQhuACHWAIEeLcZeEKJMTiTKh0l
 0gvw==
X-Gm-Message-State: ANhLgQ1bO6WkCYAkapf8fmzlVqOfTc5VOTtlTiWVDlztWP3GTNnRLxQL
 bvybOzWtSLdpQ2qjKwlNJIWrnEKn5LW8ShvpuWpwkA==
X-Google-Smtp-Source: ADFU+vtUqh736OFPwCpKycnO+jKRaFye8BXpkhHHBgAdbySY2sUauZAZqOC/BEvXWaVnwv9ITk0TcIRPkG3KkEPgfVY=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr2862540otq.91.1583506500852;
 Fri, 06 Mar 2020 06:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20200306134751.2572-1-peter.maydell@linaro.org>
 <70e18816-1d16-93a1-5e49-2f54132602fb@redhat.com>
In-Reply-To: <70e18816-1d16-93a1-5e49-2f54132602fb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 14:54:49 +0000
Message-ID: <CAFEAcA_wowY8fhsLXGZeHbdRP+1G58KmDUsLbB5WYw91KoF8+w@mail.gmail.com>
Subject: Re: [PATCH] qemu.nsi: Install Sphinx documentation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 14:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 3/6/20 2:47 PM, Peter Maydell wrote:
> > The old qemu-doc.html is no longer built, so update the Windows
> > installer to install the new Sphinx manual sets.
> >
> > We install all five of the manuals, even though some of them
> > (notably the user-mode manual) will not be very useful to Windows
> > users, because skipping some of them would mean broken links
> > in the top level 'index.html' page.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I've tested this (building it via the fedora docker image
> > and installing into a Windows VM) but I don't know anything
> > much about the installer so there might be neater ways to do it...
> >
> > NB: I didn't realize that patchew included a test of building
> > the Windows installer, so until we get this (or some variant)
> > into master I'm afraid patchew will be emailing failure reports
> > to every submitted patchseries. Sorry about that :-(
> > ---
> >   qemu.nsi | 22 +++++++++++++++++++---
> >   1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/qemu.nsi b/qemu.nsi
> > index 0c29ba359cd..1a0112265b0 100644
> > --- a/qemu.nsi
> > +++ b/qemu.nsi
> > @@ -177,9 +177,20 @@ SectionEnd
> >   !ifdef CONFIG_DOCUMENTATION
> >   Section "Documentation" SectionDoc
> >       SetOutPath "$INSTDIR"
>
> Now that we have multiple files installed, I'd move them into a separate
> directory: ${INSTDIR}/docs/ seems appropriate. Can be done later.
>
> > -    File "${BINDIR}\qemu-doc.html"
> > +    File "${BINDIR}\index.html"
> > +    SetOutPath "$INSTDIR\interop"
> > +    FILE /r "${BINDIR}\interop\*.*"
> > +    SetOutPath "$INSTDIR\specs"
> > +    FILE /r "${BINDIR}\specs\*.*"
> > +    SetOutPath "$INSTDIR\system"
> > +    FILE /r "${BINDIR}\system\*.*"
> > +    SetOutPath "$INSTDIR\tools"
> > +    FILE /r "${BINDIR}\tools\*.*"
> > +    SetOutPath "$INSTDIR\user"
> > +    FILE /r "${BINDIR}\user\*.*"
> > +    SetOutPath "$INSTDIR"
>
> The last SetOutPath seems alone (copy/paste mistake I suppose).
> Otherwise looks good.

No, it's deliberate. I wanted to put the output path back
to what it was at the start of this section, because I
wasn't sure if any of the commands below this point
implicitly depended on it.

> >       CreateDirectory "$SMPROGRAMS\${PRODUCT}"
> > -    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$I=
NSTDIR\qemu-doc.html" "" "$INSTDIR\qemu-doc.html" 0
> > +    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$I=
NSTDIR\index.html" "" "$INSTDIR\index.html" 0
> >   SectionEnd
> >   !endif

thanks
-- PMM

