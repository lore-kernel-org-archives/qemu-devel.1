Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A2FC74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEF92064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKv2PY71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEF92064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlIkH-0003VE-QS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 15:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjH-0002NX-AH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjF-00023W-Ah
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIjE-0001zN-Oc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so3504320wml.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oX1CbdtKVOFAMJ9Q94LO500mAJlD/BMXo0xt8hOSWEY=;
 b=cKv2PY71yHt40nTyQ+lyXdz2Ms5MoT9bm1y0/CZBxYH9soJTsZ/6LoHMg+lrcGZYj1
 E+ccZbwfEAw5D4UFN7YtdEPZqPuLG6yO96ZlbKqKy0r9mBT3AKKUvnSrgNOeFFg8nl7l
 Z6gJC5Fi9E+vrLsquBQAZI5fmyBu92kjNkiki4K670xCQSexhv422UqTLfvjplGwCbTK
 FIGRLti3ObetRQ47ShuC2vvuW6AbFGgBOcu3WBZ864wPSFaL3FowN/rC/yTtZuhxSDXZ
 4FeAleLR435ockMCAptR7n56W/35xl1GrRk+vAEXGNKAJhRObaz1drPKexU6lzUnSQl7
 HydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oX1CbdtKVOFAMJ9Q94LO500mAJlD/BMXo0xt8hOSWEY=;
 b=NGWgGXAA/PBz44QWFi4XEOa3HLoDmMv6W3UqvtQyf9Jm7T6y5E12sWwxWrJOmXXpu5
 SS6xB4F73ewD2QHS8U1HKuVDO1hT3iVl+7rNJrqrPh9gBS8siERV67t7uNm7vXJKUdQB
 pMVlswETU9UlicdWFzUW47vZvuYQtlSixsBApDc0beJXxZpqkBwcm6uOxihX9PrDKzIm
 594kFaIYxE/lHD6lLn+TUFzbfpQr3JYq3Aay5h0dA9LoekHGpIxJzubH7ZJrHHdyyrAO
 dPvtqipHCptGNDcDMZ1P7AyX49qy+Q3BCA4fHcLGDV3FPMgnQLxssWlbwImnoFERPbZQ
 FWJw==
X-Gm-Message-State: APjAAAVvbQoxnEL/UGQMSrLrtnrznaXw5SqJWAO4YRAANQpgPbgqNKNZ
 7GtJLYGcllVEiF13LFWEalexo58m7eEotwzlm+Q=
X-Google-Smtp-Source: APXvYqyYdWQ1xo5r2ZC39PZ9b9HG/HNb2rgdm6hMKxChYUN0FT77dcUBZQP2uloXEj/Yln9qqZV2DropT8DU/jtNKDQ=
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr6699415wmk.5.1562788690829; 
 Wed, 10 Jul 2019 12:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <0b7207b7ef4db3a894e9dbdefe4a007d8a19709c.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <0b7207b7ef4db3a894e9dbdefe4a007d8a19709c.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:57:59 +0400
Message-ID: <CAJ+F1CLPu3em-0U2N4VwJLSzXy-GTuepNfWj0iX8XE2X9Tv9kA@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 10/11] audio: remove read and write pcm_ops
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 10:57 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> They just called audio_pcm_sw_read/write anyway, so it makes no sense
> to have them too.  (The noaudio's read is the only exception, but it
> should work with the generic code too.)

It works with the generic code, but wouldn't it be more expensive?

Perhaps there can be something in audio_pcm_sw_write() to skip the
work if noaudio is the backend?

