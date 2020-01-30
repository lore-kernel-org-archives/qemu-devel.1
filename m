Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A75C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAF1206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF6bKTXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAF1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBND-0001A7-O3
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1ixBMT-0000bv-DC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1ixBMR-0000lc-TI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:04:05 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1ixBMR-0000kx-NK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:04:03 -0500
Received: by mail-ot1-x343.google.com with SMTP id i6so3392967otr.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EWuV2SxF0zyNRr9pbMx3m9yuxh/CblPB6RGRuIoZ7ss=;
 b=dF6bKTXxS6DnlHZzvh2rNFwnkB2WKt5xtqg8nnC5ktAUDUGBssdX3dchdrpWZO2kNZ
 LKtN1um5EcHszlHrbjJUJkVROjhrn0a9BKBlpdWG4ZQqLiqdSGZGv1Hs2EmYbJaEi722
 J0d11TwV9113amFp4LeSxm1HW7K+GIOEFAyxjF95Im8+87y/8pJmUF0SlYIczxWSqHQv
 ZFPBGUG6FX4Zl5CYits6gIEJCk3cgDEUI15jjyDjxU3fjbnn8skfJd+Y+O2vKQwY780M
 F0N+3C+aEZuTYffHGGx6nK1PbfpEsOiZlQoj+9QYBbsVBegzWNXnXjSND7KiY/fX83kd
 +WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EWuV2SxF0zyNRr9pbMx3m9yuxh/CblPB6RGRuIoZ7ss=;
 b=BcGck0TksUEIvg8+WmQ75Va1ZemHQeypWyjy5duao2SEEpg59qzY1JDel92DhkVtF5
 gg3Y+o1ke69/EtsujTWZDm034H8pn5yN1zWxySgCf8ZZ8eEsLbWEkqZBvxufzkeQ3u5a
 qytXiCMZpGwmCTW9xJc9Lr5Mfw1mXaSKIXxQM8oehjavKlWvszhj5+eUoWnE4QxvxXq6
 j/MBItPju/8UD6fR0XcKaPmrFx68XDCy1ou81QkUKwsj0EZlKORXn3J5NCfNTDHRARQY
 xO3j+OBDgp02KWYQP1S4CZyHJHmU1fVZygDLv7iwwNwHNDo8UXN4Ha2Cog+vVxFitBnD
 BfHA==
X-Gm-Message-State: APjAAAWvGXDvMxDzN+h0hO7BnbhhUeroIePuFIGFClcn35ktik1K21Dl
 9/gdrFuAV/4PUafzA5/6wnVgWKCcdf/g2vpLg1s=
X-Google-Smtp-Source: APXvYqz6yonCKsJmmV2GJ6yHfffaGqr1DU2AY7POHJf91muquPVA+m/SfJnKwrBhG1eppmxQzsq8dKxPyz2kuc8XCiU=
X-Received: by 2002:a9d:831:: with SMTP id 46mr3937921oty.295.1580396642797;
 Thu, 30 Jan 2020 07:04:02 -0800 (PST)
MIME-Version: 1.0
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
 <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
 <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
In-Reply-To: <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 30 Jan 2020 16:03:51 +0100
Message-ID: <CABLmASGkSnG4+vfykBnEznX=kCAcSaiW20nf-wT9Cne4Cj9+LQ@mail.gmail.com>
Subject: Re: [RFC] coreaudio: fix coreaudio_test.diff
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="0000000000007f8dcb059d5cc4c2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007f8dcb059d5cc4c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 8:13 AM Volker R=C3=BCmelin <vr_qemu@t-online.de> w=
rote:

> This is an untested patch that tries to fix the problems in the
> patch found at
> https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  audio/audio_template.h | 16 ++++++++--------
>  audio/coreaudio.c      |  5 +++++
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index a7b46b8363..e6724c5d68 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -153,13 +153,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>      sw->ratio =3D ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
>  #endif
>
> -#ifdef FLOAT_MIXENG
> -#ifdef DAC
> -    sw->conv =3D mixeng_conv_float;
> -#else
> -    sw->clip =3D mixeng_clip_float;
> -#endif
> -#else
>  #ifdef DAC
>      sw->conv =3D mixeng_conv
>  #else
> @@ -169,7 +162,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>          [sw->info.sign]
>          [sw->info.swap_endianness]
>          [audio_bits_to_index (sw->info.bits)];
> -#endif
>
>      sw->name =3D g_strdup (name);
>      err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
> @@ -284,6 +276,13 @@ static HW *glue(audio_pcm_hw_add_new_,
> TYPE)(AudioState *s,
>          goto err1;
>      }
>
> +#ifdef FLOAT_MIXENG
> +#ifdef DAC
> +    hw->clip =3D mixeng_clip_float;
> +#else
> +    hw->conv =3D mixeng_conv_float;
> +#endif
> +#else
>  #ifdef DAC
>      hw->clip =3D mixeng_clip
>  #else
> @@ -293,6 +292,7 @@ static HW *glue(audio_pcm_hw_add_new_,
> TYPE)(AudioState *s,
>          [hw->info.sign]
>          [hw->info.swap_endianness]
>          [audio_bits_to_index (hw->info.bits)];
> +#endif
>
>      glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
>
> diff --git a/audio/coreaudio.c b/audio/coreaudio.c
> index 4e7e509ad0..ff0d23fd7d 100644
> --- a/audio/coreaudio.c
> +++ b/audio/coreaudio.c
> @@ -482,6 +482,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>      Audiodev *dev =3D drv_opaque;
>      AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
>      int frames;
> +    struct audsettings fake_as;
>
>      /* create mutex */
>      err =3D pthread_mutex_init(&core->mutex, NULL);
> @@ -490,6 +491,10 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>          return -1;
>      }
>
> +    memcpy(&fake_as, as, sizeof(struct audsettings));
> +    as =3D &fake_as;
> +    /* size of float is 32bits */
> +    as->fmt =3D AUDIO_FORMAT_S32;
>      audio_pcm_init_info (&hw->info, as);
>
>      status =3D coreaudio_get_voice(&core->outputDeviceID);
> --
> 2.16.4
>
> Hi all,

