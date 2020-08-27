Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89EDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E45820737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPpeJ2pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E45820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOpF-00083Q-Pd
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBOoX-00078Q-Kh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBOoV-0002wt-Dw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598561282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FUh78OMIoptE30OPqx8VtJua4F5uWytNM9rP589ULcw=;
 b=KPpeJ2pDitE8LGSehyiA2XqpQMlcgEhD2JdWQU6w8pxdm8SUnkPLuO9IREtMd5U7uo8T2M
 +RyoGjwDr2KokQZ+gHtW0GLpMyZtp7aYirFm6jf5RkzQPao3erPhuzTLe3TL02JBh6ns3o
 jnqfSK6hmTkd4KFOgA7zpaFW9OghvzY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-o6XgD0WiP9-KxLCed5gT8A-1; Thu, 27 Aug 2020 16:47:59 -0400
X-MC-Unique: o6XgD0WiP9-KxLCed5gT8A-1
Received: by mail-ej1-f71.google.com with SMTP id g20so3137612ejd.8
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 13:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FUh78OMIoptE30OPqx8VtJua4F5uWytNM9rP589ULcw=;
 b=efHJWLYGStwYQKr/+IBv5J1W2QMc7siWfYI26aq14OMPQw2SlQ3I6CnqdBt4TYatxP
 5hSQfbuJZ7s5pBdFxTsu7GbeNa92oWXM0eK09qx+PuURsawVlN4677/Wy27fn9C1D0/v
 0IcdacrBwu/ox1I3zkyM45T49RBnzu6h8CGBUjJas1xIDAynHDn5jQ+1Q7OEH5++n68w
 0/CkX1oBW9Z3sIZi8nnVU4wXqa66vh6tnNU6KG10+KRJDpSKwreBkoKfqWqf/rYTqTMw
 iXtXYcWU0Q4IH+QP+KXbxu9zWr+Kpiaa957BzjE5dRE0fk5fgyOY7bWrBRFgW+DrIrYS
 mUIA==
X-Gm-Message-State: AOAM530i0Wy5wO5OvbwJrrMaH9PEpomN2qAg7t71t4WiAj2k1JiH2IiO
 MYyt96gvRAVIEeKKEgOcYmTdOzfgV/CAtyNG0xirei+indaTo+9n3PNM0b2Ni94jMOMn4eXT/Ud
 hL4X8/NMKZgJvA2mfr7qepeOG/V69h0o=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr23600875ejw.71.1598561278401; 
 Thu, 27 Aug 2020 13:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw94xT7zGkZML7L7LbdmIdlqvkpnMqZO5fPhkKXxjLw4XS/sUFbBUAgj38iYM3byNFUO6kx3m1V2o5UVAY42cc=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr23600865ejw.71.1598561278223; 
 Thu, 27 Aug 2020 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190245.22810-1-pbonzini@redhat.com>
 <f04c27c7-84b1-c43c-6919-53fffcd5c360@ilande.co.uk>
In-Reply-To: <f04c27c7-84b1-c43c-6919-53fffcd5c360@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 22:47:47 +0200
Message-ID: <CABgObfZ2eeUQzyL5oRz_kejfqi6-AdSCWrmM3foZP3wwRhj3TA@mail.gmail.com>
Subject: Re: [PATCH v2] configure: add --ninja option
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000023ef8d05ade20df3"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000023ef8d05ade20df3
Content-Type: text/plain; charset="UTF-8"

Thanks, that might be worth fixing in Meson.

Paolo

