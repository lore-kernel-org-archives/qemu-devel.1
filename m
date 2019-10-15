Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74328C4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 01:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2F8217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 01:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai4hKPjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2F8217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKBLi-0000W3-Cj
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 21:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hikarupsp@gmail.com>) id 1iKBKb-00083W-BK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1iKBKa-0007qO-39
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:08:57 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1iKBKZ-0007oy-5e
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:08:55 -0400
Received: by mail-lf1-x143.google.com with SMTP id q12so13076669lfc.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y8yex0jfpdfGP+P+Cv8oF58FOiYuS24yhsgnyCFUbD4=;
 b=ai4hKPjCNkhqF1j+IY0YC8fUoAgwjkPTlL4u0maddpmlb2msaHEEDYI4unUpq+AXa8
 ya/+cfjHgv7Zf0OUivl29XBwsEjRtF/TUpNvHfUG/zX+2bb7cEVU+yf2QmZfU5AKZ9C8
 JR5pLlDNl7dCjq6NggEUBJUczTcliDgO9AYzwT3ggEcu24MBmKIWqVpjGKUERMXv225j
 05Hz8ZLXZ6g72u4X3qkwXogzsjFUqR8ERb8Xf1V7jvtuYGOMwAE4/pea3sW9HI2mfOXi
 7hvibvpN4aRSUDZD/3RbkO2Q5RQJzBw3bKNQLWbstS5d8oziIDZSB396qHqz5C4L2w+O
 l7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y8yex0jfpdfGP+P+Cv8oF58FOiYuS24yhsgnyCFUbD4=;
 b=GY/dCgVgfREVMrkJQnoOy+wg9AOEabdnL5B6g87J2hPdBhGedJ2ND0JnOmZJe1lM7k
 +k+qUloSgM/WJh0YvJZ41iczpppPt1gw4XuHg3LJtVdpyM4P7YkYAMuv+MWySJSX3KpV
 gQ/QUu8SeUxxPI+vTlj1shti81Wapag1fuDZf2vVkUhNhX9nnQafR7olrevebdMpuvoN
 aDSx0jO1xpmldpsr1li6gG8XVfoTuXtQkvghimLnbyfNp41x+Cg/w2mHzkqbE9XHdjEh
 571l6cC1P7R1ICioqbCQEjz2U0ryBg4Jx1lbKT6beDKumzSNi8dj3OAlfR0yjnjCLI8Y
 Nilw==
X-Gm-Message-State: APjAAAXX9IzHrB1m4oG9g8jAwGHOoz3wy+9d7P60uimm856exDh0ajpl
 tQhsWds7O1wrfIoYB00UnuBNzFJ+0rkce8dUVsU=
X-Google-Smtp-Source: APXvYqwC/vFCEwMy6odb/FaXH6LJQ8r7jr8mJsd5gYZ2SFGFlOHkxsFUTHx01WG7RjEwSA8lTWtkD6aj9V7NWddvSfs=
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr19363356lfq.38.1571101732824; 
 Mon, 14 Oct 2019 18:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191014141608.80923-1-hikarupsp@gmail.com>
 <CAFEAcA8nG9gLd3-mgpy6eTPfYPcpJDGS8EV-aRQPRTq=NuHYvA@mail.gmail.com>
In-Reply-To: <CAFEAcA8nG9gLd3-mgpy6eTPfYPcpJDGS8EV-aRQPRTq=NuHYvA@mail.gmail.com>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Tue, 15 Oct 2019 10:08:41 +0900
Message-ID: <CAD-w0GCF7RN6To0o63FN9Fuds_xyQEvS97B4BM3xpotyh0Acfw@mail.gmail.com>
Subject: Re: [PATCH v2] ui: Fix hanging up Cocoa display on macOS 10.15
 (Catalina)
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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

> I think we don't need to mark this 'volatile sig_atomic_t',
> but could use a simple 'bool', because both applicationDidFinishLaunching=
()
> and handleEvent() are called from the same thread (the OSX run loop
> thread).

Oh, I didn't notice that.
I replaced 'volatile sig_atomic_t' with 'static bool' because it only
requires a file scope, and confirmed the allow_events is referenced by
the same thread.

* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D breakpoint =
1.1
    frame #0: 0x00000001004be802 qemu-system-x86_64`-[QemuCocoaView
handleEvent:](self=3D0x0000000111e46650, _cmd=3D"handleEvent:",
event=3D0x0000000111ebdc30) at cocoa.m:733:8
   730
   731  - (bool) handleEvent:(NSEvent *)event
   732  {
-> 733      if(!allow_events) {
   734          /*
   735           * Just let OSX have all events that arrive before
   736           * applicationDidFinishLaunching.
(lldb) c
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D breakpoint =
2.1
    frame #0: 0x00000001004c01e4
qemu-system-x86_64`-[QemuCocoaAppController
applicationDidFinishLaunching:](self=3D0x0000000111e46540,
_cmd=3D"applicationDidFinishLaunching:",
note=3D@"NSApplicationDidFinishLaunchingNotification") at
cocoa.m:1170:18
   1167 - (void)applicationDidFinishLaunching: (NSNotification *) note
   1168 {
   1169     COCOA_DEBUG("QemuCocoaAppController:
applicationDidFinishLaunching\n");
-> 1170     allow_events =3D true;
   1171     /* Tell cocoa_display_init to proceed */
   1172     qemu_sem_post(&app_started_sem);
   1173 }

I resent the patch v3. Thanks!


Hikaru Nishida

2019=E5=B9=B410=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:16 Peter Maydell <peter.ma=
ydell@linaro.org>:
>
> On Mon, 14 Oct 2019 at 15:16, <hikarupsp@gmail.com> wrote:
> >
> > From: Hikaru Nishida <hikarupsp@gmail.com>
> >
> > macOS API documentation says that before applicationDidFinishLaunching
> > is called, any events will not be processed. However, some events are
> > fired before it is called in macOS Catalina. This causes deadlock of
> > iothread_lock in handleEvent while it will be released after the
> > app_started_sem is posted.
> > This patch avoids processing events before the app_started_sem is
> > posted to prevent this deadlock.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
> > Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> > ---
> >  ui/cocoa.m | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index f12e21df6e..bccd861d16 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -134,6 +134,7 @@
> >
> >  static QemuSemaphore display_init_sem;
> >  static QemuSemaphore app_started_sem;
> > +volatile sig_atomic_t allow_events;
>
> Sorry, I failed to spot this on version 1 of the patch...
> I think we don't need to mark this 'volatile sig_atomic_t',
> but could use a simple 'bool', because both applicationDidFinishLaunching=
()
> and handleEvent() are called from the same thread (the OSX run loop
> thread).  Could you test that it still works with plain 'bool',
> please?
>
> (If we did need to handle multiple thread accesses we should
> probably prefer one of the QEMU atomic primitives described
> in docs/devel/atomics.txt, since 'volatile' isn't really sufficient.)
>
> thanks
> -- PMM

