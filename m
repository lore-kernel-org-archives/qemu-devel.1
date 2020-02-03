Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F12C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75092070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP2/qEin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75092070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXts-0007uv-0I
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyXsR-0005Vx-1i
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyXsP-0004V8-BT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:18:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyXsP-0004Tg-70
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580721520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCZdNkBTgXJS7SxG1/3cCZ1Qlgbnx3nFs5qrqNq3H/8=;
 b=hP2/qEinEcF104wLIN+WR3KUOjFkJohBbg0UJZ/JuknP2b28gw0BI2P1/UYjncSt0yLTjA
 wDxujKuBdpauK7QdRgaEWYVf3LjvRmqq/3dRCDZU6z3lJU/5h3kkFBcOumqA9Z2WSBPgVo
 dYJBjAEAiM7P93m8FnGJkaK9XiWLvJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-BcjdoHTwPiC60u_tQKeebw-1; Mon, 03 Feb 2020 04:18:36 -0500
Received: by mail-wm1-f70.google.com with SMTP id m4so3769512wmi.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aTXiCbxqjPIkKJ2+LtL9+2IyiD9Ou4SjuxwZaYmpU+k=;
 b=aZhwfEYBVlnH5tgx2wzKp1mnX/sjvk9cy2xrgrZOsMVTQccu1FZRphM6EyKTxPgcXA
 L2fhaYIWyf+3arA7MwMpyUHKpY6KOxC2pL7j1OcqjyFgZ04LUahMVQqLFdwidx8VocGn
 K9L7whHXqWZQmF114OYNHQhJu3Sn623olZAw4UwnH1qApVAaOI/jDeNsP68yE+mQ9T+g
 8YO2eSZX5rtGIY8q2wXc5C2yHnDbKybgviCfXXpETWgVPcjznpH3DUDnNNq1nE/ynnZc
 /OxkCTjvqWJWQuKaQjso5Kq/i/VH1a7BKvZ91eqLikpKvJnUaY457LL/SzVyZpAS/wDe
 szpg==
X-Gm-Message-State: APjAAAVu8gdQ0a9z8Uhu1QwXERU2Ozvbj7KA71boiNJzwOGGZxQ9vEB8
 arMu+YicFrfJEA6pGzI/F/zM0gZzJtkNHBxkY6I1R5h/Flh+CbzQOXgHxHrT3smS8IuqnF31kPJ
 +hzMfSq5ng21pRjM=
X-Received: by 2002:a1c:de55:: with SMTP id v82mr27511728wmg.48.1580721515588; 
 Mon, 03 Feb 2020 01:18:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwy14FwX7Tdc1bTGDbcvlrTEY5LJjQBtzAmFNs2NgbTwjrYmtumXnH/HBqeC1bnf4NYZmYH7A==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr27511699wmg.48.1580721515269; 
 Mon, 03 Feb 2020 01:18:35 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id n3sm23948795wrs.8.2020.02.03.01.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 01:18:34 -0800 (PST)
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
To: Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
References: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
 <CABLmASG5J0AcB7khUfK1G2tTw97ng0HRonaejo-SReAznyekCQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <38e3dd27-a6d6-ffeb-8637-0bb57caa9710@redhat.com>
Date: Mon, 3 Feb 2020 10:18:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABLmASG5J0AcB7khUfK1G2tTw97ng0HRonaejo-SReAznyekCQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BcjdoHTwPiC60u_tQKeebw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>, KJ Liew <liewkj@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Howard,

