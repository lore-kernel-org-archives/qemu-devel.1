Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF507C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E1520706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc1bU6WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E1520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATkr-0003PA-V9
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATk5-0002i9-4O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATk3-0004J1-D1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598341898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBBNjN0BcFjJ7Hp03L7FapHH/KWNx1oDCEJVGltOp4Q=;
 b=Nc1bU6WZoUWYwWd39mVF/pgoFXmX4/ZEQk9m+srthZr4VQn4nUcIeydgX+su/ZXvFbm2i8
 PQIKGGVN+yTE64d+hLEzRUVHPH8yA32Sixi+IdQLzR+l5IdHNzwOafQnjQbUfEvUyI0qKJ
 6ZLH//sA9xkB/Pb6U6/LMOOTlLId+jk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-gZcalU5qOw2FyBDxu55viQ-1; Tue, 25 Aug 2020 03:51:36 -0400
X-MC-Unique: gZcalU5qOw2FyBDxu55viQ-1
Received: by mail-ed1-f71.google.com with SMTP id g20so4298042edj.15
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eBBNjN0BcFjJ7Hp03L7FapHH/KWNx1oDCEJVGltOp4Q=;
 b=ka3BezjrjeB/9WPc/SzsQz7D1xVI0OJdv9rswihagK/pEtBWEcup7rn5JJkPlqROmu
 R81lSLfkKSHhO2iW9QoYR1DMlT1l6M46rPuseOvEpyQQplpmgNHI2AY3YukhMeGt+ZY5
 uq1dsUyFryl0yagE0IrQ3le4QJhLcvfgg6CkiWMW1DEEEk989WP1tq8wSZyCqZocVauF
 94HLYOsUXsSIakcTGVarzuCBffjJFbGj8/i9Oh7O8qOjrzN32Gdse7dCpDeW6ENwDEUC
 0ysk51kCsqEqwAhNgIDdmLSaLoN8sSTjtYRraSAYBeqhaXnquf6bNhqcIxvDosvHQEHp
 H98w==
X-Gm-Message-State: AOAM530YmT3AQHgOfD+JsgiMIXlS1bG5jjSh09ntQ2ioy/uziDCDXleo
 5ZPvbArW9Ig70OcTgXgwwCVaOiCZHGxRFIn8GboIxXFdHbmkEYM3OzIZ9Evp7PvoE6aRGeh26FT
 oS76dgcz8ObD6K+vMbU+myScjNFmQobA=
X-Received: by 2002:a17:906:1cc5:: with SMTP id
 i5mr6430457ejh.449.1598341895047; 
 Tue, 25 Aug 2020 00:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJe1dsB71wzN2GtOxaiUaLUSoW1G6c9cS/C8z9mxYqwrrxaQarO3085fWfd+FiQhqVlsf+G7lejfcqXt+9vlM=
X-Received: by 2002:a17:906:1cc5:: with SMTP id
 i5mr6430450ejh.449.1598341894900; 
 Tue, 25 Aug 2020 00:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200824155212.789568-1-brogers@suse.com>
In-Reply-To: <20200824155212.789568-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:51:23 +0200
Message-ID: <CABgObfYW5eZrQ=zuvdOxHZ0sLN4ff6+jVAuKDRjL-Ae_7oj0uw@mail.gmail.com>
Subject: Re: [PATCH] meson: Fix meson build with --enable-libdaxctl
To: Bruce Rogers <brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e027ee05adaef881"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e027ee05adaef881
Content-Type: text/plain; charset="UTF-8"

Queued, thanks.

Paolo

Il lun 24 ago 2020, 17:52 Bruce Rogers <brogers@suse.com> ha scritto:

