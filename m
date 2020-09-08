Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EC3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EAF21D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N62zdN6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EAF21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYw0-0005MW-IF
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFYvR-0004oV-Je
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:24:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFYvP-0001fb-SP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599553462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fVmz7jWX1pwvhYNJ1ndXgcxumRNQiTW5e4GTg1Xbp8=;
 b=N62zdN6lIUIGah68BcpYd5x6cV6ZWg4QEE1BsBuNunIsCuA8ML5Bech3vDB9jMmFoG+gKm
 6LU4iIR3XJz9Y22II49wXUWCro32gJU38hkoj+LSSeQlGCI3GP6IG/jX9gN/IwDumHchwH
 fYi9UsQPhhzQhwjsrDErsppTuwvLeJE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-Sp3GFa-UPfa_I44KqMzzUw-1; Tue, 08 Sep 2020 04:24:18 -0400
X-MC-Unique: Sp3GFa-UPfa_I44KqMzzUw-1
Received: by mail-ed1-f69.google.com with SMTP id z11so5893852edj.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2fVmz7jWX1pwvhYNJ1ndXgcxumRNQiTW5e4GTg1Xbp8=;
 b=nLexvmBLTk7M7O95W03tocbANE+Mm1qUzS5geG6ephqZpEs+Rphibe3rC0vJJkb97A
 EDkVW2WXrvdXP1rGhZ6AtoD2YFFerdGn8oDu4qxJMbKx6V9A3U85BNUjwG5UHNKwp6dB
 tG/nITULSnC93+KGarvu5VFySqdmI1zqwUjDUdhYi4G934hW7/+czjNkB5jMYLVlbVci
 BhW/UgiD160HQpvTJ0+nki0Zt/qbDFQH0ayXOVn85TTA+NSXbj0dWQIsNbAhQ/UUk+YD
 4NLvb0utcABwWYRo0Qz0hXYStXYBhBetgFOhxHEKOrNHyJtXX9cR3jacBW+ha2+KGTn1
 NFIQ==
X-Gm-Message-State: AOAM532RmnxUihoCddoh1Xm2Sjf0aFwSEDxXZutdbXJrCfmRGzhWSZAH
 MJcoAARiYo1ewoW9y2j2AEwmOmZo47AArM1YoLsjLZHmW1kWFjBTWW4Col6uLtKVs6gbMpNbk0w
 06mwXOa1TiM2xjL9qqi4pdGhiUPSykOw=
X-Received: by 2002:a17:906:a845:: with SMTP id
 dx5mr24229488ejb.543.1599553457686; 
 Tue, 08 Sep 2020 01:24:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTm4xMVnv3KsjpQYiR0fmg3MeycCkOl7ag/k0kdFyH9RosucqcfAH3iy0EAAm5AU30bUV6+ljvE/Ge1OjyW+U=
X-Received: by 2002:a17:906:a845:: with SMTP id
 dx5mr24229473ejb.543.1599553457471; 
 Tue, 08 Sep 2020 01:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200908074016.2593596-1-slyfox@gentoo.org>
In-Reply-To: <20200908074016.2593596-1-slyfox@gentoo.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Sep 2020 10:24:05 +0200
Message-ID: <CABgObfaqxdOuH93OB=_ioiHR3np00hwNuzvpOXD=Wte4ErkUqQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: tweak sdl-image error message
To: Sergei Trofimovich <slyfox@gentoo.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a1d85205aec90fe6"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a1d85205aec90fe6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: qemu-trivial@nongnu.org

Il mar 8 set 2020, 09:50 Sergei Trofimovich <slyfox@gentoo.org> ha scritto:

> Before the change missing SDL was reported as:
>
>     ../meson.build:253:4: ERROR: Expected 1 arguments, got 2.
>
> After the error as:
>
>     ../meson.build:258:4: ERROR: Problem encountered: sdl-image required,
> but SDL was not found
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Rafael Kitover <rkitover@gmail.com>
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 04e070bb3b..7fd2a903c5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -255,8 +255,8 @@ if sdl.found()
>                           method: 'pkg-config', static: enable_static)
>  else
>    if get_option('sdl_image').enabled()
> -    error('sdl-image required, but SDL was @0@',
> -          get_option('sdl').disabled() ? 'disabled' : 'not found')
> +    error('sdl-image required, but SDL was @0@'.format(
> +          get_option('sdl').disabled() ? 'disabled' : 'not found'))
>    endif
>    sdl_image =3D not_found
>  endif
> --
> 2.28.0
>
>

--000000000000a1d85205aec90fe6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Cc: <a href=3D"mailto:qemu-trivial@nongnu.org">qemu-trivi=
al@nongnu.org</a></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Il mar 8 set 2020, 09:50 Sergei Trofimovich &lt;<a href=3D=
"mailto:slyfox@gentoo.org">slyfox@gentoo.org</a>&gt; ha scritto:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Before the change missing SDL was reported as=
:<br>
<br>
=C2=A0 =C2=A0 ../meson.build:253:4: ERROR: Expected 1 arguments, got 2.<br>
<br>
After the error as:<br>
<br>
=C2=A0 =C2=A0 ../meson.build:258:4: ERROR: Problem encountered: sdl-image r=
equired, but SDL was not found<br>
<br>
CC: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
CC: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat=
.com</a>&gt;<br>
CC: &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;<br=
>
CC: Rafael Kitover &lt;<a href=3D"mailto:rkitover@gmail.com" target=3D"_bla=
nk" rel=3D"noreferrer">rkitover@gmail.com</a>&gt;<br>
Signed-off-by: Sergei Trofimovich &lt;<a href=3D"mailto:slyfox@gentoo.org" =
target=3D"_blank" rel=3D"noreferrer">slyfox@gentoo.org</a>&gt;<br>
---<br>
=C2=A0meson.build | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 04e070bb3b..7fd2a903c5 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -255,8 +255,8 @@ if sdl.found()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 method: &#39;pkg-config&#39;, static: enable_static)<br>
=C2=A0else<br>
=C2=A0 =C2=A0if get_option(&#39;sdl_image&#39;).enabled()<br>
-=C2=A0 =C2=A0 error(&#39;sdl-image required, but SDL was @0@&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_option(&#39;sdl&#39;).disabled() ? =
&#39;disabled&#39; : &#39;not found&#39;)<br>
+=C2=A0 =C2=A0 error(&#39;sdl-image required, but SDL was @0@&#39;.format(<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_option(&#39;sdl&#39;).disabled() ? =
&#39;disabled&#39; : &#39;not found&#39;))<br>
=C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0sdl_image =3D not_found<br>
=C2=A0endif<br>
-- <br>
2.28.0<br>
<br>
</blockquote></div>

--000000000000a1d85205aec90fe6--


