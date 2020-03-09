Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1119C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB8320674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAGvJjB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB8320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFBK-0006Pi-RV
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBFAb-0005xO-Pj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBFAa-0005Sk-Kr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:57:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBFAa-0005SF-Gj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583747875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dahhulqJ1OxLxH+bszUVsOOHFb1s1lLXDU+eAhpbQvw=;
 b=dAGvJjB5Nj/gYjNiytRIRwKa3dWgV4JNfNIjNmVF2Pe85lSXuax1fjRoVcYcHURT12n2Ap
 ijLjzxOysVNSOaYo5CGgdjdLf97SkiPcqowfSRn7QgIppkurS7VJHswuwiXzi55+5RFrRl
 QIl5Ohb0TAHkzQ5fHgp3V2ZtUaSdN2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-OuynL2A-Ms6wqfF4tqEE_w-1; Mon, 09 Mar 2020 05:57:53 -0400
X-MC-Unique: OuynL2A-Ms6wqfF4tqEE_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE638477;
 Mon,  9 Mar 2020 09:57:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 443F49051C;
 Mon,  9 Mar 2020 09:57:49 +0000 (UTC)
Date: Mon, 9 Mar 2020 09:57:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] configure: Fix building with SASL on Windows
Message-ID: <20200309095746.GB3033513@redhat.com>
References: <20200307172222.14764-1-philmd@redhat.com>
 <20200307172222.14764-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200307172222.14764-3-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Alexey Pavlov <alexpux@gmail.com>,
 =?utf-8?B?0JDQu9C10LrRgdC10Lkg0J/QsNCy0LvQvtCy?= <alexey.pawlow@gmail.com>,
 qemu-devel@nongnu.org,
 =?utf-8?B?0JzQtdGC0LvQuNGG0LrQuNC5INCu0YDQuNC5INCS0LjQutGC0L7RgNC+0LI=?=
 =?utf-8?B?0LjRhw==?= <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Youry Metlitsky <winaes@yandex.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 07, 2020 at 06:22:21PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The Simple Authentication and Security Layer (SASL) library
> re-defines the struct iovec on Win32 [*]. QEMU also re-defines
> it in "qemu/osdep.h". The two definitions then clash on a MinGW
> build.
> We can avoid the SASL definition by defining STRUCT_IOVEC_DEFINED.
> Add the definition to vnc_sasl_cflags if we are uing MinGW.
>=20
> [*] https://github.com/cyrusimap/cyrus-sasl/blob/cyrus-sasl-2.1.27/includ=
e/sasl.h#L187
>=20
> Cc: Alexey Pavlov <alexpux@gmail.com>
> Cc: Biswapriyo Nath <nathbappai@gmail.com>
> Cc: Youry Metlitsky <winaes@yandex.ru>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  configure | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 0c2dd1eb08..0bc87ce42a 100755
> --- a/configure
> +++ b/configure
> @@ -3375,7 +3375,13 @@ if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D =
"no" ; then
>  int main(void) { sasl_server_init(NULL, "qemu"); return 0; }
>  EOF
>    # Assuming Cyrus-SASL installed in /usr prefix
> -  vnc_sasl_cflags=3D""
> +  if test "$mingw32" =3D "yes" && test "$iovec" !=3D "yes"; then

I don't get why we need the "iovec !=3D yes" check there ?

On mingw sys/uio.h doesn't exist, so "$iovec" will always
be "no", and so this conditional is equivalent to

   if test "$mingw32" =3D "yes; then


If for some strange reason, a future Windows adds sys/uio.h
header containing struct iovec, then QEMU won't define its
own local copy if struct iovec, and so "$iovec" will be "yes".

In this situation we don't want SASL to define its struct iovec=20
either.

IOW we need -DSTRUCT_IOVEC_DEFINED no matter what $iovec value
is AFAICT.

This would mean the previous patch is redundant too.

> +    # QEMU defines struct iovec in "qemu/osdep.h",
> +    # we don't want libsasl to redefine it in <sasl/sasl.h>.
> +    vnc_sasl_cflags=3D"-DSTRUCT_IOVEC_DEFINED"
> +  else
> +    vnc_sasl_cflags=3D""
> +  fi
>    vnc_sasl_libs=3D"-lsasl2"
>    if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
>      vnc_sasl=3Dyes

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


