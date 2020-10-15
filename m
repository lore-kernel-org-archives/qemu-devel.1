Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6247DC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857FC207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qr8TzBny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857FC207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBc5-0006g3-Bu
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTBb2-0006Ci-C8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTBb0-0008P9-1E
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602800374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0O1C4EEgSGGLotTfc8xfagTboJ8bRRFywPsjMqzlO0=;
 b=Qr8TzBny/7xhtWHjrPAgnv8j7p5A+GLPP3PvEcJC9XG2gA8SEgYmrAnodYTKAw6/f353FQ
 ig88Tjm2poU3NJYeJjv/jFPNAiJQVwTz1DcjxM/Ej5dqIi2Xm+iJ8WEkpZ7arxvn587j47
 IM177P3JwVIR8Mi+DDnHawFCExuXUfA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-CWbmB69-N6a7gRiWKhNFDw-1; Thu, 15 Oct 2020 18:19:32 -0400
X-MC-Unique: CWbmB69-N6a7gRiWKhNFDw-1
Received: by mail-ej1-f72.google.com with SMTP id t1so108935ejb.21
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r0O1C4EEgSGGLotTfc8xfagTboJ8bRRFywPsjMqzlO0=;
 b=VEI0FpBBIPZMA0kSOJFcRMl7Zc7Bs+moqxXm+P5sL6WsgyQ22usdN1BcASLEI3AY83
 kI8oZj/8GGRSAvOoqewMZP/qErle7BSi+LDvIRvKyZ+FeL8OQDgwAztL6vp0HSv+1z0k
 es4XF5rc8qlcj2IYtX4tdMOpned1iRxbO0KdgofBoiONrbYlnVFUEXD5xCQrLYUEvhC4
 sQd8qbEdtqvrHTUd6XnfZg76d1fwu3KtfVeS9jbaivxd0fkQPdfeLQCdhvkncGyQB+ut
 QxhoqHTnWGJsSsl889L1oNKwfPYaqhfqwjo3dBwlJZLDlchzxPeYPYU4ywXfCDB0rZJC
 Qu6A==
X-Gm-Message-State: AOAM531uN2mYA/Fe39soHlEOWLCGSQ65z0Fs8OqdV5kmm/bgE/Wkj5+2
 IIWWf11O95nnLE0isM5DHhDThFCVah0NjXnkQQHaJ7qy0u8WKTs3TvKPYLEs7KMA6Th5JgALVmX
 skfyrdR4NQp3E3q1eD/VMkVyeRe+hy0I=
X-Received: by 2002:a17:906:cc83:: with SMTP id
 oq3mr561698ejb.71.1602800371083; 
 Thu, 15 Oct 2020 15:19:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnqv5L4ypC4obq+TwuQIAZPcwTVYfbxmZ4AweGKMJ/KA9hbb/9+nuVDjBMer5/sLPBVoEXRAF269QzaQd5p2U=
X-Received: by 2002:a17:906:cc83:: with SMTP id
 oq3mr561681ejb.71.1602800370869; 
 Thu, 15 Oct 2020 15:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201015220626.418-1-luoyonggang@gmail.com>
 <20201015220626.418-2-luoyonggang@gmail.com>
In-Reply-To: <20201015220626.418-2-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Oct 2020 00:19:19 +0200
Message-ID: <CABgObfZHAVioVo9xr5ViyezkNA9wq0n+Xberin0+VhzsJShGRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] docs: Fixes build docs on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000c0873205b1bd0a08"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c0873205b1bd0a08
Content-Type: text/plain; charset="UTF-8"

Il ven 16 ott 2020, 00:06 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> meson didn't support running ../scripts/kernel-do directly
>

Can you explain why this matters? Meson does not look at docs/conf.py.

Paolo


> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  docs/conf.py             | 2 +-
>  docs/sphinx/kerneldoc.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/conf.py b/docs/conf.py
> index 00e1b750e2..e584f68393 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -241,7 +241,7 @@ texinfo_documents = [
>  # We use paths starting from qemu_docdir here so that you can run
>  # sphinx-build from anywhere and the kerneldoc extension can still
>  # find everything.
> -kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
> +kerneldoc_bin = ['perl', os.path.join(qemu_docdir,
> '../scripts/kernel-doc')]
>  kerneldoc_srctree = os.path.join(qemu_docdir, '..')
>  hxtool_srctree = os.path.join(qemu_docdir, '..')
>  qapidoc_srctree = os.path.join(qemu_docdir, '..')
> diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
> index 3e87940206..3ac277d162 100644
> --- a/docs/sphinx/kerneldoc.py
> +++ b/docs/sphinx/kerneldoc.py
> @@ -67,7 +67,7 @@ class KernelDocDirective(Directive):
>
>      def run(self):
>          env = self.state.document.settings.env
> -        cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
> +        cmd = env.config.kerneldoc_bin + ['-rst', '-enable-lineno']
>
>          filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
>          export_file_patterns = []
> --
> 2.28.0.windows.1
>
>

--000000000000c0873205b1bd0a08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 16 ott 2020, 00:06 Yonggang Luo &lt;<a href=3D"=
mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">meson didn&#39;t support running ../sc=
ripts/kernel-do directly<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Can you explain why this matters? Meson does not lo=
ok at docs/conf.py.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paol=
o</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0docs/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br=
>
=C2=A0docs/sphinx/kerneldoc.py | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/docs/conf.py b/docs/conf.py<br>
index 00e1b750e2..e584f68393 100644<br>
--- a/docs/conf.py<br>
+++ b/docs/conf.py<br>
@@ -241,7 +241,7 @@ texinfo_documents =3D [<br>
=C2=A0# We use paths starting from qemu_docdir here so that you can run<br>
=C2=A0# sphinx-build from anywhere and the kerneldoc extension can still<br=
>
=C2=A0# find everything.<br>
-kerneldoc_bin =3D os.path.join(qemu_docdir, &#39;../scripts/kernel-doc&#39=
;)<br>
+kerneldoc_bin =3D [&#39;perl&#39;, os.path.join(qemu_docdir, &#39;../scrip=
ts/kernel-doc&#39;)]<br>
=C2=A0kerneldoc_srctree =3D os.path.join(qemu_docdir, &#39;..&#39;)<br>
=C2=A0hxtool_srctree =3D os.path.join(qemu_docdir, &#39;..&#39;)<br>
=C2=A0qapidoc_srctree =3D os.path.join(qemu_docdir, &#39;..&#39;)<br>
diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py<br>
index 3e87940206..3ac277d162 100644<br>
--- a/docs/sphinx/kerneldoc.py<br>
+++ b/docs/sphinx/kerneldoc.py<br>
@@ -67,7 +67,7 @@ class KernelDocDirective(Directive):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def run(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env =3D self.state.document.settings.env<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D [env.config.kerneldoc_bin, &#39;-rst&#=
39;, &#39;-enable-lineno&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D env.config.kerneldoc_bin + [&#39;-rst&=
#39;, &#39;-enable-lineno&#39;]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename =3D env.config.kerneldoc_srctree=
 + &#39;/&#39; + self.arguments[0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export_file_patterns =3D []<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>

--000000000000c0873205b1bd0a08--


