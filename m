Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D792074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIYS/i+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D792074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTpUt-0005Sh-Mo
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 12:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTpTf-0004kz-OS
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTpTa-0005XU-9k
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602953676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9UNbp77ldf/iZxbcxa8yLgoBepvdQkfFMiGWEFJq9w=;
 b=cIYS/i+LSZTaNavquGyp37CDPZH87Lgq8ibP9wyx+XuutbJkkunv6AX/5IPHMP19Mo3eNp
 MP2kdj9mqgpjTkg7ZZgqk6EToEqmlIgzgP65+S1+ez6H3Du8JFk58QofAu0dka+W8b80t7
 gTtiDV5ZMFZs1OnfPzB4d7S3CiIsdB8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-usSyrO7ANMKc-EF2Jak6Xw-1; Sat, 17 Oct 2020 12:54:32 -0400
X-MC-Unique: usSyrO7ANMKc-EF2Jak6Xw-1
Received: by mail-ej1-f69.google.com with SMTP id p19so3085326ejy.11
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 09:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o9UNbp77ldf/iZxbcxa8yLgoBepvdQkfFMiGWEFJq9w=;
 b=LTnG9Ns4zrOgudLVb8XJVZ2zwRn+bxHr8spyezsJb/EVQWVwQaY1P7p8WBVs+SB+fx
 QWQsW77KaHHcZ+Wv4Ehbugm+XQ9QGvMguDG1K+Xd2a4yJLcGlN8gSPMYFwNiXyw8k4xg
 K+q0Eb8ETi5L8L0DUeMatGqjybKLBotEsqbgnK6sBxscGdNNG8TOsHBpgmmSCOCXohsJ
 2D3sRaGTpc1pMlRG0n6Y4X50Owzr/uuR77vk9fr2K+9ynmBJj5v0NObG0JPEe3UwT7x5
 rSh63xI54xDHYaYl9vjeDzpG1kQ7FepACkawNzCYRLVCiWvans7aZExuzC5AyfuD56mA
 X5xQ==
X-Gm-Message-State: AOAM533NDEzQNgO4a3/q1rJZ7jPPp1vi6vxeK+7fyPYx/GZEjr4/GudP
 jCGdk5UyT+f9aMw8t9G4a4nd082omBcswRtDS8uRzZHMkr75AY+lyGHS7nEvbRxOXZ0gO/uUP32
 QHkUtexIzC4AWCv3GZNKwumE14O00DDg=
X-Received: by 2002:a05:6402:b72:: with SMTP id
 cb18mr9685117edb.129.1602953671199; 
 Sat, 17 Oct 2020 09:54:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFAkt7sGh/cwnHEseE50y5pSGKtLljrTO1gNPDpmptoIZiUgvQzceIyPCkdSdgo7zjFKnt3ZQ+avibMirhR/w=
X-Received: by 2002:a05:6402:b72:: with SMTP id
 cb18mr9685106edb.129.1602953670938; 
 Sat, 17 Oct 2020 09:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201017164329.1634-1-luoyonggang@gmail.com>
In-Reply-To: <20201017164329.1634-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 17 Oct 2020 18:53:56 +0200
Message-ID: <CABgObfZej0fByb+THQhxUdMsQu=ATn9LXfmSb2=vVVcX5QXr6g@mail.gmail.com>
Subject: Re: [PATCH v11] scripts: Convert qemu-version.sh to qemu-version.py
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000025e84a05b1e0bcf4"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 05:57:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000025e84a05b1e0bcf4
Content-Type: text/plain; charset="UTF-8"

Il sab 17 ott 2020, 18:43 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> The sh script are harder to maintain for compatible different
> xsh environment so convert it to python script
> Also incorporate the fixes in
>
> https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/
>
> According to https://github.com/msys2/MSYS2-packages/issues/2176
> We need use CYGWIN=noglob and MSYS=noglob in the environment variable
> for disable wildcard expanding in msys or cygwin git, and setting the
> shell=False
>

Honestly, I don't see the point in doing this change. Python is the wrong
tool for this job, and it's not like the configure script is disappearing
any time soon---so getting rid of shell scripts at this point is of limited
utility, especially for something like qemu-version.sh.

