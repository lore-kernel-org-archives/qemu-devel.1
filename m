Received: from eggs.gnu.org ([209.51.188.92]:32933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goTWG-0003HQ-Fl
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goTWC-0002Qp-NE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1goTW7-0002Pq-B3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:33:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<2ea7c5fe169dc201b4f3276f02d93e65aa9780fe.1548714862.git.DirtY.iCE.hu@gmail.com>
Date: Tue, 29 Jan 2019 14:33:23 +0100
In-Reply-To: <2ea7c5fe169dc201b4f3276f02d93e65aa9780fe.1548714862.git.DirtY.iCE.hu@gmail.com>
	(=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Mon,
	28 Jan 2019 23:43:24 +0100")
Message-ID: <87lg33h9lo.fsf@dusky.pond.sub.org>
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
> ---
>
> Notes:
>     Changes from v2:
>=20=20=20=20=20
>     * update copyright, version numbers
>     * remove #optional
>     * per-direction options are now optional (needed for qobject_object_v=
isitor_new_str)
>     * removed unnecessary AudiodevNoOptions
>     * changed integers to unsigned
>
>  Makefile.objs         |   6 +-
>  qapi/audio.json       | 233 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/qapi-schema.json |   1 +
>  3 files changed, 237 insertions(+), 3 deletions(-)
>  create mode 100644 qapi/audio.json
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 67a054b08a..d9ee3fed32 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,6 +1,6 @@
> -QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
> -QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
> -QAPI_MODULES +=3D ui
> +QAPI_MODULES =3D audio block-core block char common crypto introspect job
> +QAPI_MODULES +=3D migration misc net rdma rocker run-state sockets tpm t=
race
> +QAPI_MODULES +=3D transaction ui
>=20=20
>  #######################################################################
>  # Common libraries for tools and emulators
> diff --git a/qapi/audio.json b/qapi/audio.json
> new file mode 100644
> index 0000000000..bd6e2494bd
> --- /dev/null
> +++ b/qapi/audio.json
> @@ -0,0 +1,233 @@
> +# -*- mode: python -*-
> +#
> +# Copyright (C) 2015-2019 Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <DirtY.iCE.h=
u@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# @AudiodevAlsaPerDirectionOptions:
> +#
> +# Options of the alsa backend that are used for both playback and record=
ing.

Please break your comment lines around column 70.

> +#
> +# @dev: the name of the alsa device to use (default 'default')
> +#
> +# @try-poll: attempt to use poll mode, falling back to non polling acces=
s on

non-polling

> +#            failure (default on)

default true

> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevAlsaPerDirectionOptions',
> +  'data': {
> +    '*dev':      'str',
> +    '*try-poll': 'bool' } }
> +
> +##
> +# @AudiodevAlsaOptions:
> +#
> +# Options of the alsa audio backend.
> +#
> +# @alsa-in: options of the capture stream
> +#
> +# @alsa-out: options of the playback stream
> +#
> +# @threshold: set the threshold (in microseconds) when playback starts
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevAlsaOptions',
> +  'data': {
> +    '*alsa-in':   'AudiodevAlsaPerDirectionOptions',
> +    '*alsa-out':  'AudiodevAlsaPerDirectionOptions',
> +    '*threshold': 'uint32' } }
> +
> +##
> +# @AudiodevDsoundOptions:
> +#
> +# Options of the dsound audio backend.
> +#
> +# @latency: add extra latency to playback in microseconds (default 10000)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevDsoundOptions',
> +  'data': {
> +    '*latency': 'uint32' } }
> +
> +##
> +# @AudiodevOssPerDirectionOptions:
> +#
> +# Options of the oss backend that are used for both playback and recordi=
ng.
> +#
> +# @dev: file name of the oss device (default '/dev/dsp')

A device special file, unlike AudiodevAlsaPerDirectionOptions member
@dev.  Same name, different meaning.  Doesn't bother me in this case.

> +#
> +# @try-poll: attempt to use poll mode, falling back to non polling acces=
s on

non-polling

> +#            failure (default on)

default true

> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevOssPerDirectionOptions',
> +  'data': {
> +    '*dev':      'str',
> +    '*try-poll': 'bool' } }
> +
> +##
> +# @AudiodevOssOptions:
> +#
> +# Options of the oss audio backend.
> +#
> +# @oss-in: options of the capture stream
> +#
> +# @oss-out: options of the playback stream
> +#
> +# @try-mmap: try using memory mapped access, falling back to non
> +#            memory mapped access on failure (default off)

memory-mapped, non-memory-mapped

default false

> +#
> +# @exclusive: open device in exclusive mode (vmix won't work) (default o=
ff)

default false

> +#
> +# @dsp-policy: set the timing policy of the device (between 0 and 10, wh=
ere
> +#              smaller number means smaller latency but higher CPU usage=
) or -1
> +#              to use fragment mode (option ignored on some platforms)
> +#              (default 5)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevOssOptions',
> +  'data': {
> +    '*oss-in':     'AudiodevOssPerDirectionOptions',
> +    '*oss-out':    'AudiodevOssPerDirectionOptions',
> +    '*try-mmap':   'bool',
> +    '*exclusive':  'bool',
> +    '*dsp-policy': 'uint32' } }
> +
> +##
> +# @AudiodevPaPerDirectionOptions:
> +#
> +# Options of the pa backend that are used for both playback and recordin=
g.
> +#
> +# @name: name of the sink/source to use
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevPaPerDirectionOptions',
> +  'data': {
> +    '*name': 'str' } }

