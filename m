Received: from eggs.gnu.org ([209.51.188.92]:50392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gyRii-0000HU-Mr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 20:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gyRih-0008BY-OE
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 20:39:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gyRih-00086Z-GG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 20:39:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id r5so12054045wrg.9
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 17:39:42 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<cf14255c576fd361c6cdf941f8c637e613f6cb68.1550698466.git.DirtY.iCE.hu@gmail.com>
Message-ID: <63250655-a4a3-ef36-5882-65188093ff57@gmail.com>
Date: Tue, 26 Feb 2019 02:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <cf14255c576fd361c6cdf941f8c637e613f6cb68.1550698466.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 04/14] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-02-20 22:37, Kővágó, Zoltán wrote:
[...]
> diff --git a/audio/audio.c b/audio/audio.c
> index ce8e6ea8c2..8ad8cbe559 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
[...]
> @@ -2129,3 +1866,170 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
>          }
>      }
>  }
> +
> +void audio_create_pdos(Audiodev *dev)
> +{
> +    switch (dev->driver) {
> +#define CASE(DRIVER, driver, pdo_name)                              \
> +    case AUDIODEV_DRIVER_##DRIVER:                                  \
> +        dev->u.driver.in = g_malloc0(                               \
> +            sizeof(Audiodev##pdo_name##PerDirectionOptions));       \
This should check has_in before overwriting. It'll work correctly when
called from audio_legacy.c, but when using -audiodev it will overwrite
the options passed by user (and leak memory) when called from
audio_validate_opts. I'll fix it in the next update.

> +        dev->u.driver.has_in = true;                                \
> +        dev->u.driver.out = g_malloc0(                              \
> +            sizeof(AudiodevAlsaPerDirectionOptions));               \
> +        dev->u.driver.has_out = true;                               \
> +        break
> +
> +        CASE(NONE, none, );
> +        CASE(ALSA, alsa, Alsa);
> +        CASE(COREAUDIO, coreaudio, Coreaudio);
> +        CASE(DSOUND, dsound, );
> +        CASE(OSS, oss, Oss);
> +        CASE(PA, pa, Pa);
> +        CASE(SDL, sdl, );
> +        CASE(SPICE, spice, );
> +        CASE(WAV, wav, );
> +
> +    case AUDIODEV_DRIVER__MAX:
> +        abort();
> +    };
> +}
> +
> +static void audio_validate_per_direction_opts(
> +    AudiodevPerDirectionOptions *pdo, Error **errp)
> +{
> +    if (!pdo->has_fixed_settings) {
> +        pdo->has_fixed_settings = true;
> +        pdo->fixed_settings = true;
> +    }
> +    if (!pdo->fixed_settings &&
> +        (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
> +        error_setg(errp,
> +                   "You can't use frequency, channels or format with fixed-settings=off");
> +        return;
> +    }
> +
> +    if (!pdo->has_frequency) {
> +        pdo->has_frequency = true;
> +        pdo->frequency = 44100;
> +    }
> +    if (!pdo->has_channels) {
> +        pdo->has_channels = true;
> +        pdo->channels = 2;
> +    }
> +    if (!pdo->has_voices) {
> +        pdo->has_voices = true;
> +        pdo->voices = 1;
> +    }
> +    if (!pdo->has_format) {
> +        pdo->has_format = true;
> +        pdo->format = AUDIO_FORMAT_S16;
> +    }
> +}
> +
> +static void audio_validate_opts(Audiodev *dev, Error **errp)
> +{
> +    Error *err = NULL;
> +
> +    audio_create_pdos(dev);
> +
> +    audio_validate_per_direction_opts(audio_get_pdo_in(dev), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    audio_validate_per_direction_opts(audio_get_pdo_out(dev), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (!dev->has_timer_period) {
> +        dev->has_timer_period = true;
> +        dev->timer_period = 10000; /* 100Hz -> 10ms */
> +    }
> +}
> +
> +void audio_parse_option(const char *opt)
> +{
> +    AudiodevListEntry *e;
> +    Audiodev *dev = NULL;
> +
> +    Visitor *v = qobject_input_visitor_new_str(opt, "driver", &error_fatal);
> +    visit_type_Audiodev(v, NULL, &dev, &error_fatal);
> +    visit_free(v);
> +
> +    audio_validate_opts(dev, &error_fatal);
> +
> +    e = g_malloc0(sizeof(AudiodevListEntry));
> +    e->dev = dev;
> +    QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
> +}
> +
[...]

Regards,
Zoltan
