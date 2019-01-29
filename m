Received: from eggs.gnu.org ([209.51.188.92]:34011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goVgs-0006ZI-R3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goVgr-0006fT-PU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:52:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1goVgr-0006ep-ER
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:52:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<2ea7c5fe169dc201b4f3276f02d93e65aa9780fe.1548714862.git.DirtY.iCE.hu@gmail.com>
Date: Tue, 29 Jan 2019 16:52:41 +0100
In-Reply-To: <2ea7c5fe169dc201b4f3276f02d93e65aa9780fe.1548714862.git.DirtY.iCE.hu@gmail.com>
	(=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Mon,
	28 Jan 2019 23:43:24 +0100")
Message-ID: <8736pb4g1i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/14] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

"K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:

> This patch adds structures into qapi to replace the existing
> configuration structures used by audio backends currently. This qapi
> will be the base of the -audiodev command line parameter (that replaces
> the old environment variables based config).
>
> This is not a 1:1 translation of the old options, I've tried to make
> them much more consistent (e.g. almost every backend had an option to
> specify buffer size, but the name was different for every backend, and
> some backends required usecs, while some other required frames, samples
> or bytes). Also tried to reduce the number of abbreviations used by the
> config keys.
>
> Some of the more important changes:
> * use `in` and `out` instead of `ADC` and `DAC`, as the former is more
>   user friendly imho
> * moved buffer settings into the global setting area (so it's the same
>   for all backends that support it. Backends that can't change buffer
>   size will simply ignore them). Also using usecs, as it's probably more
>   user friendly than samples or bytes.
> * try-poll is now an alsa backend specific option (as all other backends
>   currently ignore it)
>
> AudiodevPaPerDirectionOptions struct might look pointless right now, but
> later we will have new per-direction options, so it's more future-proof
> this way.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
[...]
> diff --git a/qapi/audio.json b/qapi/audio.json
> new file mode 100644
> index 0000000000..bd6e2494bd
> --- /dev/null
> +++ b/qapi/audio.json
[...]
> +##
> +# @AudiodevPerDirectionOptions:
> +#
> +# General audio backend options that are used for both playback and reco=
rding.
> +#
> +# @fixed-settings: use fixed settings for host input/output. When off,
> +#                  frequency, channels and format must not be specified
> +#                  (default on)
> +#
> +# @frequency: frequency to use when using fixed settings (default 44100)
> +#
> +# @channels: number of channels when using fixed settings (default 2)
> +#
> +# @voices: number of voices to use (default 1)
> +#
> +# @format: sample format to use when using fixed settings (default s16)

If I specify any of @frequency, @channels, @voices, @format, then I have
to have "fixed-settings": true.  Since true is the default, I don't have
to say it explicitly, which would be redundant and mildly annoying.

However, specifying "fixed-settings": false is *not* redundant, because
it's different from specifying nothing at all, which is the same as
"fixed-settings": true, "frequency": 44100, "channels": 2, "voices": 1,
"format": "s16".

I think I get it.

> +#
> +# @buffer-len: the buffer size in microseconds
> +#
> +# @buffer-count: number of buffers
> +#
> +# Since: 4.0
> +##
[...]
