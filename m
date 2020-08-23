Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38673C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F121120774
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCuRDz5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F121120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9wr7-0004tE-8C
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 16:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9wqZ-0004UT-5T
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 16:44:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9wqX-0003P6-Al
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 16:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598215448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCqyY9kUR017A/v6kDaKhNoxxChDh/MaVh+spd2Lbf0=;
 b=hCuRDz5Q03xbKsvApqbQ6CYqYVkfNlXZA9COqiszbX/35FesPHLGEQI0QLfwhPEn9tPr8b
 MDsCUpVTTTuM5KMChXtefeTMvnqewmomjk1JOalSidGxGHYBhAXudRhhEmU91kmV6OmTpJ
 FwCnYsBSVQtTRGOmN4ztcycupJzoe60=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-x6Dob_aTNyeH6783gv1K1Q-1; Sun, 23 Aug 2020 16:44:03 -0400
X-MC-Unique: x6Dob_aTNyeH6783gv1K1Q-1
Received: by mail-ed1-f69.google.com with SMTP id dj21so286118edb.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 13:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MCqyY9kUR017A/v6kDaKhNoxxChDh/MaVh+spd2Lbf0=;
 b=BjzhgclFm793hoTXGDeVmCj9L4oJ63pF3vPmY41g2Eji2tdIOne67GNsN8+zUktR/E
 fgVa8WWt6ycqmJDMHDbcVuvdJT3UwTlH2UMOaBq3yf4MD1FGM78iz9UR5TgKONpMKjFY
 tuax97V/5y3V8kWIoOejQ2F6eNBMcnXmhslpglegNqpDra3cJPp6wOOkVLP9DIXPy0GD
 G6cTdN8/trNNLZWVYUgsZ28Xb6c2zRSdd7Z7Jtt75J2kb5Xi+m0VxHyTYn4b9YZhz6t4
 EPHldZIugxfqqJV83l0zWz7834d6TcYQxITdeIyxhRA6TV04ZQR16xFaGkfUkmAGjeI6
 VdCA==
X-Gm-Message-State: AOAM530M3dSVbDR3v5BW+5pyw3VtSpoyRZJ+J2mg76WJMfjtJ9GCxLHh
 Z/92PDGJaiMAsuTRrA/DPh3VIC50kmqpMlCdIsJWViufEzxh8C3XINTBZKalIwohGx1vxQGo1C2
 Ao3Xor7HGJA2LRI6oG+DbmwHQjSswbJ8=
X-Received: by 2002:a50:c38b:: with SMTP id h11mr2682437edf.308.1598215442290; 
 Sun, 23 Aug 2020 13:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYvgRjuaS3GtQqXZf9E1wy/X2JzOlv68Gs+nQ0s/aj8/5+9wXDtR9W/FxQ4O02PiSshtuQHOarX7c3gpEVPiM=
X-Received: by 2002:a50:c38b:: with SMTP id h11mr2682423edf.308.1598215441939; 
 Sun, 23 Aug 2020 13:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200823135644.1143953-1-laurent@vivier.eu>
In-Reply-To: <20200823135644.1143953-1-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 23 Aug 2020 22:43:50 +0200
Message-ID: <CABgObfY2w6vriSTJ1+p-fj=AZbGBXbNT4ddgUadH2cwoFEkpwQ@mail.gmail.com>
Subject: Re: [PATCH] configure: avoid compiling qemu-keymap by default
To: laurent@vivier.eu, qemu-devel <qemu-devel@nongnu.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000b13c7905ad918756"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 16:44:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b13c7905ad918756
Content-Type: text/plain; charset="UTF-8"

Hi Laurent, there are two ways to do this in Meson without having to add
more special casing in configure.

The simplest is to build qemu-keymap by default only if have_tools. This is
a one-liner adding the "build_by_default: have_tools" argument.

The second is to move the detection of xkbcommon to Meson, and putting it
under "if have_system || have_tools", that is where meson.build has the
qemu-keymap executable you do

xkbcommon = not_found
if have_system || have_tools
  xkbcommon = ...
endif
if xkbcommon.found()
  qemu_keymap = ...
endif

and CONFIG_XKBCOMMON can also be replaced by xkbcommon.found().

