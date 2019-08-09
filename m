Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D7DC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCE2214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc0e2Gaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCE2214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4r4-0007B5-TH
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58492)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw4qg-0006l3-RU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw4qf-0003vT-42
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:22:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hw4qe-0003u9-SO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:22:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so55796880otq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FFbqRXEGV0iFv+4jMrNsZkqPuLXF/3GXZmOK9MEj8Pg=;
 b=sc0e2Gaqgz4ywZg0GvsVXIa5vsKjhmYwBneRbtg2WO0Mcr1mYGlWECgFm6ybpgrJF9
 eyA2+NCdgvIGQzgL4KWkmiwHbeNjLYu+Fry+AA3mpGFAyRwqbvUX/GX05lz/kxuTU1Ue
 Y/rlPtvy+s/HJ+6NffLWbM1nS9Z1VzB2o0k/+RbBy8PlXij7fJdZ336UyeL2Jy4aFqlT
 BBmGmwp27+SzhO0liU5yiS+ekILXlfTvjbasyHyifE3iNrKBF4xTeymFth4uCXf5/Eyz
 kYjJAYbST9RqwNq+lSUeuiLPNLUje2QaRQW6D4R8soebpNLQGOdCYfrUuIkAK+e0tWht
 wS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FFbqRXEGV0iFv+4jMrNsZkqPuLXF/3GXZmOK9MEj8Pg=;
 b=Gln3GcRnOu93TRYUYH1ABZi2lfatw618+Q9i+fgPf31YoWkVZrryhjV9CURUqQ+p1E
 cFfT/R3z+VkUGYQp7Y9DPtJ5/LfnWpGrsEnsGSMU+RiufrmJ/+qtdUM3Nrvl00KgTdSy
 CfAGts7owHDOUGCT2EpttF4KkSwlOQDP+F4op4gnAKowNrhUIxdDmh6ZgyqYF1tWYui8
 4XmzN0w3FeqwkAIVrdG75u3pVTnmAp4AoJMvZQOlZME9BlvqBTZyHZyYIttPDhCqqwvc
 UJ2/N+5qvGybaQTgEUQAKrjnS0DWaeiuuh1ttcDsEkK95MwUsSpFPMAaKYUYsjLVUykN
 cmYg==
X-Gm-Message-State: APjAAAUDHnOodRh7rR8K1k1H8X5Y23FpiWxKzfT1cp+HLJSQh52LXjzC
 ZFcyJxz6iidVF5B1vOXaKaIjY0JlK8Yun/DOktM=
X-Google-Smtp-Source: APXvYqzLvtOYUF5Q9o7OjWPqb9uxCInfqvRy5rjr94whDrVFn+nxcrcYxVd+6ddLeGQRy02UNK0QoP7ozFaXTXK1suY=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr6621535otq.306.1565356943333; 
 Fri, 09 Aug 2019 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
 <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
In-Reply-To: <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 9 Aug 2019 15:22:12 +0200
Message-ID: <CAL1e-=jkRA472Meui2Bz=1nnidfVMfNLCOVUf3v7pkzirnSEAA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: Laurent Vivier <Laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 2:57 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 9 Aug 2019 at 13:22, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > On Thu, 8 Aug 2019 at 16:37, Markus Armbruster <armbru@redhat.com>
> wrote:
> > >
> > > Fails for me, but perhaps I'm doing it wrong:
> >
> >
> > > NOTE: cross-compilers enabled:  'cc'
> > > $ make
> > >   CC      i386-linux-user/linux-user/syscall.o
> > > /home/armbru/qemu/linux-user/ioctls.h:306:9: error:
> =E2=80=98SNDCTL_DSP_MAPINBUF=E2=80=99 undeclared here (not in a function)
> > >    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
> > >          ^
> > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition o=
f
> macro =E2=80=98IOCTL=E2=80=99
> > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > >                        ^
> > > /home/armbru/qemu/linux-user/ioctls.h:307:9: error:
> =E2=80=98SNDCTL_DSP_MAPOUTBUF=E2=80=99 undeclared here (not in a function=
)
> > >    IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_buffmem_desc)))
> > >          ^
> > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition o=
f
> macro =E2=80=98IOCTL=E2=80=99
> > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > >                        ^
> > > /home/armbru/qemu/linux-user/ioctls.h:362:9: error:
> =E2=80=98SOUND_MIXER_ACCESS=E2=80=99 undeclared here (not in a function)
> > >    IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
> > >          ^
> > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition o=
f
> macro =E2=80=98IOCTL=E2=80=99
> > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > >                        ^
> >
> > We expect these to be provided by the system's "linux/soundcard.h".
> > For my Debian system that's provided by the linux-libc-dev package,
> > but I imagine you have that installed or you wouldn't have got
> > this far in the configure/compile process...
>
> Further investigation shows that this is because the system has
> the 'oss4-dev' package installed, which diverts
> /usr/include/linux/soundcard.h
> and installs its own version which doesn't provide all the symbols
> that the kernel one does.
>
> Easy fix: uninstall oss4-dev.
>
> Better fix: patch QEMU to provide its own versions of these constants
> if the system headers don't.
>
>
Another related case, needing internal-to-QEMU ioctl constant definitions:

Linux namespaces and their ioctls:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

http://man7.org/linux/man-pages/man7/namespaces.7.html

http://man7.org/linux/man-pages/man2/ioctl_ns.2.html

Kernel support exist since 4.9 (amended in 4.11), but there is no
header that exposes ioctl definitions - an applications must contain
something like this:

       #ifndef NS_GET_USERNS
       #define NSIO    0xb7
       #define NS_GET_USERNS   _IO(NSIO, 0x1)
       #define NS_GET_PARENT   _IO(NSIO, 0x2)
       #endif

QEMU does not support these ioctls (regardless of the presence of
host kernel support) - however, if we had the above definitions in our
code, we could support them (of course, relying on the support in the
host kernel, otherwise we would return "unknown ioctl").

Cordially,
Aleksandar



> Utopian fix: I've wondered occasionally whether for cases like this
> where the constant is known to be the same for the host and the guest
> we should have some sort of approach which lets us use the QEMU
> copies of the linux kernel headers rather than having to rely on
> the host system, which might have an older version that restricts
> us unnecessarily on what we could support...
>
> Issue previously reported in 2016:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01421.html
>
> thanks
> -- PMM
>
>
