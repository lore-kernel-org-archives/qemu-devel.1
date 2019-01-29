Received: from eggs.gnu.org ([209.51.188.92]:35493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goVkq-0001rf-Ba
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goVkp-0008AP-2e
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1goVko-00088x-Bu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:56:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<c0642d4f64a82bf2c04c8b52095d11cf9263b5ad.1548714862.git.DirtY.iCE.hu@gmail.com>
Date: Tue, 29 Jan 2019 16:56:43 +0100
In-Reply-To: <c0642d4f64a82bf2c04c8b52095d11cf9263b5ad.1548714862.git.DirtY.iCE.hu@gmail.com>
	(=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Mon,
	28 Jan 2019 23:43:27 +0100")
Message-ID: <87womn31ac.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

"K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:

> Audio drivers now get an Audiodev * as config paramters, instead of the
> global audio_option structs.  There is some code in audio/audio_legacy.c
> that converts the old environment variables to audiodev options (this
> way backends do not have to worry about legacy options).  It also
> contains a replacement of -audio-help, which prints out the equivalent
> -audiodev based config of the currently specified environment variables.
>
> Note that backends are not updated and still rely on environment
> variables.
>
> Also note that (due to moving try-poll from global to backend specific
> option) currently ALSA and OSS will always try poll mode, regardless of
> environment variables or -audiodev options.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
> ---
[...]
> diff --git a/audio/audio.c b/audio/audio.c
> index ce8e6ea8c2..b37c245a8a 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
[...]
> @@ -2129,3 +1866,145 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, =
uint8_t lvol, uint8_t rvol)
>          }
>      }
>  }
> +
> +static void audio_validate_per_direction_opts(
> +    AudiodevPerDirectionOptions **pdo, bool *has_pdo, Error **errp)
> +{
> +    if (!*has_pdo) {
> +        *pdo =3D g_malloc0(sizeof(AudiodevPerDirectionOptions));
> +        *has_pdo =3D true;
> +    }
> +
> +    if (!(*pdo)->has_fixed_settings) {
> +        (*pdo)->has_fixed_settings =3D true;
> +        (*pdo)->fixed_settings =3D true;
> +    }
> +    if (!(*pdo)->fixed_settings &&
> +        ((*pdo)->has_frequency || (*pdo)->has_channels || (*pdo)->has_fo=
rmat)) {
> +        error_setg(errp,
> +                   "You can't use frequency, channels or format with fix=
ed-settings=3Doff");
> +        return;
> +    }
> +
> +    if (!(*pdo)->has_frequency) {
> +        (*pdo)->has_frequency =3D true;
> +        (*pdo)->frequency =3D 44100;
> +    }
> +    if (!(*pdo)->has_channels) {
> +        (*pdo)->has_channels =3D true;
> +        (*pdo)->channels =3D 2;
> +    }
> +    if (!(*pdo)->has_voices) {
> +        (*pdo)->has_voices =3D true;
> +        (*pdo)->voices =3D 1;
> +    }
> +    if (!(*pdo)->has_format) {
> +        (*pdo)->has_format =3D true;
> +        (*pdo)->format =3D AUDIO_FORMAT_S16;
> +    }
> +}
> +
> +static void audio_validate_opts(Audiodev *dev, Error **errp)
> +{
> +    Error *err =3D NULL;
> +
> +    audio_validate_per_direction_opts(&dev->in, &dev->has_in, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    audio_validate_per_direction_opts(&dev->out, &dev->has_out, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (!dev->has_timer_period) {
> +        dev->has_timer_period =3D true;
> +        dev->timer_period =3D 10000; /* 100Hz -> 10ms */
> +    }
> +}

Drive-by question: this validates just the generic part of Audiodev gets
validated, not the driver-specific part.  Is there nothing to validate?
Does it happen somewhere else?

> +
> +void audio_parse_option(const char *opt)
> +{
> +    AudiodevListEntry *e;
> +    Audiodev *dev =3D NULL;
> +
> +    Visitor *v =3D qobject_input_visitor_new_str(opt, "driver", &error_f=
atal);
> +    visit_type_Audiodev(v, NULL, &dev, &error_fatal);
> +    visit_free(v);
> +
> +    audio_validate_opts(dev, &error_fatal);
> +
> +    e =3D g_malloc0(sizeof(AudiodevListEntry));
> +    e->dev =3D dev;
> +    QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
> +}
> +
> +void audio_init_audiodevs(void)
> +{
> +    AudiodevListEntry *e;
> +
> +    QSIMPLEQ_FOREACH(e, &audiodevs, next) {
> +        audio_init(e->dev);
> +    }
> +}

Your use of QAPI here looks good to me.

[...]
