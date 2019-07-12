Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01030C742D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F94204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD9yBU5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F94204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzdo-0000x9-16
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlzdb-0000Yl-RT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlzdW-0006pM-83
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:47:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlzdW-0006mV-0c
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:47:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so10765574wru.13
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jF1MRgtmJ7zywyfhh+VuyjpUk4QqOlRIUccTzmib8mY=;
 b=cD9yBU5VnHIOHvSgXvWdJ0JXQ1CPFCiwUq8yHvk+SqS/0UnZVVMHxjLGQfe3TKu2aM
 BUB2SmlRaNjMY06FS6irJG3MeJ7FLcX4v30JO+wrvVzlUtCuLV7JF+Wneo9lfBM9Yh2s
 khj2ZH6HO4DyPw3Op24b4b5a9qW9MeuK/Xw55PhiX4JtYf65ynoysaQY7D7QIXJVL5xw
 UuhFHkK6US+gtPsTvpOn9pmAmqoyMuucHt275XeoKakh3hA9sI3MLLYKpDZqIVNXW5Ke
 uo1wUzJWTRtX8UwZKpI4BAG3ETRt6RHV09ug8lm8WrKQOT9jQmjjgvrBUEuR0Dd4o8ie
 ci0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jF1MRgtmJ7zywyfhh+VuyjpUk4QqOlRIUccTzmib8mY=;
 b=Qh3tuVYv0GFUUBV0AVhnTxrjv/0fMCvVrN2si1Rb2Onel/40ax31v61UU7ckFbpQzF
 S2/JsCxp4+u4ky6AcJyhYx0CLVCQlWQ1O/qoeLRVPx+VdnrjJvD39cuvlfXRuQCK8VKz
 9IW4I5f/S3aDRwNDQXOZ0rluJbIvFKuBhA7pyFggmCWitjQtcfq1n7o9it3OqR2G7lMS
 ariuho2nFlUa1++x//8IhPDtgneZRjL6GXSMuZ5Sx5K7NCHUZx1h9ZFCymqG7g4DJICH
 V5uTpjQ+sjsyDmCrxVWRHn2HrZnvwDj9+i3MrI8gGOB0UN3OAY906RWilGMYGQ/Mt6PZ
 j+gA==
X-Gm-Message-State: APjAAAW3hHw7/P0vLaFX1gynrWpattmP8EuPqjZVHBPaT0jyoqQCOXJ9
 Gv8DGCskqUMaHDefDIzqPQgU8jSUv0BdcrPD0oY=
X-Google-Smtp-Source: APXvYqxSVHh+a8DYxMZuRcjuVKL04WA9npIgd3Xe2LpHfcc4xQacKW8kP5FkAVGwmXrAHEr0Or+bHaEe6YPYyRb98iY=
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr12112585wrv.186.1562953628637; 
 Fri, 12 Jul 2019 10:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190712172743.17632-1-marcandre.lureau@redhat.com>
 <f9a3ad2f-e895-d4e4-6aee-8d956f907e9b@redhat.com>
In-Reply-To: <f9a3ad2f-e895-d4e4-6aee-8d956f907e9b@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jul 2019 21:46:56 +0400
Message-ID: <CAJ+F1CK2wgSsmFFnrhdRKh-pFh-JK5Ov3t34hVf2cB6THpYv0Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] build-sys: remove slirp cflags from
 main-loop.o
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jul 12, 2019 at 9:37 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> On 7/12/19 7:27 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Left over from c2d63650d962612cfa1b21302782d4cd12142c74.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > ---
> >  util/Makefile.objs | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/util/Makefile.objs b/util/Makefile.objs
> > index 38178201ff..68af3cd5e9 100644
> > --- a/util/Makefile.objs
> > +++ b/util/Makefile.objs
> > @@ -3,7 +3,6 @@ util-obj-y +=3D bufferiszero.o
> >  util-obj-y +=3D lockcnt.o
> >  util-obj-y +=3D aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
> >  util-obj-y +=3D main-loop.o iohandler.o
> > -main-loop.o-cflags :=3D $(SLIRP_CFLAGS)
> >  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) +=3D atomic64.o
> >  util-obj-$(CONFIG_POSIX) +=3D aio-posix.o
> >  util-obj-$(CONFIG_POSIX) +=3D compatfd.o
> >
>
> Since you are looking at slirp, I'm having a bunch of:
>
> $ make help
> [...]
>   CC      slirp/src/tftp.o
> Package glib-2.0 was not found in the pkg-config search path.
> Perhaps you should add the directory containing `glib-2.0.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'glib-2.0' found
>   CC      slirp/src/udp6.o
> Package glib-2.0 was not found in the pkg-config search path.
> Perhaps you should add the directory containing `glib-2.0.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'glib-2.0' found
> [...]
>
> On MinGW.

On "cross-mingw" I suppose

> I can silent the warnings using (32-git build):
>
> PKG_CONFIG_PATH=3D/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/pkgconfig

Hmm that looks like a pkg-config configuration issue to me.

>
> This is new since the slirp split.
>
> Any idea where to fix that?
>

Compile and install libslirp shared lib, ./configure --enable-slirp=3Dsyste=
m :)

Btw, I wonder if we can already warn about deprecation of
--enable-slirp=3Dgit. Peter is that too early for 4.1? (first libslirp
was released last month)


--=20
Marc-Andr=C3=A9 Lureau