> The daxctl library needs to be linked against when daxctl is asked for
> in configure.
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  configure   | 1 +
>  meson.build | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 67832e3bab..15de7d10de 100755
> --- a/configure
> +++ b/configure
> @@ -7488,6 +7488,7 @@ fi
>
>  if test "$libdaxctl" = "yes" ; then
>    echo "CONFIG_LIBDAXCTL=y" >> $config_host_mak
> +  echo "LIBDAXCTL_LIBS=$libdaxctl_libs" >> $config_host_mak
>  fi
>
>  if test "$bochs" = "yes" ; then
> diff --git a/meson.build b/meson.build
> index df5bf728b5..0a24e5c31a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -380,6 +380,10 @@ if 'CONFIG_LIBPMEM' in config_host
>    libpmem = declare_dependency(compile_args:
> config_host['LIBPMEM_CFLAGS'].split(),
>                                 link_args:
> config_host['LIBPMEM_LIBS'].split())
>  endif
> +libdaxctl = not_found
> +if 'CONFIG_LIBDAXCTL' in config_host
> +  libdaxctl = declare_dependency(link_args:
> config_host['LIBDAXCTL_LIBS'].split())
> +endif
>
>  # Create config-host.h
>
> @@ -786,7 +790,7 @@ common_ss.add(files('cpus-common.c'))
>
>  subdir('softmmu')
>
> -specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone,
> libpmem)
> +specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone,
> libpmem, libdaxctl)
>  specific_ss.add(files('exec-vary.c'))
>  specific_ss.add(when: 'CONFIG_TCG', if_true: files(
>    'fpu/softfloat.c',
> --
> 2.28.0
>
>

--000000000000e027ee05adaef881
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Queued, thanks.<div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Il lun 24 ago 2020, 17:52 Bruce Rogers &lt;<a href=3D"mailt=
o:brogers@suse.com">brogers@suse.com</a>&gt; ha scritto:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">The daxctl library needs to be linked against when da=
xctl is asked for<br>
in configure.<br>
<br>
Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank" rel=3D"noreferrer">brogers@suse.com</a>&gt;<br>
---<br>
=C2=A0configure=C2=A0 =C2=A0| 1 +<br>
=C2=A0meson.build | 6 +++++-<br>
=C2=A02 files changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/configure b/configure<br>
index 67832e3bab..15de7d10de 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7488,6 +7488,7 @@ fi<br>
<br>
=C2=A0if test &quot;$libdaxctl&quot; =3D &quot;yes&quot; ; then<br>
=C2=A0 =C2=A0echo &quot;CONFIG_LIBDAXCTL=3Dy&quot; &gt;&gt; $config_host_ma=
k<br>
+=C2=A0 echo &quot;LIBDAXCTL_LIBS=3D$libdaxctl_libs&quot; &gt;&gt; $config_=
host_mak<br>
=C2=A0fi<br>
<br>
=C2=A0if test &quot;$bochs&quot; =3D &quot;yes&quot; ; then<br>
diff --git a/meson.build b/meson.build<br>
index df5bf728b5..0a24e5c31a 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -380,6 +380,10 @@ if &#39;CONFIG_LIBPMEM&#39; in config_host<br>
=C2=A0 =C2=A0libpmem =3D declare_dependency(compile_args: config_host[&#39;=
LIBPMEM_CFLAGS&#39;].split(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_args: config_host[&#39;LIBPMEM_=
LIBS&#39;].split())<br>
=C2=A0endif<br>
+libdaxctl =3D not_found<br>
+if &#39;CONFIG_LIBDAXCTL&#39; in config_host<br>
+=C2=A0 libdaxctl =3D declare_dependency(link_args: config_host[&#39;LIBDAX=
CTL_LIBS&#39;].split())<br>
+endif<br>
<br>
=C2=A0# Create config-host.h<br>
<br>
@@ -786,7 +790,7 @@ common_ss.add(files(&#39;cpus-common.c&#39;))<br>
<br>
=C2=A0subdir(&#39;softmmu&#39;)<br>
<br>
-specific_ss.add(files(&#39;disas.c&#39;, &#39;exec.c&#39;, &#39;gdbstub.c&=
#39;), capstone, libpmem)<br>
+specific_ss.add(files(&#39;disas.c&#39;, &#39;exec.c&#39;, &#39;gdbstub.c&=
#39;), capstone, libpmem, libdaxctl)<br>
=C2=A0specific_ss.add(files(&#39;exec-vary.c&#39;))<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_TCG&#39;, if_true: files(<br>
=C2=A0 =C2=A0&#39;fpu/softfloat.c&#39;,<br>
-- <br>
2.28.0<br>
<br>
</blockquote></div>

--000000000000e027ee05adaef881--


