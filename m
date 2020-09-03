Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB1C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18452072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/CG57ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18452072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDo5q-0005ol-3G
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDo56-00052U-FV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDo54-0005jJ-Jk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599135065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CbpgAWV4n4xWnUnCBN0ErTyAAfGn8vkn04spAe4H9Yc=;
 b=U/CG57lyR1v+GD7tuP8j2jMyJ5eVAsG6ac1Pk3GS52WfzwALtW+IV+Mt2GXCN/HtrZo9Fk
 afyqed9e43T/RhCzqS3NiXC126EpMLlEaQNTv+lKOrNkv+lu/fIT3kqvGPEIfQU2oX/CMj
 YC7mF8VsetyRwJ2y1FclfFcCgml7yMo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-mwMrgOQNPGyN6tGC_KJIiA-1; Thu, 03 Sep 2020 08:11:03 -0400
X-MC-Unique: mwMrgOQNPGyN6tGC_KJIiA-1
Received: by mail-ej1-f72.google.com with SMTP id y10so1142417ejd.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CbpgAWV4n4xWnUnCBN0ErTyAAfGn8vkn04spAe4H9Yc=;
 b=oqYNU471rQHc6XHI/VmnaTfUMDDQdifkD9noanaKMG1nqZcag9lFVSEKA6I1jtV1ID
 kb1FFXjNOndtbyRAXZ3PC5G/bU5u0KOKvIwaRYi9agvoW2SV7NH4bjUg9Ccv3xuEfp0o
 2nZtpqb6Lh27lrSpA3Sdc6j91Tj6TN5WEH6y42rih71R5TtROHzLiJqTLK+jMzEiTuL1
 qZ2EJk2tUXpLDhl/LTQPPA9P+1igzsOGD4x6N3UF0spsCER19zZWquXLCVswxjzLedYD
 D8tLkZgYTfV58EJedXRL3sV8VinCMgIJ53TMDc3fwdmNwSSsSaLbqIEtQ26han+u5dcg
 jc9w==
X-Gm-Message-State: AOAM532eUnWlSsCTJN0+sc7/B6MSpxtqZufC801TYefHcRhnzvTAuFO0
 zjO3GXPsukkgE4cr+eAKyNpkjVznnhYhCUsD4CfVQeJ2ZqopjiVzOBZaxgbQnlhliBNyYcoJCB3
 29SHjfWfOq9ClleQIMmTXhVQssBeCjZU=
X-Received: by 2002:a17:906:c001:: with SMTP id
 e1mr1886744ejz.390.1599135060190; 
 Thu, 03 Sep 2020 05:11:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4vnjrHxDrfQ7VQ+tcnxuGjhV4JmGC5HIyGAYJdJoxWzSuZ0AJCx+TB8TnJapvXQbz9hHyM0NjyDixBtUPUQA=
X-Received: by 2002:a17:906:c001:: with SMTP id
 e1mr1886725ejz.390.1599135059995; 
 Thu, 03 Sep 2020 05:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-7-alex.bennee@linaro.org>
In-Reply-To: <20200903112107.27367-7-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 14:10:47 +0200
Message-ID: <CABgObfZ_Xdd-pnRjpWO=8NjEznZhz84DTq95OzCdjL_rxnw=XQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] tests/meson.build: fp tests don't need CONFIG_TCG
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000033052a05ae67a56e"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 f4bug@amsat.org, "Emilio G. Cota" <cota@braap.org>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000033052a05ae67a56e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scrit=
to:

> As the tests build only softfloat.c no actual TCG machinary is neede
> to test them (as is evidenced by GCC check-softfloat). Might as well
> fix the wording on Travis while at it.
>

The reason is that softfloat is not built at all into QEMU if !CONFIG_TCG.
We similarly skip block layer tests if !CONFIG_SOFTMMU && !CONFIG_TOOLS.

Paolo


> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml       | 2 +-
>  tests/meson.build | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 1d0ade0a133..65341634d02 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -138,7 +138,7 @@ jobs:
>
>
>      # Just build tools and run minimal unit and softfloat checks
> -    - name: "GCC check-softfloat (user)"
> +    - name: "GCC check-unit and check-softfloat"
>        env:
>          - BASE_CONFIG=3D"--enable-tools"
>          - CONFIG=3D"--disable-user --disable-system"
> diff --git a/tests/meson.build b/tests/meson.build
> index fe2c6d8e6b6..bdcc5d75293 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -7,8 +7,9 @@ test('decodetree', sh,
>       workdir: meson.current_source_dir() / 'decode',
>       suite: 'decodetree')
>
> +subdir('fp')
> +
>  if 'CONFIG_TCG' in config_host
> -  subdir('fp')
>    if 'CONFIG_PLUGIN' in config_host
>      subdir('plugin')
>    endif
> --
> 2.20.1
>
>

--00000000000033052a05ae67a56e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">As the tests build only softfloa=
t.c no actual TCG machinary is neede<br>
to test them (as is evidenced by GCC check-softfloat). Might as well<br>
fix the wording on Travis while at it.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">The reason is that softfloat is not b=
uilt at all into QEMU if !CONFIG_TCG. We similarly skip block layer tests i=
f !CONFIG_SOFTMMU &amp;&amp; !CONFIG_TOOLS.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Paolo<br></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0tests/meson.build | 3 ++-<br>
=C2=A02 files changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 1d0ade0a133..65341634d02 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -138,7 +138,7 @@ jobs:<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Just build tools and run minimal unit and softfloat c=
hecks<br>
-=C2=A0 =C2=A0 - name: &quot;GCC check-softfloat (user)&quot;<br>
+=C2=A0 =C2=A0 - name: &quot;GCC check-unit and check-softfloat&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0env:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- BASE_CONFIG=3D&quot;--enable-tools&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- CONFIG=3D&quot;--disable-user --disable=
-system&quot;<br>
diff --git a/tests/meson.build b/tests/meson.build<br>
index fe2c6d8e6b6..bdcc5d75293 100644<br>
--- a/tests/meson.build<br>
+++ b/tests/meson.build<br>
@@ -7,8 +7,9 @@ test(&#39;decodetree&#39;, sh,<br>
=C2=A0 =C2=A0 =C2=A0 workdir: meson.current_source_dir() / &#39;decode&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 suite: &#39;decodetree&#39;)<br>
<br>
+subdir(&#39;fp&#39;)<br>
+<br>
=C2=A0if &#39;CONFIG_TCG&#39; in config_host<br>
-=C2=A0 subdir(&#39;fp&#39;)<br>
=C2=A0 =C2=A0if &#39;CONFIG_PLUGIN&#39; in config_host<br>
=C2=A0 =C2=A0 =C2=A0subdir(&#39;plugin&#39;)<br>
=C2=A0 =C2=A0endif<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div></div></div>

--00000000000033052a05ae67a56e--


