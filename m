Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED0C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5250B2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI0ZORCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5250B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlImf-0000G4-I3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIja-0002pV-AG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjY-0002Ws-6n
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIjX-0002WH-V6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id p13so3727255wru.10
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OnYAvrTpS2BRRGWc1xmVZdXr5Nei3fk/A5VT1VHtjds=;
 b=OI0ZORCtDBoFjVD0ewi3YRgewXy/w6YulZqHL2qhja5zzyHwkbOQtiLZ+2nSq0P1LC
 pgPTnHWsO9PiIT/c88rVi2htUuBc7DveHN5nQc56ydZleI+lslt5YmxVUfbfzsmVBTLd
 OaGA+GpTj3mKiOi1GNxYUFQ0MhWRGZLkEfwD9Kcpal1Zh1Dn5jNoskIHxHDp9qPjp23e
 QNugAUxhAIpdBFAAtNA612EtplevscpG8FvCD7J7+5bAQb98Gp+mbH5dgo1Lhs3IC4xg
 Xwo1p6ZBYqHw7ZI6UR877pwE7LLPQ9ZS+0+FlaylCh5wPugHWaCJNGv4NAI4cY9p3tcS
 sb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OnYAvrTpS2BRRGWc1xmVZdXr5Nei3fk/A5VT1VHtjds=;
 b=FLRpGfzzilMMK2Du6aGkIIv2PB3FjwKQJYHTjGD+5MzCqtGC9d4x+523J0LujWRAX0
 gUTjSjaW9a5eiVLlOO/01uee5YMOyiQ3T8uyxkfNm0/MSnops2BHkhYF8Sq+99LBXVrQ
 WGpa87j6d3HkCf0pagofMOluux5CVZ3ZQA3LXUY5fMMIiN0YZj9DJ9JztwFgwToC6OBm
 KpF3UU/fD3ogBnjs/ayHV62wkoqTt857Y4qC2rNb0dODI1ePRybGEDNQq1xpmDyx4OAM
 aMuTC54J1Yd4M8ZRxQgFNFyC/4iiJu/VCqAuA12HLjpYG0e1Wz8XcAGWMLnDvvbzI//J
 sf9A==
X-Gm-Message-State: APjAAAUfMvBAjTUmT1upsoXzXQvlFFKxaBvAWk2U0YdWZoeKkRD273D0
 MvPihlI+60WLHrGKXkXe05ut6R4/f09oTuWlO6A=
X-Google-Smtp-Source: APXvYqwiJCCLHswBWx8XP3dKkj1Hg0NOrh4JAMr+gHs9+UPYws/f5Fa3OVJyKr205UC0/2pWpMvMb8eVl8RoQ1cjAeU=
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr32294136wrm.100.1562788710956; 
 Wed, 10 Jul 2019 12:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:58:18 +0400
Message-ID: <CAJ+F1CLbHktECo+86kXBe8jMsCLX0N50C_48i5Xp3NzbsDNaQg@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 02/11] audio: basic support for multi
 backend audio
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 11:02 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> Audio functions no longer access glob_audio_state, instead they get an
> AudioState as a parameter.  This is required in order to support
> multiple backends.
>
> glob_audio_state is also gone, and replaced with a tailq so we can store
> more than one states.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>


I guess you could have made the vnc and wavcapture audiodev argument a
seperate commit. Or mention it in commit message.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