Your "might look pointless" remark made me expect an empty struct.  That
would've been pointless indeed.  Instead, you're wrapping the single
option you already have in a struct, to keep open the door for more
options.  Makes sense.

> +
> +##
> +# @AudiodevPaOptions:
> +#
> +# Options of the pa (PulseAudio) audio backend.
> +#
> +# @server: PulseAudio server address (default: let PulseAudio choose)
> +#
> +# @sink: name of the sink to use
> +#
> +# @source: name of the source to use
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevPaOptions',
> +  'data': {
> +    '*server': 'str',
> +    '*sink':   'AudiodevPaPerDirectionOptions',
> +    '*source': 'AudiodevPaPerDirectionOptions' } }
> +
> +##
> +# @AudiodevWavOptions:
> +#
> +# Options of the wav audio backend.
> +#
> +# @path: name of the wav file to record (default 'qemu.wav')
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevWavOptions',
> +  'data': {
> +    '*path': 'str' } }

Pattern so far:

* AudiodevFooOptions=20

  Foo           direction options       other options
  Alsa          alsa-in, alsa-out       threshold
  Dsound                                latency
  Oss           oss-in, oss-out         try-map, exclusive, dsp-policy
  Pa            sink, source            server
  Wav                                   path

Any particular reason for naming the direction options differently?

> +
> +
> +##
> +# @AudioFormat:
> +#
> +# An enumeration of possible audio formats.
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'AudioFormat',
> +  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
> +
> +##
> +# @AudiodevDriver:
> +#
> +# An enumeration of possible audio backend drivers.
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'AudiodevDriver',
> +  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl', '=
spice',
> +            'wav' ] }
> +
> +##
> +# @AudiodevPerDirectionOptions:
> +#
> +# General audio backend options that are used for both playback and reco=
rding.
> +#
> +# @fixed-settings: use fixed settings for host input/output. When off,
> +#                  frequency, channels and format must not be specified
> +#                  (default on)

default true

> +#
> +# @frequency: frequency to use when using fixed settings (default 44100)
> +#
> +# @channels: number of channels when using fixed settings (default 2)
> +#
> +# @voices: number of voices to use (default 1)
> +#
> +# @format: sample format to use when using fixed settings (default s16)
> +#
> +# @buffer-len: the buffer size in microseconds
> +#
> +# @buffer-count: number of buffers
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*fixed-settings': 'bool',
> +    '*frequency':      'uint32',
> +    '*channels':       'uint32',
> +    '*voices':         'uint32',
> +    '*format':         'AudioFormat',
> +    '*buffer-len':     'uint32',
> +    '*buffer-count':   'uint32' } }
> +
> +##
> +# @Audiodev:
> +#
> +# Options of an audio backend.
> +#
> +# @id: identifier of the backend
> +#
> +# @driver: the backend driver to use
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @timer-period: timer period (in microseconds, 0: use lowest possible)
> +#
> +# Since: 4.0
> +##
> +{ 'union': 'Audiodev',
> +  'base': {
> +    'id':            'str',
> +    'driver':        'AudiodevDriver',
> +    '*in':           'AudiodevPerDirectionOptions',
> +    '*out':          'AudiodevPerDirectionOptions',
> +    '*timer-period': 'uint32' },
> +  'discriminator': 'driver',
> +  'data': {
> +    'alsa':      'AudiodevAlsaOptions',
> +    'dsound':    'AudiodevDsoundOptions',
> +    'oss':       'AudiodevOssOptions',
> +    'pa':        'AudiodevPaOptions',
> +    'wav':       'AudiodevWavOptions' } }

'none', 'coreaudio', 'sdl' and 'spice' have no driver-specific options.

Do all the generic options apply to all drivers?  Even 'none'?

Do @in and @out apply to drivers 'dsound' and 'wav'?

Per-direction options are split between generic ones in @in and @out,
and driver-specific ones in @alsa-in and @alsa-out / @oss-in and
@oss-out / @sink and @source.

Perhaps the following would be tidier: make the generic per-direction
options AudiodevPerDirectionOptions the base of driver-specific ones
AudiodevAlsaPerDirectionOptions, AudiodevOssPerDirectionOptions,
AudiodevPaPerDirectionOptions, and then

   { 'struct': 'AudiodevGenericOptions',
     'data': {
       '*in':     'AudiodevPerDirectionOptions',
       '*out':    'AudiodevPerDirectionOptions' } }

   { 'union': 'Audiodev',
     'base': {
       'id':            'str',
       'driver':        'AudiodevDriver',
       '*timer-period': 'uint32' },
     'discriminator': 'driver',
     'data': {
       'none':      'AudiodevGenericOptions',
       'alsa':      'AudiodevAlsaOptions',
       'coreaudio:  'AudiodevGenericOptions',
       'dsound':    'AudiodevDsoundOptions',
       'oss':       'AudiodevOssOptions',
       'pa':        'AudiodevPaOptions',
       'sdl:        'AudiodevGenericOptions',
       'spice':     'AudiodevGenericOptions',
       'wav':       'AudiodevWavOptions' } }

> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 3bbdfcee84..d5f9856be7 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -95,3 +95,4 @@
>  { 'include': 'trace.json' }
>  { 'include': 'introspect.json' }
>  { 'include': 'misc.json' }
> +{ 'include': 'audio.json' }

Looks pretty good.
