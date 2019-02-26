Received: from eggs.gnu.org ([209.51.188.92]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyWfJ-00020L-Er
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyWfH-0007is-GZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gyWfD-0007gs-Gt
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:56:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<d23b1c134a97f8be492348c8b4f87a76b717eeff.1550698466.git.DirtY.iCE.hu@gmail.com>
Date: Tue, 26 Feb 2019 07:56:21 +0100
In-Reply-To: <d23b1c134a97f8be492348c8b4f87a76b717eeff.1550698466.git.DirtY.iCE.hu@gmail.com>
	(=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Wed,
	20 Feb 2019 22:37:30 +0100")
Message-ID: <875zt7nilm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/14] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>

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
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
> ---
>
> Notes:
>     Changes from v4:
>=20=20=20=20=20
>     * documentation fixes
>     * renamed pa's source/sink to pa-in/pa-out
>     * per-direction options changed per Markus Armbruster's comments
>=20=20=20=20=20
>     Changes from v2:
>=20=20=20=20=20
>     * update copyright, version numbers
>     * remove #optional
>     * per-direction options are now optional (needed for qobject_object_v=
isitor_new_str)
>     * removed unnecessary AudiodevNoOptions
>     * changed integers to unsigned
>
>  qapi/audio.json       | 304 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/qapi-schema.json |   1 +
>  qapi/Makefile.objs    |   6 +-
>  3 files changed, 308 insertions(+), 3 deletions(-)
>  create mode 100644 qapi/audio.json
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> new file mode 100644
> index 0000000000..2f203462c7
> --- /dev/null
> +++ b/qapi/audio.json
> @@ -0,0 +1,304 @@
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
> +# @AudiodevPerDirectionOptions:
> +#
> +# General audio backend options that are used for both playback and
> +# recording.
> +#
> +# @fixed-settings: use fixed settings for host input/output. When off,
> +#                  frequency, channels and format must not be
> +#                  specified (default true)
> +#
> +# @frequency: frequency to use when using fixed settings
> +#             (default 44100)
> +#
> +# @channels: number of channels when using fixed settings (default 2)
> +#
> +# @voices: number of voices to use (default 1)
> +#
> +# @format: sample format to use when using fixed settings
> +#          (default s16)
> +#
> +# @buffer-len: the buffer size in microseconds

The name says "len" (for length), the comment says "size" and by its
unit implies "duration".

In the QMP schema, we traditionally prefer longhand like "length" over
abbreviations like "len".

What about calling it @buffer-capacity?

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
> +    '*buffer-len':     'uint32' } }
> +
> +##
> +# @AudiodevGenericOptions:
> +#
> +# Generic driver-specific options.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevGenericOptions',
> +  'data': {
> +    '*in':  'AudiodevPerDirectionOptions',
> +    '*out': 'AudiodevPerDirectionOptions' } }
> +
> +##
> +# @AudiodevAlsaPerDirectionOptions:
> +#
> +# Options of the alsa backend that are used for both playback and
> +# recording.

Permit me to indulge in a little nitpicking...  If you want to refer to
the Advanced Linux Sound Architecture, that's spelled ALSA.  If you want
to refer to the enumeration value, consider putting it in double quotes:
"alsa".

Here, 'the ALSA backend', 'the "alsa" backend', and 'the alsa backend'
would all work for me.  Your choice.

More occurences of 'the FOO backend' and 'the FOO audio backend' below.

> +#
> +# @dev: the name of the alsa device to use (default 'default')

But I'd definitely use ALSA here.

> +#
> +# @period-len: the period length in microseconds

period-length

> +#
> +# @try-poll: attempt to use poll mode, falling back to non-polling
> +#            access on failure (default true)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevAlsaPerDirectionOptions',
> +  'base': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*dev':        'str',
> +    '*period-len': 'uint32',
> +    '*try-poll':   'bool' } }
> +
> +##
> +# @AudiodevAlsaOptions:
> +#
> +# Options of the alsa audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @threshold: set the threshold (in microseconds) when playback starts
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevAlsaOptions',
> +  'data': {
> +    '*in':        'AudiodevAlsaPerDirectionOptions',
> +    '*out':       'AudiodevAlsaPerDirectionOptions',
> +    '*threshold': 'uint32' } }
> +
> +##
> +# @AudiodevCoreaudioPerDirectionOptions:
> +#
> +# Options of the coreaudio backend that are used for both playback and
> +# recording.

If you decide to use 'the ALSA backend' above, use 'the Core Audio
backend' here.