> ---
>  audio/audio.h          |  12 +++--
>  audio/audio_int.h      |   2 +
>  audio/audio_template.h |   2 +-
>  ui/vnc.h               |   2 +
>  audio/audio.c          | 102 +++++++++++++++++++++++++++++++----------
>  audio/wavcapture.c     |   6 +--
>  monitor/misc.c         |  12 ++++-
>  ui/vnc.c               |  15 +++++-
>  hmp-commands.hx        |  11 +++--
>  qemu-options.hx        |   5 ++
>  10 files changed, 131 insertions(+), 38 deletions(-)
>
> diff --git a/audio/audio.h b/audio/audio.h
> index 64b0f761bc..ad2457f4de 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -78,8 +78,10 @@ typedef struct SWVoiceOut SWVoiceOut;
>  typedef struct CaptureVoiceOut CaptureVoiceOut;
>  typedef struct SWVoiceIn SWVoiceIn;
>
> +typedef struct AudioState AudioState;
>  typedef struct QEMUSoundCard {
>      char *name;
> +    AudioState *state;
>      QLIST_ENTRY (QEMUSoundCard) entries;
>  } QEMUSoundCard;
>
> @@ -92,7 +94,8 @@ void AUD_log (const char *cap, const char *fmt, ...) GC=
C_FMT_ATTR(2, 3);
>
>  void AUD_register_card (const char *name, QEMUSoundCard *card);
>  void AUD_remove_card (QEMUSoundCard *card);
> -CaptureVoiceOut *AUD_add_capture (
> +CaptureVoiceOut *AUD_add_capture(
> +    AudioState *s,
>      struct audsettings *as,
>      struct audio_capture_ops *ops,
>      void *opaque
> @@ -160,8 +163,8 @@ static inline void *advance (void *p, int incr)
>  #define audio_MAX(a, b) ((a)<(b)?(b):(a))
>  #endif
>
> -int wav_start_capture (CaptureState *s, const char *path, int freq,
> -                       int bits, int nchannels);
> +int wav_start_capture(AudioState *state, CaptureState *s, const char *pa=
th,
> +                      int freq, int bits, int nchannels);
>
>  bool audio_is_cleaning_up(void);
>  void audio_cleanup(void);
> @@ -175,4 +178,7 @@ void audio_parse_option(const char *opt);
>  void audio_init_audiodevs(void);
>  void audio_legacy_help(void);
>
> +AudioState *audio_state_by_name(const char *name);
> +const char *audio_get_id(QEMUSoundCard *card);
> +
>  #endif /* QEMU_AUDIO_H */
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 8164696b2c..9f01f6ad00 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -196,6 +196,8 @@ typedef struct AudioState {
>
>      bool timer_running;
>      uint64_t timer_last;
> +
> +    QTAILQ_ENTRY(AudioState) list;
>  } AudioState;
>
>  extern const struct mixeng_volume nominal_volume;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index c721fed75d..54f07338e7 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -428,7 +428,7 @@ SW *glue (AUD_open_, TYPE) (
>      struct audsettings *as
>      )
>  {
> -    AudioState *s =3D &glob_audio_state;
> +    AudioState *s =3D card->state;
>      AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(s->d=
ev);
>
>      if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 2f84db3142..6f54653455 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -183,6 +183,8 @@ struct VncDisplay
>  #ifdef CONFIG_VNC_SASL
>      VncDisplaySASL sasl;
>  #endif
> +
> +    AudioState *audio_state;
>  };
>
>  typedef struct VncTight {
> diff --git a/audio/audio.c b/audio/audio.c
> index 8d2f580788..e9dd7c8b32 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -87,7 +87,8 @@ audio_driver *audio_driver_lookup(const char *name)
>      return NULL;
>  }
>
> -static AudioState glob_audio_state;
> +static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =3D
> +    QTAILQ_HEAD_INITIALIZER(audio_states);
>
>  const struct mixeng_volume nominal_volume =3D {
>      .mute =3D 0,
> @@ -1236,11 +1237,14 @@ static void audio_run_capture (AudioState *s)
>
>  void audio_run (const char *msg)
>  {
> -    AudioState *s =3D &glob_audio_state;
> +    AudioState *s;
> +
> +    QTAILQ_FOREACH(s, &audio_states, list) {
> +        audio_run_out(s);
> +        audio_run_in(s);
> +        audio_run_capture(s);
> +    }
>
> -    audio_run_out (s);
> -    audio_run_in (s);
> -    audio_run_capture (s);
>  #ifdef DEBUG_POLL
>      {
>          static double prevtime;
> @@ -1304,13 +1308,11 @@ bool audio_is_cleaning_up(void)
>      return is_cleaning_up;
>  }
>
> -void audio_cleanup(void)
> +static void free_audio_state(AudioState *s)
>  {
> -    AudioState *s =3D &glob_audio_state;
>      HWVoiceOut *hwo, *hwon;
>      HWVoiceIn *hwi, *hwin;
>
> -    is_cleaning_up =3D true;
>      QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
>          SWVoiceCap *sc;
>
> @@ -1347,6 +1349,17 @@ void audio_cleanup(void)
>          qapi_free_Audiodev(s->dev);
>          s->dev =3D NULL;
>      }
> +    g_free(s);
> +}
> +
> +void audio_cleanup(void)
> +{
> +    is_cleaning_up =3D true;
> +    while (!QTAILQ_EMPTY(&audio_states)) {
> +        AudioState *s =3D QTAILQ_FIRST(&audio_states);
> +        QTAILQ_REMOVE(&audio_states, s, list);
> +        free_audio_state(s);
> +    }
>  }
>
>  static const VMStateDescription vmstate_audio =3D {
> @@ -1373,28 +1386,33 @@ static AudiodevListEntry *audiodev_find(
>      return NULL;
>  }
>
> -static int audio_init(Audiodev *dev)
> +/*
> + * if we have dev, this function was called because of an -audiodev argu=
ment =3D>
> + *   initialize a new state with it
> + * if dev =3D=3D NULL =3D> legacy implicit initialization, return the al=
ready created
> + *   state or create a new one
> + */
> +static AudioState *audio_init(Audiodev *dev)
>  {
> +    static bool atexit_registered;
>      size_t i;
>      int done =3D 0;
>      const char *drvname =3D NULL;
>      VMChangeStateEntry *e;
> -    AudioState *s =3D &glob_audio_state;
> +    AudioState *s;
>      struct audio_driver *driver;
>      /* silence gcc warning about uninitialized variable */
>      AudiodevListHead head =3D QSIMPLEQ_HEAD_INITIALIZER(head);
>
> -    if (s->drv) {
> -        if (dev) {
> -            dolog("Cannot create more than one audio backend, sorry\n");
> -            qapi_free_Audiodev(dev);
> -        }
> -        return -1;
> -    }
> -
>      if (dev) {
>          /* -audiodev option */
>          drvname =3D AudiodevDriver_str(dev->driver);
> +    } else if (!QTAILQ_EMPTY(&audio_states)) {
> +        /*
> +         * todo: check for -audiodev once we have normal audiodev select=
ion
> +         * support
> +         */
> +        return QTAILQ_FIRST(&audio_states);
>      } else {
>          /* legacy implicit initialization */
>          head =3D audio_handle_legacy_opts();
> @@ -1408,12 +1426,18 @@ static int audio_init(Audiodev *dev)
>          dev =3D QSIMPLEQ_FIRST(&head)->dev;
>          audio_validate_opts(dev, &error_abort);
>      }
> +
> +    s =3D g_malloc0(sizeof(AudioState));
>      s->dev =3D dev;
>
>      QLIST_INIT (&s->hw_head_out);
>      QLIST_INIT (&s->hw_head_in);
>      QLIST_INIT (&s->cap_head);
> -    atexit(audio_cleanup);
> +    if (!atexit_registered) {
> +        atexit(audio_cleanup);
> +        atexit_registered =3D true;
> +    }
> +    QTAILQ_INSERT_TAIL(&audio_states, s, list);
>
>      s->ts =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
>
> @@ -1478,7 +1502,7 @@ static int audio_init(Audiodev *dev)
>
>      QLIST_INIT (&s->card_head);
>      vmstate_register (NULL, 0, &vmstate_audio, s);
> -    return 0;
> +    return s;
>  }
>
>  void audio_free_audiodev_list(AudiodevListHead *head)
> @@ -1493,10 +1517,13 @@ void audio_free_audiodev_list(AudiodevListHead *h=
ead)
>
>  void AUD_register_card (const char *name, QEMUSoundCard *card)
>  {
> -    audio_init(NULL);
> +    if (!card->state) {
> +        card->state =3D audio_init(NULL);
> +    }
> +
>      card->name =3D g_strdup (name);
>      memset (&card->entries, 0, sizeof (card->entries));
> -    QLIST_INSERT_HEAD (&glob_audio_state.card_head, card, entries);
> +    QLIST_INSERT_HEAD (&card->state->card_head, card, entries);
>  }
>
>  void AUD_remove_card (QEMUSoundCard *card)
> @@ -1506,16 +1533,21 @@ void AUD_remove_card (QEMUSoundCard *card)
>  }
>
>
> -CaptureVoiceOut *AUD_add_capture (
> +CaptureVoiceOut *AUD_add_capture(
> +    AudioState *s,
>      struct audsettings *as,
>      struct audio_capture_ops *ops,
>      void *cb_opaque
>      )
>  {
> -    AudioState *s =3D &glob_audio_state;
>      CaptureVoiceOut *cap;
>      struct capture_callback *cb;
>
> +    if (!s) {
> +        /* todo: remove when we have normal audiodev selection support *=
/
> +        s =3D audio_init(NULL);
> +    }
> +
>      if (audio_validate_settings (as)) {
>          dolog ("Invalid settings were passed when trying to add capture\=
n");
>          audio_print_settings (as);
> @@ -1805,3 +1837,25 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions=
 *pdo,
>      return audio_buffer_samples(pdo, as, def_usecs) *
>          audioformat_bytes_per_sample(as->fmt);
>  }
> +
> +AudioState *audio_state_by_name(const char *name)
> +{
> +    AudioState *s;
> +    QTAILQ_FOREACH(s, &audio_states, list) {
> +        assert(s->dev);
> +        if (strcmp(name, s->dev->id) =3D=3D 0) {
> +            return s;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +const char *audio_get_id(QEMUSoundCard *card)
> +{
> +    if (card->state) {
> +        assert(card->state->dev);
> +        return card->state->dev->id;
> +    } else {
> +        return "";
> +    }
> +}
> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> index 74320dfecc..81c5c19032 100644
> --- a/audio/wavcapture.c
> +++ b/audio/wavcapture.c
> @@ -105,8 +105,8 @@ static struct capture_ops wav_capture_ops =3D {
>      .info =3D wav_capture_info
>  };
>
> -int wav_start_capture (CaptureState *s, const char *path, int freq,
> -                       int bits, int nchannels)
> +int wav_start_capture(AudioState *state, CaptureState *s, const char *pa=
th,
> +                      int freq, int bits, int nchannels)
>  {
>      WAVState *wav;
>      uint8_t hdr[] =3D {
> @@ -171,7 +171,7 @@ int wav_start_capture (CaptureState *s, const char *p=
ath, int freq,
>          goto error_free;
>      }
>
> -    cap =3D AUD_add_capture (&as, &ops, wav);
> +    cap =3D AUD_add_capture(state, &as, &ops, wav);
>      if (!cap) {
>          error_report("Failed to add audio capture");
>          goto error_free;
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 00338c002a..f97810d370 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -1148,7 +1148,17 @@ static void hmp_wavcapture(Monitor *mon, const QDi=
ct *qdict)
>      int bits =3D qdict_get_try_int(qdict, "bits", -1);
>      int has_channels =3D qdict_haskey(qdict, "nchannels");
>      int nchannels =3D qdict_get_try_int(qdict, "nchannels", -1);
> +    const char *audiodev =3D qdict_get_try_str(qdict, "audiodev");
>      CaptureState *s;
> +    AudioState *as =3D NULL;
> +
> +    if (audiodev) {
> +        as =3D audio_state_by_name(audiodev);
> +        if (!as) {
> +            monitor_printf(mon, "Invalid audiodev specified\n");
> +            return;
> +        }
> +    }
>
>      s =3D g_malloc0 (sizeof (*s));
>
> @@ -1156,7 +1166,7 @@ static void hmp_wavcapture(Monitor *mon, const QDic=
t *qdict)
>      bits =3D has_bits ? bits : 16;
>      nchannels =3D has_channels ? nchannels : 2;
>
> -    if (wav_start_capture (s, path, freq, bits, nchannels)) {
> +    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
>          monitor_printf(mon, "Failed to add wave capture\n");
>          g_free (s);
>          return;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 38f92bfca3..24f9be5b5d 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
>      ops.destroy =3D audio_capture_destroy;
>      ops.capture =3D audio_capture;
>
> -    vs->audio_cap =3D AUD_add_capture(&vs->as, &ops, vs);
> +    vs->audio_cap =3D AUD_add_capture(vs->vd->audio_state, &vs->as, &ops=
, vs);
>      if (!vs->audio_cap) {
>          error_report("Failed to add audio capture");
>      }
> @@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts =3D {
>          },{
>              .name =3D "non-adaptive",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "audiodev",
> +            .type =3D QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> @@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **errp)
>      const char *saslauthz;
>      int lock_key_sync =3D 1;
>      int key_delay_ms;
> +    const char *audiodev;
>
>      if (!vd) {
>          error_setg(errp, "VNC display not active");
> @@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **errp=
)
>      }
>      vd->ledstate =3D 0;
>
> +    audiodev =3D qemu_opt_get(opts, "audiodev");
> +    if (audiodev) {
> +        vd->audio_state =3D audio_state_by_name(audiodev);
> +        if (!vd->audio_state) {
> +            error_setg(errp, "Audiodev '%s' not found", audiodev);
> +            goto fail;
> +        }
> +    }
> +
>      device_id =3D qemu_opt_get(opts, "display");
>      if (device_id) {
>          int head =3D qemu_opt_get_number(opts, "head", 0);
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index bfa5681dd2..23196da3fe 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -819,16 +819,17 @@ ETEXI
>
>      {
>          .name       =3D "wavcapture",
> -        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?",
> -        .params     =3D "path [frequency [bits [channels]]]",
> +        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?=
",
> +        .params     =3D "path [frequency [bits [channels [audiodev]]]]",
>          .help       =3D "capture audio to a wave file (default frequency=
=3D44100 bits=3D16 channels=3D2)",
>          .cmd        =3D hmp_wavcapture,
>      },
>  STEXI
> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{chann=
els}]]]
> +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{chann=
els} [@var{audiodev}]]]]
>  @findex wavcapture
> -Capture audio into @var{filename}. Using sample rate @var{frequency}
> -bits per sample @var{bits} and number of channels @var{channels}.
> +Capture audio into @var{filename} from @var{audiodev}. Using sample rate
> +@var{frequency} bits per sample @var{bits} and number of channels
> +@var{channels}.
>
>  Defaults:
>  @itemize @minus
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..0111055aa4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1978,6 +1978,11 @@ can help the device and guest to keep up and not l=
ose events in case
>  events are arriving in bulk.  Possible causes for the latter are flaky
>  network connections, or scripts for automated testing.
>
> +@item audiodev=3D@var{audiodev}
> +
> +Use the specified @var{audiodev} when the VNC client requests audio
> +transmission.
> +
>  @end table
>  ETEXI
>
> --
> 2.22.0
>
>


--
Marc-Andr=C3=A9 Lureau

