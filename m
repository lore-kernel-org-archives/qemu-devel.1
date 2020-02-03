Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55724C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC9920661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoi1CLjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC9920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWbH-0007I7-AF
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 02:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyWae-0006aJ-J2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyWac-0000m0-Oz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:56:16 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iyWac-0000jc-GW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:56:14 -0500
Received: by mail-oi1-x242.google.com with SMTP id v19so13840996oic.12
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 23:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bCLuvTwnS5+/a2G4PyrqcAZOvK1O2jYRQcsT3tDRRj8=;
 b=hoi1CLjwtRNGd3WxTqZwfSeDGL6Ybean+eUC0sNT1HFs3xkAFnyuF74GpzjxBTSPgs
 fRCg/aM/RcPlGkuf5m5wbSQc3L+Jvi774YBCk6yMj+ES9e95HAJV2wujkacwvmhRLR9+
 TIQcsOuyRkCtoGJ5BxLWzEBRwaqeQT0o+CBOLl35CKe5F+9EzaMYSUYI+fxkTvBaLOJs
 +jsG5r4/WoCunPyGTinPQF9yWw5V8KzslxKK4Wjzdmcauk4h6+gz8kFOQxAM8C2jNc8X
 GE/RbmxYSnPgO5Rqcq9ilV+tWihIe5fgpBJgdDvQ6KossiitvJxYWfCQD9/XLz6kW9CU
 /Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCLuvTwnS5+/a2G4PyrqcAZOvK1O2jYRQcsT3tDRRj8=;
 b=k3MwifurC34AYu4cAk4XKEbOH7P/eUi8KHqjsOQLbgD29TYkfrBckih/sM74cskYUh
 wcSXkdGdmcyNsVm33uzN5887tQzP8K6kka+2T4x1KHKtV6Hdsx4OOJajyFTYY/5h1nEC
 DL4tok02UG4AtlmFBsMk8nhC1i3/K/2QcvcCGVkTAyZdptbHfjCO9r2r7LaDXollWtA4
 AMIOhlmNrWMEy6YaCGD53SlW9hZEodFV3+uyl/g/SpRxauhA3vsHcyvYZwMx9vbtAVF5
 jNpEuZimKgjgrINo4gANjuivAFwugTxZW23GJghZ12whLRSui2sG0Vr5i9nwa7+4mCE4
 tHGA==
X-Gm-Message-State: APjAAAUL/Gp8Y4Xm9iL7FH6wAqpG7uZDjvq0+S5PgUPgyh4yKKJ9CZjZ
 n6zU20N8Qy+L5fwFWBBaeeUItbhoOlOsePGor8Q=
X-Google-Smtp-Source: APXvYqyQtLlIVRHGXp3LMRdzAB7pm54nF9n5Tgshf6o3EfeyPH2CoyrAiyHI85fk6hq+Cx6MB8fY6syrpeRevE8WUCI=
X-Received: by 2002:a05:6808:487:: with SMTP id
 z7mr14215423oid.59.1580716573525; 
 Sun, 02 Feb 2020 23:56:13 -0800 (PST)
MIME-Version: 1.0
References: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 3 Feb 2020 08:56:01 +0100
Message-ID: <CABLmASG5J0AcB7khUfK1G2tTw97ng0HRonaejo-SReAznyekCQ@mail.gmail.com>
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000db0c56059da74123"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: KJ Liew <liewkj@yahoo.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000db0c56059da74123
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2020 at 12:02 AM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com>
wrote:

