Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB3C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C82208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv4cH5VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C82208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios6d-00077I-0D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ioruH-0002Wp-AO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ioruE-0003Aa-O0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:40:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ioruE-00039B-Fu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578415233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ijb+I/w5fooBGV7tHXtFatEAkdbihBD54nk3sX98BBM=;
 b=dv4cH5VPQkfypwK2glpexbYW6mPNgTxvR9gMEWQ9czG+LS/ofKjiRTB0jioHko/Z8DcsI8
 UggUuVsmxK3ZUpt8R6oXuZ/9F5gTcPoIGtss2t/H5lPTW8FeQo1RGYwIKDxmJh5Bx01Rg6
 +EUP1dgHF/geWh9hpxpfj0DnI7tm/mA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-5z1Nwt05OQCDddqQ-qDrKA-1; Tue, 07 Jan 2020 11:40:32 -0500
Received: by mail-oi1-f200.google.com with SMTP id q204so221588oic.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ijb+I/w5fooBGV7tHXtFatEAkdbihBD54nk3sX98BBM=;
 b=H5kocR3s6LUnoQ+sCL1rirudNnF01+hzUSPckUHhLLDAX9AEH2ro9ZtEnnt4FVH5cs
 5RwWebhQ0CvqUOufCXwetCxwTpe8ukAIk+m3AkmdZfxoLaeccao8iOmVx/QlDHKlxD0Z
 fBr3oB1O1u7oQKwlMoK+Ulz7jnydq4e8KVooy7qqGxp4Bvqc7mX2v9TzqqD9F9alMK4M
 m5fv9+g3VsKwivY3Z7HBApvaF87di94iL3yYeA/Sjq+NDZuJDSHL6mGuQ4lvXqPtNJe/
 R0a0LEorTCsYyE8MEJQ08eDgxapFeXVzL859u78ynunEUZMRF32QDETcWkBIRRCmyl/i
 fv8w==
X-Gm-Message-State: APjAAAXvWRAx+t2ODNk5qSkxPZzJtp1/QVSOquc4Z9XNUwRygPByZOtt
 KoH3iv1QYG/0ANrZRKM9SNzgB/PLz+khMUZRb1O7CtCBha2i8imgfbgQx3JsLRdA3nGH9e4pmfm
 kgi0mJt2SrWx2eX95CFQ8g5oSh8AEYcI=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr649849otk.62.1578415231907;
 Tue, 07 Jan 2020 08:40:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbjPVXgunlcV7pDmMFW31ZeYjgKvvu/sEIdSIaqmz+QCGLhCx/pKeW64T8gnREV0KtVJPVvMm0GiVkilie+cA=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr649821otk.62.1578415231686;
 Tue, 07 Jan 2020 08:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
 <20200106144622.1520994-7-marcandre.lureau@redhat.com>
 <CAFEAcA8c3A_zXcHRF3kj9z3C2AtLLPatQ=h=NX2+Ywzj+OiyVg@mail.gmail.com>
In-Reply-To: <CAFEAcA8c3A_zXcHRF3kj9z3C2AtLLPatQ=h=NX2+Ywzj+OiyVg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Jan 2020 20:40:01 +0400
Message-ID: <CAMxuvazSBkowtk1p_tDFs+j8TJ53TfuCKjyBDeDVP3Yuj_uoEw@mail.gmail.com>
Subject: Re: [PULL v2 6/9] configure: add GDBUS_CODEGEN
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: 5z1Nwt05OQCDddqQ-qDrKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Jan 7, 2020 at 8:14 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Mon, 6 Jan 2020 at 14:47, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > gdbus-codegen generated code requires gio-unix on Unix, so add it to
> > GIO libs/cflags.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  configure | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 747d3b4120..0ce2c0354a 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3701,10 +3701,16 @@ if $pkg_config --atleast-version=3D$glib_req_ve=
r gio-2.0; then
> >      gio=3Dyes
> >      gio_cflags=3D$($pkg_config --cflags gio-2.0)
> >      gio_libs=3D$($pkg_config --libs gio-2.0)
> > +    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
> >  else
> >      gio=3Dno
> >  fi
> >
> > +if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
> > +    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
> > +    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
> > +fi
> > +
> >  # Sanity check that the current size_t matches the
> >  # size that glib thinks it should be. This catches
> >  # problems on multi-arch where people try to build
> > @@ -6904,6 +6910,7 @@ if test "$gio" =3D "yes" ; then
> >      echo "CONFIG_GIO=3Dy" >> $config_host_mak
> >      echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
> >      echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
> > +    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
> >  fi
>
> I've just noticed that this seems to cause problems for
> the NetBSD VM, because pkg-config reports a value for
> gdbus_codegen which isn't an installed binary:
>
> localhost$ pkg-config --variable=3Dgdbus_codegen gio-2.0
> /usr/pkg/bin/gdbus-codegen
> localhost$ ls /usr/pkg/bin/gdbus-codegen
> ls: /usr/pkg/bin/gdbus-codegen: No such file or directory
>
> I think we need to install the 'gdbus-codegen' package in
> our netbsd VM image.
>
> Maybe configure should check that it's actually got
> an executable file before trying to use it?

Sure, that should be enough:

+    if [ ! -x "$gdbus_codegen" ]; then
+        gdbus_codegen=3D
+    fi

I can send the patch.