This is a bit more complicated but all the parts are explained in
docs/devel/build-system.rst.

Feel free to pick the simplest of the two, I just explained both just in
case. When I am back I can also explain you on IRC the way I translated the
syscall_nr.h generator.

Thanks,

Paolo

Il dom 23 ago 2020, 22:32 <no-reply@patchew.org> ha scritto:

> qemu-keymap is not needed with linux-user, so disable it by default if
> tools are disabled (tools are disabled by default with linux-user).
>
> Avoid this error with statically linked binaries:
>
>     Linking target qemu-keymap
>     /usr/bin/ld: cannot find -lxkbcommon
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/configure b/configure
> index d9ca87fbbb52..2cab3330d010 100755
> --- a/configure
> +++ b/configure
> @@ -3448,6 +3448,11 @@ fi
>
>  ##########################################
>  # xkbcommon probe
> +if test -z "$xkbcommon"; then
> +  if test "$want_tools" = "no"; then
> +    xkbcommon=no
> +  fi
> +fi
>  if test "$xkbcommon" != "no" ; then
>    if $pkg_config xkbcommon --exists; then
>      xkbcommon_cflags=$($pkg_config xkbcommon --cflags)
> --
> 2.26.2
>
>
>
>

--000000000000b13c7905ad918756
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Laurent, there are two ways to do this in Meson w=
ithout having to add more special casing in configure.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">The simplest is to build qemu-keymap by defa=
ult only if have_tools. This is a one-liner adding the &quot;build_by_defau=
lt: have_tools&quot; argument.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">The second is to move the detection of xkbcommon to Meson, and putti=
ng it under &quot;if have_system || have_tools&quot;, that is where meson.b=
uild has the qemu-keymap executable you do</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">xkbcommon =3D not_found</div><div dir=3D"auto">if have_s=
ystem || have_tools</div><div dir=3D"auto">=C2=A0 xkbcommon =3D ...</div><d=
iv dir=3D"auto">endif</div><div dir=3D"auto">if xkbcommon.found()</div><div=
 dir=3D"auto">=C2=A0 qemu_keymap =3D ...</div><div dir=3D"auto">endif</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">and CONFIG_XKBCOMMON can also=
 be replaced by xkbcommon.found().</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">This is a bit more complicated but all the parts are explained i=
n docs/devel/build-system.rst.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Feel free to pick the simplest of the two, I just explained both jus=
t in case. When I am back I can also explain you on IRC the way I translate=
d the syscall_nr.h generator.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo<br><=
br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_=
attr">Il dom 23 ago 2020, 22:32  &lt;<a href=3D"mailto:no-reply@patchew.org=
">no-reply@patchew.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">qemu-keymap is not needed with linux-user, so disable it by default=
 if<br>
tools are disabled (tools are disabled by default with linux-user).<br>
<br>
Avoid this error with statically linked binaries:<br>
<br>
=C2=A0 =C2=A0 Linking target qemu-keymap<br>
=C2=A0 =C2=A0 /usr/bin/ld: cannot find -lxkbcommon<br>
<br>
Signed-off-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" targ=
et=3D"_blank" rel=3D"noreferrer">laurent@vivier.eu</a>&gt;<br>
---<br>
=C2=A0configure | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/configure b/configure<br>
index d9ca87fbbb52..2cab3330d010 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -3448,6 +3448,11 @@ fi<br>
<br>
=C2=A0##########################################<br>
=C2=A0# xkbcommon probe<br>
+if test -z &quot;$xkbcommon&quot;; then<br>
+=C2=A0 if test &quot;$want_tools&quot; =3D &quot;no&quot;; then<br>
+=C2=A0 =C2=A0 xkbcommon=3Dno<br>
+=C2=A0 fi<br>
+fi<br>
=C2=A0if test &quot;$xkbcommon&quot; !=3D &quot;no&quot; ; then<br>
=C2=A0 =C2=A0if $pkg_config xkbcommon --exists; then<br>
=C2=A0 =C2=A0 =C2=A0xkbcommon_cflags=3D$($pkg_config xkbcommon --cflags)<br=
>
-- <br>
2.26.2<br>
<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000b13c7905ad918756--