> +#
> +# @buffer-count: number of buffers
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevCoreaudioPerDirectionOptions',
> +  'base': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*buffer-count': 'uint32' } }
> +
> +##
> +# @AudiodevCoreaudioOptions:
> +#
> +# Options of the coreaudio audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevCoreaudioOptions',
> +  'data': {
> +    '*in':  'AudiodevCoreaudioPerDirectionOptions',
> +    '*out': 'AudiodevCoreaudioPerDirectionOptions' } }
> +
> +##
> +# @AudiodevDsoundOptions:
> +#
> +# Options of the dsound audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @latency: add extra latency to playback in microseconds
> +#           (default 10000)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevDsoundOptions',
> +  'data': {
> +    '*in':      'AudiodevPerDirectionOptions',
> +    '*out':     'AudiodevPerDirectionOptions',
> +    '*latency': 'uint32' } }
> +
> +##
> +# @AudiodevOssPerDirectionOptions:
> +#
> +# Options of the oss backend that are used for both playback and
> +# recording.
> +#
> +# @dev: file name of the oss device (default '/dev/dsp')

OSS

> +#
> +# @buffer-count: number of buffers
> +#
> +# @try-poll: attempt to use poll mode, falling back to non-polling
> +#            access on failure (default true)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevOssPerDirectionOptions',
> +  'base': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*dev':          'str',
> +    '*buffer-count': 'uint32',
> +    '*try-poll':     'bool' } }
> +
> +##
> +# @AudiodevOssOptions:
> +#
> +# Options of the oss audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @try-mmap: try using memory-mapped access, falling back to
> +#            non-memory-mapped access on failure (default true)
> +#
> +# @exclusive: open device in exclusive mode (vmix won't work)
> +#             (default false)
> +#
> +# @dsp-policy: set the timing policy of the device (between 0 and 10,
> +#              where smaller number means smaller latency but higher
> +#              CPU usage) or -1 to use fragment mode (option ignored
> +#              on some platforms) (default 5)
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevOssOptions',
> +  'data': {
> +    '*in':         'AudiodevOssPerDirectionOptions',
> +    '*out':        'AudiodevOssPerDirectionOptions',
> +    '*try-mmap':   'bool',
> +    '*exclusive':  'bool',
> +    '*dsp-policy': 'uint32' } }
> +
> +##
> +# @AudiodevPaPerDirectionOptions:
> +#
> +# Options of the pa backend that are used for both playback and
> +# recording.

If you decide to use 'the ALSA backend' above, use 'the PulseAudio
backend' here.

> +#
> +# @name: name of the sink/source to use
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevPaPerDirectionOptions',
> +  'base': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*name': 'str' } }
> +
> +##
> +# @AudiodevPaOptions:
> +#
> +# Options of the pa (PulseAudio) audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @server: PulseAudio server address (default: let PulseAudio choose)

Here, you're already using the name PulseAudio rather than the
enumeration value "pa".

> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevPaOptions',
> +  'data': {
> +    '*in':     'AudiodevPaPerDirectionOptions',
> +    '*out':    'AudiodevPaPerDirectionOptions',
> +    '*server': 'str' } }
> +
> +##
> +# @AudiodevWavOptions:
> +#
> +# Options of the wav audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# @path: name of the wav file to record (default 'qemu.wav')
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'AudiodevWavOptions',
> +  'data': {
> +    '*in':   'AudiodevPerDirectionOptions',
> +    '*out':  'AudiodevPerDirectionOptions',
> +    '*path': 'str' } }
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
> +  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl',
> +            'spice', 'wav' ] }
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
> +# @timer-period: timer period (in microseconds, 0: use lowest possible)
> +#
> +# Since: 4.0
> +##
> +{ 'union': 'Audiodev',
> +  'base': {
> +    'id':            'str',
> +    'driver':        'AudiodevDriver',
> +    '*timer-period': 'uint32' },
> +  'discriminator': 'driver',
> +  'data': {
> +    'none':      'AudiodevGenericOptions',
> +    'alsa':      'AudiodevAlsaOptions',
> +    'coreaudio': 'AudiodevCoreaudioOptions',
> +    'dsound':    'AudiodevDsoundOptions',
> +    'oss':       'AudiodevOssOptions',
> +    'pa':        'AudiodevPaOptions',
> +    'sdl':       'AudiodevGenericOptions',
> +    'spice':     'AudiodevGenericOptions',
> +    'wav':       'AudiodevWavOptions' } }
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index db61bfd688..5a8bb276d5 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -98,3 +98,4 @@
>  { 'include': 'introspect.json' }
>  { 'include': 'misc.json' }
>  { 'include': 'target.json' }
> +{ 'include': 'audio.json' }
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 87e4df1660..5061bee978 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -5,9 +5,9 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
>  util-obj-y +=3D qmp-event.o
>  util-obj-y +=3D qapi-util.o
>=20=20
> -QAPI_COMMON_MODULES =3D block-core block char common crypto introspect
> -QAPI_COMMON_MODULES +=3D job migration misc net rdma rocker run-state
> -QAPI_COMMON_MODULES +=3D sockets tpm trace transaction ui
> +QAPI_COMMON_MODULES =3D audio block-core block char common crypto
> +QAPI_COMMON_MODULES +=3D introspect job migration misc net rdma rocker
> +QAPI_COMMON_MODULES +=3D run-state sockets tpm trace transaction ui
>  QAPI_TARGET_MODULES =3D target
>  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)

We're down to minor stylistic issues.  Good work!

With at least the 'len' names tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
