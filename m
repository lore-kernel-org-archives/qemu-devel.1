Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE873C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D2F218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxjJNQvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D2F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvir-0004vj-Ta
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ihvK0-0006ff-Ui
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ihvJz-0002kJ-FP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:54:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ihvJz-0002eg-5H
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:54:27 -0500
Received: by mail-wr1-x444.google.com with SMTP id q10so5853959wrm.11
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=574+0hMfTGTneBk5ZMCU2i5zduKJQvEXlGD9zX/SOEQ=;
 b=sxjJNQvJ/7Jf3HM5iKke/cvkaOjMvh/9xoxvUIc+7bB25O9gunTl1ejbrbfTUEDKx/
 2Lwg9vgEGvr3E5AY1rHQcDVv+8SdLN1EXCAU84YqZQzOKbMFkWhv0pAQssJgKNe6I7JA
 /nfdaB3cE4jgym+ojGQTjuYOIlJWeOTuX4PR6NB75Jw3XFt9iOIa05GrmDVRQUT3bxSy
 uUvCG9bmqNar2NtddxmR9gvqNGHVPu82b0r75Y5yu0OB3tiwbm9/NGXTMaPYjkXueqn2
 nidAIIlp4QlkjVvK/B78qu5+bZZYEpHq1AEa72MJoHJ9u1NCNtCxEmBUUetJR04lu1Jm
 E3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=574+0hMfTGTneBk5ZMCU2i5zduKJQvEXlGD9zX/SOEQ=;
 b=BR0LwicA5nTeyD3rlo1xlaBPl/3yDZgfTb8UPF+afZ9VeIWaLm3RtWATFFF4eSbG9U
 0nRibOskJtTzcbP2PW96b5x4Qk7dxvryaFE1pDv4ETMesYbbkq0fnQKcsTxQSfoMI2Pn
 1rof9vq5irKqdpWIACvfOpy99OtWhHj+lQZ365Sx6At62Iq/VDapZLSMRNjuVUbQhDFy
 dsWHF8+4Mj1QzbCSGP+xkFavST9r9papLoTgvxYOeiVnq2MhmIhyslBH5j0/NPWmMBcU
 DaPCUAmxq/fFMP327PtQmUzzGnsiz59vW0w7NTv07PaO60Qf11tuV0xKJ+aiueBF+mQY
 22Lw==
X-Gm-Message-State: APjAAAVE95Z0GPbXFNsh4azMibJwl5auffE7CH+heQknYI94S+ctx65m
 heXLvUFQFqL9AhKduxV0DOw8UawsXBKS/xxv+9YuEq0M
X-Google-Smtp-Source: APXvYqwYpHkzCSQZ6vcqzCML7oGjYUbA2eN/0DZ/8XIAbwegOLc3UoUFCPDw3gl1HH4G0YIngEM7bUoF9KnTm0tMoUk=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr9301585wro.202.1576760065894; 
 Thu, 19 Dec 2019 04:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-7-marcandre.lureau@redhat.com>
 <20191212120520.GJ1829331@redhat.com>
In-Reply-To: <20191212120520.GJ1829331@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Dec 2019 16:54:12 +0400
Message-ID: <CAJ+F1C+rPfZ76-=XtUB5GBEVFE931+G286XA6M4K2J5zOZgaAg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] configure: add GDBUS_CODEGEN
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Michal Privoznik <mprivozn@redhat.com>, Juan Quintela <quintela@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Dec 12, 2019 at 4:05 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Dec 11, 2019 at 05:45:04PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > gdbus-codegen generated code requires gio-unix on Unix, so add it to
> > GIO libs/cflags.
>
> What is the situation on Windows, is it still supported ?

Yes, it should build fine. Only fd-passing related code is missing.

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  configure | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 6099be1d84..68a7705df7 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3720,10 +3720,16 @@ if $pkg_config --atleast-version=3D$glib_req_ve=
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
> > @@ -6949,6 +6955,7 @@ if test "$gio" =3D "yes" ; then
> >      echo "CONFIG_GIO=3Dy" >> $config_host_mak
> >      echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
> >      echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
> > +    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
> >  fi
> >  echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
> >  if test "$gnutls" =3D "yes" ; then
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

