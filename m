Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A880EC742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59980208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FarXg6qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59980208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlecO-0002Bk-D2
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hlecA-0001iv-A4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hlec8-0003Z4-7O
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:20:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hlec3-0003Q3-Is
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:20:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so7525912wru.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JNA9ln/6WE2wa8JDwufUg/6ufjR8ouqjROBJ/aWDfpI=;
 b=FarXg6qb+GoYDMt58iaIpeze5r7zNuzMKCGtzHN0WPzDaHHB1HUtxBo1fo5n5Ncg8h
 nYFpIpxB8eyeWGNm2Sqn95DWZR7FC1uQDxL9rzts5V90dCCP2RdETXc0WFNVptwqcVSB
 XtMPqKQN5OV8ZgQxClCkR7wBtuI/qFvP6YMiGnUqb/nSP/JG3qkqAGOu5So8A5t2gQ9M
 qJqqLmsPDgZuH1vt/QjNLHMkcFsY3/VVr5yB/6rqxKSH6N2YKkdclmGPwDTVgmqOX8w2
 36sfLpNj/wn64lnNi+JDf1Kk991CaKvmHjJtT4h3yrlstIbJXCP71UxXWRh0iuPKG/0Y
 nKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JNA9ln/6WE2wa8JDwufUg/6ufjR8ouqjROBJ/aWDfpI=;
 b=dEeC+XBZf1ddMnojSfk6HQqvspe/CFm+2EVB5LbzTGkoImCaRrJpxRPFQP9jSzEbnH
 fIfxCaISo7dJGotwIyhpyjVlKu9nFR1xGmOoXOBVXYWxLcWiN2+XI8fP+9VFytnVo0Rq
 MC8i3TnN86IClqRXr+ZZH+nLvIEHwgz/migo5PlhhR+nW4k2MSxHFxLrIPB0nYvyS2O2
 dBTWJlGhowNveCMLXEy3859H4R8/L8U8kd992Hqh0bKl/zaH1HwZBZ+WdovyWmL5M5EU
 4eYa5XKPBM5Aar4uJsBA9MzWDma8aLTGo5jX+4duJH5a1WRegiT5P9T7AtsThO+yGek6
 ItBw==
X-Gm-Message-State: APjAAAXMQPGPXFEtvcgVByF4PW8svIDSA9IV3pnEjl1GUCGRwu5Aj5VD
 Qpb95Hvr0VnNkXkDCzBVN7o=
X-Google-Smtp-Source: APXvYqzdg9Y4Oiv4+uCaStE26W7TyTcxu1NGSQrqKqEdHeQNDnM2TwwcGNO2h2NiDIXHbrKa3mmZ8g==
X-Received: by 2002:adf:f904:: with SMTP id b4mr6876934wrr.291.1562872813861; 
 Thu, 11 Jul 2019 12:20:13 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::ca?
 (2a01-036c-0113-6e3f-0001-0000-0000-00ca.pool6.digikabel.hu.
 [2a01:36c:113:6e3f:1::ca])
 by smtp.gmail.com with ESMTPSA id p26sm8630893wrp.58.2019.07.11.12.20.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 12:20:13 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <0b7207b7ef4db3a894e9dbdefe4a007d8a19709c.1562695780.git.DirtY.iCE.hu@gmail.com>
 <CAJ+F1CLPu3em-0U2N4VwJLSzXy-GTuepNfWj0iX8XE2X9Tv9kA@mail.gmail.com>
Message-ID: <ae079fc7-7105-1051-23d8-0f8cc9be51f5@gmail.com>
Date: Thu, 11 Jul 2019 21:20:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLPu3em-0U2N4VwJLSzXy-GTuepNfWj0iX8XE2X9Tv9kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On 2019-07-10 21:57, Marc-André Lureau wrote:
> On Tue, Jul 9, 2019 at 10:57 PM Kővágó, Zoltán <dirty.ice.hu@gmail.com> wrote:
>>
>> They just called audio_pcm_sw_read/write anyway, so it makes no sense
>> to have them too.  (The noaudio's read is the only exception, but it
>> should work with the generic code too.)
> 
> It works with the generic code, but wouldn't it be more expensive?

It's a bit more expensive, but only if the guest has a sound card and
the guest is playing some sound, because otherwise the output is suspended.

> Perhaps there can be something in audio_pcm_sw_write() to skip the
> work if noaudio is the backend?

It feels like a hacky solution to the same problem what the function
pointer currently solves.  On the other hand, it's unlikely any other
backend would drop every sample without processing them.

