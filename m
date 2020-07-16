Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEF4C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18844207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qomfQtSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18844207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4gP-0005Iw-Ar
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jw4fe-0004ao-6W
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:15:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jw4fc-0003in-0s
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:15:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so10456494wmi.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=byn+tchBuiicl5b/FZ5BeZCek0X1Ol5rSL3gDi0fBLw=;
 b=qomfQtSK/rPijjxYPKvNYu4/UXJXgni0z26LYXB6T8aTCvdj/umbccf5SSCbL2/sGO
 11AbVqJDQ4MV99UY83QqmaIZyz1lJ117ln/0KuogeseSZFXdEsmOK5YVkutU7XFiygzc
 sZEaT3Hn4FW3kSt7gWOOvZzqCBjTeXByaqmEUmSAnWwIC3l0V5zpuvD6g0G5+IuDwiYd
 SbfuSWyVAVOqxSHVuXvtAIonNMQMyhHvuZOJa4BkyoMCZbB7Z7NZsUsUsZY8j7Tfwr5v
 E6iDJQq2ccxry53TFsZoO5Pq8OgcGHKaRJ8f2q2WG1NSsSUVRTPx1Md7EJw9+sjZcCLs
 NOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=byn+tchBuiicl5b/FZ5BeZCek0X1Ol5rSL3gDi0fBLw=;
 b=j6ACoDRGpeP9b9IPSniyLujGy+JryCXzznXkudkU7BtZqsVpjqmK4RBrZNPxosXD/z
 6I+NxPaUeHnJBq5xMq0if4Ubvk7wemP9A14kvYd88UWTU/hqHbSRhWEJDKKGQxD5MW04
 AbN0lBdiiP9cCqHToMt43DZMMhsyaYVqmoxGeBtYhMTiGGOfyo+uGB06QI2Qnc1B8uxJ
 91t0c99lite9ucGggo9cVTxa05GJt9+n4XZqoJf2kRse446YNnb/QBdDBWmuuajctgMa
 TIhhG9Ij14Zoce/YIb5d4Ad4AyCUzZvB3axT38n3yNKBrUHuEtRF6O3Naat5oFQvh7+b
 lxGw==
X-Gm-Message-State: AOAM5329VgKameTkMdKRIkJWm4HCL7BnNIqpPENGkYC30WYvH4xQzf0e
 a5+YMLddveNTsrz1pceReSU9eRbdbNfYZSg0riJzIQTO
X-Google-Smtp-Source: ABdhPJwCCHP2RPPyjh99LqY0VENPGo0mY1wyXFAyI6JX1kssha79dUvkBd6qTe/XDHRz/tM+Z3Ge+r0GTVb0SSQYR3E=
X-Received: by 2002:a1c:b608:: with SMTP id g8mr4543094wmf.55.1594908929747;
 Thu, 16 Jul 2020 07:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141100.398296-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200716141100.398296-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Jul 2020 18:15:17 +0400
