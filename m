Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273BC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A7721783
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPK/PY10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4Tf-000557-Vq
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw4Ke-0003eb-HP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw4Kd-0001a2-Aw
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:49:20 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw4Kd-0001Zn-4R
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:49:19 -0400
Received: by mail-ot1-x344.google.com with SMTP id o101so132088902ota.8
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3JkgBNG2hX162hwRUL/oEhlM1Da/oaM7v+n5q+VX+0I=;
 b=sPK/PY10+d0Xu33ayPdl/GTq3C8AEjpmmlJ2pQ1Xj/x1fyRainxsqf0J4B6cGHDmU8
 InP9yu9LD89pJGNaswJxXlK11m1+XXvwhaS8rwUqjo8EXkgYlOoMHWSDaipBIa7jfyZX
 f+Tv3xSu5tzo6VbN2M2ksEHbA6U6nILKBpINuK/IrH/zXmQ2sb/F+G2D4T9PErb4jdDy
 sW7w0XN5Z7Is7zxzq5U0DVZnuatwSbFoZtFtbNA6GMybGc/3hAMorMgCSfOLJR/WjrUP
 fi6kdXfMWv11TeBRHEafKpxoNtmRm6y3Ciap4o6h1dEm9Bnz0WABWPbfC1vxbMXmGCuM
 2i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3JkgBNG2hX162hwRUL/oEhlM1Da/oaM7v+n5q+VX+0I=;
 b=nDS5hY/FCUBCJuWC70P0p60Q3nhTz1Q4k4miQzmL1VyYEVQ74QZeqHc/6gk/7cyHXw
 3yt1LKHWu24BOL64k90aG4WfXzWIeMh/1vFzItq90FlYSC36b285VUEa/cIMBQORtRhg
 oDh3622LHZXPPZQLY9pOJFd67XBHyF6hwfVHOhLr8J4OYgRhRGR/NsC6UORdrXjt1Duw
 B9cOOOMwq0LL3EdnTJMHZLaT3+pWGIrsFX3RcXLvRe/kJsddT4BXO0WYVXpdpWb3prIQ
 SoE42pmKweByJAYjkipA82JEwFTBwx83PtWPqbWPHr19EWR8ZfRLMtF3abcpmQoKy89M
 BgGw==
X-Gm-Message-State: APjAAAUVPol2Gs/Ae1BOrxYG37sYzeifkNq1hRTb9zUyQxwMSF5BvSyS
 b+YACoYKVlAlH04CdLsSRT32hcyexHMzdc58v5pG1A==
X-Google-Smtp-Source: APXvYqx9d8eW/1/dj3G94b5CduqhAPICPw/NbQYQx0cq+KMWd9rV7o2haDo7YrKwrMSqbQW/AXKJvKhE+wZ4O9QEezE=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr18268282otn.135.1565354958122; 
 Fri, 09 Aug 2019 05:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
In-Reply-To: <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 13:49:07 +0100
Message-ID: <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <Laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 13:22, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Thu, 8 Aug 2019 at 16:37, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Fails for me, but perhaps I'm doing it wrong:
>
>
> > NOTE: cross-compilers enabled:  'cc'
> > $ make
> >   CC      i386-linux-user/linux-user/syscall.o
> > /home/armbru/qemu/linux-user/ioctls.h:306:9: error: =E2=80=98SNDCTL_DSP=
_MAPINBUF=E2=80=99 undeclared here (not in a function)
> >    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_de=
sc)))
> >          ^
> > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of =
macro =E2=80=98IOCTL=E2=80=99
> >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> >                        ^
> > /home/armbru/qemu/linux-user/ioctls.h:307:9: error: =E2=80=98SNDCTL_DSP=
_MAPOUTBUF=E2=80=99 undeclared here (not in a function)
> >    IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_d=
esc)))
> >          ^
> > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of =
macro =E2=80=98IOCTL=E2=80=99
> >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> >                        ^
> > /home/armbru/qemu/linux-user/ioctls.h:362:9: error: =E2=80=98SOUND_MIXE=
R_ACCESS=E2=80=99 undeclared here (not in a function)
> >    IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
> >          ^
> > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of =
macro =E2=80=98IOCTL=E2=80=99
> >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> >                        ^
>
> We expect these to be provided by the system's "linux/soundcard.h".
> For my Debian system that's provided by the linux-libc-dev package,
> but I imagine you have that installed or you wouldn't have got
> this far in the configure/compile process...

Further investigation shows that this is because the system has
the 'oss4-dev' package installed, which diverts /usr/include/linux/soundcar=
d.h
and installs its own version which doesn't provide all the symbols
that the kernel one does.

Easy fix: uninstall oss4-dev.

Better fix: patch QEMU to provide its own versions of these constants
if the system headers don't.

Utopian fix: I've wondered occasionally whether for cases like this
where the constant is known to be the same for the host and the guest
we should have some sort of approach which lets us use the QEMU
copies of the linux kernel headers rather than having to rely on
the host system, which might have an older version that restricts
us unnecessarily on what we could support...

Issue previously reported in 2016:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01421.html

thanks
-- PMM

