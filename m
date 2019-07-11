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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DD7C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD596208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+MlHeEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD596208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hleRo-0006c7-1t
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37465)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hleRL-0004jB-3i
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hleRI-0005de-0I
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:09:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hleRH-0005cb-Ez
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:09:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so7496503wru.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uq/1+me51iqeIHNJ1XMEx8v2xZoeAXXOSb3Dsw6WwqI=;
 b=D+MlHeEW8wiHEXvIjy+R3ZFdvVwCVcypsWH4LKdP/EJbYpU3yqt+T6M59dQck0O7/x
 yUpex0E6nLR0wTr0AlqNG8pqOBbaAVnfIEy0sIklI6QE/WxeNI2pQsaP5TGDCXi4bXzM
 d/Q4uPfcSf5hnYYjzghgd8uaHS/twcBjfos3lJFBFQNN2vMdw5+uPP42Q9O3TL0VCmhM
 Ed/QyUq5dM3Zm4ylQbyOrXjcWsqr1DHNsKVJra1CWHD9hlC8K1igkp+Rg1e3mIq32hI1
 Opto9KBbnz8w/Bf/ppkKjNF0wF//ODqWnG9ZpY1rpDMTkHgtArGd3HMRCHlLxbaDqZKU
 v2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uq/1+me51iqeIHNJ1XMEx8v2xZoeAXXOSb3Dsw6WwqI=;
 b=LWQXlwVkupRUhIENNFkcwqhv7vQzL9cQW7eCr/PuXIKE/6WpEmYgod/WvJk+c2zeSv
 Mfxdxw2PSbFefTHTX5It1FN9mqbcphaWN8jCK0B+k6ZicAz3vYRqEmTTWpDfeqN6h9NX
 kvZhZq/L8+qpQY8ZfrfBYDqUeMfoqQJ9EJjvIaoj/+MR3aNVviD42zBt0Dw818E4fBiv
 kql20nq9qD6WwyICdmJPleHLpUN7y8aRH3yhZ+qv9vuayGVxMCWRTfK1fn8zRjoUWA+s
 /eI2jrKhOgcK02ogED2bGOaAczt6ETj/9Fa7iyeFzSnYvoGuqm0x6sn/prvaYfvlyehc
 xbOQ==
X-Gm-Message-State: APjAAAW9zFCre7suXj8zoffD18V3TF6LjFiTyVAGZHVvor+rdHIH9Fv4
 0P4o5EYw692Beec/TtQfq/NqSdkC
X-Google-Smtp-Source: APXvYqxrW5DjjVcVYOIt2i7Bkh1wUFWZgRAnZyEC1ltxYP4G8gsy8LUBu8e/s1+XZQ66y/rCD5npnA==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr6673867wrm.22.1562872146480; 
 Thu, 11 Jul 2019 12:09:06 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::ca?
 (2a01-036c-0113-6e3f-0001-0000-0000-00ca.pool6.digikabel.hu.
 [2a01:36c:113:6e3f:1::ca])
 by smtp.gmail.com with ESMTPSA id g11sm7430942wrq.92.2019.07.11.12.09.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 12:09:05 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <25d0165508ec9a4dbac572adcee97dd4c342b55b.1562695780.git.DirtY.iCE.hu@gmail.com>
 <CAJ+F1C+A72=W1XscymUQe6UXijVBgXUDC3EPnb1YLxsVC_DXAA@mail.gmail.com>
Message-ID: <211ce8ca-140f-58c8-bff3-aa4c5fbeb27c@gmail.com>
Date: Thu, 11 Jul 2019 21:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+A72=W1XscymUQe6UXijVBgXUDC3EPnb1YLxsVC_DXAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 04/11] audio: audiodev= parameters no
 longer optional when -audiodev present
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

On 2019-07-10 21:30, Marc-André Lureau wrote:
> On Tue, Jul 9, 2019 at 11:00 PM Kővágó, Zoltán <dirty.ice.hu@gmail.com> wrote:
>>
>> This means you should probably stop using -soundhw (as it doesn't allow
>> you to specify any options) and add the device manually with -device.
>> The exception is pcspk, it's currently not possible to manually add it.
>> To use it with audiodev, use something like this:
>>
>>     -audiodev id=foo,... -global isa-pcspk.audiodev=foo -soundhw pcspk
> 
> Can you seperate the paaudio changes to ease review?