Message-ID: <CAJ+F1CLUj4uGwvuReBY-xOhbr6_RW0yG4976mpW=1gDbb+ZEtA@mail.gmail.com>
Subject: Re: [RFC PATCH] os-posix: fix regression for install-less datadir
 location
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000034ef3a05aa8faccf"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joe Slater <joe.slater@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000034ef3a05aa8faccf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 16, 2020 at 6:11 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> os_find_datadir() used to check the ../share/qemu location (regardless
> of CONFIG_QEMU_DATADIR). It turns out that people rely on that location
> for running qemu in an arbitrary "install-less/portable" fashion. Change
> the logic to return that directory as a last resort.
>
> (this is an alternative to the patch "[PATCH 1/1] os_find_datadir: search
> as in version 4.2" from Joe Slater)
>
> Fixes: 6dd2dacedd83d12328 ("os-posix: simplify os_find_datadir")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  os-posix.c            | 15 ++++++++++++---
>  scripts/create_config |  2 +-
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/os-posix.c b/os-posix.c
> index b674b20b1b1..bd0ed0c14d1 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -82,8 +82,13 @@ void os_setup_signal_handling(void)
>
>  /*
>   * Find a likely location for support files using the location of the
> binary.
> - * When running from the build tree this will be "$bindir/../pc-bios".
> - * Otherwise, this is CONFIG_QEMU_DATADIR.
> + *
> + * If running from the install location (CONFIG_BINDIR), this will be
> + * CONFIG_QEMU_DATADIR.
> + *
> + * Otherwise, fallback on "$execdir/../pc-bios" if it exists (the build
> tree
> + * location), else on "$execdir/../share/qemu" (for the
> install-less/"portable"
> + * version).
>   */
>  char *os_find_datadir(void)
>  {
> @@ -93,12 +98,16 @@ char *os_find_datadir(void)
>      exec_dir =3D qemu_get_exec_dir();
>      g_return_val_if_fail(exec_dir !=3D NULL, NULL);
>
> +    if (g_str_has_prefix(exec_dir, CONFIG_BINDIR)) {
>

I realize g_str_has_prefix() may not be good enough (it was meant to ignore
the / suffix..). I guess we can just go with the version from Joe instead.


+        return g_strdup(CONFIG_QEMU_DATADIR);
> +    }
> +
>      dir =3D g_build_filename(exec_dir, "..", "pc-bios", NULL);
>      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
>          return g_steal_pointer(&dir);
>      }
>
> -    return g_strdup(CONFIG_QEMU_DATADIR);
> +    return g_build_filename(exec_dir, "..", "share", "qemu", NULL);
>  }
>
>  void os_set_proc_name(const char *s)
> diff --git a/scripts/create_config b/scripts/create_config
> index 6d8f08b39da..03f8cb1dc10 100755
> --- a/scripts/create_config
> +++ b/scripts/create_config
> @@ -15,7 +15,7 @@ case $line in
>      echo "#define QEMU_VERSION_MINOR $minor"
>      echo "#define QEMU_VERSION_MICRO $micro"
>      ;;
> - qemu_*dir=3D* | qemu_*path=3D*) # qemu-specific directory configuration
> + bindir=3D* | qemu_*dir=3D* | qemu_*path=3D*) # qemu-specific directory
> configuration
>      name=3D${line%=3D*}
>      value=3D${line#*=3D}
>      define_name=3D$(echo $name | LC_ALL=3DC tr '[a-z]' '[A-Z]')
> --
> 2.27.0.221.ga08a83db2b
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000034ef3a05aa8faccf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 16, 2020 at 6:11 PM Mar=
c-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marc=
andre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">os_find_datadir() used to check the ../share/qemu lo=
cation (regardless<br>
of CONFIG_QEMU_DATADIR). It turns out that people rely on that location<br>
for running qemu in an arbitrary &quot;install-less/portable&quot; fashion.=
 Change<br>
the logic to return that directory as a last resort.<br>
<br>
(this is an alternative to the patch &quot;[PATCH 1/1] os_find_datadir: sea=
rch<br>
as in version 4.2&quot; from Joe Slater)<br>
<br>
Fixes: 6dd2dacedd83d12328 (&quot;os-posix: simplify os_find_datadir&quot;)<=
br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0os-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15 ++++++++++++=
---<br>
=C2=A0scripts/create_config |=C2=A0 2 +-<br>
=C2=A02 files changed, 13 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/os-posix.c b/os-posix.c<br>
index b674b20b1b1..bd0ed0c14d1 100644<br>
--- a/os-posix.c<br>
+++ b/os-posix.c<br>
@@ -82,8 +82,13 @@ void os_setup_signal_handling(void)<br>
<br>
=C2=A0/*<br>
=C2=A0 * Find a likely location for support files using the location of the=
 binary.<br>
- * When running from the build tree this will be &quot;$bindir/../pc-bios&=
quot;.<br>
- * Otherwise, this is CONFIG_QEMU_DATADIR.<br>
+ *<br>
+ * If running from the install location (CONFIG_BINDIR), this will be<br>
+ * CONFIG_QEMU_DATADIR.<br>
+ *<br>
+ * Otherwise, fallback on &quot;$execdir/../pc-bios&quot; if it exists (th=
e build tree<br>
+ * location), else on &quot;$execdir/../share/qemu&quot; (for the install-=
less/&quot;portable&quot;<br>
+ * version).<br>
=C2=A0 */<br>
=C2=A0char *os_find_datadir(void)<br>
=C2=A0{<br>
@@ -93,12 +98,16 @@ char *os_find_datadir(void)<br>
=C2=A0 =C2=A0 =C2=A0exec_dir =3D qemu_get_exec_dir();<br>
=C2=A0 =C2=A0 =C2=A0g_return_val_if_fail(exec_dir !=3D NULL, NULL);<br>
<br>
+=C2=A0 =C2=A0 if (g_str_has_prefix(exec_dir, CONFIG_BINDIR)) {<br></blockq=
uote><div><br></div><div>I realize g_str_has_prefix() may not be good enoug=
h (it was meant to ignore the / suffix..). I guess we can just go with the =
version from Joe instead.</div><div><br></div><div> <br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(CONFIG_QEMU_DATADIR);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0dir =3D g_build_filename(exec_dir, &quot;..&quot;, &quo=
t;pc-bios&quot;, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return g_steal_pointer(&amp;dir);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return g_strdup(CONFIG_QEMU_DATADIR);<br>
+=C2=A0 =C2=A0 return g_build_filename(exec_dir, &quot;..&quot;, &quot;shar=
e&quot;, &quot;qemu&quot;, NULL);<br>
=C2=A0}<br>
<br>
=C2=A0void os_set_proc_name(const char *s)<br>
diff --git a/scripts/create_config b/scripts/create_config<br>
index 6d8f08b39da..03f8cb1dc10 100755<br>
--- a/scripts/create_config<br>
+++ b/scripts/create_config<br>
@@ -15,7 +15,7 @@ case $line in<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;#define QEMU_VERSION_MINOR $minor&quot;<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;#define QEMU_VERSION_MICRO $micro&quot;<br>
=C2=A0 =C2=A0 =C2=A0;;<br>
- qemu_*dir=3D* | qemu_*path=3D*) # qemu-specific directory configuration<b=
r>
+ bindir=3D* | qemu_*dir=3D* | qemu_*path=3D*) # qemu-specific directory co=
nfiguration<br>
=C2=A0 =C2=A0 =C2=A0name=3D${line%=3D*}<br>
=C2=A0 =C2=A0 =C2=A0value=3D${line#*=3D}<br>
=C2=A0 =C2=A0 =C2=A0define_name=3D$(echo $name | LC_ALL=3DC tr &#39;[a-z]&#=
39; &#39;[A-Z]&#39;)<br>
-- <br>
2.27.0.221.ga08a83db2b<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000034ef3a05aa8faccf--