IMO the msys build is already much more robust in 5.2 than in 5.1 once the
pending pull request for ninja is in). Any other change has to provide a
clear improvement.

Paolo


> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build             |  2 +-
>  scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++
>  scripts/qemu-version.sh | 25 -------------------------
>  3 files changed, 38 insertions(+), 26 deletions(-)
>  create mode 100644 scripts/qemu-version.py
>  delete mode 100755 scripts/qemu-version.sh
>
> diff --git a/meson.build b/meson.build
> index 05fb59a00b..b100b6d7be 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1240,7 +1240,7 @@ tracetool = [
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
> index 0000000000..cf97b2bbb5
> --- /dev/null
> +++ b/scripts/qemu-version.py
> @@ -0,0 +1,37 @@
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
> +import os
> +import os.path
> +
> +def main(_program, dir, pkgversion, version, *unused):
> +    os.chdir(dir)
> +    if not pkgversion and os.path.exists('.git'):
> +        pc = subprocess.run(
> +            ['git', 'describe', '--match', 'v*', '--dirty', '--always'],
> +            env=dict(os.environ, CYGWIN="noglob", MSYS='noglob'),
> +            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
> +            encoding='utf8', shell=False)
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
> index 3f6e7e6d41..0000000000
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
> -        pkgversion=$(git describe --match 'v*' --dirty) || :
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

--00000000000025e84a05b1e0bcf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 17 ott 2020, 18:43 Yonggang Luo &lt;<a href=3D"=
mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">The sh script are harder to maintain f=
or compatible different<br>
xsh environment so convert it to python script<br>
Also incorporate the fixes in<br>
<a href=3D"https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lurea=
u@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patc=
hew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/</a><br>
<br>
According to <a href=3D"https://github.com/msys2/MSYS2-packages/issues/2176=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/msys2/=
MSYS2-packages/issues/2176</a><br>
We need use CYGWIN=3Dnoglob and MSYS=3Dnoglob in the environment variable<b=
r>
for disable wildcard expanding in msys or cygwin git, and setting the shell=
=3DFalse<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Honestly, I don&#39;t see the point in doing this change. Python =
is the wrong tool for this job, and it&#39;s not like the configure script =
is disappearing any time soon---so getting rid of shell scripts at this poi=
nt is of limited utility, especially for something like qemu-version.sh.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">IMO the msys build is alre=
ady much more robust in 5.2 than in 5.1 once the pending pull request for n=
inja is in). Any other change has to provide a clear improvement.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
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
=C2=A0scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++<br=
>
=C2=A0scripts/qemu-version.sh | 25 -------------------------<br>
=C2=A03 files changed, 38 insertions(+), 26 deletions(-)<br>
=C2=A0create mode 100644 scripts/qemu-version.py<br>
=C2=A0delete mode 100755 scripts/qemu-version.sh<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 05fb59a00b..b100b6d7be 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1240,7 +1240,7 @@ tracetool =3D [<br>
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
index 0000000000..cf97b2bbb5<br>
--- /dev/null<br>
+++ b/scripts/qemu-version.py<br>
@@ -0,0 +1,37 @@<br>
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
+import os<br>
+import os.path<br>
+<br>
+def main(_program, dir, pkgversion, version, *unused):<br>
+=C2=A0 =C2=A0 os.chdir(dir)<br>
+=C2=A0 =C2=A0 if not pkgversion and os.path.exists(&#39;.git&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pc =3D subprocess.run(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&#39;git&#39;, &#39;describe&#3=
9;, &#39;--match&#39;, &#39;v*&#39;, &#39;--dirty&#39;, &#39;--always&#39;]=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env=3Ddict(os.environ, CYGWIN=3D=
&quot;noglob&quot;, MSYS=3D&#39;noglob&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdout=3Dsubprocess.PIPE, stderr=
=3Dsubprocess.DEVNULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 encoding=3D&#39;utf8&#39;, shell=
=3DFalse)<br>
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
index 3f6e7e6d41..0000000000<br>
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
9; --dirty) || :<br>
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

--00000000000025e84a05b1e0bcf4--