> Windows (unlike wine) bails out when IDirectSoundBuffer8::Lock is called
> with zero length.  Also, hw->pos_emul handling was incorrect when
> calling this function for the first time.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> Reported-by: KJ Liew <liewkj@yahoo.com>
> ---
>
> I've tested this patch on wine and a borrowed Windows 8.1 laptop, I
> could only test audio playback, not recording.  I've cross-compiled qemu
> using the docker image, for 64-bit.
>
> ---
>  audio/dsound_template.h |  1 +
>  audio/audio.c           |  6 ++----
>  audio/dsoundaudio.c     | 27 +++++++++++++++++++++++----
>  3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/audio/dsound_template.h b/audio/dsound_template.h
> index 7a15f91ce5..9c5ce625ab 100644
> --- a/audio/dsound_template.h
> +++ b/audio/dsound_template.h
> @@ -244,6 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>          goto fail0;
>      }
>
> +    ds->first_time =3D true;
>      obt_as.endianness =3D 0;
>      audio_pcm_init_info (&hw->info, &obt_as);
>
> diff --git a/audio/audio.c b/audio/audio.c
> index f63f39769a..cb1efc6dc5 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw,
> size_t live)
>      while (live) {
>          size_t size, decr, proc;
>          void *buf =3D hw->pcm_ops->get_buffer_out(hw, &size);
> -        if (!buf) {
> -            /* retrying will likely won't help, drop everything. */
> -            hw->mix_buf->pos =3D (hw->mix_buf->pos + live) %
> hw->mix_buf->size;
> -            return clipped + live;
> +        if (!buf || size =3D=3D 0) {
> +            break;
>          }
>
>          decr =3D MIN(size / hw->info.bytes_per_frame, live);
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index c265c0094b..bd57082a8d 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -53,12 +53,14 @@ typedef struct {
>  typedef struct {
>      HWVoiceOut hw;
>      LPDIRECTSOUNDBUFFER dsound_buffer;
> +    bool first_time;
>      dsound *s;
>  } DSoundVoiceOut;
>
>  typedef struct {
>      HWVoiceIn hw;
>      LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
> +    bool first_time;
>      dsound *s;
>  } DSoundVoiceIn;
>
> @@ -414,21 +416,32 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw,
> size_t *size)
>      DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
>      LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
>      HRESULT hr;
> -    DWORD ppos, act_size;
> +    DWORD ppos, wpos, act_size;
>      size_t req_size;
>      int err;
>      void *ret;
>
> -    hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
> +    hr =3D IDirectSoundBuffer_GetCurrentPosition(
> +        dsb, &ppos, ds->first_time ? &wpos : NULL);
>      if (FAILED(hr)) {
>          dsound_logerr(hr, "Could not get playback buffer position\n");
>          *size =3D 0;
>          return NULL;
>      }
>
> +    if (ds->first_time) {
> +        hw->pos_emul =3D wpos;
> +        ds->first_time =3D false;
> +    }
> +
>      req_size =3D audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
>      req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
>
> +    if (req_size =3D=3D 0) {
> +        *size =3D 0;
> +        return NULL;
> +    }
> +
>      err =3D dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret=
,
> NULL,
>                            &act_size, NULL, false, ds->s);
>      if (err) {
> @@ -508,18 +521,24 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw,
> size_t *size)
>      DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
>      LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer;
>      HRESULT hr;
> -    DWORD cpos, act_size;
> +    DWORD cpos, rpos, act_size;
>      size_t req_size;
>      int err;
>      void *ret;
>
> -    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NUL=
L);
> +    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(
> +        dscb, &cpos, ds->first_time ? &rpos : NULL);
>      if (FAILED(hr)) {
>          dsound_logerr(hr, "Could not get capture buffer position\n");
>          *size =3D 0;
>          return NULL;
>      }
>
> +    if (ds->first_time) {
> +        hw->pos_emul =3D rpos;
> +        ds->first_time =3D false;
> +    }
> +
>      req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
>      req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
>
> --
> 2.25.0
>

Hi,

I tested this patch running qemu-system-ppc with MacOS 9.2 and OSX 10.5.
Qemu was cross-compiled on Fedora 31 from
https://github.com/mcayland/qemu/tree/screamer. Host was Windows 10.

The dsound locking errors are gone, so for this test case all seems OK.

Best,
Howard

