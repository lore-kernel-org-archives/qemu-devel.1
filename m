Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964DDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C40A20786
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0N/guqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C40A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrRd-0005az-Gc
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kDrQS-00049G-7A
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:45:24 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kDrQQ-0003Jp-FZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:45:23 -0400
Received: by mail-ed1-x542.google.com with SMTP id c10so3146405edk.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gbwZRlflHVl/ilYGKX2fH33/klrazdTt9WM1Pj2xZgI=;
 b=H0N/guqdBl2YgloJD+riNGcEEU2iquEB5RT51GrJfsrEzR+2tUTalFoh3L3ZQ98LM9
 5YYqb8MDQYCnX8elwgqPmOjMVUuemXawhjDdIiBxcpv9xasvkda9OTwdusJcdRVzg4aa
 C8qOqwNCuZ8c8yVs9D5NQJJvGO3OfG8VJWg/TtMSXL0xUulHtTvSjpTfIngvu+sS/FT+
 obtcb1OWOMr1wgv/7grpSCHALCjr+9dySsqvsPuFooO1DpBEBmsn/h5bf5GCwJejqXDp
 H48lmQ0YlC03rkYRA1ixIupejrbwCRxexDmPFO9vIA6V2jEtLYpxxNWWFNTM6HlZaQ4y
 xajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gbwZRlflHVl/ilYGKX2fH33/klrazdTt9WM1Pj2xZgI=;
 b=UH8XDA+BMhOulWFE5em9/avZqdyZFI1yui8YeShezHjawV2w8Ryi5IFLrdjX1gU0yS
 RpzhGkLcc6v+LfjS8VKTjSg8Q7oV7PQ5qXih76hScVd3xm8yKZQYbllO13Xrshwiagfh
 YlPeEnF7pAjV3CZQkDbp8pypdHopVghjOWuRSRQnk28ujsiG95yLKFtWolus8hvy80jM
 YSTtp5R4OpYzmAXXYQirh/VdYFTzVRiO4qTNYalkZyDVQXwldhjV6rHO6cj0WoDM+qC5
 cxU2LCKl3Kj19cchME4jFw6iOeUMHg7qdiLFwZoXP4CzhJ7LY574KFq1P0UyjHKIH7BG
 +pdA==
X-Gm-Message-State: AOAM531B20CGqCbUmJ+hGN97YcKe8g+4xo3xRiK79YFKV1tk0/43npAm
 NUFOw3xDjXdk9fdRQfqiQD9Q19UoqFbqEp13h2Y=
X-Google-Smtp-Source: ABdhPJyohxFRbpZWKKopIMFivRoG2D5j0HCJ95HSzNsFzW6nktrCgxKLk4cUPR6n/+3y2FX6E0u898QMIA08218cnNQ=
X-Received: by 2002:aa7:ca17:: with SMTP id y23mr3837081eds.245.1599147920196; 
 Thu, 03 Sep 2020 08:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200903152933.97838-1-brogers@suse.com>
In-Reply-To: <20200903152933.97838-1-brogers@suse.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 3 Sep 2020 19:45:08 +0400
Message-ID: <CAJ+F1C+2P9Z_YLVxwjkwOCrCCqMwPg5_OnS7dYvhWDN-iXHyOg@mail.gmail.com>
Subject: Re: [PATCH] meson: remove linkage of sdl to baum
To: Bruce Rogers <brogers@suse.com>
Content-Type: multipart/alternative; boundary="000000000000ba0b5305ae6aa349"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ba0b5305ae6aa349
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 3, 2020 at 7:33 PM Bruce Rogers <brogers@suse.com> wrote:

> Ever since commit 537fe2d63f744e7c96ff45b60d09486a81958e06 there
> has been a 'linkage' to sdl for compiling baum.c. Originally it
> had to do with including sdl cflags for any file including sdl
> headers. There is no longer any such need for baum.c, but the
> association has persisted in the make system, and with the switch
> to meson it has now become a hard requirement, which now causes
> chardev-baum.so to not be produced if sdl is not configured.
> Remove this bogus linkage.
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  chardev/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 27a9a28f4c..54e88d0310 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -36,9 +36,9 @@ softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true:
> files('spice.c'))
>
>  chardev_modules =3D {}
>
> -if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
> +if config_host.has_key('CONFIG_BRLAPI')
>    module_ss =3D ss.source_set()
> -  module_ss.add(when: [sdl, brlapi], if_true: [files('baum.c'), pixman])
> +  module_ss.add(when: [brlapi], if_true: [files('baum.c'), pixman])
>    chardev_modules +=3D { 'baum': module_ss }
>  endif
>
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ba0b5305ae6aa349
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 7:33 PM Bruc=
e Rogers &lt;<a href=3D"mailto:brogers@suse.com">brogers@suse.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ever since=
 commit 537fe2d63f744e7c96ff45b60d09486a81958e06 there<br>
has been a &#39;linkage&#39; to sdl for compiling baum.c. Originally it<br>
had to do with including sdl cflags for any file including sdl<br>
headers. There is no longer any such need for baum.c, but the<br>
association has persisted in the make system, and with the switch<br>
to meson it has now become a hard requirement, which now causes<br>
chardev-baum.so to not be produced if sdl is not configured.<br>
Remove this bogus linkage.<br>
<br>
Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank">brogers@suse.com</a>&gt;<br></blockquote><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0chardev/meson.build | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/chardev/meson.build b/chardev/meson.build<br>
index 27a9a28f4c..54e88d0310 100644<br>
--- a/chardev/meson.build<br>
+++ b/chardev/meson.build<br>
@@ -36,9 +36,9 @@ softmmu_ss.add(when: [&#39;CONFIG_SPICE&#39;, spice], if_=
true: files(&#39;spice.c&#39;))<br>
<br>
=C2=A0chardev_modules =3D {}<br>
<br>
-if config_host.has_key(&#39;CONFIG_BRLAPI&#39;) and sdl.found()<br>
+if config_host.has_key(&#39;CONFIG_BRLAPI&#39;)<br>
=C2=A0 =C2=A0module_ss =3D ss.source_set()<br>
-=C2=A0 module_ss.add(when: [sdl, brlapi], if_true: [files(&#39;baum.c&#39;=
), pixman])<br>
+=C2=A0 module_ss.add(when: [brlapi], if_true: [files(&#39;baum.c&#39;), pi=
xman])<br>
=C2=A0 =C2=A0chardev_modules +=3D { &#39;baum&#39;: module_ss }<br>
=C2=A0endif<br>
<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ba0b5305ae6aa349--

