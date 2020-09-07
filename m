Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E272145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBqRceT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E272145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNKS-0001IW-80
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFNJg-0000n5-RS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:00:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kFNJe-0007oh-GY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599508836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=htem0mn5CXTTJJtCP7lOx6IfqTX9nm2gFd1vZN9bU10=;
 b=YBqRceT8Ti3xd6DVNnJDzCaxQXCK/dMhxxnydnZEC3xRGwhmtJkE/Fp4e9WVNV17LJLryI
 LQpdg49OeDlECTbOmptIa6jgzC3hMnuJEP70MCoTtVKyJ+ujq2Hmcu4XcVgmxpUmrSKgDM
 pnsEDfMqvDKGXjT1HGl5fLXBcLWYV+U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-acXR32HTN1i9yDojGmo-gg-1; Mon, 07 Sep 2020 16:00:32 -0400
X-MC-Unique: acXR32HTN1i9yDojGmo-gg-1
Received: by mail-ej1-f71.google.com with SMTP id ml20so5851742ejb.23
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=htem0mn5CXTTJJtCP7lOx6IfqTX9nm2gFd1vZN9bU10=;
 b=hEdU4jrVLdCIQ5KD30PsFyYdi5t1j3TOPMzvjrK78tlG+ot5IvGBeIBz9q/hkbEcEH
 TdSqcPLSpq9w1bia2fds33JhzT/pDz3I+nDKZvWo5QKi+BlQtpGzNRIkBIj73p4s8jKc
 I2trH9vm0sWKvKQeOahZSo2vCHgurjLFUhrZ1+PC1O1WDq8e2CCTIIzqFBODwH15kYLZ
 b8S+grhK6On4yJxOcV11ZZvZkCWRt3J7BRBVZj/BK/I7xAxc2jBnfO5ZQfQYBF7kSifg
 sEkr65/oCaNaYpBxxkwWM6vqKYMEZgBUdEb5oJ6AP1GU5ZPYgOC9jN22MK9oK35kntWJ
 rcKA==
X-Gm-Message-State: AOAM530ASTGNvkrKYrmjxilRspEblNwVpmbvoSbyg13ozHPq3O96uigk
 5CXRVhBdxylrsirJHX14lBNzc6Ucfrnn1Kux3Pa84MA2Mdx0Okhgju4+jUFJBBVsULkamQLPqff
 0oYAT6P0r2yD9RZfnMA/7GHs2fQKWNTI=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr21928229ejb.121.1599508831205; 
 Mon, 07 Sep 2020 13:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4oMuy+QcoIOpeBvu7AdkCunUzr3SDbsMmomdt6W5GmYey2gQhCxSe5NsvuRAaw3FbLWx6A/grfhlbrhVZjFk=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr21928220ejb.121.1599508831012; 
 Mon, 07 Sep 2020 13:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200907195025.2308-1-luoyonggang@gmail.com>
 <20200907195025.2308-3-luoyonggang@gmail.com>
In-Reply-To: <20200907195025.2308-3-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Sep 2020 22:00:19 +0200
Message-ID: <CABgObfasCYQhiX5YnOPH5CEZ3ev=QNuqbyEv=LUjvibug=4mwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] meson: Fixes jemalloc and tcmalloc can not
 building.
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000b022f505aebeab22"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b022f505aebeab22
Content-Type: text/plain; charset="UTF-8"

Hi, LIBS is going away soon. I have a few more Meson patches including one
for tcmalloc and jemalloc, I won't post them super soon though.

Paolo

Il lun 7 set 2020, 21:50 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> Currently, the LIBS are not exposed to meson and meson didn't use that
> Use base_lib = declare_dependency(link_args: config_host['LIBS'].split())
> to force use it
>
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure   | 9 +++++++++
>  meson.build | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 823756f4a4..7b2f3d64b0 100755
> --- a/configure
> +++ b/configure
> @@ -7245,6 +7245,14 @@ if test "$libxml2" = "yes" ; then
>    echo "LIBXML2_LIBS=$libxml2_libs" >> $config_host_mak
>  fi
>
> +if test "$tcmalloc" = "yes" ; then
> +  echo "CONFIG_TCMALLOC=y" >> $config_host_mak
> +fi
> +
> +if test "$jemalloc" = "yes" ; then
> +  echo "CONFIG_JEMALLOC=y" >> $config_host_mak
> +fi
> +
>  if test "$replication" = "yes" ; then
>    echo "CONFIG_REPLICATION=y" >> $config_host_mak
>  fi
> @@ -7416,6 +7424,7 @@ echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
>  echo "WINDRES=$windres" >> $config_host_mak
>  echo "CFLAGS=$CFLAGS" >> $config_host_mak
>  echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
> +echo "LIBS=$LIBS" >> $config_host_mak
>  echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
>  echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
>  echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
> diff --git a/meson.build b/meson.build
> index 5421eca66a..6e909213ee 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -116,6 +116,9 @@ endif
>  # grandfathered in from the QEMU Makefiles.
>  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
>                        native: false, language: ['c', 'cpp', 'objc'])
> +
> +base_lib = declare_dependency(link_args: config_host['LIBS'].split())
> +
>  glib = declare_dependency(link_args: config_host['GLIB_LIBS'].split())
>  gio = not_found
>  if 'CONFIG_GIO' in config_host
> @@ -818,7 +821,7 @@ util_ss.add_all(trace_ss)
>  util_ss = util_ss.apply(config_all, strict: false)
>  libqemuutil = static_library('qemuutil',
>                               sources: util_ss.sources() +
> stub_ss.sources() + genh,
> -                             dependencies: [util_ss.dependencies(), m,
> glib, socket])
> +                             dependencies: [util_ss.dependencies(), m,
> base_lib, glib, socket])
>  qemuutil = declare_dependency(link_with: libqemuutil,
>                                sources: genh + version_res)
>
> --
> 2.28.0.windows.1
>
>

