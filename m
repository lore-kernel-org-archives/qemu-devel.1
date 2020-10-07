Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE904C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD4A206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZXusy6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD4A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFXQ-00063v-5z
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQFWU-0005TB-Fi
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQFWS-00031B-72
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602100487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHNPk2ysH4LHy7tRjZp0g/wmllepe3doO8JNJ8/3rJo=;
 b=gZXusy6Mg2fyQhDJndmooME0RDGduzwpSRq3eiPMhEPRLYQMaRkf1OC5HfyF6iR/JBSVFw
 lfDWl5VHCSm7MlOggyhctZfl4KHJmB0MhYDdKBJ9dFREd+kg8UQ7F17mZpzLU8XWtkoP5c
 x5mBqFs5Pv/NQjdFSijH3XGl8/j7HDY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-MOLU3eb0PGW9ij4j8na8gQ-1; Wed, 07 Oct 2020 15:54:44 -0400
X-MC-Unique: MOLU3eb0PGW9ij4j8na8gQ-1
Received: by mail-ed1-f69.google.com with SMTP id n19so1342223eds.8
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 12:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kHNPk2ysH4LHy7tRjZp0g/wmllepe3doO8JNJ8/3rJo=;
 b=kxzUs/QQMbGk5v1hqdEsbUotpSF4of/L7n5xmabH+PPC6Hedfyug2Fms4CrLpjV6kx
 RpwKcZjNvGup+h6tiTtH9G10sWKE90sklvl8nF4VNFTuwzEgRwa6YWNAbITblpVeXu7w
 9OA57TvDh+yQu7lqUNE0cbAb44u2TmV3c551lAr1NXYV4y30qlsBXw+HZV2UOBUvKkaB
 Z8xoEYmsriWpDk+U7ok0xBgNOtFtvxB3BcYyF1EcUfqO0pDAyvUag6NYb+sokhqE79HI
 7OKgR6NRx+0QXqj6NV8IM3kelxx53SAnH8CLYFNZlUr+wQDXtH5FLLWjV7Nr4O+kDFDA
 0VFg==
X-Gm-Message-State: AOAM530izeARgAlCCSaiFxiSQ6TV7PJfz6nLZXKVIDTsr/K7hTfIUPyJ
 Y5Js/Z2JE0eIOzwv9N/p/3UHM0YEcB71q0hd4sEYQ2XqCkg0ImRjN0DHLIcfoAnRHQaf+tY4BWP
 RHjy8ET5+7I20oefp4sljL1gl20OrbI8=
X-Received: by 2002:a17:906:ce5a:: with SMTP id
 se26mr4936299ejb.106.1602100483330; 
 Wed, 07 Oct 2020 12:54:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb+BWgwXnx9Pr1viHiTIPIUpyWyb7ZkgOEDeU/pdgXlQQoS7WXoQdyrT/LibGmEjJrBRxeicOcGt8uitWzAHg=
X-Received: by 2002:a17:906:ce5a:: with SMTP id
 se26mr4936280ejb.106.1602100483077; 
 Wed, 07 Oct 2020 12:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201007194526.1778-1-luoyonggang@gmail.com>
In-Reply-To: <20201007194526.1778-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Oct 2020 21:54:31 +0200
Message-ID: <CABgObfawi9Nd_c-O6MJ6VAAxOZYOu5fUoZsZ42dur47=PfY8aQ@mail.gmail.com>
Subject: Re: [PATCH v8] scripts: Convert qemu-version.sh to qemu-version.py
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000003051d605b11a1615"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003051d605b11a1615
Content-Type: text/plain; charset="UTF-8"

Il mer 7 ott 2020, 21:46 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> The sh script are harder to maintain for compatible different
> xsh environment so convert it to python script
> Also incorporate the fixes in
>
> https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/
> Using --match=v* instead of --match 'v*' for speed up the git version
> And using --match=v\\* to resolve wildcard problem on windows.
> Tested under Ubuntu/msys2/mingw.
>

Sorry but no, this is hideous.

We need to keep in mind the maintainability and this is the opposite of a
maintainable solution. It seems that subprocess (with shell=false, which I
agree would be the right setting for this task) is not always an
appropriate implementation when cross platform compatibility is required.