>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> ---
>  audio/audio_int.h   |  5 -----
>  audio/alsaaudio.c   | 12 ------------
>  audio/audio.c       |  8 ++++----
>  audio/coreaudio.c   |  6 ------
>  audio/dsoundaudio.c | 12 ------------
>  audio/noaudio.c     | 19 -------------------
>  audio/ossaudio.c    | 12 ------------
>  audio/paaudio.c     | 12 ------------
>  audio/sdlaudio.c    |  6 ------
>  audio/spiceaudio.c  | 12 ------------
>  audio/wavaudio.c    |  6 ------
>  11 files changed, 4 insertions(+), 106 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 7e00c1332e..003b7ab8cc 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -150,13 +150,11 @@ struct audio_pcm_ops {
>      int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_o=
paque);
>      void (*fini_out)(HWVoiceOut *hw);
>      int  (*run_out) (HWVoiceOut *hw, int live);
> -    int  (*write)   (SWVoiceOut *sw, void *buf, int size);
>      int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
>
>      int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_op=
aque);
>      void (*fini_in) (HWVoiceIn *hw);
>      int  (*run_in)  (HWVoiceIn *hw);
> -    int  (*read)    (SWVoiceIn *sw, void *buf, int size);
>      int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
>  };
>
> @@ -210,11 +208,8 @@ audio_driver *audio_driver_lookup(const char *name);
>  void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as);
>  void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, i=
nt len);
>
> -int  audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int len);
>  int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
>
> -int  audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int len);
> -
>  int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
>                             int live, int pending);
>
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 3daa7c8f8f..e9e3a4819c 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -270,11 +270,6 @@ static int alsa_poll_in (HWVoiceIn *hw)
>      return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
>  }
>
> -static int alsa_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
>  {
>      switch (fmt) {
> @@ -988,11 +983,6 @@ static int alsa_run_in (HWVoiceIn *hw)
>      return read_samples;
>  }
>
> -static int alsa_read (SWVoiceIn *sw, void *buf, int size)
> -{
> -    return audio_pcm_sw_read (sw, buf, size);
> -}
> -
>  static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
>  {
>      ALSAVoiceIn *alsa =3D (ALSAVoiceIn *) hw;
> @@ -1076,13 +1066,11 @@ static struct audio_pcm_ops alsa_pcm_ops =3D {
>      .init_out =3D alsa_init_out,
>      .fini_out =3D alsa_fini_out,
>      .run_out  =3D alsa_run_out,
> -    .write    =3D alsa_write,
>      .ctl_out  =3D alsa_ctl_out,
>
>      .init_in  =3D alsa_init_in,
>      .fini_in  =3D alsa_fini_in,
>      .run_in   =3D alsa_run_in,
> -    .read     =3D alsa_read,
>      .ctl_in   =3D alsa_ctl_in,
>  };
>
> diff --git a/audio/audio.c b/audio/audio.c
> index d73cc086b6..b79f56fe64 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -594,7 +594,7 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
>      }
>  }
>
> -int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
> +static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
>  {
>      HWVoiceIn *hw =3D sw->hw;
>      int samples, live, ret =3D 0, swlim, isamp, osamp, rpos, total =3D 0=
;
> @@ -696,7 +696,7 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw,=
 int *nb_live)