--000000000000b022f505aebeab22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi, LIBS is going away soon. I have a few more Meson patc=
hes including one for tcmalloc and jemalloc, I won&#39;t post them super so=
on though.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 7=
 set 2020, 21:50 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">=
luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">Currently, the LIBS are not exposed to meson and meson didn&#39;t us=
e that<br>
Use base_lib =3D declare_dependency(link_args: config_host[&#39;LIBS&#39;].=
split())<br>
to force use it<br>
<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0configure=C2=A0 =C2=A0| 9 +++++++++<br>
=C2=A0meson.build | 5 ++++-<br>
=C2=A02 files changed, 13 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/configure b/configure<br>
index 823756f4a4..7b2f3d64b0 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7245,6 +7245,14 @@ if test &quot;$libxml2&quot; =3D &quot;yes&quot; ; t=
hen<br>
=C2=A0 =C2=A0echo &quot;LIBXML2_LIBS=3D$libxml2_libs&quot; &gt;&gt; $config=
_host_mak<br>
=C2=A0fi<br>
<br>
+if test &quot;$tcmalloc&quot; =3D &quot;yes&quot; ; then<br>
+=C2=A0 echo &quot;CONFIG_TCMALLOC=3Dy&quot; &gt;&gt; $config_host_mak<br>
+fi<br>
+<br>
+if test &quot;$jemalloc&quot; =3D &quot;yes&quot; ; then<br>
+=C2=A0 echo &quot;CONFIG_JEMALLOC=3Dy&quot; &gt;&gt; $config_host_mak<br>
+fi<br>
+<br>
=C2=A0if test &quot;$replication&quot; =3D &quot;yes&quot; ; then<br>
=C2=A0 =C2=A0echo &quot;CONFIG_REPLICATION=3Dy&quot; &gt;&gt; $config_host_=
mak<br>
=C2=A0fi<br>
@@ -7416,6 +7424,7 @@ echo &quot;PKG_CONFIG=3D$pkg_config_exe&quot; &gt;&gt=
; $config_host_mak<br>
=C2=A0echo &quot;WINDRES=3D$windres&quot; &gt;&gt; $config_host_mak<br>
=C2=A0echo &quot;CFLAGS=3D$CFLAGS&quot; &gt;&gt; $config_host_mak<br>
=C2=A0echo &quot;CFLAGS_NOPIE=3D$CFLAGS_NOPIE&quot; &gt;&gt; $config_host_m=
ak<br>
+echo &quot;LIBS=3D$LIBS&quot; &gt;&gt; $config_host_mak<br>
=C2=A0echo &quot;QEMU_CFLAGS=3D$QEMU_CFLAGS&quot; &gt;&gt; $config_host_mak=
<br>
=C2=A0echo &quot;QEMU_CXXFLAGS=3D$QEMU_CXXFLAGS&quot; &gt;&gt; $config_host=
_mak<br>
=C2=A0echo &quot;QEMU_INCLUDES=3D$QEMU_INCLUDES&quot; &gt;&gt; $config_host=
_mak<br>
diff --git a/meson.build b/meson.build<br>
index 5421eca66a..6e909213ee 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -116,6 +116,9 @@ endif<br>
=C2=A0# grandfathered in from the QEMU Makefiles.<br>
=C2=A0add_project_arguments(config_host[&#39;GLIB_CFLAGS&#39;].split(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0native: false, language: [&#39;c&#39;, &#39;cpp&#39;, &#39;objc&#=
39;])<br>
+<br>
+base_lib =3D declare_dependency(link_args: config_host[&#39;LIBS&#39;].spl=
it())<br>
+<br>
=C2=A0glib =3D declare_dependency(link_args: config_host[&#39;GLIB_LIBS&#39=
;].split())<br>
=C2=A0gio =3D not_found<br>
=C2=A0if &#39;CONFIG_GIO&#39; in config_host<br>
@@ -818,7 +821,7 @@ util_ss.add_all(trace_ss)<br>
=C2=A0util_ss =3D util_ss.apply(config_all, strict: false)<br>
=C2=A0libqemuutil =3D static_library(&#39;qemuutil&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sources: util_ss.sources() + stub_ss.source=
s() + genh,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependencies: [util_ss.dependencies(), m, gl=
ib, socket])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dependencies: [util_ss.dependencies(), m, ba=
se_lib, glib, socket])<br>
=C2=A0qemuutil =3D declare_dependency(link_with: libqemuutil,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sources: genh + version_res)<br>
<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div>

--000000000000b022f505aebeab22--