--000000000000db0c56059da74123
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 3, 2020 at 12:02 AM K=C5=
=91v=C3=A1g=C3=B3, Zolt=C3=A1n &lt;<a href=3D"mailto:dirty.ice.hu@gmail.com=
">dirty.ice.hu@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Windows (unlike wine) bails out when IDirectSoundBu=
ffer8::Lock is called<br>
with zero length.=C2=A0 Also, hw-&gt;pos_emul handling was incorrect when<b=
r>
calling this function for the first time.<br>
<br>
Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n &lt;<a href=3D"mailto:Dir=
tY.iCE.hu@gmail.com" target=3D"_blank">DirtY.iCE.hu@gmail.com</a>&gt;<br>
Reported-by: KJ Liew &lt;<a href=3D"mailto:liewkj@yahoo.com" target=3D"_bla=
nk">liewkj@yahoo.com</a>&gt;<br>
---<br>
<br>
I&#39;ve tested this patch on wine and a borrowed Windows 8.1 laptop, I<br>
could only test audio playback, not recording.=C2=A0 I&#39;ve cross-compile=
d qemu<br>
using the docker image, for 64-bit.<br>
<br>
---<br>
=C2=A0audio/dsound_template.h |=C2=A0 1 +<br>
=C2=A0audio/audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++---=
-<br>
=C2=A0audio/dsoundaudio.c=C2=A0 =C2=A0 =C2=A0| 27 +++++++++++++++++++++++--=
--<br>
=C2=A03 files changed, 26 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/audio/dsound_template.h b/audio/dsound_template.h<br>
index 7a15f91ce5..9c5ce625ab 100644<br>
--- a/audio/dsound_template.h<br>
+++ b/audio/dsound_template.h<br>
@@ -244,6 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audse=
ttings *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 ds-&gt;first_time =3D true;<br>
=C2=A0 =C2=A0 =C2=A0obt_as.endianness =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&gt;info, &amp;obt_as);<br=
>
<br>
diff --git a/audio/audio.c b/audio/audio.c<br>
index f63f39769a..cb1efc6dc5 100644<br>
--- a/audio/audio.c<br>
+++ b/audio/audio.c<br>
@@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, s=
ize_t live)<br>
=C2=A0 =C2=A0 =C2=A0while (live) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size, decr, proc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf =3D hw-&gt;pcm_ops-&gt;get_buff=
er_out(hw, &amp;size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* retrying will likely won&#39;=
t help, drop everything. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;mix_buf-&gt;pos =3D (hw-&=
gt;mix_buf-&gt;pos + live) % hw-&gt;mix_buf-&gt;size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return clipped + live;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf || size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0decr =3D MIN(size / hw-&gt;info.bytes_per=
_frame, live);<br>
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c<br>
index c265c0094b..bd57082a8d 100644<br>
--- a/audio/dsoundaudio.c<br>
+++ b/audio/dsoundaudio.c<br>
@@ -53,12 +53,14 @@ typedef struct {<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0HWVoiceOut hw;<br>
=C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDBUFFER dsound_buffer;<br>
+=C2=A0 =C2=A0 bool first_time;<br>
=C2=A0 =C2=A0 =C2=A0dsound *s;<br>
=C2=A0} DSoundVoiceOut;<br>
<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0HWVoiceIn hw;<br>
=C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;<br>
+=C2=A0 =C2=A0 bool first_time;<br>
=C2=A0 =C2=A0 =C2=A0dsound *s;<br>
=C2=A0} DSoundVoiceIn;<br>
<br>
@@ -414,21 +416,32 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, si=
ze_t *size)<br>
=C2=A0 =C2=A0 =C2=A0DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;<br>
=C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDBUFFER dsb =3D ds-&gt;dsound_buffer;<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
-=C2=A0 =C2=A0 DWORD ppos, act_size;<br>
+=C2=A0 =C2=A0 DWORD ppos, wpos, act_size;<br>
=C2=A0 =C2=A0 =C2=A0size_t req_size;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
=C2=A0 =C2=A0 =C2=A0void *ret;<br>
<br>
-=C2=A0 =C2=A0 hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &amp;ppos,=
 NULL);<br>
+=C2=A0 =C2=A0 hr =3D IDirectSoundBuffer_GetCurrentPosition(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsb, &amp;ppos, ds-&gt;first_time ? &amp;wpos =
: NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound_logerr(hr, &quot;Could not get pla=
yback buffer position\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (ds-&gt;first_time) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;pos_emul =3D wpos;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ds-&gt;first_time =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0req_size =3D audio_ring_dist(ppos, hw-&gt;pos_emul, hw-=
&gt;size_emul);<br>
=C2=A0 =C2=A0 =C2=A0req_size =3D MIN(req_size, hw-&gt;size_emul - hw-&gt;po=
s_emul);<br>
<br>
+=C2=A0 =C2=A0 if (req_size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0err =3D dsound_lock_out(dsb, &amp;hw-&gt;info, hw-&gt;p=
os_emul, req_size, &amp;ret, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;act_size, NULL, false, ds-&gt;s);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
@@ -508,18 +521,24 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size=
_t *size)<br>
=C2=A0 =C2=A0 =C2=A0DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;<br>
=C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds-&gt;dsound_captu=
re_buffer;<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
-=C2=A0 =C2=A0 DWORD cpos, act_size;<br>
+=C2=A0 =C2=A0 DWORD cpos, rpos, act_size;<br>
=C2=A0 =C2=A0 =C2=A0size_t req_size;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
=C2=A0 =C2=A0 =C2=A0void *ret;<br>
<br>
-=C2=A0 =C2=A0 hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &a=
mp;cpos, NULL);<br>
+=C2=A0 =C2=A0 hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dscb, &amp;cpos, ds-&gt;first_time ? &amp;rpos=
 : NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound_logerr(hr, &quot;Could not get cap=
ture buffer position\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (ds-&gt;first_time) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;pos_emul =3D rpos;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ds-&gt;first_time =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0req_size =3D audio_ring_dist(cpos, hw-&gt;pos_emul, hw-=
&gt;size_emul);<br>
=C2=A0 =C2=A0 =C2=A0req_size =3D MIN(req_size, hw-&gt;size_emul - hw-&gt;po=
s_emul);<br>
<br>
-- <br>
2.25.0<br></blockquote><div><br></div><div>Hi,</div><div><br></div><div>I t=
ested this patch running qemu-system-ppc with MacOS 9.2 and OSX 10.5. Qemu =
was cross-compiled on Fedora 31 from <a href=3D"https://github.com/mcayland=
/qemu/tree/screamer">https://github.com/mcayland/qemu/tree/screamer</a>. Ho=
st was Windows 10.<br></div><div><br></div><div>The dsound locking errors a=
re gone, so for this test case all seems OK.</div><div><br></div><div>Best,=
</div><div>Howard<br></div></div></div>

--000000000000db0c56059da74123--