>  /*
>   * Soft voice (playback)
>   */
> -int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
> +static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
>  {
>      int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim,=
 blck;
>      int ret =3D 0, pos =3D 0, total =3D 0;
> @@ -854,7 +854,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
>          return 0;
>      }
>
> -    return sw->hw->pcm_ops->write(sw, buf, size);
> +    return audio_pcm_sw_write(sw, buf, size);
>  }
>
>  int AUD_read (SWVoiceIn *sw, void *buf, int size)
> @@ -869,7 +869,7 @@ int AUD_read (SWVoiceIn *sw, void *buf, int size)
>          return 0;
>      }
>
> -    return sw->hw->pcm_ops->read(sw, buf, size);
> +    return audio_pcm_sw_read(sw, buf, size);
>  }
>
>  int AUD_get_buffer_size_out (SWVoiceOut *sw)
> diff --git a/audio/coreaudio.c b/audio/coreaudio.c
> index f0ab4014a8..091fe84a34 100644
> --- a/audio/coreaudio.c
> +++ b/audio/coreaudio.c
> @@ -489,11 +489,6 @@ static OSStatus audioDeviceIOProc(
>      return 0;
>  }
>
> -static int coreaudio_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
>                                void *drv_opaque)
>  {
> @@ -692,7 +687,6 @@ static struct audio_pcm_ops coreaudio_pcm_ops =3D {
>      .init_out =3D coreaudio_init_out,
>      .fini_out =3D coreaudio_fini_out,
>      .run_out  =3D coreaudio_run_out,
> -    .write    =3D coreaudio_write,
>      .ctl_out  =3D coreaudio_ctl_out
>  };
>
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 07260f881e..11594c3095 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -454,11 +454,6 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, =
...)
>      return 0;
>  }
>
> -static int dsound_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  static int dsound_run_out (HWVoiceOut *hw, int live)
>  {
>      int err;
> @@ -645,11 +640,6 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ..=
.)
>      return 0;
>  }
>
> -static int dsound_read (SWVoiceIn *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_read (sw, buf, len);
> -}
> -
>  static int dsound_run_in (HWVoiceIn *hw)
>  {
>      int err;
> @@ -856,13 +846,11 @@ static struct audio_pcm_ops dsound_pcm_ops =3D {
>      .init_out =3D dsound_init_out,
>      .fini_out =3D dsound_fini_out,
>      .run_out  =3D dsound_run_out,
> -    .write    =3D dsound_write,
>      .ctl_out  =3D dsound_ctl_out,
>
>      .init_in  =3D dsound_init_in,
>      .fini_in  =3D dsound_fini_in,
>      .run_in   =3D dsound_run_in,
> -    .read     =3D dsound_read,
>      .ctl_in   =3D dsound_ctl_in
>  };
>
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 14a0e4ab29..cbb02d9e49 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -61,11 +61,6 @@ static int no_run_out (HWVoiceOut *hw, int live)
>      return decr;
>  }
>
> -static int no_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write(sw, buf, len);
> -}
> -
>  static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv=
_opaque)
>  {
>      audio_pcm_init_info (&hw->info, as);
> @@ -118,18 +113,6 @@ static int no_run_in (HWVoiceIn *hw)
>      return samples;
>  }
>
> -static int no_read (SWVoiceIn *sw, void *buf, int size)
> -{
> -    /* use custom code here instead of audio_pcm_sw_read() to avoid
> -     * useless resampling/mixing */
> -    int samples =3D size >> sw->info.shift;
> -    int total =3D sw->hw->total_samples_captured - sw->total_hw_samples_=
acquired;
> -    int to_clear =3D MIN (samples, total);
> -    sw->total_hw_samples_acquired +=3D total;
> -    audio_pcm_info_clear_buf (&sw->info, buf, to_clear);
> -    return to_clear << sw->info.shift;
> -}
> -
>  static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
>  {
>      (void) hw;
> @@ -151,13 +134,11 @@ static struct audio_pcm_ops no_pcm_ops =3D {
>      .init_out =3D no_init_out,
>      .fini_out =3D no_fini_out,
>      .run_out  =3D no_run_out,
> -    .write    =3D no_write,
>      .ctl_out  =3D no_ctl_out,
>
>      .init_in  =3D no_init_in,
>      .fini_in  =3D no_fini_in,
>      .run_in   =3D no_run_in,
> -    .read     =3D no_read,
>      .ctl_in   =3D no_ctl_in
>  };
>
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 456fba7480..b99edbec17 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -134,11 +134,6 @@ static void oss_poll_in (HWVoiceIn *hw)
>      qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
>  }
>
> -static int oss_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  static int aud_to_ossfmt (AudioFormat fmt, int endianness)
>  {
>      switch (fmt) {
> @@ -788,11 +783,6 @@ static int oss_run_in (HWVoiceIn *hw)
>      return read_samples;
>  }
>
> -static int oss_read (SWVoiceIn *sw, void *buf, int size)
> -{
> -    return audio_pcm_sw_read (sw, buf, size);
> -}
> -
>  static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
>  {
>      OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
> @@ -855,13 +845,11 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
>      .init_out =3D oss_init_out,
>      .fini_out =3D oss_fini_out,
>      .run_out  =3D oss_run_out,
> -    .write    =3D oss_write,
>      .ctl_out  =3D oss_ctl_out,
>
>      .init_in  =3D oss_init_in,
>      .fini_in  =3D oss_fini_in,
>      .run_in   =3D oss_run_in,
> -    .read     =3D oss_read,
>      .ctl_in   =3D oss_ctl_in
>  };
>
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index d320d2e453..12471154ed 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -295,11 +295,6 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
>      return decr;
>  }
>
> -static int qpa_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  /* capture */
>  static void *qpa_thread_in (void *arg)
>  {
> @@ -388,11 +383,6 @@ static int qpa_run_in (HWVoiceIn *hw)
>      return incr;
>  }
>
> -static int qpa_read (SWVoiceIn *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_read (sw, buf, len);
> -}
> -
>  static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness=
)
>  {
>      int format;
> @@ -1016,13 +1006,11 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
>      .init_out =3D qpa_init_out,
>      .fini_out =3D qpa_fini_out,
>      .run_out  =3D qpa_run_out,
> -    .write    =3D qpa_write,
>      .ctl_out  =3D qpa_ctl_out,
>
>      .init_in  =3D qpa_init_in,
>      .fini_in  =3D qpa_fini_in,
>      .run_in   =3D qpa_run_in,
> -    .read     =3D qpa_read,
>      .ctl_in   =3D qpa_ctl_in
>  };
>
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 42f7614124..c7fd487e0e 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -217,11 +217,6 @@ static void sdl_callback (void *opaque, Uint8 *buf, =
int len)
>      }
>  }
>
> -static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  static int sdl_run_out (HWVoiceOut *hw, int live)
>  {
>      int decr;
> @@ -342,7 +337,6 @@ static struct audio_pcm_ops sdl_pcm_ops =3D {
>      .init_out =3D sdl_init_out,
>      .fini_out =3D sdl_fini_out,
>      .run_out  =3D sdl_run_out,
> -    .write    =3D sdl_write_out,
>      .ctl_out  =3D sdl_ctl_out,
>  };
>
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 6f4a0558f8..6e7f13cffa 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -193,11 +193,6 @@ static int line_out_run (HWVoiceOut *hw, int live)
>      return decr;
>  }
>
> -static int line_out_write (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
>  {
>      SpiceVoiceOut *out =3D container_of (hw, SpiceVoiceOut, hw);
> @@ -326,11 +321,6 @@ static int line_in_run (HWVoiceIn *hw)
>      return num_samples;
>  }
>
> -static int line_in_read (SWVoiceIn *sw, void *buf, int size)
> -{
> -    return audio_pcm_sw_read (sw, buf, size);
> -}
> -
>  static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
>  {
>      SpiceVoiceIn *in =3D container_of (hw, SpiceVoiceIn, hw);
> @@ -378,13 +368,11 @@ static struct audio_pcm_ops audio_callbacks =3D {
>      .init_out =3D line_out_init,
>      .fini_out =3D line_out_fini,
>      .run_out  =3D line_out_run,
> -    .write    =3D line_out_write,
>      .ctl_out  =3D line_out_ctl,
>
>      .init_in  =3D line_in_init,
>      .fini_in  =3D line_in_fini,
>      .run_in   =3D line_in_run,
> -    .read     =3D line_in_read,
>      .ctl_in   =3D line_in_ctl,
>  };
>
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index bbf3f3b346..17ab921cef 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -84,11 +84,6 @@ static int wav_run_out (HWVoiceOut *hw, int live)
>      return decr;
>  }
>
> -static int wav_write_out (SWVoiceOut *sw, void *buf, int len)
> -{
> -    return audio_pcm_sw_write (sw, buf, len);
> -}
> -
>  /* VICE code: Store number as little endian. */
>  static void le_store (uint8_t *buf, uint32_t val, int len)
>  {
> @@ -240,7 +235,6 @@ static struct audio_pcm_ops wav_pcm_ops =3D {
>      .init_out =3D wav_init_out,
>      .fini_out =3D wav_fini_out,
>      .run_out  =3D wav_run_out,
> -    .write    =3D wav_write_out,
>      .ctl_out  =3D wav_ctl_out,
>  };
>
> --
> 2.22.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

