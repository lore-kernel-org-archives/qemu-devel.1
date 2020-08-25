Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AE5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414BF207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxxrPH5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414BF207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbt5-0000sI-HS
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAbsX-0000So-DR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAbsU-0000wl-On
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598373173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyXYL1xdOQZifPG/Zyr9Z7Jp23nBUaDqqk4ONdK+Sbw=;
 b=BxxrPH5FybMtOWp2zjduZFO/fioPdZhtwd1XADAcFju11FnlZXdTWuRBWD+7Mr70XRQgs4
 uOIOXFzXIvlEGSdJH7m12qNIXeoFumVnVnoWitCcUHJhEes5cfJmvxaMyvmwobhQtAbA8N
 vnJsdfNPITprm3N+tWjx5UjnYfMQMQ4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-3ZVBOjGvOnaj2J5E5ZMeiA-1; Tue, 25 Aug 2020 12:32:50 -0400
X-MC-Unique: 3ZVBOjGvOnaj2J5E5ZMeiA-1
Received: by mail-ej1-f70.google.com with SMTP id d24so5656896ejb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WyXYL1xdOQZifPG/Zyr9Z7Jp23nBUaDqqk4ONdK+Sbw=;
 b=j/9rgJ99DT4LreIXyttQpQ215VjPsYY02i4rLqVSHpIqazTSmsyo8UfqC0EMt/8yf4
 JYBZHMTMpG6DNISJi2FcZLyaP7yL1b5sGDDYvt9MLMP4zcXDx+GiZl0mUgZ13DvtUwAu
 97MlDaI9ke06YZ2oTHYHSQAOSmeie5mj1mANC+qqqSg3KkEqtV/n6v5RaWWda4kq46wG
 JTlgfJgdccszAJFF4YXnlkpqTW9h+r6QYWR9HJKs/mA9g6wiUVMS0e0++i4BblAFEMSi
 rBji9O55q7Tf5u1daE3cznp5+bJAuWEwS3GEWmLIIoIjcgZPS96gVqDOG81JVAhX1JJ+
 gvqQ==
X-Gm-Message-State: AOAM5305Jk3rizeYHGwNrIju2dtzEFgMQllrllVB/6BxwfAgJ8fzsri4
 oQmvvhWylcKocE0gpqS0PzkgpvkbAPJwWlWuMbNEdoIeWZBwo7HB7c64xO539Jwka0d5S3m0iy1
 bCrkhmrcODdJuCvOKREtKVC8s5AC+xZ0=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr2317013ejb.121.1598373169466; 
 Tue, 25 Aug 2020 09:32:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeh0GoCXbc4zqu8I2qCb+l3fzsTVUt66XqYkgDfVfBpxPTaLoKl8bVtwNfIFY1CgbddJ4jBH2a7JInQrqp1bk=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr2316979ejb.121.1598373169202; 
 Tue, 25 Aug 2020 09:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200825162628.182885-1-thuth@redhat.com>
In-Reply-To: <20200825162628.182885-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 18:32:37 +0200
Message-ID: <CABgObfbKSo+TLKZZ=PLMiYhKh2XX3YyvHEh-uP7kuvR7S6G1FA@mail.gmail.com>
Subject: Re: [PATCH] configure / meson: Fix building with --disable-system and
 virglrenderer
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f8290805adb64068"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Rafael Kitover <rkitover@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f8290805adb64068
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I wrote all this thinking that pixman was mandatory. We could
already move the code to detect pixman to meson.build (see
docs/devel/build-system.rst), but unless I see a patch for that in 1-2 days
I will queue this one.

Paolo

Il mar 25 ago 2020, 18:26 Thomas Huth <thuth@redhat.com> ha scritto:

