Received: from eggs.gnu.org ([209.51.188.92]:37918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1grqJ6-0003eL-Tu
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1grqIx-0002bP-OR
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:29:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1grqIw-0002X5-Rl
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:29:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id a16so1330443wrv.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 12:29:46 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<c0642d4f64a82bf2c04c8b52095d11cf9263b5ad.1548714862.git.DirtY.iCE.hu@gmail.com>
	<87womn31ac.fsf@dusky.pond.sub.org>
Message-ID: <f5295fcf-56a1-3593-2ceb-065d88c1e742@gmail.com>
Date: Thu, 7 Feb 2019 21:29:43 +0100
MIME-Version: 1.0
In-Reply-To: <87womn31ac.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 04/14] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 2019-01-29 16:56, Markus Armbruster wrote:
> "Kővágó, Zoltán" <dirty.ice.hu@gmail.com> writes:
> 
>> Audio drivers now get an Audiodev * as config paramters, instead of the
>> global audio_option structs.  There is some code in audio/audio_legacy.c
>> that converts the old environment variables to audiodev options (this
>> way backends do not have to worry about legacy options).  It also
>> contains a replacement of -audio-help, which prints out the equivalent
>> -audiodev based config of the currently specified environment variables.
>>
>> Note that backends are not updated and still rely on environment
>> variables.
>>
>> Also note that (due to moving try-poll from global to backend specific
>> option) currently ALSA and OSS will always try poll mode, regardless of
>> environment variables or -audiodev options.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
> [...]
>> diff --git a/audio/audio.c b/audio/audio.c
>> index ce8e6ea8c2..b37c245a8a 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
> [...]
>> @@ -2129,3 +1866,145 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
>>          }
>>      }
>>  }
>> +
>> +static void audio_validate_per_direction_opts(
>> +    AudiodevPerDirectionOptions **pdo, bool *has_pdo, Error **errp)
>> +{
>> +    if (!*has_pdo) {
>> +        *pdo = g_malloc0(sizeof(AudiodevPerDirectionOptions));
>> +        *has_pdo = true;
>> +    }
>> +
>> +    if (!(*pdo)->has_fixed_settings) {
>> +        (*pdo)->has_fixed_settings = true;
>> +        (*pdo)->fixed_settings = true;
>> +    }
>> +    if (!(*pdo)->fixed_settings &&
>> +        ((*pdo)->has_frequency || (*pdo)->has_channels || (*pdo)->has_format)) {
>> +        error_setg(errp,
>> +                   "You can't use frequency, channels or format with fixed-settings=off");
>> +        return;
>> +    }
>> +
>> +    if (!(*pdo)->has_frequency) {
>> +        (*pdo)->has_frequency = true;
>> +        (*pdo)->frequency = 44100;
>> +    }
>> +    if (!(*pdo)->has_channels) {
>> +        (*pdo)->has_channels = true;
>> +        (*pdo)->channels = 2;
>> +    }
>> +    if (!(*pdo)->has_voices) {
>> +        (*pdo)->has_voices = true;
>> +        (*pdo)->voices = 1;
>> +    }
>> +    if (!(*pdo)->has_format) {
>> +        (*pdo)->has_format = true;
>> +        (*pdo)->format = AUDIO_FORMAT_S16;
>> +    }
>> +}
>> +
>> +static void audio_validate_opts(Audiodev *dev, Error **errp)
>> +{
>> +    Error *err = NULL;
>> +
>> +    audio_validate_per_direction_opts(&dev->in, &dev->has_in, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>> +    audio_validate_per_direction_opts(&dev->out, &dev->has_out, &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>> +    if (!dev->has_timer_period) {
>> +        dev->has_timer_period = true;
>> +        dev->timer_period = 10000; /* 100Hz -> 10ms */
>> +    }
>> +}
> 
> Drive-by question: this validates just the generic part of Audiodev gets
> validated, not the driver-specific part.  Is there nothing to validate?
> Does it happen somewhere else?

Driver specific validation/initialization happens in each driver's init
function (they're added in the upcoming patches).

>> +
>> +void audio_parse_option(const char *opt)
>> +{
>> +    AudiodevListEntry *e;
>> +    Audiodev *dev = NULL;
>> +
>> +    Visitor *v = qobject_input_visitor_new_str(opt, "driver", &error_fatal);
>> +    visit_type_Audiodev(v, NULL, &dev, &error_fatal);
>> +    visit_free(v);
>> +
>> +    audio_validate_opts(dev, &error_fatal);
>> +
>> +    e = g_malloc0(sizeof(AudiodevListEntry));
>> +    e->dev = dev;
>> +    QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
>> +}
>> +
>> +void audio_init_audiodevs(void)
>> +{
>> +    AudiodevListEntry *e;
>> +
>> +    QSIMPLEQ_FOREACH(e, &audiodevs, next) {
>> +        audio_init(e->dev);
>> +    }
>> +}
> 
> Your use of QAPI here looks good to me.
> 
> [...]
> 