Thanks to the generous help from Mark, I can now report that it is good to
hear coreaudio has been restored into a working state with this patch! I
tested qemu-system-ppc running MacOS and OSX.

Best,
Howard

--0000000000007f8dcb059d5cc4c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 29, 2020 at 8:13 AM Volke=
r R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de">vr_qemu@t-online.=
de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">This is an untested patch that tries to fix the problems in the<br>
patch found at<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg0214=
2.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-01/msg02142.html</a>. <br>
<br>
Signed-off-by: Volker R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.d=
e" target=3D"_blank">vr_qemu@t-online.de</a>&gt;<br>
---<br>
=C2=A0audio/audio_template.h | 16 ++++++++--------<br>
=C2=A0audio/coreaudio.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++++<br>
=C2=A02 files changed, 13 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/audio/audio_template.h b/audio/audio_template.h<br>
index a7b46b8363..e6724c5d68 100644<br>
--- a/audio/audio_template.h<br>
+++ b/audio/audio_template.h<br>
@@ -153,13 +153,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (<br>
=C2=A0 =C2=A0 =C2=A0sw-&gt;ratio =3D ((int64_t) sw-&gt;info.freq &lt;&lt; 3=
2) / sw-&gt;hw-&gt;info.freq;<br>
=C2=A0#endif<br>
<br>
-#ifdef FLOAT_MIXENG<br>
-#ifdef DAC<br>
-=C2=A0 =C2=A0 sw-&gt;conv =3D mixeng_conv_float;<br>
-#else<br>
-=C2=A0 =C2=A0 sw-&gt;clip =3D mixeng_clip_float;<br>
-#endif<br>
-#else<br>
=C2=A0#ifdef DAC<br>
=C2=A0 =C2=A0 =C2=A0sw-&gt;conv =3D mixeng_conv<br>
=C2=A0#else<br>
@@ -169,7 +162,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[sw-&gt;info.sign]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[sw-&gt;info.swap_endianness]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[audio_bits_to_index (sw-&gt;info.bits)];=
<br>
-#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0sw-&gt;name =3D g_strdup (name);<br>
=C2=A0 =C2=A0 =C2=A0err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw)=
;<br>
@@ -284,6 +276,13 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioStat=
e *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#ifdef FLOAT_MIXENG<br>
+#ifdef DAC<br>
+=C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip_float;<br>
+#else<br>
+=C2=A0 =C2=A0 hw-&gt;conv =3D mixeng_conv_float;<br>
+#endif<br>
+#else<br>
=C2=A0#ifdef DAC<br>
=C2=A0 =C2=A0 =C2=A0hw-&gt;clip =3D mixeng_clip<br>
=C2=A0#else<br>
@@ -293,6 +292,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState=
 *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hw-&gt;info.sign]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hw-&gt;info.swap_endianness]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[audio_bits_to_index (hw-&gt;info.bits)];=
<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);<br>
<br>
diff --git a/audio/coreaudio.c b/audio/coreaudio.c<br>
index 4e7e509ad0..ff0d23fd7d 100644<br>
--- a/audio/coreaudio.c<br>
+++ b/audio/coreaudio.c<br>
@@ -482,6 +482,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct au=
dsettings *as,<br>
=C2=A0 =C2=A0 =C2=A0Audiodev *dev =3D drv_opaque;<br>
=C2=A0 =C2=A0 =C2=A0AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev-&gt;=
u.coreaudio.out;<br>
=C2=A0 =C2=A0 =C2=A0int frames;<br>
+=C2=A0 =C2=A0 struct audsettings fake_as;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* create mutex */<br>
=C2=A0 =C2=A0 =C2=A0err =3D pthread_mutex_init(&amp;core-&gt;mutex, NULL);<=
br>
@@ -490,6 +491,10 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct a=
udsettings *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 memcpy(&amp;fake_as, as, sizeof(struct audsettings));<br>
+=C2=A0 =C2=A0 as =3D &amp;fake_as;<br>
+=C2=A0 =C2=A0 /* size of float is 32bits */<br>
+=C2=A0 =C2=A0 as-&gt;fmt =3D AUDIO_FORMAT_S32;<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&gt;info, as);<br>
<br>
=C2=A0 =C2=A0 =C2=A0status =3D coreaudio_get_voice(&amp;core-&gt;outputDevi=
ceID);<br>
-- <br>
2.16.4<br>
<br></blockquote><div>Hi all,</div><div><br></div><div>Thanks to the genero=
us help from Mark, I can now report that it is good to hear coreaudio has b=
een restored into a working state with this patch! I tested qemu-system-ppc=
 running MacOS and OSX.<br></div><div><br></div><div>Best,</div><div>Howard=
<br></div></div></div>

--0000000000007f8dcb059d5cc4c2--