Il gio 27 ago 2020, 17:57 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> On 26/08/2020 20:02, Paolo Bonzini wrote:
>
> > On Windows it is not possible to invoke a Python script as $NINJA.
> > If ninja is present use it directly, while if it is not we can
> > keep using ninjatool.
> >
> > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  configure | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 9db9bb89b9..6ecaff429b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -568,6 +568,7 @@ rng_none="no"
> >  secret_keyring=""
> >  libdaxctl=""
> >  meson=""
> > +ninja=""
> >  skip_meson=no
> >  gettext=""
> >
> > @@ -1052,6 +1053,8 @@ for opt do
> >    ;;
> >    --meson=*) meson="$optarg"
> >    ;;
> > +  --ninja=*) ninja="$optarg"
> > +  ;;
> >    --smbd=*) smbd="$optarg"
> >    ;;
> >    --extra-cflags=*)
> > @@ -1820,6 +1823,7 @@ Advanced options (experts only):
> >    --python=PYTHON          use specified python [$python]
> >    --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
> >    --meson=MESON            use specified meson [$meson]
> > +  --ninja=NINJA            use specified ninja [$ninja]
> >    --smbd=SMBD              use specified smbd [$smbd]
> >    --with-git=GIT           use specified git [$git]
> >    --static                 enable static build [$static]
> > @@ -2058,6 +2062,16 @@ case "$meson" in
> >      *) meson=$(command -v meson) ;;
> >  esac
> >
> > +# Probe for ninja (used for compdb)
> > +
> > +if test -z "$ninja"; then
> > +    for c in ninja ninja-build samu; do
> > +        if has $c; then
> > +            ninja=$(command -v "$c")
> > +            break
> > +        fi
> > +    done
> > +fi
> >
> >  # Check that the C compiler works. Doing this here before testing
> >  # the host CPU ensures that we had a valid CC to autodetect the
> > @@ -8197,7 +8211,7 @@ fi
> >  mv $cross config-meson.cross
> >
> >  rm -rf meson-private meson-info meson-logs
> > -NINJA=$PWD/ninjatool $meson setup \
> > +NINJA=${ninja:-$PWD/ninjatool} $meson setup \
> >          --prefix "${pre_prefix}$prefix" \
> >          --libdir "${pre_prefix}$libdir" \
> >          --libexecdir "${pre_prefix}$libexecdir" \
>
> I've just tested this, but it gives me a python stacktrace if I run it
> without
> passing a --ninja argument to configure. With a bit of extra debugging
> added to see
> what is being generated:
>
> ###XXX ['C:/msys64/mingw64/bin/ninja', '--version']
> Traceback (most recent call last):
>   File "C:/msys64/home/Mark/qemu/meson/mesonbuild/mesonmain.py", line 131,
> in run
>     return options.run_func(options)
>   File "C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py", line 245, in
> run
>     app.generate()
>   File "C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py", line 159, in
> generate
>     self._generate(env)
>   File "C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py", line 215, in
> _generate
>     intr.backend.generate()
>   File
> "C:/msys64/home/Mark/qemu/meson/mesonbuild/backend/ninjabackend.py", line
> 483,
> in generate
>     ninja = environment.detect_ninja_command_and_version(log=True)
>   File "C:/msys64/home/Mark/qemu/meson/mesonbuild/environment.py", line
> 177, in
> detect_ninja_command_and_version
>     name = os.path.basename(n)
>   File "C:/msys64/mingw64/lib/python3.8/ntpath.py", line 231, in basename
>     return split(p)[1]
>   File "C:/msys64/mingw64/lib/python3.8/ntpath.py", line 200, in split
>     p = os.fspath(p)
> TypeError: expected str, bytes or os.PathLike object, not NoneType
>
> ERROR: meson setup failed
>
> It seems that it doesn't like parsing the discovered ninja path. I can
> make configure
> work by passing --ninja=ninja to configure which falls back to PATH and
> appears to do
> the right thing:
>
> ###XXX ['ninja', '--version']
> Found ninja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE
>
> I tried a few other things too:
>
>  --ninja=C:/msys64/mingw64/bin/ninja - fails
>  --ninja=C:/msys64/mingw64/bin/ninja.exe - works
>  --ninja=ninja.exe - works
>  --ninja=/c/msys64/mingw64/bin/ninja - fails similar as above
>  --ninja=/c/msys64/mingw64/bin/ninja.exe - works
>  --ninja=C:\\msys64\\mingw64\\bin\\ninja - fails similar as above
>  --ninja=C:\\msys64\\mingw64\\bin\\ninja.exe - works
>
> From these tests it looks as if the .exe prefix is required when using a
> full path to
> the ninja executable.
>
>
> ATB,
>
> Mark.
>
>