On 2/3/20 8:56 AM, Howard Spoelstra wrote:
> On Mon, Feb 3, 2020 at 12:02 AM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty=
.ice.hu@gmail.com=20
> <mailto:dirty.ice.hu@gmail.com>> wrote:
>=20
>     Windows (unlike wine) bails out when IDirectSoundBuffer8::Lock is cal=
led
>     with zero length.=C2=A0 Also, hw->pos_emul handling was incorrect whe=
n
>     calling this function for the first time.
>=20
>     Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail=
.com
>     <mailto:DirtY.iCE.hu@gmail.com>>
>     Reported-by: KJ Liew <liewkj@yahoo.com <mailto:liewkj@yahoo.com>>
>     ---
>=20
>     I've tested this patch on wine and a borrowed Windows 8.1 laptop, I
>     could only test audio playback, not recording.=C2=A0 I've cross-compi=
led qemu
>     using the docker image, for 64-bit.
>=20
>     ---
>      =C2=A0audio/dsound_template.h |=C2=A0 1 +
>      =C2=A0audio/audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
6 ++----
>      =C2=A0audio/dsoundaudio.c=C2=A0 =C2=A0 =C2=A0| 27 ++++++++++++++++++=
+++++----
>      =C2=A03 files changed, 26 insertions(+), 8 deletions(-)
>=20
>     diff --git a/audio/dsound_template.h b/audio/dsound_template.h
>     index 7a15f91ce5..9c5ce625ab 100644
>     --- a/audio/dsound_template.h
>     +++ b/audio/dsound_template.h
>     @@ -244,6 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw,
>     struct audsettings *as,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail0;
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>     +=C2=A0 =C2=A0 ds->first_time =3D true;
>      =C2=A0 =C2=A0 =C2=A0obt_as.endianness =3D 0;
>      =C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&hw->info, &obt_as);
>=20
>     diff --git a/audio/audio.c b/audio/audio.c
>     index f63f39769a..cb1efc6dc5 100644
>     --- a/audio/audio.c
>     +++ b/audio/audio.c
>     @@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut
>     *hw, size_t live)
>      =C2=A0 =C2=A0 =C2=A0while (live) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size, decr, proc;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buf =3D hw->pcm_ops->get_buf=
fer_out(hw, &size);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf) {
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* retrying will likely wo=
n't help, drop everything. */
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw->mix_buf->pos =3D (hw->=
mix_buf->pos + live) %
>     hw->mix_buf->size;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return clipped + live;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!buf || size =3D=3D 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0decr =3D MIN(size / hw->info.bytes=
_per_frame, live);
>     diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
>     index c265c0094b..bd57082a8d 100644
>     --- a/audio/dsoundaudio.c
>     +++ b/audio/dsoundaudio.c
>     @@ -53,12 +53,14 @@ typedef struct {
>      =C2=A0typedef struct {
>      =C2=A0 =C2=A0 =C2=A0HWVoiceOut hw;
>      =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDBUFFER dsound_buffer;
>     +=C2=A0 =C2=A0 bool first_time;
>      =C2=A0 =C2=A0 =C2=A0dsound *s;
>      =C2=A0} DSoundVoiceOut;
>=20
>      =C2=A0typedef struct {
>      =C2=A0 =C2=A0 =C2=A0HWVoiceIn hw;
>      =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer=
;
>     +=C2=A0 =C2=A0 bool first_time;
>      =C2=A0 =C2=A0 =C2=A0dsound *s;
>      =C2=A0} DSoundVoiceIn;
>=20
>     @@ -414,21 +416,32 @@ static void *dsound_get_buffer_out(HWVoiceOut
>     *hw, size_t *size)
>      =C2=A0 =C2=A0 =C2=A0DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
>      =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
>      =C2=A0 =C2=A0 =C2=A0HRESULT hr;
>     -=C2=A0 =C2=A0 DWORD ppos, act_size;
>     +=C2=A0 =C2=A0 DWORD ppos, wpos, act_size;
>      =C2=A0 =C2=A0 =C2=A0size_t req_size;
>      =C2=A0 =C2=A0 =C2=A0int err;
>      =C2=A0 =C2=A0 =C2=A0void *ret;
>=20
>     -=C2=A0 =C2=A0 hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &ppo=
s, NULL);
>     +=C2=A0 =C2=A0 hr =3D IDirectSoundBuffer_GetCurrentPosition(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsb, &ppos, ds->first_time ? &wpos : NUL=
L);
>      =C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound_logerr(hr, "Could not get p=
layback buffer position\n");
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>     +=C2=A0 =C2=A0 if (ds->first_time) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw->pos_emul =3D wpos;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ds->first_time =3D false;
>     +=C2=A0 =C2=A0 }
>     +
>      =C2=A0 =C2=A0 =C2=A0req_size =3D audio_ring_dist(ppos, hw->pos_emul,=
 hw->size_emul);
>      =C2=A0 =C2=A0 =C2=A0req_size =3D MIN(req_size, hw->size_emul - hw->p=
os_emul);
>=20
>     +=C2=A0 =C2=A0 if (req_size =3D=3D 0) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>     +=C2=A0 =C2=A0 }
>     +
>      =C2=A0 =C2=A0 =C2=A0err =3D dsound_lock_out(dsb, &hw->info, hw->pos_=
emul, req_size,
>     &ret, NULL,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&act_size, NULL, false, ds->s);
>      =C2=A0 =C2=A0 =C2=A0if (err) {
>     @@ -508,18 +521,24 @@ static void *dsound_get_buffer_in(HWVoiceIn
>     *hw, size_t *size)
>      =C2=A0 =C2=A0 =C2=A0DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
>      =C2=A0 =C2=A0 =C2=A0LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_c=
apture_buffer;
>      =C2=A0 =C2=A0 =C2=A0HRESULT hr;
>     -=C2=A0 =C2=A0 DWORD cpos, act_size;
>     +=C2=A0 =C2=A0 DWORD cpos, rpos, act_size;
>      =C2=A0 =C2=A0 =C2=A0size_t req_size;
>      =C2=A0 =C2=A0 =C2=A0int err;
>      =C2=A0 =C2=A0 =C2=A0void *ret;
>=20
>     -=C2=A0 =C2=A0 hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(ds=
cb, &cpos,
>     NULL);
>     +=C2=A0 =C2=A0 hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dscb, &cpos, ds->first_time ? &rpos : NU=
LL);
>      =C2=A0 =C2=A0 =C2=A0if (FAILED(hr)) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dsound_logerr(hr, "Could not get c=
apture buffer position\n");
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D 0;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>     +=C2=A0 =C2=A0 if (ds->first_time) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw->pos_emul =3D rpos;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ds->first_time =3D false;
>     +=C2=A0 =C2=A0 }
>     +
>      =C2=A0 =C2=A0 =C2=A0req_size =3D audio_ring_dist(cpos, hw->pos_emul,=
 hw->size_emul);
>      =C2=A0 =C2=A0 =C2=A0req_size =3D MIN(req_size, hw->size_emul - hw->p=
os_emul);
>=20
>     --=20
>     2.25.0
>=20
>=20
> Hi,
>=20
> I tested this patch running qemu-system-ppc with MacOS 9.2 and OSX 10.5.=
=20
> Qemu was cross-compiled on Fedora 31 from=20
> https://github.com/mcayland/qemu/tree/screamer. Host was Windows 10.
>=20
> The dsound locking errors are gone, so for this test case all seems OK.

Thanks for testing!

Does that mean we can add your tag to this patch?

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>

Regards,

Phil.