I'll look into it, unfortunately the two changes are more intermixed
than I'd like them to be.

>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  audio/audio.c   |  24 ++--
>>  audio/paaudio.c | 329 +++++++++++++++++++++++++++---------------------
>>  2 files changed, 203 insertions(+), 150 deletions(-)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index e9dd7c8b32..82dd0e3e13 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -101,6 +101,8 @@ const struct mixeng_volume nominal_volume = {
>>  #endif
>>  };
>>
>> +static bool legacy_config = true;
>> +
>>  #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
>>  #error No its not
>>  #else
>> @@ -1392,7 +1394,7 @@ static AudiodevListEntry *audiodev_find(
>>   * if dev == NULL => legacy implicit initialization, return the already created
>>   *   state or create a new one
>>   */
>> -static AudioState *audio_init(Audiodev *dev)
>> +static AudioState *audio_init(Audiodev *dev, const char *name)
>>  {
>>      static bool atexit_registered;
>>      size_t i;
>> @@ -1406,12 +1408,13 @@ static AudioState *audio_init(Audiodev *dev)
>>
>>      if (dev) {
>>          /* -audiodev option */
>> +        legacy_config = false;
>>          drvname = AudiodevDriver_str(dev->driver);
>>      } else if (!QTAILQ_EMPTY(&audio_states)) {
>> -        /*
>> -         * todo: check for -audiodev once we have normal audiodev selection
>> -         * support
>> -         */
>> +        if (!legacy_config) {
>> +            dolog("You must specify an audiodev= for the device %s\n", name);
>> +            exit(1);
>> +        }
>>          return QTAILQ_FIRST(&audio_states);
>>      } else {
>>          /* legacy implicit initialization */
>> @@ -1518,7 +1521,7 @@ void audio_free_audiodev_list(AudiodevListHead *head)
>>  void AUD_register_card (const char *name, QEMUSoundCard *card)
>>  {
>>      if (!card->state) {
>> -        card->state = audio_init(NULL);
>> +        card->state = audio_init(NULL, name);
>>      }
>>
>>      card->name = g_strdup (name);
>> @@ -1544,8 +1547,11 @@ CaptureVoiceOut *AUD_add_capture(
>>      struct capture_callback *cb;
>>
>>      if (!s) {
>> -        /* todo: remove when we have normal audiodev selection support */
>> -        s = audio_init(NULL);
>> +        if (!legacy_config) {
>> +            dolog("You must specify audiodev when trying to capture\n");
>> +            return NULL;
>> +        }
>> +        s = audio_init(NULL, NULL);
>>      }
>>
>>      if (audio_validate_settings (as)) {
>> @@ -1776,7 +1782,7 @@ void audio_init_audiodevs(void)
>>      AudiodevListEntry *e;
>>
>>      QSIMPLEQ_FOREACH(e, &audiodevs, next) {
>> -        audio_init(e->dev);
>> +        audio_init(e->dev, NULL);
>>      }
>>  }
>>
>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>> index 5fc886bb33..cc3a34c2ea 100644
>> --- a/audio/paaudio.c
>> +++ b/audio/paaudio.c
>> @@ -11,10 +11,21 @@
>>  #include "audio_int.h"
>>  #include "audio_pt_int.h"
>>
>> -typedef struct {
>> -    Audiodev *dev;
>> +typedef struct PAConnection {
>> +    char *server;
>> +    int refcount;
>> +    QTAILQ_ENTRY(PAConnection) list;
>> +
>>      pa_threaded_mainloop *mainloop;
>>      pa_context *context;
>> +} PAConnection;
>> +
>> +static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =
>> +    QTAILQ_HEAD_INITIALIZER(pa_conns);
>> +
>> +typedef struct {
>> +    Audiodev *dev;
>> +    PAConnection *conn;
>>  } paaudio;
>>
>>  typedef struct {
>> @@ -45,7 +56,7 @@ typedef struct {
>>      int samples;
>>  } PAVoiceIn;
>>
>> -static void qpa_audio_fini(void *opaque);
>> +static void qpa_conn_fini(PAConnection *c);
>>
>>  static void GCC_FMT_ATTR (2, 3) qpa_logerr (int err, const char *fmt, ...)
>>  {
>> @@ -108,11 +119,11 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
>>
>>  static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror)
>>  {
>> -    paaudio *g = p->g;
>> +    PAConnection *c = p->g->conn;
>>
>> -    pa_threaded_mainloop_lock (g->mainloop);
>> +    pa_threaded_mainloop_lock(c->mainloop);
>>
>> -    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
>> +    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>>
>>      while (length > 0) {
>>          size_t l;
>> @@ -121,11 +132,11 @@ static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror
>>              int r;
>>
>>              r = pa_stream_peek (p->stream, &p->read_data, &p->read_length);
>> -            CHECK_SUCCESS_GOTO (g, rerror, r == 0, unlock_and_fail);
>> +            CHECK_SUCCESS_GOTO(c, rerror, r == 0, unlock_and_fail);
>>
>>              if (!p->read_data) {
>> -                pa_threaded_mainloop_wait (g->mainloop);
>> -                CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
>> +                pa_threaded_mainloop_wait(c->mainloop);
>> +                CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>>              } else {
>>                  p->read_index = 0;
>>              }
>> @@ -148,53 +159,53 @@ static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror
>>              p->read_length = 0;
>>              p->read_index = 0;
>>
>> -            CHECK_SUCCESS_GOTO (g, rerror, r == 0, unlock_and_fail);
>> +            CHECK_SUCCESS_GOTO(c, rerror, r == 0, unlock_and_fail);
>>          }
>>      }
>>
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>>      return 0;
>>
>>  unlock_and_fail:
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>>      return -1;
>>  }
>>
>>  static int qpa_simple_write (PAVoiceOut *p, const void *data, size_t length, int *rerror)
>>  {
>> -    paaudio *g = p->g;
>> +    PAConnection *c = p->g->conn;
>>
>> -    pa_threaded_mainloop_lock (g->mainloop);
>> +    pa_threaded_mainloop_lock(c->mainloop);
>>
>> -    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
>> +    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>>
>>      while (length > 0) {
>>          size_t l;
>>          int r;
>>
>>          while (!(l = pa_stream_writable_size (p->stream))) {
>> -            pa_threaded_mainloop_wait (g->mainloop);
>> -            CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
>> +            pa_threaded_mainloop_wait(c->mainloop);
>> +            CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>>          }
>>
>> -        CHECK_SUCCESS_GOTO (g, rerror, l != (size_t) -1, unlock_and_fail);
>> +        CHECK_SUCCESS_GOTO(c, rerror, l != (size_t) -1, unlock_and_fail);
>>
>>          if (l > length) {
>>              l = length;
>>          }
>>
>>          r = pa_stream_write (p->stream, data, l, NULL, 0LL, PA_SEEK_RELATIVE);
>> -        CHECK_SUCCESS_GOTO (g, rerror, r >= 0, unlock_and_fail);
>> +        CHECK_SUCCESS_GOTO(c, rerror, r >= 0, unlock_and_fail);
>>
>>          data = (const uint8_t *) data + l;
>>          length -= l;
>>      }
>>
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>>      return 0;
>>
>>  unlock_and_fail:
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>>      return -1;
>>  }
>>
>> @@ -432,13 +443,13 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
>>
>>  static void context_state_cb (pa_context *c, void *userdata)
>>  {
>> -    paaudio *g = userdata;
>> +    PAConnection *conn = userdata;
>>
>>      switch (pa_context_get_state(c)) {
>>      case PA_CONTEXT_READY:
>>      case PA_CONTEXT_TERMINATED:
>>      case PA_CONTEXT_FAILED:
>> -        pa_threaded_mainloop_signal (g->mainloop, 0);
>> +        pa_threaded_mainloop_signal(conn->mainloop, 0);
>>          break;
>>
>>      case PA_CONTEXT_UNCONNECTED:
>> @@ -451,14 +462,14 @@ static void context_state_cb (pa_context *c, void *userdata)
>>
>>  static void stream_state_cb (pa_stream *s, void * userdata)
>>  {
>> -    paaudio *g = userdata;
>> +    PAConnection *c = userdata;
>>
>>      switch (pa_stream_get_state (s)) {
>>
>>      case PA_STREAM_READY:
>>      case PA_STREAM_FAILED:
>>      case PA_STREAM_TERMINATED:
>> -        pa_threaded_mainloop_signal (g->mainloop, 0);
>> +        pa_threaded_mainloop_signal(c->mainloop, 0);
>>          break;
>>
>>      case PA_STREAM_UNCONNECTED:
>> @@ -469,13 +480,13 @@ static void stream_state_cb (pa_stream *s, void * userdata)
>>
>>  static void stream_request_cb (pa_stream *s, size_t length, void *userdata)
>>  {
>> -    paaudio *g = userdata;
>> +    PAConnection *c = userdata;
>>
>> -    pa_threaded_mainloop_signal (g->mainloop, 0);
>> +    pa_threaded_mainloop_signal(c->mainloop, 0);
>>  }
>>
>>  static pa_stream *qpa_simple_new (
>> -        paaudio *g,
>> +        PAConnection *c,
>>          const char *name,
>>          pa_stream_direction_t dir,
>>          const char *dev,
>> @@ -486,50 +497,48 @@ static pa_stream *qpa_simple_new (
>>  {
>>      int r;
>>      pa_stream *stream;
>> +    pa_stream_flags_t flags;
>>
>> -    pa_threaded_mainloop_lock (g->mainloop);
>> +    pa_threaded_mainloop_lock(c->mainloop);
>>
>> -    stream = pa_stream_new (g->context, name, ss, map);
>> +    stream = pa_stream_new(c->context, name, ss, map);
>>      if (!stream) {
>>          goto fail;
>>      }
>>
>> -    pa_stream_set_state_callback (stream, stream_state_cb, g);
>> -    pa_stream_set_read_callback (stream, stream_request_cb, g);
>> -    pa_stream_set_write_callback (stream, stream_request_cb, g);
>> +    pa_stream_set_state_callback(stream, stream_state_cb, c);
>> +    pa_stream_set_read_callback(stream, stream_request_cb, c);
>> +    pa_stream_set_write_callback(stream, stream_request_cb, c);
>> +
>> +    flags =
>> +        PA_STREAM_INTERPOLATE_TIMING
>> +#ifdef PA_STREAM_ADJUST_LATENCY
>> +        | PA_STREAM_ADJUST_LATENCY
>> +#endif
>> +        | PA_STREAM_AUTO_TIMING_UPDATE;
>>
>>      if (dir == PA_STREAM_PLAYBACK) {
>> -        r = pa_stream_connect_playback (stream, dev, attr,
>> -                                        PA_STREAM_INTERPOLATE_TIMING
>> -#ifdef PA_STREAM_ADJUST_LATENCY
>> -                                        |PA_STREAM_ADJUST_LATENCY
>> -#endif
>> -                                        |PA_STREAM_AUTO_TIMING_UPDATE, NULL, NULL);
>> +        r = pa_stream_connect_playback(stream, dev, attr, flags, NULL, NULL);
>>      } else {
>> -        r = pa_stream_connect_record (stream, dev, attr,
>> -                                      PA_STREAM_INTERPOLATE_TIMING
>> -#ifdef PA_STREAM_ADJUST_LATENCY
>> -                                      |PA_STREAM_ADJUST_LATENCY
>> -#endif
>> -                                      |PA_STREAM_AUTO_TIMING_UPDATE);
>> +        r = pa_stream_connect_record(stream, dev, attr, flags);
>>      }
>>
>>      if (r < 0) {
>>        goto fail;
>>      }
>>
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>>
>>      return stream;
>>
>>  fail:
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>>
>>      if (stream) {
>>          pa_stream_unref (stream);
>>      }
>>
>> -    *rerror = pa_context_errno (g->context);
>> +    *rerror = pa_context_errno(c->context);
>>
>>      return NULL;
>>  }
>> @@ -545,6 +554,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>>      paaudio *g = pa->g = drv_opaque;
>>      AudiodevPaOptions *popts = &g->dev->u.pa;
>>      AudiodevPaPerDirectionOptions *ppdo = popts->out;
>> +    PAConnection *c = g->conn;
>>
>>      ss.format = audfmt_to_pa (as->fmt, as->endianness);
>>      ss.channels = as->nchannels;
>> @@ -558,7 +568,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>>      obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
>>
>>      pa->stream = qpa_simple_new (
>> -        g,
>> +        c,
>>          "qemu",
>>          PA_STREAM_PLAYBACK,
>>          ppdo->has_name ? ppdo->name : NULL,
>> @@ -612,6 +622,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>>      paaudio *g = pa->g = drv_opaque;
>>      AudiodevPaOptions *popts = &g->dev->u.pa;
>>      AudiodevPaPerDirectionOptions *ppdo = popts->in;
>> +    PAConnection *c = g->conn;
>>
>>      ss.format = audfmt_to_pa (as->fmt, as->endianness);
>>      ss.channels = as->nchannels;
>> @@ -625,7 +636,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>>      obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
>>
>>      pa->stream = qpa_simple_new (
>> -        g,
>> +        c,
>>          "qemu",
>>          PA_STREAM_RECORD,
>>          ppdo->has_name ? ppdo->name : NULL,
>> @@ -714,7 +725,7 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
>>      PAVoiceOut *pa = (PAVoiceOut *) hw;
>>      pa_operation *op;
>>      pa_cvolume v;
>> -    paaudio *g = pa->g;
>> +    PAConnection *c = pa->g->conn;
>>
>>  #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
>>      pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
>> @@ -734,28 +745,29 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
>>              v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
>>              v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
>>
>> -            pa_threaded_mainloop_lock (g->mainloop);
>> +            pa_threaded_mainloop_lock(c->mainloop);
>>
>> -            op = pa_context_set_sink_input_volume (g->context,
>> +            op = pa_context_set_sink_input_volume(c->context,
>>                  pa_stream_get_index (pa->stream),
>>                  &v, NULL, NULL);
>> -            if (!op)
>> -                qpa_logerr (pa_context_errno (g->context),
>> -                            "set_sink_input_volume() failed\n");
>> -            else
>> -                pa_operation_unref (op);
>> +            if (!op) {
>> +                qpa_logerr(pa_context_errno(c->context),
>> +                           "set_sink_input_volume() failed\n");
>> +            } else {
>> +                pa_operation_unref(op);
>> +            }
>>
>> -            op = pa_context_set_sink_input_mute (g->context,
>> +            op = pa_context_set_sink_input_mute(c->context,
>>                  pa_stream_get_index (pa->stream),
>>                 sw->vol.mute, NULL, NULL);
>>              if (!op) {
>> -                qpa_logerr (pa_context_errno (g->context),
>> -                            "set_sink_input_mute() failed\n");
>> +                qpa_logerr(pa_context_errno(c->context),
>> +                           "set_sink_input_mute() failed\n");
>>              } else {
>> -                pa_operation_unref (op);
>> +                pa_operation_unref(op);
>>              }
>>
>> -            pa_threaded_mainloop_unlock (g->mainloop);
>> +            pa_threaded_mainloop_unlock(c->mainloop);
>>          }
>>      }
>>      return 0;
>> @@ -766,7 +778,7 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
>>      PAVoiceIn *pa = (PAVoiceIn *) hw;
>>      pa_operation *op;
>>      pa_cvolume v;
>> -    paaudio *g = pa->g;
>> +    PAConnection *c = pa->g->conn;
>>
>>  #ifdef PA_CHECK_VERSION
>>      pa_cvolume_init (&v);
>> @@ -786,29 +798,29 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
>>              v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
>>              v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
>>
>> -            pa_threaded_mainloop_lock (g->mainloop);
>> +            pa_threaded_mainloop_lock(c->mainloop);
>>
>> -            op = pa_context_set_source_output_volume (g->context,
>> -                pa_stream_get_index (pa->stream),
>> +            op = pa_context_set_source_output_volume(c->context,
>> +                pa_stream_get_index(pa->stream),
>>                  &v, NULL, NULL);
>>              if (!op) {
>> -                qpa_logerr (pa_context_errno (g->context),
>> -                            "set_source_output_volume() failed\n");
>> +                qpa_logerr(pa_context_errno(c->context),
>> +                           "set_source_output_volume() failed\n");
>>              } else {
>>                  pa_operation_unref(op);
>>              }
>>
>> -            op = pa_context_set_source_output_mute (g->context,
>> +            op = pa_context_set_source_output_mute(c->context,
>>                  pa_stream_get_index (pa->stream),
>>                  sw->vol.mute, NULL, NULL);
>>              if (!op) {
>> -                qpa_logerr (pa_context_errno (g->context),
>> -                            "set_source_output_mute() failed\n");
>> +                qpa_logerr(pa_context_errno(c->context),
>> +                           "set_source_output_mute() failed\n");
>>              } else {
>>                  pa_operation_unref (op);
>>              }
>>
>> -            pa_threaded_mainloop_unlock (g->mainloop);
>> +            pa_threaded_mainloop_unlock(c->mainloop);
>>          }
>>      }
>>      return 0;
>> @@ -828,11 +840,75 @@ static int qpa_validate_per_direction_opts(Audiodev *dev,
>>      return 1;
>>  }
>>
>> +/* common */
>> +static void *qpa_conn_init(const char *server)
>> +{
>> +    PAConnection *c = g_malloc0(sizeof(PAConnection));
>> +    QTAILQ_INSERT_TAIL(&pa_conns, c, list);
>> +
>> +    c->mainloop = pa_threaded_mainloop_new();
>> +    if (!c->mainloop) {
>> +        goto fail;
>> +    }
>> +
>> +    c->context = pa_context_new(pa_threaded_mainloop_get_api(c->mainloop),
>> +                                server);
>> +    if (!c->context) {
>> +        goto fail;
>> +    }
>> +
>> +    pa_context_set_state_callback(c->context, context_state_cb, c);
>> +
>> +    if (pa_context_connect(c->context, server, 0, NULL) < 0) {
>> +        qpa_logerr(pa_context_errno(c->context),
>> +                   "pa_context_connect() failed\n");
>> +        goto fail;
>> +    }
>> +
>> +    pa_threaded_mainloop_lock(c->mainloop);
>> +
>> +    if (pa_threaded_mainloop_start(c->mainloop) < 0) {
>> +        goto unlock_and_fail;
>> +    }
>> +
>> +    for (;;) {
>> +        pa_context_state_t state;
>> +
>> +        state = pa_context_get_state(c->context);
>> +
>> +        if (state == PA_CONTEXT_READY) {
>> +            break;
>> +        }
>> +
>> +        if (!PA_CONTEXT_IS_GOOD(state)) {
>> +            qpa_logerr(pa_context_errno(c->context),
>> +                       "Wrong context state\n");
>> +            goto unlock_and_fail;
>> +        }
>> +
>> +        /* Wait until the context is ready */
>> +        pa_threaded_mainloop_wait(c->mainloop);
>> +    }
>> +
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>> +    return c;
>> +
>> +unlock_and_fail:
>> +    pa_threaded_mainloop_unlock(c->mainloop);
>> +fail:
>> +    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
>> +    qpa_conn_fini(c);
>> +    return NULL;
>> +}
>> +
>>  static void *qpa_audio_init(Audiodev *dev)
>>  {
>>      paaudio *g;
>>      AudiodevPaOptions *popts = &dev->u.pa;
>>      const char *server;
>> +    PAConnection *c;
>> +
>> +    assert(dev->driver == AUDIODEV_DRIVER_PA);
>>
>>      if (!popts->has_server) {
>>          char pidfile[64];
>> @@ -849,93 +925,64 @@ static void *qpa_audio_init(Audiodev *dev)
>>          }
>>      }
>>
>> -    assert(dev->driver == AUDIODEV_DRIVER_PA);
>> -
>> -    g = g_malloc(sizeof(paaudio));
>> -    server = popts->has_server ? popts->server : NULL;
>> -
>>      if (!qpa_validate_per_direction_opts(dev, popts->in)) {
>> -        goto fail;
>> +        return NULL;
>>      }
>>      if (!qpa_validate_per_direction_opts(dev, popts->out)) {
>> -        goto fail;
>> +        return NULL;
>>      }
>>
>> +    g = g_malloc0(sizeof(paaudio));
>> +    server = popts->has_server ? popts->server : NULL;
>> +
>>      g->dev = dev;
>> -    g->mainloop = NULL;
>> -    g->context = NULL;
>>
>> -    g->mainloop = pa_threaded_mainloop_new ();
>> -    if (!g->mainloop) {
>> -        goto fail;
>> -    }
>> -
>> -    g->context = pa_context_new (pa_threaded_mainloop_get_api (g->mainloop),
>> -                                 server);
>> -    if (!g->context) {
>> -        goto fail;
>> -    }
>> -
>> -    pa_context_set_state_callback (g->context, context_state_cb, g);
>> -
>> -    if (pa_context_connect(g->context, server, 0, NULL) < 0) {
>> -        qpa_logerr (pa_context_errno (g->context),
>> -                    "pa_context_connect() failed\n");
>> -        goto fail;
>> -    }
>> -
>> -    pa_threaded_mainloop_lock (g->mainloop);
>> -
>> -    if (pa_threaded_mainloop_start (g->mainloop) < 0) {
>> -        goto unlock_and_fail;
>> -    }
>> -
>> -    for (;;) {
>> -        pa_context_state_t state;
>> -
>> -        state = pa_context_get_state (g->context);
>> -
>> -        if (state == PA_CONTEXT_READY) {
>> +    QTAILQ_FOREACH(c, &pa_conns, list) {
>> +        if (server == NULL || c->server == NULL ?
>> +            server == c->server :
>> +            strcmp(server, c->server) == 0) {
>> +            g->conn = c;
>>              break;
>>          }
>> -
>> -        if (!PA_CONTEXT_IS_GOOD (state)) {
>> -            qpa_logerr (pa_context_errno (g->context),
>> -                        "Wrong context state\n");
>> -            goto unlock_and_fail;
>> -        }
>> -
>> -        /* Wait until the context is ready */
>> -        pa_threaded_mainloop_wait (g->mainloop);
>> +    }
>> +    if (!g->conn) {
>> +        g->conn = qpa_conn_init(server);
>> +    }
>> +    if (!g->conn) {
>> +        g_free(g);
>> +        return NULL;
>>      }
>>
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> -
>> +    ++g->conn->refcount;
>>      return g;
>> +}
>>
>> -unlock_and_fail:
>> -    pa_threaded_mainloop_unlock (g->mainloop);
>> -fail:
>> -    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
>> -    qpa_audio_fini(g);
>> -    return NULL;
>> +static void qpa_conn_fini(PAConnection *c)
>> +{
>> +    if (c->mainloop) {
>> +        pa_threaded_mainloop_stop(c->mainloop);
>> +    }
>> +
>> +    if (c->context) {
>> +        pa_context_disconnect(c->context);
>> +        pa_context_unref(c->context);
>> +    }
>> +
>> +    if (c->mainloop) {
>> +        pa_threaded_mainloop_free(c->mainloop);
>> +    }
>> +
>> +    QTAILQ_REMOVE(&pa_conns, c, list);
>> +    g_free(c);
>>  }
>>
>>  static void qpa_audio_fini (void *opaque)
>>  {
>>      paaudio *g = opaque;
>> +    PAConnection *c = g->conn;
>>
>> -    if (g->mainloop) {
>> -        pa_threaded_mainloop_stop (g->mainloop);
>> -    }
>> -
>> -    if (g->context) {
>> -        pa_context_disconnect (g->context);
>> -        pa_context_unref (g->context);
>> -    }
>> -
>> -    if (g->mainloop) {
>> -        pa_threaded_mainloop_free (g->mainloop);
>> +    if (--c->refcount == 0) {
>> +        qpa_conn_fini(c);
>>      }
>>
>>      g_free(g);
>> --
>> 2.22.0
>>
>>
> 
> 


