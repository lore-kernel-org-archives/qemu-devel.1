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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57CC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F4720658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jihSQak6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F4720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXzo-0003n7-7P
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyXz0-0002rq-Kr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyXyv-0001FL-Hs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:25:30 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iyXyv-0001Bx-9r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:25:25 -0500
Received: by mail-oi1-x242.google.com with SMTP id a22so14016757oid.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BkjaGOGKFLkPM0/O2/S8fZzMc67x76zdsnueF80BDEk=;
 b=jihSQak6NepXJXK1FRk7sMpcMyQKBoaG5U+FuUZQeJ0WO0AIWRV6zIeBAkmktmBF4c
 BDe/Fh3nAwEoA4xytunyhs6SLkqUkG2s63fV0WaCadoaVQH9gV09meLqpiVvivS8Jduq
 shoZProUfbqlUZBYt+xQlVFiPyzcnoJal1DwBb0XE+WPOuUNJt9YI6lAvrZh2fdPR+kX
 XrIP8p25kQq/NzTbePokVV4wphBdlhm/vgTSJS0UNzz9rrK0c4yGQXI3uLd0d758zHLv
 PFBKWhVtgkYdV5Kwj4ujYg0JMs8ofAzvGiTfpx1c0sPKHvHDthjGdKDngqiHE7hIpaYy
 Y8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BkjaGOGKFLkPM0/O2/S8fZzMc67x76zdsnueF80BDEk=;
 b=ic/ex5XfNXeQ7lTC5FovZ8Mcusyh5SNkm9dGFo/TGhbiDYp3SYGae9fOqygCJakPB2
 5bAOTqwgdzDpo78hascd3lBmtZBSL0ZIuFoPS8xIofEWEkJvnQt2kPwaSMQPmiEAIgNJ
 C35XMzFuYcJIjphBm0ASHuaR1zjnnekoJoSAARvg60vFqzSIhgoCE2fq/OnGoHEys6uE
 3CAje3juU3dRlletzwYqDxJEx5QrwM0kcKc+d3zxZ1WX6zPQmuiX8HOIVpz4MfW7FPaU
 AJ9HXoEtA3ByGJXNl1gPK02iZxphlJ+sNLrBCEoTI7Ahqavx20G6jqrd7veCPVkUsJDe
 gMwQ==
X-Gm-Message-State: APjAAAUtIq0GbcWO1/TyDQdNokZUQCDm9rGtr4gxNUo7rzsC9bNiEGJ8
 B5iAJL5ZDm/7gf4jWxwrQ1/TrmhKunn6eilbsLY=
X-Google-Smtp-Source: APXvYqx+K+66P4sdZ5SZ0SIn2K7xfFhFSBwEzS9AH6pf5zvn6Pm2maYlRJicJ2CaG8uQUMTuPOnew0ogCpRFWiINcV8=
X-Received: by 2002:aca:1314:: with SMTP id e20mr6643926oii.112.1580721924279; 
 Mon, 03 Feb 2020 01:25:24 -0800 (PST)
MIME-Version: 1.0
References: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
 <CABLmASG5J0AcB7khUfK1G2tTw97ng0HRonaejo-SReAznyekCQ@mail.gmail.com>
 <38e3dd27-a6d6-ffeb-8637-0bb57caa9710@redhat.com>
In-Reply-To: <38e3dd27-a6d6-ffeb-8637-0bb57caa9710@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 3 Feb 2020 10:25:12 +0100
Message-ID: <CABLmASE-DaA_KDTFHJ2eMmyrDS5Qp61q3K-nrh4+keMq=NRQOg@mail.gmail.com>
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ca3151059da880ec"
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
Cc: KJ Liew <liewkj@yahoo.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ca3151059da880ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cher Philippe,