> When pixman is not installed (or too old), but virglrenderer is available
> and "configure" has been run with "--disable-system", the build currently
> aborts when trying to compile vhost-user-gpu (since it requires pixman).
> Let's add a proper CONFIG_PIXMAN switch so we can skip the build of
> vhost-user-gpu when pixman is not installed or too old.
>
> Fixes: 9b52b17ba5 ("configure: Allow to build tools without pixman")
> Reported-by: Rafael Kitover <rkitover@gmail.com>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure                          | 20 +++++++++++++-------
>  contrib/vhost-user-gpu/meson.build |  3 ++-
>  meson.build                        | 12 +++++++-----
>  3 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/configure b/configure
> index b1e11397a8..bddda91477 100755
> --- a/configure
> +++ b/configure
> @@ -3925,15 +3925,18 @@ fi
>  ##########################################
>  # pixman support probe
>
> -if test "$softmmu" =3D "no"; then
> -  pixman_cflags=3D
> -  pixman_libs=3D
> -elif $pkg_config --atleast-version=3D0.21.8 pixman-1 > /dev/null 2>&1; t=
hen
> +if $pkg_config --atleast-version=3D0.21.8 pixman-1 > /dev/null 2>&1; the=
n
> +  pixman=3D"yes"
>    pixman_cflags=3D$($pkg_config --cflags pixman-1)
>    pixman_libs=3D$($pkg_config --libs pixman-1)
>  else
> +  pixman=3D"no"
> +  pixman_cflags=3D
> +  pixman_libs=3D
> +fi
> +if test "$softmmu" =3D "yes" && test "$pixman" =3D "no"; then
>    error_exit "pixman >=3D 0.21.8 not present." \
> -      "Please install the pixman devel package."
> +      "Please install the pixman devel package or use --disable-system."
>  fi
>
>  ##########################################
> @@ -8054,8 +8057,11 @@ fi
>
>  done # for target in $targets
>
> -echo "PIXMAN_CFLAGS=3D$pixman_cflags" >> $config_host_mak
> -echo "PIXMAN_LIBS=3D$pixman_libs" >> $config_host_mak
> +if test "$pixman" =3D "yes"; then
> +  echo "CONFIG_PIXMAN=3Dy" >> $config_host_mak
> +  echo "PIXMAN_CFLAGS=3D$pixman_cflags" >> $config_host_mak
> +  echo "PIXMAN_LIBS=3D$pixman_libs" >> $config_host_mak
> +fi
>
>  if [ "$fdt" =3D "git" ]; then
>    subdirs=3D"$subdirs dtc"
> diff --git a/contrib/vhost-user-gpu/meson.build
> b/contrib/vhost-user-gpu/meson.build
> index 6c1459f54a..142daebfd7 100644
> --- a/contrib/vhost-user-gpu/meson.build
> +++ b/contrib/vhost-user-gpu/meson.build
> @@ -1,5 +1,6 @@
>  if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
> -    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host
> +    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host \
> +    and 'CONFIG_PIXMAN' in config_host
>    executable('vhost-user-gpu', files('vhost-user-gpu.c', 'virgl.c',
> 'vugbm.c'),
>               link_with: libvhost_user,
>               dependencies: [qemuutil, pixman, gbm, virgl],
> diff --git a/meson.build b/meson.build
> index 7fbb7ab2fb..9eecea549c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -113,8 +113,11 @@ if 'CONFIG_GNUTLS' in config_host
>    gnutls =3D declare_dependency(compile_args:
> config_host['GNUTLS_CFLAGS'].split(),
>                                link_args:
> config_host['GNUTLS_LIBS'].split())
>  endif
> -pixman =3D declare_dependency(compile_args:
> config_host['PIXMAN_CFLAGS'].split(),
> -                            link_args: config_host['PIXMAN_LIBS'].split(=
))
> +pixman =3D not_found
> +if 'CONFIG_PIXMAN' in config_host
> +  pixman =3D declare_dependency(compile_args:
> config_host['PIXMAN_CFLAGS'].split(),
> +                              link_args:
> config_host['PIXMAN_LIBS'].split())
> +endif
>  pam =3D not_found
>  if 'CONFIG_AUTH_PAM' in config_host
>    pam =3D cc.find_library('pam')
> @@ -1095,9 +1098,7 @@ if have_tools
>    if 'CONFIG_VHOST_USER' in config_host
>      subdir('contrib/libvhost-user')
>      subdir('contrib/vhost-user-blk')
> -    if 'CONFIG_LINUX' in config_host
> -      subdir('contrib/vhost-user-gpu')
> -    endif
> +    subdir('contrib/vhost-user-gpu')
>      subdir('contrib/vhost-user-input')
>      subdir('contrib/vhost-user-scsi')
>    endif
> @@ -1278,6 +1279,7 @@ summary_info +=3D {'SDL image support':
> sdl_image.found()}
>  # TODO: add back version
>  summary_info +=3D {'GTK support':       config_host.has_key('CONFIG_GTK'=
)}
>  summary_info +=3D {'GTK GL support':
> config_host.has_key('CONFIG_GTK_GL')}
> +summary_info +=3D {'pixman support':
> config_host.has_key('CONFIG_PIXMAN')}
>  # TODO: add back version
>  summary_info +=3D {'VTE support':       config_host.has_key('CONFIG_VTE'=
)}
>  summary_info +=3D {'TLS priority':      config_host['CONFIG_TLS_PRIORITY=
']}
> --
> 2.18.2
>
>

--000000000000f8290805adb64068
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sorry, I wrote all this thinking that pixman was mandator=
y. We could already move the code to detect pixman to meson.build (see docs=
/devel/build-system.rst), but unless I see a patch for that in 1-2 days I w=
ill queue this one.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>Il mar 25 ago 2020, 18:26 Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.c=
om">thuth@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">When pixman is not installed (or too old), but virglrenderer is avail=
able<br>
and &quot;configure&quot; has been run with &quot;--disable-system&quot;, t=
he build currently<br>
aborts when trying to compile vhost-user-gpu (since it requires pixman).<br=
>
Let&#39;s add a proper CONFIG_PIXMAN switch so we can skip the build of<br>
vhost-user-gpu when pixman is not installed or too old.<br>
<br>
Fixes: 9b52b17ba5 (&quot;configure: Allow to build tools without pixman&quo=
t;)<br>
Reported-by: Rafael Kitover &lt;<a href=3D"mailto:rkitover@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">rkitover@gmail.com</a>&gt;<br>
Reported-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 20 +++++++++++++-------<br>
=C2=A0contrib/vhost-user-gpu/meson.build |=C2=A0 3 ++-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +++++++-----<br>
=C2=A03 files changed, 22 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/configure b/configure<br>
index b1e11397a8..bddda91477 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -3925,15 +3925,18 @@ fi<br>
=C2=A0##########################################<br>
=C2=A0# pixman support probe<br>
<br>
-if test &quot;$softmmu&quot; =3D &quot;no&quot;; then<br>
-=C2=A0 pixman_cflags=3D<br>
-=C2=A0 pixman_libs=3D<br>
-elif $pkg_config --atleast-version=3D0.21.8 pixman-1 &gt; /dev/null 2&gt;&=
amp;1; then<br>
+if $pkg_config --atleast-version=3D0.21.8 pixman-1 &gt; /dev/null 2&gt;&am=
p;1; then<br>
+=C2=A0 pixman=3D&quot;yes&quot;<br>
=C2=A0 =C2=A0pixman_cflags=3D$($pkg_config --cflags pixman-1)<br>
=C2=A0 =C2=A0pixman_libs=3D$($pkg_config --libs pixman-1)<br>
=C2=A0else<br>
+=C2=A0 pixman=3D&quot;no&quot;<br>
+=C2=A0 pixman_cflags=3D<br>
+=C2=A0 pixman_libs=3D<br>
+fi<br>
+if test &quot;$softmmu&quot; =3D &quot;yes&quot; &amp;&amp; test &quot;$pi=
xman&quot; =3D &quot;no&quot;; then<br>
=C2=A0 =C2=A0error_exit &quot;pixman &gt;=3D 0.21.8 not present.&quot; \<br=
>
-=C2=A0 =C2=A0 =C2=A0 &quot;Please install the pixman devel package.&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 &quot;Please install the pixman devel package or use =
--disable-system.&quot;<br>
=C2=A0fi<br>
<br>
=C2=A0##########################################<br>
@@ -8054,8 +8057,11 @@ fi<br>
<br>
=C2=A0done # for target in $targets<br>
<br>
-echo &quot;PIXMAN_CFLAGS=3D$pixman_cflags&quot; &gt;&gt; $config_host_mak<=
br>
-echo &quot;PIXMAN_LIBS=3D$pixman_libs&quot; &gt;&gt; $config_host_mak<br>
+if test &quot;$pixman&quot; =3D &quot;yes&quot;; then<br>
+=C2=A0 echo &quot;CONFIG_PIXMAN=3Dy&quot; &gt;&gt; $config_host_mak<br>
+=C2=A0 echo &quot;PIXMAN_CFLAGS=3D$pixman_cflags&quot; &gt;&gt; $config_ho=
st_mak<br>
+=C2=A0 echo &quot;PIXMAN_LIBS=3D$pixman_libs&quot; &gt;&gt; $config_host_m=
ak<br>
+fi<br>
<br>
=C2=A0if [ &quot;$fdt&quot; =3D &quot;git&quot; ]; then<br>
=C2=A0 =C2=A0subdirs=3D&quot;$subdirs dtc&quot;<br>
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/me=
son.build<br>
index 6c1459f54a..142daebfd7 100644<br>
--- a/contrib/vhost-user-gpu/meson.build<br>
+++ b/contrib/vhost-user-gpu/meson.build<br>
@@ -1,5 +1,6 @@<br>
=C2=A0if &#39;CONFIG_TOOLS&#39; in config_host and &#39;CONFIG_VIRGL&#39; i=
n config_host \<br>
-=C2=A0 =C2=A0 and &#39;CONFIG_GBM&#39; in config_host and &#39;CONFIG_LINU=
X&#39; in config_host<br>
+=C2=A0 =C2=A0 and &#39;CONFIG_GBM&#39; in config_host and &#39;CONFIG_LINU=
X&#39; in config_host \<br>
+=C2=A0 =C2=A0 and &#39;CONFIG_PIXMAN&#39; in config_host<br>
=C2=A0 =C2=A0executable(&#39;vhost-user-gpu&#39;, files(&#39;vhost-user-gpu=
.c&#39;, &#39;virgl.c&#39;, &#39;vugbm.c&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_with: libvhost_user,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: [qemuutil, p=
ixman, gbm, virgl],<br>
diff --git a/meson.build b/meson.build<br>
index 7fbb7ab2fb..9eecea549c 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -113,8 +113,11 @@ if &#39;CONFIG_GNUTLS&#39; in config_host<br>
=C2=A0 =C2=A0gnutls =3D declare_dependency(compile_args: config_host[&#39;G=
NUTLS_CFLAGS&#39;].split(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_args: config_host[&#39;GNUTLS_LI=
BS&#39;].split())<br>
=C2=A0endif<br>
-pixman =3D declare_dependency(compile_args: config_host[&#39;PIXMAN_CFLAGS=
&#39;].split(),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 link_args: config_host[&#39;PIXMAN_LIBS&#39;].spli=
t())<br>
+pixman =3D not_found<br>
+if &#39;CONFIG_PIXMAN&#39; in config_host<br>
+=C2=A0 pixman =3D declare_dependency(compile_args: config_host[&#39;PIXMAN=
_CFLAGS&#39;].split(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_args: config_host[&#39;PIXMAN_LIBS&#39=
;].split())<br>
+endif<br>
=C2=A0pam =3D not_found<br>
=C2=A0if &#39;CONFIG_AUTH_PAM&#39; in config_host<br>
=C2=A0 =C2=A0pam =3D cc.find_library(&#39;pam&#39;)<br>
@@ -1095,9 +1098,7 @@ if have_tools<br>
=C2=A0 =C2=A0if &#39;CONFIG_VHOST_USER&#39; in config_host<br>
=C2=A0 =C2=A0 =C2=A0subdir(&#39;contrib/libvhost-user&#39;)<br>
=C2=A0 =C2=A0 =C2=A0subdir(&#39;contrib/vhost-user-blk&#39;)<br>
-=C2=A0 =C2=A0 if &#39;CONFIG_LINUX&#39; in config_host<br>
-=C2=A0 =C2=A0 =C2=A0 subdir(&#39;contrib/vhost-user-gpu&#39;)<br>
-=C2=A0 =C2=A0 endif<br>
+=C2=A0 =C2=A0 subdir(&#39;contrib/vhost-user-gpu&#39;)<br>
=C2=A0 =C2=A0 =C2=A0subdir(&#39;contrib/vhost-user-input&#39;)<br>
=C2=A0 =C2=A0 =C2=A0subdir(&#39;contrib/vhost-user-scsi&#39;)<br>
=C2=A0 =C2=A0endif<br>
@@ -1278,6 +1279,7 @@ summary_info +=3D {&#39;SDL image support&#39;: sdl_i=
mage.found()}<br>
=C2=A0# TODO: add back version<br>
=C2=A0summary_info +=3D {&#39;GTK support&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0c=
onfig_host.has_key(&#39;CONFIG_GTK&#39;)}<br>
=C2=A0summary_info +=3D {&#39;GTK GL support&#39;:=C2=A0 =C2=A0 config_host=
.has_key(&#39;CONFIG_GTK_GL&#39;)}<br>
+summary_info +=3D {&#39;pixman support&#39;:=C2=A0 =C2=A0 config_host.has_=
key(&#39;CONFIG_PIXMAN&#39;)}<br>
=C2=A0# TODO: add back version<br>
=C2=A0summary_info +=3D {&#39;VTE support&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0c=
onfig_host.has_key(&#39;CONFIG_VTE&#39;)}<br>
=C2=A0summary_info +=3D {&#39;TLS priority&#39;:=C2=A0 =C2=A0 =C2=A0 config=
_host[&#39;CONFIG_TLS_PRIORITY&#39;]}<br>
-- <br>
2.18.2<br>
<br>
</blockquote></div>

--000000000000f8290805adb64068--


