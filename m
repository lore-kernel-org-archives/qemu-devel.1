Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D5FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAAD20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye/p3IEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAAD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0cD-0001Aw-9J
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hikarupsp@gmail.com>) id 1iK0b2-0000LE-A4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1iK0b1-0002TA-2p
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:41:12 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1iK0b0-0002Rs-RN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:41:11 -0400
Received: by mail-lj1-x243.google.com with SMTP id n14so16654699ljj.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Uy2XlV3QAbCqTNm1WdW0WJ6DYDBj76kl2PpYn3m1PGs=;
 b=Ye/p3IEpExzaCFLrF0od96YVzbi4OEwiM45YoeI91m+iHbwY7QWOWt0jZQwIhVNaZF
 Tuu7G5RE7rQv7cz8lnyc9oDo2CXRIwxpsNV3IVR5ZrE/TQVmTjoL/dUq28lYD3nx8Lv8
 j8mTEOmgVkmVaIPg3DgKVKFJFoHkxb8CGRSNbTwZngcWF/Jku3z6rRex3gdZlNSlR2v9
 1G6yztSENqYRYAyrq0WH50Vl8bp1Qs0Vg0hzHktB+b0qO1MWi017U7XauV/5NOmMyGae
 bmlf1iTfWfOLSz+8iooExRiNh8ZS9q2I7rCVW5oFfGOb/ARGhktPNRzQ1CAIlANouWSP
 HyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Uy2XlV3QAbCqTNm1WdW0WJ6DYDBj76kl2PpYn3m1PGs=;
 b=aQ/kyxdCFv8D8NAEnFXnZObqr5neUnVKkgcARDCnAueuhnUtTAy5dIQbxpAmUsh6Hf
 l8S7yv5b3RVUxFSZz8IVCF5TFRgca5JeUUsw6nvPRVv/Kt+EvJ9c/DRYACHfNqCppmky
 buu16/2np9ViXVhqVtAIP0rxbfuNOqlEmJH6H4xcbsLjYyZrujxfyIX90vTaBAg7x777
 n5InZxYYh6E2HSAQnhYjxLtiFivN/hZ/VAcIToQ+MDIWRlLonVXsKSCUkxsTNBsroxdk
 EAIyW+0vT7cisM50VcnL6doWrLKIqXnEPMpCCgA2r2UTjfpVEG4Qwpu5GguDxVoGSY6J
 qYJQ==
X-Gm-Message-State: APjAAAU6ggH+PZWtg4aG6NBEMOKL0zpkOh/s60xQxm+RM0/QnHKxH145
 XdpXT141FGr1/YWJZChtX4cRkGYlAEDd7+EX2S0=
X-Google-Smtp-Source: APXvYqx5FFuwofbLvOw9aGkyZZ8j7BkO8WtZYM7n7SKPZHA4fcajt1On/nGqrrU45nR3Nao9JkKh/90OBYgupWTcDGg=
X-Received: by 2002:a05:651c:1069:: with SMTP id
 y9mr9078054ljm.171.1571060468719; 
 Mon, 14 Oct 2019 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191014125254.74913-1-hikarupsp@gmail.com>
 <CAFEAcA-iaUraj+AZuGcXw6pNy2aBQ2J0Cm9900COsY+quJc2tA@mail.gmail.com>
In-Reply-To: <CAFEAcA-iaUraj+AZuGcXw6pNy2aBQ2J0Cm9900COsY+quJc2tA@mail.gmail.com>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Mon, 14 Oct 2019 22:40:57 +0900
Message-ID: <CAD-w0GAzUvF_ckFviFa+Am2Wph2xGH2ywUAN15hunofaM2OBDw@mail.gmail.com>
Subject: Re: [PATCH] This patch fixes hanging up Cocoa display on macOS 10.15
 (Catalina)
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for your reply.

The event gets fired before applicationDidFinishLaunching is: (output
of  NSLog(@"event: %@", event);)
event: NSEvent: type=3DKitdefined loc=3D(0,1440) time=3D164310.0 flags=3D0x=
40
win=3D0x0 winNum=3D0 ctxt=3D0x0 subtype=3D1 data1=3D834 data2=3D0

I moved allow_events =3D true just before
qemu_sem_post(&app_started_sem) and it also works.


Hikaru Nishida
(resending in plaintext)


2019=E5=B9=B410=E6=9C=8814=E6=97=A5(=E6=9C=88) 22:19 Peter Maydell <peter.m=
aydell@linaro.org>:
>
> On Mon, 14 Oct 2019 at 13:53, <hikarupsp@gmail.com> wrote:
> >
> > From: Hikaru Nishida <hikarupsp@gmail.com>
> >
> > An NSEvent is fired before applicationDidFinishLaunching on macOS
> > Catalina. This causes deadlock of iothread_lock by calling
> > bool_with_iothread_lock in handleEvent while its already locked.
> > This patch prevents to call bool_with_iothread_lock until the
> > app_started_sem is released to prevent this deadlock.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
> > Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> > ---
> >  ui/cocoa.m | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index f12e21df6e..f16d341a0a 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -134,6 +134,7 @@
> >
> >  static QemuSemaphore display_init_sem;
> >  static QemuSemaphore app_started_sem;
> > +volatile sig_atomic_t allow_events;
> >
> >  // Utility functions to run specified code block with iothread lock he=
ld
> >  typedef void (^CodeBlock)(void);
> > @@ -729,6 +730,9 @@ - (void) handleMonitorInput:(NSEvent *)event
> >
> >  - (bool) handleEvent:(NSEvent *)event
> >  {
> > +    if(!allow_events) {
> > +        return false;
> > +    }
> >      return bool_with_iothread_lock(^{
> >          return [self handleEventLocked:event];
> >      });
> > @@ -1897,6 +1901,7 @@ static void cocoa_display_init(DisplayState *ds, =
DisplayOptions *opts)
> >      /* Tell main thread to go ahead and create the app and enter the r=
un loop */
> >      qemu_sem_post(&display_init_sem);
> >      qemu_sem_wait(&app_started_sem);
> > +    allow_events =3D true;
> >      COCOA_DEBUG("cocoa_display_init: app start completed\n");
>
> If we do use a flag to fix this race, I think it would be
> better to set allow_events =3D true in the
> applicationDidFinishLaunching() function before posting
> the app_started_sem. Otherwise there's a window after
> applicationDidFinishLaunching() returns but before
> cocoa_display_init() resumes and sets the flag where we
> will unnecessarily drop events.
>
> Could you try that and check that it still fixes the hang?
>
> thanks
> -- PMM

