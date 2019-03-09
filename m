Received: from eggs.gnu.org ([209.51.188.92]:34522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2YGq-0006HN-Ia
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2YGp-0007JT-Ic
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:27:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2YGp-0007Ij-9U
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:27:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
	<5461b514dbf3e0bc31b0abb6498a9b3a008c271e.1552083282.git.DirtY.iCE.hu@gmail.com>
Date: Sat, 09 Mar 2019 10:27:49 +0100
In-Reply-To: <5461b514dbf3e0bc31b0abb6498a9b3a008c271e.1552083282.git.DirtY.iCE.hu@gmail.com>
	(=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Fri,
	8 Mar 2019 23:34:12 +0100")
Message-ID: <87tvgc5re2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/14] qapi: qapi for audio backends
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
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>
> Notes:
>     Changes from v5:
>=20=20=20=20=20
>     * documentation fixes
>     * renamed buffer-len to buffer-length and period-len to period-length
>=20=20=20=20=20
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
> index 0000000000..97aee37288
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
> +# @buffer-length: the buffer length in microseconds

The name buffer-length suggests bytes rather than microseconds.  That's
why I suggested @buffer-capacity.  Matter of taste, up to you and Gerd.

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
> +    '*buffer-length':  'uint32' } }
[...]

Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