--00000000000023ef8d05ade20df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, that might be worth fixing in Meson.<div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 27 ago 2020, 17:57 Mark =
Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-=
ayland@ilande.co.uk</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">On 26/08/2020 20:02, Paolo Bonzini wrote:<br>
<br>
&gt; On Windows it is not possible to invoke a Python script as $NINJA.<br>
&gt; If ninja is present use it directly, while if it is not we can<br>
&gt; keep using ninjatool.<br>
&gt; <br>
&gt; Reported-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@i=
lande.co.uk" target=3D"_blank" rel=3D"noreferrer">mark.cave-ayland@ilande.c=
o.uk</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure | 16 +++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 15 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/configure b/configure<br>
&gt; index 9db9bb89b9..6ecaff429b 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -568,6 +568,7 @@ rng_none=3D&quot;no&quot;<br>
&gt;=C2=A0 secret_keyring=3D&quot;&quot;<br>
&gt;=C2=A0 libdaxctl=3D&quot;&quot;<br>
&gt;=C2=A0 meson=3D&quot;&quot;<br>
&gt; +ninja=3D&quot;&quot;<br>
&gt;=C2=A0 skip_meson=3Dno<br>
&gt;=C2=A0 gettext=3D&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -1052,6 +1053,8 @@ for opt do<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --meson=3D*) meson=3D&quot;$optarg&quot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt; +=C2=A0 --ninja=3D*) ninja=3D&quot;$optarg&quot;<br>
&gt; +=C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --smbd=3D*) smbd=3D&quot;$optarg&quot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --extra-cflags=3D*)<br>
&gt; @@ -1820,6 +1823,7 @@ Advanced options (experts only):<br>
&gt;=C2=A0 =C2=A0 --python=3DPYTHON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use s=
pecified python [$python]<br>
&gt;=C2=A0 =C2=A0 --sphinx-build=3DSPHINX=C2=A0 =C2=A0 use specified sphinx=
-build [$sphinx_build]<br>
&gt;=C2=A0 =C2=A0 --meson=3DMESON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
use specified meson [$meson]<br>
&gt; +=C2=A0 --ninja=3DNINJA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use s=
pecified ninja [$ninja]<br>
&gt;=C2=A0 =C2=A0 --smbd=3DSMBD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 use specified smbd [$smbd]<br>
&gt;=C2=A0 =C2=A0 --with-git=3DGIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
use specified git [$git]<br>
&gt;=C2=A0 =C2=A0 --static=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enable static build [$static]<br>
&gt; @@ -2058,6 +2062,16 @@ case &quot;$meson&quot; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *) meson=3D$(command -v meson) ;;<br>
&gt;=C2=A0 esac<br>
&gt;=C2=A0 <br>
&gt; +# Probe for ninja (used for compdb)<br>
&gt; +<br>
&gt; +if test -z &quot;$ninja&quot;; then<br>
&gt; +=C2=A0 =C2=A0 for c in ninja ninja-build samu; do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if has $c; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ninja=3D$(command -v &quot;=
$c&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 done<br>
&gt; +fi<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Check that the C compiler works. Doing this here before testin=
g<br>
&gt;=C2=A0 # the host CPU ensures that we had a valid CC to autodetect the<=
br>
&gt; @@ -8197,7 +8211,7 @@ fi<br>
&gt;=C2=A0 mv $cross config-meson.cross<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 rm -rf meson-private meson-info meson-logs<br>
&gt; -NINJA=3D$PWD/ninjatool $meson setup \<br>
&gt; +NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --prefix &quot;${pre_prefix}$prefix&=
quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --libdir &quot;${pre_prefix}$libdir&=
quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --libexecdir &quot;${pre_prefix}$lib=
execdir&quot; \<br>
<br>
I&#39;ve just tested this, but it gives me a python stacktrace if I run it =
without<br>
passing a --ninja argument to configure. With a bit of extra debugging adde=
d to see<br>
what is being generated:<br>
<br>
###XXX [&#39;C:/msys64/mingw64/bin/ninja&#39;, &#39;--version&#39;]<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;C:/msys64/home/Mark/qemu/meson/mesonbuild/mesonmain.py&qu=
ot;, line 131, in run<br>
=C2=A0 =C2=A0 return options.run_func(options)<br>
=C2=A0 File &quot;C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py&quot;=
, line 245, in run<br>
=C2=A0 =C2=A0 app.generate()<br>
=C2=A0 File &quot;C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py&quot;=
, line 159, in generate<br>
=C2=A0 =C2=A0 self._generate(env)<br>
=C2=A0 File &quot;C:/msys64/home/Mark/qemu/meson/mesonbuild/msetup.py&quot;=
, line 215, in _generate<br>
=C2=A0 =C2=A0 intr.backend.generate()<br>
=C2=A0 File &quot;C:/msys64/home/Mark/qemu/meson/mesonbuild/backend/ninjaba=
ckend.py&quot;, line 483,<br>
in generate<br>
=C2=A0 =C2=A0 ninja =3D environment.detect_ninja_command_and_version(log=3D=
True)<br>
=C2=A0 File &quot;C:/msys64/home/Mark/qemu/meson/mesonbuild/environment.py&=
quot;, line 177, in<br>
detect_ninja_command_and_version<br>
=C2=A0 =C2=A0 name =3D os.path.basename(n)<br>
=C2=A0 File &quot;C:/msys64/mingw64/lib/python3.8/ntpath.py&quot;, line 231=
, in basename<br>
=C2=A0 =C2=A0 return split(p)[1]<br>
=C2=A0 File &quot;C:/msys64/mingw64/lib/python3.8/ntpath.py&quot;, line 200=
, in split<br>
=C2=A0 =C2=A0 p =3D os.fspath(p)<br>
TypeError: expected str, bytes or os.PathLike object, not NoneType<br>
<br>
ERROR: meson setup failed<br>
<br>
It seems that it doesn&#39;t like parsing the discovered ninja path. I can =
make configure<br>
work by passing --ninja=3Dninja to configure which falls back to PATH and a=
ppears to do<br>
the right thing:<br>
<br>
###XXX [&#39;ninja&#39;, &#39;--version&#39;]<br>
Found ninja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE<br>
<br>
I tried a few other things too:<br>
<br>
=C2=A0--ninja=3DC:/msys64/mingw64/bin/ninja - fails<br>
=C2=A0--ninja=3DC:/msys64/mingw64/bin/ninja.exe - works<br>
=C2=A0--ninja=3Dninja.exe - works<br>
=C2=A0--ninja=3D/c/msys64/mingw64/bin/ninja - fails similar as above<br>
=C2=A0--ninja=3D/c/msys64/mingw64/bin/ninja.exe - works<br>
=C2=A0--ninja=3DC:\\msys64\\mingw64\\bin\\ninja - fails similar as above<br=
>
=C2=A0--ninja=3DC:\\msys64\\mingw64\\bin\\ninja.exe - works<br>
<br>
From these tests it looks as if the .exe prefix is required when using a fu=
ll path to<br>
the ninja executable.<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div>

--00000000000023ef8d05ade20df3--