>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  audio/audio_int.h   |  5 -----
>>  audio/alsaaudio.c   | 12 ------------
>>  audio/audio.c       |  8 ++++----
>>  audio/coreaudio.c   |  6 ------
>>  audio/dsoundaudio.c | 12 ------------
>>  audio/noaudio.c     | 19 -------------------
>>  audio/ossaudio.c    | 12 ------------
>>  audio/paaudio.c     | 12 ------------
>>  audio/sdlaudio.c    |  6 ------
>>  audio/spiceaudio.c  | 12 ------------
>>  audio/wavaudio.c    |  6 ------
>>  11 files changed, 4 insertions(+), 106 deletions(-)
>>
>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>> index 7e00c1332e..003b7ab8cc 100644
>> --- a/audio/audio_int.h
>> +++ b/audio/audio_int.h
>> @@ -150,13 +150,11 @@ struct audio_pcm_ops {
>>      int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque);
>>      void (*fini_out)(HWVoiceOut *hw);
>>      int  (*run_out) (HWVoiceOut *hw, int live);
>> -    int  (*write)   (SWVoiceOut *sw, void *buf, int size);
>>      int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
>>
>>      int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
>>      void (*fini_in) (HWVoiceIn *hw);
>>      int  (*run_in)  (HWVoiceIn *hw);
>> -    int  (*read)    (SWVoiceIn *sw, void *buf, int size);
>>      int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
>>  };
>>
>> @@ -210,11 +208,8 @@ audio_driver *audio_driver_lookup(const char *name);
>>  void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
>>  void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
>>
>> -int  audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int len);
>>  int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
>>
>> -int  audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int len);
>> -
>>  int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
>>                             int live, int pending);
>>
>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
>> index 3daa7c8f8f..e9e3a4819c 100644
>> --- a/audio/alsaaudio.c
>> +++ b/audio/alsaaudio.c
>> @@ -270,11 +270,6 @@ static int alsa_poll_in (HWVoiceIn *hw)
>>      return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
>>  }
>>
>> -static int alsa_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
>>  {
>>      switch (fmt) {
>> @@ -988,11 +983,6 @@ static int alsa_run_in (HWVoiceIn *hw)
>>      return read_samples;
>>  }
>>
>> -static int alsa_read (SWVoiceIn *sw, void *buf, int size)
>> -{
>> -    return audio_pcm_sw_read (sw, buf, size);
>> -}
>> -
>>  static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
>>  {
>>      ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
>> @@ -1076,13 +1066,11 @@ static struct audio_pcm_ops alsa_pcm_ops = {
>>      .init_out = alsa_init_out,
>>      .fini_out = alsa_fini_out,
>>      .run_out  = alsa_run_out,
>> -    .write    = alsa_write,
>>      .ctl_out  = alsa_ctl_out,
>>
>>      .init_in  = alsa_init_in,
>>      .fini_in  = alsa_fini_in,
>>      .run_in   = alsa_run_in,
>> -    .read     = alsa_read,
>>      .ctl_in   = alsa_ctl_in,
>>  };
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index d73cc086b6..b79f56fe64 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -594,7 +594,7 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
>>      }
>>  }
>>
>> -int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
>> +static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
>>  {
>>      HWVoiceIn *hw = sw->hw;
>>      int samples, live, ret = 0, swlim, isamp, osamp, rpos, total = 0;
>> @@ -696,7 +696,7 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
>>  /*
>>   * Soft voice (playback)
>>   */
>> -int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
>> +static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
>>  {
>>      int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim, blck;
>>      int ret = 0, pos = 0, total = 0;
>> @@ -854,7 +854,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
>>          return 0;
>>      }
>>
>> -    return sw->hw->pcm_ops->write(sw, buf, size);
>> +    return audio_pcm_sw_write(sw, buf, size);
>>  }
>>
>>  int AUD_read (SWVoiceIn *sw, void *buf, int size)
>> @@ -869,7 +869,7 @@ int AUD_read (SWVoiceIn *sw, void *buf, int size)
>>          return 0;
>>      }
>>
>> -    return sw->hw->pcm_ops->read(sw, buf, size);
>> +    return audio_pcm_sw_read(sw, buf, size);
>>  }
>>
>>  int AUD_get_buffer_size_out (SWVoiceOut *sw)
>> diff --git a/audio/coreaudio.c b/audio/coreaudio.c
>> index f0ab4014a8..091fe84a34 100644
>> --- a/audio/coreaudio.c
>> +++ b/audio/coreaudio.c
>> @@ -489,11 +489,6 @@ static OSStatus audioDeviceIOProc(
>>      return 0;
>>  }
>>
>> -static int coreaudio_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
>>                                void *drv_opaque)
>>  {
>> @@ -692,7 +687,6 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
>>      .init_out = coreaudio_init_out,
>>      .fini_out = coreaudio_fini_out,
>>      .run_out  = coreaudio_run_out,
>> -    .write    = coreaudio_write,
>>      .ctl_out  = coreaudio_ctl_out
>>  };
>>
>> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
>> index 07260f881e..11594c3095 100644
>> --- a/audio/dsoundaudio.c
>> +++ b/audio/dsoundaudio.c
>> @@ -454,11 +454,6 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
>>      return 0;
>>  }
>>
>> -static int dsound_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  static int dsound_run_out (HWVoiceOut *hw, int live)
>>  {
>>      int err;
>> @@ -645,11 +640,6 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
>>      return 0;
>>  }
>>
>> -static int dsound_read (SWVoiceIn *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_read (sw, buf, len);
>> -}
>> -
>>  static int dsound_run_in (HWVoiceIn *hw)
>>  {
>>      int err;
>> @@ -856,13 +846,11 @@ static struct audio_pcm_ops dsound_pcm_ops = {
>>      .init_out = dsound_init_out,
>>      .fini_out = dsound_fini_out,
>>      .run_out  = dsound_run_out,
>> -    .write    = dsound_write,
>>      .ctl_out  = dsound_ctl_out,
>>
>>      .init_in  = dsound_init_in,
>>      .fini_in  = dsound_fini_in,
>>      .run_in   = dsound_run_in,
>> -    .read     = dsound_read,
>>      .ctl_in   = dsound_ctl_in
>>  };
>>
>> diff --git a/audio/noaudio.c b/audio/noaudio.c
>> index 14a0e4ab29..cbb02d9e49 100644
>> --- a/audio/noaudio.c
>> +++ b/audio/noaudio.c
>> @@ -61,11 +61,6 @@ static int no_run_out (HWVoiceOut *hw, int live)
>>      return decr;
>>  }
>>
>> -static int no_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write(sw, buf, len);
>> -}
>> -
>>  static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>>  {
>>      audio_pcm_init_info (&hw->info, as);
>> @@ -118,18 +113,6 @@ static int no_run_in (HWVoiceIn *hw)
>>      return samples;
>>  }
>>
>> -static int no_read (SWVoiceIn *sw, void *buf, int size)
>> -{
>> -    /* use custom code here instead of audio_pcm_sw_read() to avoid
>> -     * useless resampling/mixing */
>> -    int samples = size >> sw->info.shift;
>> -    int total = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
>> -    int to_clear = MIN (samples, total);
>> -    sw->total_hw_samples_acquired += total;
>> -    audio_pcm_info_clear_buf (&sw->info, buf, to_clear);
>> -    return to_clear << sw->info.shift;
>> -}
>> -
>>  static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
>>  {
>>      (void) hw;
>> @@ -151,13 +134,11 @@ static struct audio_pcm_ops no_pcm_ops = {
>>      .init_out = no_init_out,
>>      .fini_out = no_fini_out,
>>      .run_out  = no_run_out,
>> -    .write    = no_write,
>>      .ctl_out  = no_ctl_out,
>>
>>      .init_in  = no_init_in,
>>      .fini_in  = no_fini_in,
>>      .run_in   = no_run_in,
>> -    .read     = no_read,
>>      .ctl_in   = no_ctl_in
>>  };
>>
>> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
>> index 456fba7480..b99edbec17 100644
>> --- a/audio/ossaudio.c
>> +++ b/audio/ossaudio.c
>> @@ -134,11 +134,6 @@ static void oss_poll_in (HWVoiceIn *hw)
>>      qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
>>  }
>>
>> -static int oss_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  static int aud_to_ossfmt (AudioFormat fmt, int endianness)
>>  {
>>      switch (fmt) {
>> @@ -788,11 +783,6 @@ static int oss_run_in (HWVoiceIn *hw)
>>      return read_samples;
>>  }
>>
>> -static int oss_read (SWVoiceIn *sw, void *buf, int size)
>> -{
>> -    return audio_pcm_sw_read (sw, buf, size);
>> -}
>> -
>>  static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
>>  {
>>      OSSVoiceIn *oss = (OSSVoiceIn *) hw;
>> @@ -855,13 +845,11 @@ static struct audio_pcm_ops oss_pcm_ops = {
>>      .init_out = oss_init_out,
>>      .fini_out = oss_fini_out,
>>      .run_out  = oss_run_out,
>> -    .write    = oss_write,
>>      .ctl_out  = oss_ctl_out,
>>
>>      .init_in  = oss_init_in,
>>      .fini_in  = oss_fini_in,
>>      .run_in   = oss_run_in,
>> -    .read     = oss_read,
>>      .ctl_in   = oss_ctl_in
>>  };
>>
>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>> index d320d2e453..12471154ed 100644
>> --- a/audio/paaudio.c
>> +++ b/audio/paaudio.c
>> @@ -295,11 +295,6 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
>>      return decr;
>>  }
>>
>> -static int qpa_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  /* capture */
>>  static void *qpa_thread_in (void *arg)
>>  {
>> @@ -388,11 +383,6 @@ static int qpa_run_in (HWVoiceIn *hw)
>>      return incr;
>>  }
>>
>> -static int qpa_read (SWVoiceIn *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_read (sw, buf, len);
>> -}
>> -
>>  static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
>>  {
>>      int format;
>> @@ -1016,13 +1006,11 @@ static struct audio_pcm_ops qpa_pcm_ops = {
>>      .init_out = qpa_init_out,
>>      .fini_out = qpa_fini_out,
>>      .run_out  = qpa_run_out,
>> -    .write    = qpa_write,
>>      .ctl_out  = qpa_ctl_out,
>>
>>      .init_in  = qpa_init_in,
>>      .fini_in  = qpa_fini_in,
>>      .run_in   = qpa_run_in,
>> -    .read     = qpa_read,
>>      .ctl_in   = qpa_ctl_in
>>  };
>>
>> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
>> index 42f7614124..c7fd487e0e 100644
>> --- a/audio/sdlaudio.c
>> +++ b/audio/sdlaudio.c
>> @@ -217,11 +217,6 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
>>      }
>>  }
>>
>> -static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  static int sdl_run_out (HWVoiceOut *hw, int live)
>>  {
>>      int decr;
>> @@ -342,7 +337,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
>>      .init_out = sdl_init_out,
>>      .fini_out = sdl_fini_out,
>>      .run_out  = sdl_run_out,
>> -    .write    = sdl_write_out,
>>      .ctl_out  = sdl_ctl_out,
>>  };
>>
>> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
>> index 6f4a0558f8..6e7f13cffa 100644
>> --- a/audio/spiceaudio.c
>> +++ b/audio/spiceaudio.c
>> @@ -193,11 +193,6 @@ static int line_out_run (HWVoiceOut *hw, int live)
>>      return decr;
>>  }
>>
>> -static int line_out_write (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
>>  {
>>      SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
>> @@ -326,11 +321,6 @@ static int line_in_run (HWVoiceIn *hw)
>>      return num_samples;
>>  }
>>
>> -static int line_in_read (SWVoiceIn *sw, void *buf, int size)
>> -{
>> -    return audio_pcm_sw_read (sw, buf, size);
>> -}
>> -
>>  static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
>>  {
>>      SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
>> @@ -378,13 +368,11 @@ static struct audio_pcm_ops audio_callbacks = {
>>      .init_out = line_out_init,
>>      .fini_out = line_out_fini,
>>      .run_out  = line_out_run,
>> -    .write    = line_out_write,
>>      .ctl_out  = line_out_ctl,
>>
>>      .init_in  = line_in_init,
>>      .fini_in  = line_in_fini,
>>      .run_in   = line_in_run,
>> -    .read     = line_in_read,
>>      .ctl_in   = line_in_ctl,
>>  };
>>
>> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
>> index bbf3f3b346..17ab921cef 100644
>> --- a/audio/wavaudio.c
>> +++ b/audio/wavaudio.c
>> @@ -84,11 +84,6 @@ static int wav_run_out (HWVoiceOut *hw, int live)
>>      return decr;
>>  }
>>
>> -static int wav_write_out (SWVoiceOut *sw, void *buf, int len)
>> -{
>> -    return audio_pcm_sw_write (sw, buf, len);
>> -}
>> -
>>  /* VICE code: Store number as little endian. */
>>  static void le_store (uint8_t *buf, uint32_t val, int len)
>>  {
>> @@ -240,7 +235,6 @@ static struct audio_pcm_ops wav_pcm_ops = {
>>      .init_out = wav_init_out,
>>      .fini_out = wav_fini_out,
>>      .run_out  = wav_run_out,
>> -    .write    = wav_write_out,
>>      .ctl_out  = wav_ctl_out,
>>  };
>>
>> --
>> 2.22.0
>>
>>
> 
> 


