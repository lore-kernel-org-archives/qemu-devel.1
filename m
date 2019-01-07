Received: from eggs.gnu.org ([209.51.188.92]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1ggbow-0002ZV-LB
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 15:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1ggbom-0005eh-8d
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 15:48:19 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1ggbok-0005c8-4G
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 15:48:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so1869533wra.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 12:48:12 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<26b300d6c17e6ac015f1519d50151744cf806c03.1545598229.git.DirtY.iCE.hu@gmail.com>
	<87sgy4k3u7.fsf@dusky.pond.sub.org>
Message-ID: <b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
Date: Mon, 7 Jan 2019 21:48:06 +0100
MIME-Version: 1.0
In-Reply-To: <87sgy4k3u7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/52] audio: -audiodev command line
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

On 2019-01-07 14:13, Markus Armbruster wrote:
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
>> index 96cbd57c37..e7f25ea84b 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
> [...]
>> @@ -2127,3 +1841,158 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
>>          }
>>      }
>>  }
>> +
>> +QemuOptsList qemu_audiodev_opts = {
>> +    .name = "audiodev",
>> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_audiodev_opts.head),
>> +    .implied_opt_name = "driver",
>> +    .desc = {
>> +        /*
>> +         * no elements => accept any params
>> +         * sanity checking will happen later
>> +         */
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +static void validate_per_direction_opts(AudiodevPerDirectionOptions *pdo,
>> +                                        Error **errp)
>> +{
>> +    if (!pdo->has_fixed_settings) {
>> +        pdo->has_fixed_settings = true;
>> +        pdo->fixed_settings = true;
>> +    }
>> +    if (!pdo->fixed_settings &&
>> +        (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
>> +        error_setg(errp,
>> +                   "You can't use frequency, channels or format with fixed-settings=off");
>> +        return;
>> +    }
>> +
>> +    if (!pdo->has_frequency) {
>> +        pdo->has_frequency = true;
>> +        pdo->frequency = 44100;
>> +    }
>> +    if (!pdo->has_channels) {
>> +        pdo->has_channels = true;
>> +        pdo->channels = 2;
>> +    }
>> +    if (!pdo->has_voices) {
>> +        pdo->has_voices = true;
>> +        pdo->voices = 1;
>> +    }
>> +    if (!pdo->has_format) {
>> +        pdo->has_format = true;
>> +        pdo->format = AUDIO_FORMAT_S16;
>> +    }
>> +}
>> +
>> +static Audiodev *parse_option(QemuOpts *opts, Error **errp)
>> +{
>> +    Error *local_err = NULL;
>> +    Visitor *v = opts_visitor_new(opts, true);
>> +    Audiodev *dev = NULL;
>> +    visit_type_Audiodev(v, NULL, &dev, &local_err);
>> +    visit_free(v);
>> +
>> +    if (local_err) {
>> +        goto err2;
>> +    }
>> +
>> +    validate_per_direction_opts(dev->in, &local_err);
>> +    if (local_err) {
>> +        goto err;
>> +    }
>> +    validate_per_direction_opts(dev->out, &local_err);
>> +    if (local_err) {
>> +        goto err;
>> +    }
>> +
>> +    if (!dev->has_timer_period) {
>> +        dev->has_timer_period = true;
>> +        dev->timer_period = 10000; /* 100Hz -> 10ms */
>> +    }
>> +
>> +    return dev;
>> +
>> +err:
>> +    qapi_free_Audiodev(dev);
>> +err2:
>> +    error_propagate(errp, local_err);
>> +    return NULL;
>> +}
>> +
>> +static int each_option(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    Audiodev *dev = parse_option(opts, errp);
>> +    if (!dev) {
>> +        return -1;
>> +    }
>> +    return audio_init(dev);
>> +}
>> +
>> +void audio_set_options(void)
>> +{
>> +    if (qemu_opts_foreach(qemu_find_opts("audiodev"), each_option, NULL,
>> +                          &error_abort)) {
>> +        exit(1);
>> +    }
>> +}
> [...]
>> diff --git a/vl.c b/vl.c
>> index 8353d3c718..b5364ffe46 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3074,6 +3074,7 @@ int main(int argc, char **argv, char **envp)
>>      qemu_add_opts(&qemu_option_rom_opts);
>>      qemu_add_opts(&qemu_machine_opts);
>>      qemu_add_opts(&qemu_accel_opts);
>> +    qemu_add_opts(&qemu_audiodev_opts);
>>      qemu_add_opts(&qemu_mem_opts);
>>      qemu_add_opts(&qemu_smp_opts);
>>      qemu_add_opts(&qemu_boot_opts);
>> @@ -3307,9 +3308,15 @@ int main(int argc, char **argv, char **envp)
>>                  add_device_config(DEV_BT, optarg);
>>                  break;
>>              case QEMU_OPTION_audio_help:
>> -                AUD_help ();
>> +                audio_legacy_help();
>>                  exit (0);
>>                  break;
>> +            case QEMU_OPTION_audiodev:
>> +                if (!qemu_opts_parse_noisily(qemu_find_opts("audiodev"),
>> +                                             optarg, true)) {
>> +                    exit(1);
>> +                }
>> +                break;
>>              case QEMU_OPTION_soundhw:
>>                  select_soundhw (optarg);
>>                  break;
>> @@ -4545,6 +4552,8 @@ int main(int argc, char **argv, char **envp)
>>      /* do monitor/qmp handling at preconfig state if requested */
>>      main_loop();
>>  
>> +    audio_set_options();
>> +
>>      /* from here on runstate is RUN_STATE_PRELAUNCH */
>>      machine_run_board_init(current_machine);
> 
> This uses the options visitor, roughly like -netdev.  Depends on your
> options visitor enhancements.  Is there any particular reason not to do
> it like -blockdev and -display, with qobject_input_visitor_new_str()?
> I'm asking because I'd very much like new code to use
> qobject_input_visitor_new_str() rather than the options visitor.
> 
> Today, the options visitor looks like an evolutionary dead end.  My
> command-line qapification (still stuck at the RFC stage, hope to get it
> unstuck this year) relies on qobject_input_visitor_new_str().  The goal
> is to convert *all* of the command line to it.
> 
> I suspect your series uses the options visitor only because back when
> you started, qobject_input_visitor_new_str() didn't exist.
> 

Yes, this patch series is a bit old, and at that time this was the best
I could do. I can look into it this (probably only on the weekend
though), it looks like it supports foo.bar=something syntax, so I don't
have to specify a json on the command line...

Regards,
Zoltan
