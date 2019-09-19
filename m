Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67521C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A02C20665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zP8Gr6Tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A02C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyHw-00015x-BN
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAyH1-0000Zl-8b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAyGz-0001Ab-Tb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:23:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAyGz-0001A4-OJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:23:09 -0400
Received: by mail-ot1-x341.google.com with SMTP id k32so3442923otc.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cVgPRVslMHxKJDvm8H39J7/SYPphkOVKOaspZV/rYfM=;
 b=zP8Gr6Tn1FdVD7+0j6Wf175jg6IAuksOi4gg5UzXL5vvdKx8ZWarrq6QHUNJO2OmXW
 csHVazQruZRbbInzqklAKhKIMIhi29t0IiCHc8G/dHM5r5OsbgNWjuzIuu6P2iJWxxHg
 vX077fTWYf03EAI5PiOs3fU0MLAf6F3CAp3dskocmLz76QTMhA8OD6BiWsOEagfQptCE
 DLoboQ/IT90hLMnYXAW2nF8IGZpdlckN27ORBxhejdwsn13fK80GV+h3FREtjrs0Wdq6
 xRclXJuXoxqSXOLCAasz5FEjy+ypK+E7K7qugAnc0uiHZn3gjiS80jYuB5PDLwoEXOhi
 xOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cVgPRVslMHxKJDvm8H39J7/SYPphkOVKOaspZV/rYfM=;
 b=CbL9GBdqSLSdYcIOnNa0eD0UR5e7JI63tQ5I3o8rAe4xe3ucJws4BU/vw8Bdwbq06j
 fQMsI5XKsr2lF++xGvDnMLKpYVToGVuV4qR8vYFeGRYC5wGDbFYOYznnfJiVaPZ4/dS4
 WT+VWhEAOsdGHSHieGrdhKdMOs5fwP1Dy7zHyXcptz8HGxapTR2clifnPTF+V4Vb7u23
 fbN96H2KRiW7AyWUQ2eDsnc8ThhZ02kIs44VsbW8H/iOtT5P7oxAjCfdbQHlVZMcIg14
 5VFwfkhf2aHlwBqwciPm2MRJYZW58fUzO+6vP64lbOpQwyyejWEg/sR3meNKBNBf0m5e
 GEOQ==
X-Gm-Message-State: APjAAAXKyeE7KUh6tTB1hbbvaWnCt2WIgEzqr8ojRkp//qyiQsckYnOA
 R+sG0JH6e3TJmmr3ObTdD6+Jyex7RM+6UA200cA/6g==
X-Google-Smtp-Source: APXvYqxT1wrZefzt5i+Us2YjwWaCX7LDVeO4S0gad0nGQd93kVMiw7F3VYCu7lUYPBZBBH4bFXCldATHKv359MSXSt4=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr7403762oti.135.1568906588546; 
 Thu, 19 Sep 2019 08:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
 <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
 <CAFEAcA_P8H4=-tnKLrm+YTqH_p7x2oVjHq1Sg03m6ssrWnKsjw@mail.gmail.com>
 <07b8a4b8-79d2-a2f6-721d-e4a14917c808@redhat.com>
In-Reply-To: <07b8a4b8-79d2-a2f6-721d-e4a14917c808@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 16:22:57 +0100
Message-ID: <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 14:54, Eric Blake <eblake@redhat.com> wrote:
>
> On 9/19/19 8:35 AM, Peter Maydell wrote:
> > On Thu, 19 Sep 2019 at 14:27, Eric Blake <eblake@redhat.com> wrote:
> >>
> >> On 9/19/19 7:00 AM, Peter Maydell wrote:
> >>
> >>>> In an incremental build on Fedora 30, I'm now seeing:
> >>>>
> >>>>         CHK version_gen.h
> >>>>   GEN     docs/interop/qemu-ga.8
> >>>> No filename or title
> >>>> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
> >>>> Error 255
> >>>>
> >>>> and suspect this patch introduced it.  It may be that I just need to
> >>>> nuke intermediate artifacts rather than an actual problem with the
> >>>> patch, but I'd welcome help in identifying the problem.
> >>>
> >>> If you build with V=1 what does it say it's doing?
> >>
> >> make[1]: Leaving directory '/home/eblake/qemu/dtc'
> >> perl -Ww -- /home/eblake/qemu/scripts/texi2pod.pl -I docs -I scripts -I
> >> docs/interop -DVERSION="4.1.50" -DCONFDIR="/usr/local/etc/qemu"
> >> scripts/texi2pod.pl docs/interop/qemu-ga.8.pod && pod2man --utf8
> >> --section=8 --center=" " --release=" " docs/interop/qemu-ga.8.pod >
> >> docs/interop/qemu-ga.8
> >> No filename or title
> >> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
> >> Error 255
> >
> > Do you have sphinx installed on this machine?
>
> Not yet.
>
> /me goes and installs sphinx-2.2.11-12.fc30.x86_64
>
> Nope, problem is still happening even after rerunning ./configure

Alex looked at this and suggests the problem is probably because
you're doing an in-tree build. Sphinx insists that it can't build
output files into the source tree, so we have a thing where we
set MANUAL_BUILDDIR to docs/built if we're doing an in-tree build.
But the filename we add to DOCS is just "docs/interop/qemu-ga.8"
so for an in-tree build the sphinx rule won't match it, and
the install rune won't find it either.

If that's the cause I think this untested fix should help:

diff --git a/Makefile b/Makefile
index 111082ce545..8d9dcb3aa4a 100644
--- a/Makefile
+++ b/Makefile
@@ -325,7 +325,7 @@ endif
 endif

 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8
docs/interop/qemu-ga.8
+DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8
$(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt
docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt
docs/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-block-drivers.7
@@ -819,7 +819,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
        $(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-       $(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
+       $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8
"$(DESTDIR)$(mandir)/man8"
        $(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
        $(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
        $(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"


thanks
-- PMM

