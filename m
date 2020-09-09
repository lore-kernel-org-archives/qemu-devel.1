Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104372080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIR83rsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104372080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG6P2-0001Vd-73
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 16:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG6OR-00011o-N9
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 16:08:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG6OP-0002Gw-69
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599682111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ukxyw5N1oHzn5fAzb47tn+m0n3BiB2/shBmID+BE/eM=;
 b=JIR83rskV1xoW+DNWoRqLp/bIedvx9yrmRb9DZCC++jWSoW9446ZwT3JSC+izzbQv1P50Z
 4iSlN+R+RQXKuT3s9YD3G75riLn4Dg5nb++gLLoxU1CjqY5f3b4Q5pzE7z7fS10ISA1jOG
 LF50C2LA761GZmLSYD+RgUBo3/yWMNA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-2_k6dzFcMZSWyL_D-NENzg-1; Wed, 09 Sep 2020 16:08:26 -0400
X-MC-Unique: 2_k6dzFcMZSWyL_D-NENzg-1
Received: by mail-ej1-f69.google.com with SMTP id m24so1742398ejx.22
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 13:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ukxyw5N1oHzn5fAzb47tn+m0n3BiB2/shBmID+BE/eM=;
 b=P61xEYnS1O36KTU9w7sJuGvYUQzYsnqiLwrmbu6DWhRw32hNIZAELwNMHP3cEtJBb6
 iXfV6EJcT8g49ys5XnqurAKS8FuRL9+Q+S3MtCzJpE7imqHmpztPE4/LUyftCRIA0PdK
 X2zT+Kk8UjHG5dllBVI+sWmaDC3yvGU3h03FOizKa/lKy4+uuPGnOXE0hJZwd+Km8gPZ
 1mDt4hLAu7YYdpkfWlhwTJ9vTkUKJvCgKjE5/mNpWfesK+4Be9Fmn9YH9Fvrrs9vUJ4s
 yDH2NuKygVTJ+5zR+Mju54sBC/4bDXAO2jukch9p9wv0cmKClmTanRR0fzeit9p7dZWo
 jZRA==
X-Gm-Message-State: AOAM530U6KD/kc3xJOUiCdjHCsmLhJNgYpTIgvDTIbWaAoe89iDN5sid
 VvLWE4Ui+5pcYXYxSsbNjqTgOtvKR8GT7xosbTLTZDjT/paBKnyGXgMFzLIeRLt61HgpCXxN8Pg
 9pF2mG2/RfsNTvxNCnHx2STxTA6rSMpY=
X-Received: by 2002:a17:906:a845:: with SMTP id
 dx5mr5243454ejb.543.1599682105398; 
 Wed, 09 Sep 2020 13:08:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPwcPg8CghYjXWmZVWnMFn5MVT/1MywoD8v1L+pOuufSrik7fhJATKF5Cl7UPGcISZJCncorGS8igpzfJCWP4=
X-Received: by 2002:a17:906:a845:: with SMTP id
 dx5mr5243426ejb.543.1599682105160; 
 Wed, 09 Sep 2020 13:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200909184237.765-1-luoyonggang@gmail.com>
 <20200909184237.765-3-luoyonggang@gmail.com>
In-Reply-To: <20200909184237.765-3-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Sep 2020 22:08:13 +0200
Message-ID: <CABgObfaGzMDC_n5ukJc4y2k9NVvDkYT=Zp6DGycCXRtmXQzJ5g@mail.gmail.com>
Subject: Re: [PATCH v6 25/25] meson: guard the minimal meson version to 0.55.1
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a1c9b505aee703e2"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:15:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a1c9b505aee703e2
Content-Type: text/plain; charset="UTF-8"

Il mer 9 set 2020, 20:43 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> So we can removal usage of unstable-keyval
>

Isn't it stable only on 0.56.0?

Paolo


> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  meson.build | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 0b1741557d..af34a85bec 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1,14 +1,11 @@
> -project('qemu', ['c'], meson_version: '>=0.55.0',
> +project('qemu', ['c'], meson_version: '>=0.55.1',
>          default_options: ['warning_level=1', 'c_std=gnu99',
> 'cpp_std=gnu++11',
>                            'b_colorout=auto'],
>          version: run_command('head', meson.source_root() /
> 'VERSION').stdout().strip())
>
>  not_found = dependency('', required: false)
> -if meson.version().version_compare('>=0.56.0')
> -  keyval = import('keyval')
> -else
> -  keyval = import('unstable-keyval')
> -endif
> +keyval = import('keyval')
> +
>  ss = import('sourceset')
>
>  sh = find_program('sh')
> --
> 2.28.0.windows.1
>
>

--000000000000a1c9b505aee703e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 9 set 2020, 20:43 Yonggang Luo &lt;<a href=3D"m=
ailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">So we can removal usage of unstable-key=
val<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Isn&#39;t it stable only on 0.56.0?</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 9 +++------<br>
=C2=A01 file changed, 3 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 0b1741557d..af34a85bec 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1,14 +1,11 @@<br>
-project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#39;&gt;=3D0.55.0&#=
39;,<br>
+project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#39;&gt;=3D0.55.1&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_options: [&#39;warning_level=3D1&=
#39;, &#39;c_std=3Dgnu99&#39;, &#39;cpp_std=3Dgnu++11&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;b_colorout=3Dauto&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version: run_command(&#39;head&#39;, meso=
n.source_root() / &#39;VERSION&#39;).stdout().strip())<br>
<br>
=C2=A0not_found =3D dependency(&#39;&#39;, required: false)<br>
-if meson.version().version_compare(&#39;&gt;=3D0.56.0&#39;)<br>
-=C2=A0 keyval =3D import(&#39;keyval&#39;)<br>
-else<br>
-=C2=A0 keyval =3D import(&#39;unstable-keyval&#39;)<br>
-endif<br>
+keyval =3D import(&#39;keyval&#39;)<br>
+<br>
=C2=A0ss =3D import(&#39;sourceset&#39;)<br>
<br>
=C2=A0sh =3D find_program(&#39;sh&#39;)<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>

--000000000000a1c9b505aee703e2--


