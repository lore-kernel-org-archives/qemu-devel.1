Received: from eggs.gnu.org ([209.51.188.92]:36945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggiHo-00035F-EE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 22:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggiHn-0004vI-9E
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 22:42:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ggiHn-0004v0-19
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 22:42:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<26b300d6c17e6ac015f1519d50151744cf806c03.1545598229.git.DirtY.iCE.hu@gmail.com>
	<87sgy4k3u7.fsf@dusky.pond.sub.org>
	<b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
Date: Tue, 08 Jan 2019 04:42:34 +0100
In-Reply-To: <b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
	(=?utf-8?B?IlpvbHTDoW4JS8WRdsOhZ8OzIidz?= message of "Mon, 7 Jan 2019
	21:48:06 +0100")
Message-ID: <87va2zg6hh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

"Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3" <dirty.ice.hu@gmail.com> writes:

> On 2019-01-07 14:13, Markus Armbruster wrote:
>> "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:
>>=20
>>> Audio drivers now get an Audiodev * as config paramters, instead of the
>>> global audio_option structs.  There is some code in audio/audio_legacy.c
>>> that converts the old environment variables to audiodev options (this
>>> way backends do not have to worry about legacy options).  It also
>>> contains a replacement of -audio-help, which prints out the equivalent
>>> -audiodev based config of the currently specified environment variables.
>>>
>>> Note that backends are not updated and still rely on environment
>>> variables.
>>>
>>> Also note that (due to moving try-poll from global to backend specific
>>> option) currently ALSA and OSS will always try poll mode, regardless of
>>> environment variables or -audiodev options.
>>>
>>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
>>> ---
>> [...]
>>> diff --git a/audio/audio.c b/audio/audio.c
>>> index 96cbd57c37..e7f25ea84b 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>> [...]
>>> @@ -2127,3 +1841,158 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute=
, uint8_t lvol, uint8_t rvol)
>>>          }
>>>      }
>>>  }
>>> +
>>> +QemuOptsList qemu_audiodev_opts =3D {
>>> +    .name =3D "audiodev",
>>> +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_audiodev_opts.head),
>>> +    .implied_opt_name =3D "driver",
>>> +    .desc =3D {
>>> +        /*
>>> +         * no elements =3D> accept any params
>>> +         * sanity checking will happen later
>>> +         */
>>> +        { /* end of list */ }
>>> +    },
>>> +};
>>> +
>>> +static void validate_per_direction_opts(AudiodevPerDirectionOptions *p=
do,
>>> +                                        Error **errp)
>>> +{
>>> +    if (!pdo->has_fixed_settings) {
>>> +        pdo->has_fixed_settings =3D true;
>>> +        pdo->fixed_settings =3D true;
>>> +    }
>>> +    if (!pdo->fixed_settings &&
>>> +        (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
>>> +        error_setg(errp,
>>> +                   "You can't use frequency, channels or format with f=
ixed-settings=3Doff");
>>> +        return;
>>> +    }
>>> +
>>> +    if (!pdo->has_frequency) {
>>> +        pdo->has_frequency =3D true;
>>> +        pdo->frequency =3D 44100;
>>> +    }
>>> +    if (!pdo->has_channels) {
>>> +        pdo->has_channels =3D true;
>>> +        pdo->channels =3D 2;
>>> +    }
>>> +    if (!pdo->has_voices) {
>>> +        pdo->has_voices =3D true;
>>> +        pdo->voices =3D 1;
>>> +    }
>>> +    if (!pdo->has_format) {
>>> +        pdo->has_format =3D true;
>>> +        pdo->format =3D AUDIO_FORMAT_S16;
>>> +    }
>>> +}
>>> +
>>> +static Audiodev *parse_option(QemuOpts *opts, Error **errp)
>>> +{
>>> +    Error *local_err =3D NULL;
>>> +    Visitor *v =3D opts_visitor_new(opts, true);
>>> +    Audiodev *dev =3D NULL;
>>> +    visit_type_Audiodev(v, NULL, &dev, &local_err);
>>> +    visit_free(v);
>>> +
>>> +    if (local_err) {
>>> +        goto err2;
>>> +    }
>>> +
>>> +    validate_per_direction_opts(dev->in, &local_err);
>>> +    if (local_err) {
>>> +        goto err;
>>> +    }
>>> +    validate_per_direction_opts(dev->out, &local_err);
>>> +    if (local_err) {
>>> +        goto err;
>>> +    }
>>> +
>>> +    if (!dev->has_timer_period) {
>>> +        dev->has_timer_period =3D true;
>>> +        dev->timer_period =3D 10000; /* 100Hz -> 10ms */
>>> +    }
>>> +
>>> +    return dev;
>>> +
>>> +err:
>>> +    qapi_free_Audiodev(dev);
>>> +err2:
>>> +    error_propagate(errp, local_err);
>>> +    return NULL;
>>> +}
>>> +
>>> +static int each_option(void *opaque, QemuOpts *opts, Error **errp)
>>> +{
>>> +    Audiodev *dev =3D parse_option(opts, errp);
>>> +    if (!dev) {
>>> +        return -1;
>>> +    }
>>> +    return audio_init(dev);
>>> +}
>>> +
>>> +void audio_set_options(void)
>>> +{
>>> +    if (qemu_opts_foreach(qemu_find_opts("audiodev"), each_option, NUL=
L,
>>> +                          &error_abort)) {
>>> +        exit(1);
>>> +    }
>>> +}
>> [...]
>>> diff --git a/vl.c b/vl.c
>>> index 8353d3c718..b5364ffe46 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -3074,6 +3074,7 @@ int main(int argc, char **argv, char **envp)
>>>      qemu_add_opts(&qemu_option_rom_opts);
>>>      qemu_add_opts(&qemu_machine_opts);
>>>      qemu_add_opts(&qemu_accel_opts);
>>> +    qemu_add_opts(&qemu_audiodev_opts);
>>>      qemu_add_opts(&qemu_mem_opts);
>>>      qemu_add_opts(&qemu_smp_opts);
>>>      qemu_add_opts(&qemu_boot_opts);
>>> @@ -3307,9 +3308,15 @@ int main(int argc, char **argv, char **envp)
>>>                  add_device_config(DEV_BT, optarg);
>>>                  break;
>>>              case QEMU_OPTION_audio_help:
>>> -                AUD_help ();
>>> +                audio_legacy_help();
>>>                  exit (0);
>>>                  break;
>>> +            case QEMU_OPTION_audiodev:
>>> +                if (!qemu_opts_parse_noisily(qemu_find_opts("audiodev"=
),
>>> +                                             optarg, true)) {
>>> +                    exit(1);
>>> +                }
>>> +                break;
>>>              case QEMU_OPTION_soundhw:
>>>                  select_soundhw (optarg);
>>>                  break;
>>> @@ -4545,6 +4552,8 @@ int main(int argc, char **argv, char **envp)
>>>      /* do monitor/qmp handling at preconfig state if requested */
>>>      main_loop();
>>>=20=20
>>> +    audio_set_options();
>>> +
>>>      /* from here on runstate is RUN_STATE_PRELAUNCH */
>>>      machine_run_board_init(current_machine);
>>=20
>> This uses the options visitor, roughly like -netdev.  Depends on your
>> options visitor enhancements.  Is there any particular reason not to do
>> it like -blockdev and -display, with qobject_input_visitor_new_str()?
>> I'm asking because I'd very much like new code to use
>> qobject_input_visitor_new_str() rather than the options visitor.
>>=20
>> Today, the options visitor looks like an evolutionary dead end.  My
>> command-line qapification (still stuck at the RFC stage, hope to get it
>> unstuck this year) relies on qobject_input_visitor_new_str().  The goal
>> is to convert *all* of the command line to it.
>>=20
>> I suspect your series uses the options visitor only because back when
>> you started, qobject_input_visitor_new_str() didn't exist.
>>=20
>
> Yes, this patch series is a bit old, and at that time this was the best
> I could do. I can look into it this (probably only on the weekend
> though), it looks like it supports foo.bar=3Dsomething syntax, so I don't
> have to specify a json on the command line...

The dotted key syntax and how it relates to JSON is documented in
util/keyval.c.

If you have further questions on this stuff, please don't hesitate to
ask me.

If you get to the point where you feel your (beefy) series has gotten
stuck on the conversion away from the options visitor, let's discuss how
to best get it unstuck.

Thanks!