On Mon, Feb 3, 2020 at 10:18 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Howard,
>
> On 2/3/20 8:56 AM, Howard Spoelstra wrote:
> > On Mon, Feb 3, 2020 at 12:02 AM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dir=
ty.ice.hu@gmail.com
> > <mailto:dirty.ice.hu@gmail.com>> wrote:
> >
> >     Windows (unlike wine) bails out when IDirectSoundBuffer8::Lock is
> called
> >     with zero length.  Also, hw->pos_emul handling was incorrect when
> >     calling this function for the first time.
> >
> >     Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gma=
il.com
> >     <mailto:DirtY.iCE.hu@gmail.com>>
> >     Reported-by: KJ Liew <liewkj@yahoo.com <mailto:liewkj@yahoo.com>>
> >     ---
> >
> >     I've tested this patch on wine and a borrowed Windows 8.1 laptop, I
> >     could only test audio playback, not recording.  I've cross-compiled
> qemu
> >     using the docker image, for 64-bit.
> >
> >     ---
> >       audio/dsound_template.h |  1 +
> >       audio/audio.c           |  6 ++----
> >       audio/dsoundaudio.c     | 27 +++++++++++++++++++++++----
> >       3 files changed, 26 insertions(+), 8 deletions(-)
> >
> >     diff --git a/audio/dsound_template.h b/audio/dsound_template.h
> >     index 7a15f91ce5..9c5ce625ab 100644
> >     --- a/audio/dsound_template.h
> >     +++ b/audio/dsound_template.h
> >     @@ -244,6 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw,
> >     struct audsettings *as,
> >               goto fail0;
> >           }
> >
> >     +    ds->first_time =3D true;
> >           obt_as.endianness =3D 0;
> >           audio_pcm_init_info (&hw->info, &obt_as);
> >
> >     diff --git a/audio/audio.c b/audio/audio.c
> >     index f63f39769a..cb1efc6dc5 100644
> >     --- a/audio/audio.c
> >     +++ b/audio/audio.c
> >     @@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOu=
t
> >     *hw, size_t live)
> >           while (live) {
> >               size_t size, decr, proc;
> >               void *buf =3D hw->pcm_ops->get_buffer_out(hw, &size);
> >     -        if (!buf) {
> >     -            /* retrying will likely won't help, drop everything. *=
/
> >     -            hw->mix_buf->pos =3D (hw->mix_buf->pos + live) %
> >     hw->mix_buf->size;
> >     -            return clipped + live;
> >     +        if (!buf || size =3D=3D 0) {
> >     +            break;
> >               }
> >
> >               decr =3D MIN(size / hw->info.bytes_per_frame, live);
> >     diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> >     index c265c0094b..bd57082a8d 100644
> >     --- a/audio/dsoundaudio.c
> >     +++ b/audio/dsoundaudio.c
> >     @@ -53,12 +53,14 @@ typedef struct {
> >       typedef struct {
> >           HWVoiceOut hw;
> >           LPDIRECTSOUNDBUFFER dsound_buffer;
> >     +    bool first_time;
> >           dsound *s;
> >       } DSoundVoiceOut;
> >
> >       typedef struct {
> >           HWVoiceIn hw;
> >           LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
> >     +    bool first_time;
> >           dsound *s;
> >       } DSoundVoiceIn;
> >
> >     @@ -414,21 +416,32 @@ static void *dsound_get_buffer_out(HWVoiceOut
> >     *hw, size_t *size)
> >           DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
> >           LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
> >           HRESULT hr;
> >     -    DWORD ppos, act_size;
> >     +    DWORD ppos, wpos, act_size;
> >           size_t req_size;
> >           int err;
> >           void *ret;
> >
> >     -    hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL)=
;
> >     +    hr =3D IDirectSoundBuffer_GetCurrentPosition(
> >     +        dsb, &ppos, ds->first_time ? &wpos : NULL);
> >           if (FAILED(hr)) {
> >               dsound_logerr(hr, "Could not get playback buffer
> position\n");
> >               *size =3D 0;
> >               return NULL;
> >           }
> >
> >     +    if (ds->first_time) {
> >     +        hw->pos_emul =3D wpos;
> >     +        ds->first_time =3D false;
> >     +    }
> >     +
> >           req_size =3D audio_ring_dist(ppos, hw->pos_emul, hw->size_emu=
l);
> >           req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
> >
> >     +    if (req_size =3D=3D 0) {
> >     +        *size =3D 0;
> >     +        return NULL;
> >     +    }
> >     +
> >           err =3D dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_siz=
e,
> >     &ret, NULL,
> >                                 &act_size, NULL, false, ds->s);
> >           if (err) {
> >     @@ -508,18 +521,24 @@ static void *dsound_get_buffer_in(HWVoiceIn
> >     *hw, size_t *size)
> >           DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
> >           LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer=
;
> >           HRESULT hr;
> >     -    DWORD cpos, act_size;
> >     +    DWORD cpos, rpos, act_size;
> >           size_t req_size;
> >           int err;
> >           void *ret;
> >
> >     -    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpo=
s,
> >     NULL);
> >     +    hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(
> >     +        dscb, &cpos, ds->first_time ? &rpos : NULL);
> >           if (FAILED(hr)) {
> >               dsound_logerr(hr, "Could not get capture buffer
> position\n");
> >               *size =3D 0;
> >               return NULL;
> >           }
> >
> >     +    if (ds->first_time) {
> >     +        hw->pos_emul =3D rpos;
> >     +        ds->first_time =3D false;
> >     +    }
> >     +
> >           req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emu=
l);
> >           req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
> >
> >     --
> >     2.25.0
> >
> >
> > Hi,
> >
> > I tested this patch running qemu-system-ppc with MacOS 9.2 and OSX 10.5=
.
> > Qemu was cross-compiled on Fedora 31 from
> > https://github.com/mcayland/qemu/tree/screamer. Host was Windows 10.
> >
> > The dsound locking errors are gone, so for this test case all seems OK.
>
> Thanks for testing!
>
> Does that mean we can add your tag to this patch?
>
>
> Regards,
>
> Phil.
>
>
Yes, so:

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>

Best,
Howard

--000000000000ca3151059da880ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Cher Philippe,<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 3, 2020 at 10:18 AM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi Howard,<br>
<br>
On 2/3/20 8:56 AM, Howard Spoelstra wrote:<br>
&gt; On Mon, Feb 3, 2020 at 12:02 AM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n &lt=
;<a href=3D"mailto:dirty.ice.hu@gmail.com" target=3D"_blank">dirty.ice.hu@g=
mail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:dirty.ice.hu@gmail.com" target=3D"_blank"=
>dirty.ice.hu@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Windows (unlike wine) bails out when IDirectSoundBu=
ffer8::Lock is called<br>
&gt;=C2=A0 =C2=A0 =C2=A0with zero length.=C2=A0 Also, hw-&gt;pos_emul handl=
ing was incorrect when<br>
&gt;=C2=A0 =C2=A0 =C2=A0calling this function for the first time.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n &=
lt;<a href=3D"mailto:DirtY.iCE.hu@gmail.com" target=3D"_blank">DirtY.iCE.hu=
@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:DirtY.iCE.hu@gmail.com=
" target=3D"_blank">DirtY.iCE.hu@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reported-by: KJ Liew &lt;<a href=3D"mailto:liewkj@y=
ahoo.com" target=3D"_blank">liewkj@yahoo.com</a> &lt;mailto:<a href=3D"mail=
to:liewkj@yahoo.com" target=3D"_blank">liewkj@yahoo.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ve tested this patch on wine and a borrowed W=
indows 8.1 laptop, I<br>
&gt;=C2=A0 =C2=A0 =C2=A0could only test audio playback, not recording.=C2=
=A0 I&#39;ve cross-compiled qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0using the docker image, for 64-bit.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0audio/dsound_template.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0audio/audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 ++----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0audio/dsoundaudio.c=C2=A0 =C2=A0 =C2=A0| 27 =
+++++++++++++++++++++++----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A03 files changed, 26 insertions(+), 8 deletio=
ns(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/audio/dsound_template.h b/audio/dsound=
_template.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 7a15f91ce5..9c5ce625ab 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/audio/dsound_template.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/audio/dsound_template.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -244,6 +244,7 @@ static int dsound_init_out(HWVo=
iceOut *hw,<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct audsettings *as,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ds-&gt;first_time =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0obt_as.endianness =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&=
gt;info, &amp;obt_as);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/audio/audio.c b/audio/audio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index f63f39769a..cb1efc6dc5 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/audio/audio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/audio/audio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_r=
un_out(HWVoiceOut<br>
&gt;=C2=A0 =C2=A0 =C2=A0*hw, size_t live)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (live) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size, dec=
r, proc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf =3D hw=
-&gt;pcm_ops-&gt;get_buffer_out(hw, &amp;size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* retry=
ing will likely won&#39;t help, drop everything. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;m=
ix_buf-&gt;pos =3D (hw-&gt;mix_buf-&gt;pos + live) %<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw-&gt;mix_buf-&gt;size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return c=
lipped + live;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf || size =3D=
=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0decr =3D MIN(siz=
e / hw-&gt;info.bytes_per_frame, live);<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/audio/dsoundaudio.c b/audio/dsoundaudi=
o.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index c265c0094b..bd57082a8d 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/audio/dsoundaudio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/audio/dsoundaudio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -53,12 +53,14 @@ typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HWVoiceOut hw;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDBUFFER dsound_buf=
fer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 bool first_time;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound *s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} DSoundVoiceOut;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HWVoiceIn hw;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDCAPTUREBUFFER dso=
und_capture_buffer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 bool first_time;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound *s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} DSoundVoiceIn;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -414,21 +416,32 @@ static void *dsound_get_buffe=
r_out(HWVoiceOut<br>
&gt;=C2=A0 =C2=A0 =C2=A0*hw, size_t *size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSoundVoiceOut *ds =3D (DSound=
VoiceOut *) hw;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDBUFFER dsb =3D ds=
-&gt;dsound_buffer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 DWORD ppos, act_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 DWORD ppos, wpos, act_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t req_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *ret;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 hr =3D IDirectSoundBuffer_GetCurrent=
Position(dsb, &amp;ppos, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 hr =3D IDirectSoundBuffer_GetCurrent=
Position(<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsb, &amp;ppos, ds-&gt=
;first_time ? &amp;wpos : NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound_logerr(hr=
, &quot;Could not get playback buffer position\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (ds-&gt;first_time) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;pos_emul =3D wp=
os;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ds-&gt;first_time =3D =
false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req_size =3D audio_ring_dist(p=
pos, hw-&gt;pos_emul, hw-&gt;size_emul);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req_size =3D MIN(req_size, hw-=
&gt;size_emul - hw-&gt;pos_emul);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (req_size =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D dsound_lock_out(dsb, &=
amp;hw-&gt;info, hw-&gt;pos_emul, req_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;ret, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;act_size, NULL, false,=
 ds-&gt;s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -508,18 +521,24 @@ static void *dsound_get_buffe=
r_in(HWVoiceIn<br>
&gt;=C2=A0 =C2=A0 =C2=A0*hw, size_t *size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSoundVoiceIn *ds =3D (DSoundV=
oiceIn *) hw;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDCAPTUREBUFFER dsc=
b =3D ds-&gt;dsound_capture_buffer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HRESULT hr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 DWORD cpos, act_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 DWORD cpos, rpos, act_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t req_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *ret;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 hr =3D IDirectSoundCaptureBuffer_Get=
CurrentPosition(dscb, &amp;cpos,<br>
&gt;=C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 hr =3D IDirectSoundCaptureBuffer_Get=
CurrentPosition(<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dscb, &amp;cpos, ds-&g=
t;first_time ? &amp;rpos : NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound_logerr(hr=
, &quot;Could not get capture buffer position\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (ds-&gt;first_time) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;pos_emul =3D rp=
os;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ds-&gt;first_time =3D =
false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req_size =3D audio_ring_dist(c=
pos, hw-&gt;pos_emul, hw-&gt;size_emul);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req_size =3D MIN(req_size, hw-=
&gt;size_emul - hw-&gt;pos_emul);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.25.0<br>
&gt; <br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; I tested this patch running qemu-system-ppc with MacOS 9.2 and OSX 10.=
5. <br>
&gt; Qemu was cross-compiled on Fedora 31 from <br>
&gt; <a href=3D"https://github.com/mcayland/qemu/tree/screamer" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/mcayland/qemu/tree/screamer</a=
>. Host was Windows 10.<br>
&gt; <br>
&gt; The dsound locking errors are gone, so for this test case all seems OK=
.<br>
<br>
Thanks for testing!<br>
<br>
Does that mean we can add your tag to this patch?<br>
<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br></blockquote><div><br></div><div>Yes, so:</div><div><br></div><div>
Tested-by: Howard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com" targe=
t=3D"_blank">hsp.cat7@gmail.com</a>&gt; <br></div><div><br></div><div>Best,=
</div><div>Howard<br></div><div>=C2=A0</div></div></div>

--000000000000ca3151059da880ec--