Paolo


> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build             |  2 +-
>  scripts/qemu-version.py | 35 +++++++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 36 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
>
> diff --git a/meson.build b/meson.build
> index 26230614ba..1d3bb25bc6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1132,7 +1132,7 @@ tracetool = [
>     '--backend=' + config_host['TRACE_BACKENDS']
>  ]
>
> -qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
> +qemu_version_cmd = [find_program('scripts/qemu-version.py'),
>                      meson.current_source_dir(),
>                      config_host['PKGVERSION'], meson.project_version()]
>  qemu_version = custom_target('qemu-version.h',
> diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
> new file mode 100644
> index 0000000000..3f24c44e8a
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,35 @@
> +#!/usr/bin/env python3
> +
> +#
> +# Script for retrieve qemu git version information
> +#
> +# Authors:
> +#  Yonggang Luo <luoyonggang@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or, at your option, any later version.  See the COPYING file in
> +# the top-level directory.
> +
> +import sys
> +import subprocess
> +import os, os.path
> +import platform
> +
> +def main(_program, dir, pkgversion, version, *unused):
> +    os.chdir(dir)
> +    if not pkgversion and os.path.exists('.git'):
> +        match_expression = '--match=v\\*' if platform.system() ==
> 'Windows' else '--match=v*'
> +        pc = subprocess.run(['git', 'describe', match_expression,
> '--always'],
> +                            stdout=subprocess.PIPE,
> stderr=subprocess.DEVNULL, encoding='utf8', shell=False)
> +        if pc.returncode == 0:
> +            pkgversion = pc.stdout.strip()
> +
> +    fullversion = version
> +    if pkgversion:
> +        fullversion = "{} ({})".format(version, pkgversion)
> +
> +    print('#define QEMU_PKGVERSION "%s"' % pkgversion)
> +    print('#define QEMU_FULL_VERSION "%s"' % fullversion)
> +
> +if __name__ == "__main__":
> +    main(*sys.argv)
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> deleted file mode 100755
> index 03128c56a2..0000000000
> --- a/scripts/qemu-version.sh
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -#!/bin/sh
> -
> -set -eu
> -
> -dir="$1"
> -pkgversion="$2"
> -version="$3"
> -
> -if [ -z "$pkgversion" ]; then
> -    cd "$dir"
> -    if [ -e .git ]; then
> -        pkgversion=$(git describe --match 'v*' --dirty | echo "")
> -    fi
> -fi
> -
> -if [ -n "$pkgversion" ]; then
> -    fullversion="$version ($pkgversion)"
> -else
> -    fullversion="$version"
> -fi
> -
> -cat <<EOF
> -#define QEMU_PKGVERSION "$pkgversion"
> -#define QEMU_FULL_VERSION "$fullversion"
> -EOF
> --
> 2.28.0.windows.1
>
>

--0000000000003051d605b11a1615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il mer 7 ott 2020, 21:46 Yonggang Luo &lt;<a href=3D"mailto:lu=
oyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">The sh script are harder to maintain for compat=
ible different<br>
xsh environment so convert it to python script<br>
Also incorporate the fixes in<br>
<a href=3D"https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lurea=
u@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patc=
hew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/</a><br>
Using --match=3Dv* instead of --match &#39;v*&#39; for speed up the git ver=
sion<br>
And using --match=3Dv\\* to resolve wildcard problem on windows.<br>
Tested under Ubuntu/msys2/mingw.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Sorry but no, this is hideous.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">We need to keep in mind the maintain=
ability and this is the opposite of a maintainable solution. It seems that =
subprocess (with shell=3Dfalse, which I agree would be the right setting fo=
r this task) is not always an appropriate implementation when cross platfor=
m compatibility is required.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20201006112139.700-1-luoyonggang@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">20201006112139.700-1-luoyonggang@gm=
ail.com</a>&gt;<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 =
+-<br>
=C2=A0scripts/qemu-version.py | 35 +++++++++++++++++++++++++++++++++++<br>
=C2=A0scripts/qemu-version.sh | 25 -------------------------<br>
=C2=A03 files changed, 36 insertions(+), 26 deletions(-)<br>
=C2=A0create mode 100644 scripts/qemu-version.py<br>
=C2=A0delete mode 100755 scripts/qemu-version.sh<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 26230614ba..1d3bb25bc6 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1132,7 +1132,7 @@ tracetool =3D [<br>
=C2=A0 =C2=A0 &#39;--backend=3D&#39; + config_host[&#39;TRACE_BACKENDS&#39;=
]<br>
=C2=A0]<br>
<br>
-qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version.sh&#39;),<br>
+qemu_version_cmd =3D [find_program(&#39;scripts/qemu-version.py&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0meson.current_source_dir(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0config_host[&#39;PKGVERSION&#39;], meson.project_version()]<br>
=C2=A0qemu_version =3D custom_target(&#39;qemu-version.h&#39;,<br>
diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py<br>
new file mode 100644<br>
index 0000000000..3f24c44e8a<br>
--- /dev/null<br>
+++ b/scripts/qemu-version.py<br>
@@ -0,0 +1,35 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#<br>
+# Script for retrieve qemu git version information<br>
+#<br>
+# Authors:<br>
+#=C2=A0 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
+#<br>
+# This work is licensed under the terms of the GNU GPL, version 2<br>
+# or, at your option, any later version.=C2=A0 See the COPYING file in<br>
+# the top-level directory.<br>
+<br>
+import sys<br>
+import subprocess<br>
+import os, os.path<br>
+import platform<br>
+<br>
+def main(_program, dir, pkgversion, version, *unused):<br>
+=C2=A0 =C2=A0 os.chdir(dir)<br>
+=C2=A0 =C2=A0 if not pkgversion and os.path.exists(&#39;.git&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 match_expression =3D &#39;--match=3Dv\\*&#39; =
if platform.system() =3D=3D &#39;Windows&#39; else &#39;--match=3Dv*&#39;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pc =3D subprocess.run([&#39;git&#39;, &#39;des=
cribe&#39;, match_expression, &#39;--always&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.DEVN=
ULL, encoding=3D&#39;utf8&#39;, shell=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if pc.returncode =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion =3D pc.stdout.strip()=
<br>
+<br>
+=C2=A0 =C2=A0 fullversion =3D version<br>
+=C2=A0 =C2=A0 if pkgversion:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fullversion =3D &quot;{} ({})&quot;.format(ver=
sion, pkgversion)<br>
+<br>
+=C2=A0 =C2=A0 print(&#39;#define QEMU_PKGVERSION &quot;%s&quot;&#39; % pkg=
version)<br>
+=C2=A0 =C2=A0 print(&#39;#define QEMU_FULL_VERSION &quot;%s&quot;&#39; % f=
ullversion)<br>
+<br>
+if __name__ =3D=3D &quot;__main__&quot;:<br>
+=C2=A0 =C2=A0 main(*sys.argv)<br>
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<br>
deleted file mode 100755<br>
index 03128c56a2..0000000000<br>
--- a/scripts/qemu-version.sh<br>
+++ /dev/null<br>
@@ -1,25 +0,0 @@<br>
-#!/bin/sh<br>
-<br>
-set -eu<br>
-<br>
-dir=3D&quot;$1&quot;<br>
-pkgversion=3D&quot;$2&quot;<br>
-version=3D&quot;$3&quot;<br>
-<br>
-if [ -z &quot;$pkgversion&quot; ]; then<br>
-=C2=A0 =C2=A0 cd &quot;$dir&quot;<br>
-=C2=A0 =C2=A0 if [ -e .git ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgversion=3D$(git describe --match &#39;v*&#3=
9; --dirty | echo &quot;&quot;)<br>
-=C2=A0 =C2=A0 fi<br>
-fi<br>
-<br>
-if [ -n &quot;$pkgversion&quot; ]; then<br>
-=C2=A0 =C2=A0 fullversion=3D&quot;$version ($pkgversion)&quot;<br>
-else<br>
-=C2=A0 =C2=A0 fullversion=3D&quot;$version&quot;<br>
-fi<br>
-<br>
-cat &lt;&lt;EOF<br>
-#define QEMU_PKGVERSION &quot;$pkgversion&quot;<br>
-#define QEMU_FULL_VERSION &quot;$fullversion&quot;<br>
-EOF<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>

--0000000000003051d605b11a1615--


