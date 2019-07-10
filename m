Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE89AC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6A82064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVkyHLp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6A82064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlIkc-0004Q6-Q8
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 15:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjU-0002ca-6u
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIjS-0002RK-Ue
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIjS-0002Q9-Li
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:58:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so3763123wrs.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H7d6LfmK2OYaCLgpugrmjtdRqlURUcg42LdCb+7qkXM=;
 b=bVkyHLp+OCNjJnqYHteP4IoTZMQNc4Oc7uMUezZ+3MDWKWmsCLCgGXhxOcna4eJWrg
 Cx7XclSTpH+mKOqKxq/Zaf5qFA8DBpINnipdXB5hhtjWK3wTkza5yStHQ0sTEhh7A7Gy
 2rHAhA9HapavEPoOeOdsGAoBpd+sDtfFXzIQ5WDfeVQ4xttZpVLwzPuThtYNZfXqdwC0
 TFgLsu0FcNqmjiJ/vEggLnqgMYcmL00fP42cib8+DKCQ3RfNJ6fCwcMx3IXQhz2AMVOf
 +NQu2NrJnXpVNVX6NoDe46uckjNN+YD/Aj4eEDM/uSm4GZlzN1KrnGxkqYUUc39opQ7K
 ZEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H7d6LfmK2OYaCLgpugrmjtdRqlURUcg42LdCb+7qkXM=;
 b=d4rl/xsBWqfTDiokPrZahayaN8nA/MILD1bYLJAyx7u3eK2sT9glMU1vnTANpPzdoa
 bFNRIR6XkeD5hPVa2awdSMvFjrQtexcKVmenzN2X7uXgIx0SLuxEK0TD7beS0hfFRG2A
 1celRUzZ+3+ElQYxtcpSlZUQknOwyy0Vb+mdvTIXEUwb8y/d9uSsoBmo6vlxAQXDwoVF
 a4Uc5+2EyjvIF4eXUtuRYRIOaLf8xN2mmCVoy2YlSxRLdb9Msj4bixV89GY3WXK0MY1K
 R4AwzRW9p/vujIPczkENuPXq/dAVyYkJlBijgt33oo+ReYAxOycA85C56xJkaJFORXGk
 9TUA==
X-Gm-Message-State: APjAAAWIlBFqRnv/zQdwofj/7wP4EasrPcOdOk6IdtzDe5K+tV0FPTtl
 5Kezlj5rPa2oy68JF+LzrfxBbP/n0CQfuj5Qxh4=
X-Google-Smtp-Source: APXvYqzPdqc3Rrz7M/Pfid78AYwcH7xboYyrzjWYLxOzucc2osgIaRlRhHQ8/67INC2qkeLqU3GT7j5xHoOdjufjCGY=
X-Received: by 2002:adf:eac4:: with SMTP id o4mr27042610wrn.290.1562788705293; 
 Wed, 10 Jul 2019 12:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <185aa104b9cd1fbea627be06eefaf7cf29d67ad0.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <185aa104b9cd1fbea627be06eefaf7cf29d67ad0.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:58:13 +0400
Message-ID: <CAJ+F1C+Lqh7-i1P2Ry2rOeXbYiMNYkAmxheZ6UN2BWeJdMpwqA@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 08/11] audio: do not run each backend in
 audio_run
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

On Tue, Jul 9, 2019 at 10:51 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> audio_run is called manually by alsa and oss backends when polling.
> In this case only the requesting backend should be run, not all of them.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/audio_int.h |  2 +-
>  audio/alsaaudio.c |  7 +++++--
>  audio/audio.c     | 14 +++++---------
>  audio/ossaudio.c  | 12 ++++++------
>  4 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 9f01f6ad00..7e00c1332e 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -221,7 +221,7 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_=
buf,
>  int audio_bug (const char *funcname, int cond);
>  void *audio_calloc (const char *funcname, int nmemb, size_t size);
>
> -void audio_run (const char *msg);
> +void audio_run(AudioState *s, const char *msg);
>
>  #define VOICE_ENABLE 1
>  #define VOICE_DISABLE 2
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 6b9e0f06af..3daa7c8f8f 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -39,6 +39,7 @@ struct pollhlp {
>      struct pollfd *pfds;
>      int count;
>      int mask;
> +    AudioState *s;
>  };
>
>  typedef struct ALSAVoiceOut {
> @@ -199,11 +200,11 @@ static void alsa_poll_handler (void *opaque)
>          break;
>
>      case SND_PCM_STATE_PREPARED:
> -        audio_run ("alsa run (prepared)");
> +        audio_run(hlp->s, "alsa run (prepared)");
>          break;
>
>      case SND_PCM_STATE_RUNNING:
> -        audio_run ("alsa run (running)");
> +        audio_run(hlp->s, "alsa run (running)");
>          break;
>
>      default:
> @@ -749,6 +750,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
>          return -1;
>      }
>
> +    alsa->pollhlp.s =3D hw->s;
>      alsa->handle =3D handle;
>      alsa->dev =3D dev;
>      return 0;
> @@ -850,6 +852,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
>          return -1;
>      }
>
> +    alsa->pollhlp.s =3D hw->s;
>      alsa->handle =3D handle;
>      alsa->dev =3D dev;
>      return 0;
> diff --git a/audio/audio.c b/audio/audio.c
> index 6bf30ac9b3..d73cc086b6 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -835,7 +835,7 @@ static void audio_timer (void *opaque)
>      }
>      s->timer_last =3D now;
>
> -    audio_run("timer");
> +    audio_run(s, "timer");
>      audio_reset_timer(s);
>  }
>
> @@ -1237,15 +1237,11 @@ static void audio_run_capture (AudioState *s)
>      }
>  }
>
> -void audio_run (const char *msg)
> +void audio_run(AudioState *s, const char *msg)
>  {
> -    AudioState *s;
> -
> -    QTAILQ_FOREACH(s, &audio_states, list) {
> -        audio_run_out(s);
> -        audio_run_in(s);
> -        audio_run_capture(s);
> -    }
> +    audio_run_out(s);
> +    audio_run_in(s);
> +    audio_run_capture(s);
>
>  #ifdef DEBUG_POLL
>      {
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 29139ef1f5..456fba7480 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -110,28 +110,28 @@ static void oss_anal_close (int *fdp)
>
>  static void oss_helper_poll_out (void *opaque)
>  {
> -    (void) opaque;
> -    audio_run ("oss_poll_out");
> +    AudioState *s =3D opaque;
> +    audio_run(s, "oss_poll_out");
>  }
>
>  static void oss_helper_poll_in (void *opaque)
>  {
> -    (void) opaque;
> -    audio_run ("oss_poll_in");
> +    AudioState *s =3D opaque;
> +    audio_run(s, "oss_poll_in");
>  }
>
>  static void oss_poll_out (HWVoiceOut *hw)
>  {
>      OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
>
> -    qemu_set_fd_handler (oss->fd, NULL, oss_helper_poll_out, NULL);
> +    qemu_set_fd_handler(oss->fd, NULL, oss_helper_poll_out, hw->s);
>  }
>
>  static void oss_poll_in (HWVoiceIn *hw)
>  {
>      OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
>
> -    qemu_set_fd_handler (oss->fd, oss_helper_poll_in, NULL, NULL);
> +    qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
>  }
>
>  static int oss_write (SWVoiceOut *sw, void *buf, int len)
> --
> 2.22.0
>
>


--
Marc-Andr=C3=A9 Lureau

