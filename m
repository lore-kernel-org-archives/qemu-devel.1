Received: from eggs.gnu.org ([209.51.188.92]:55343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghQPl-0002C1-5h
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghQPj-0000D9-Kt
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:49:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghQPh-0000CH-KV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:49:45 -0500
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<b35ceed43600ab8572d8d7881adc14f3937ef91f.1545598229.git.DirtY.iCE.hu@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9046d6e2-611e-643a-386e-e0fd1dbce5bb@redhat.com>
Date: Wed, 9 Jan 2019 20:49:40 -0600
MIME-Version: 1.0
In-Reply-To: <b35ceed43600ab8572d8d7881adc14f3937ef91f.1545598229.git.DirtY.iCE.hu@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xTNTCeahJ7b2yrwmApn4fAVSZTfHbbREJ"
Subject: Re: [Qemu-devel] [PATCH v2 03/52] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTNTCeahJ7b2yrwmApn4fAVSZTfHbbREJ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <9046d6e2-611e-643a-386e-e0fd1dbce5bb@redhat.com>
Subject: Re: [PATCH v2 03/52] qapi: qapi for audio backends
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
 <b35ceed43600ab8572d8d7881adc14f3937ef91f.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <b35ceed43600ab8572d8d7881adc14f3937ef91f.1545598229.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/23/18 2:51 PM, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
> This patch adds structures into qapi to replace the existing
> configuration structures used by audio backends currently. This qapi
> will be the base of the -audiodev command line parameter (that replaces=

> the old environment variables based config).
>=20
> This is not a 1:1 translation of the old options, I've tried to make
> them much more consistent (e.g. almost every backend had an option to
> specify buffer size, but the name was different for every backend, and
> some backends required usecs, while some other required frames, samples=

> or bytes). Also tried to reduce the number of abbreviations used by the=

> config keys.
>=20
> Some of the more important changes:
> * use `in` and `out` instead of `ADC` and `DAC`, as the former is more
>   user friendly imho
> * moved buffer settings into the global setting area (so it's the same
>   for all backends that support it. Backends that can't change buffer
>   size will simply ignore them). Also using usecs, as it's probably mor=
e
>   user friendly than samples or bytes.
> * try-poll is now an alsa backend specific option (as all other backend=
s
>   currently ignore it)
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  Makefile.objs         |   6 +-
>  qapi/audio.json       | 253 ++++++++++++++++++++++++++++++++++++++++++=

>  qapi/qapi-schema.json |   1 +
>  3 files changed, 257 insertions(+), 3 deletions(-)
>  create mode 100644 qapi/audio.json
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index bc5b8a8442..3f833a70c0 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,6 +1,6 @@
> -QAPI_MODULES =3D block-core block char common crypto introspect job mi=
gration
> -QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace tra=
nsaction
> -QAPI_MODULES +=3D ui
> +QAPI_MODULES =3D audio block-core block char common crypto introspect =
job
> +QAPI_MODULES +=3D migration misc net rdma rocker run-state sockets tpm=
 trace
> +QAPI_MODULES +=3D transaction ui
> =20
>  ######################################################################=
#
>  # Common libraries for tools and emulators
> diff --git a/qapi/audio.json b/qapi/audio.json
> new file mode 100644
> index 0000000000..56d8ce439f
> --- /dev/null
> +++ b/qapi/audio.json
> @@ -0,0 +1,253 @@
> +# -*- mode: python -*-
> +#
> +# Copyright (C) 2015 Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <DirtY.iCE.hu@g=
mail.com>

Do you want to claim 2015-2019 now?  But ultimately what you put is your
call, so don't treat my suggestion as a legal mandate.

> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# @AudiodevNoOptions:
> +#
> +# The none, coreaudio, sdl and spice audio backend have no options.
> +#
> +# Since: 3.2

4.0, now.

> +##
> +{ 'struct': 'AudiodevNoOptions',
> +  'data': { } }

Also, we now have support for empty branches in a flat union, so do you
really need this type, or...

> +
> +##
> +# @AudiodevAlsaPerDirectionOptions:
> +#
> +# Options of the alsa backend that are used for both playback and reco=
rding.
> +#
> +# @dev: #optional the name of the alsa device to use (default 'default=
')

No need to use the '#optional' tag any more; the doc generator now takes
care of that.

> +#
> +# @try-poll: #optional attempt to use poll mode, falling back to non p=
olling
> +#            access on failure (default on)
> +#
> +# Since: 3.2

More 4.0 (I'll quit pointing it out)


> +##
> +{ 'union': 'Audiodev',
> +  'base': {
> +    'id':            'str',
> +    'driver':        'AudiodevDriver',
> +    'in':            'AudiodevPerDirectionOptions',
> +    'out':           'AudiodevPerDirectionOptions',
> +    '*timer-period': 'int' },
> +  'discriminator': 'driver',
> +  'data': {
> +    'none':      'AudiodevNoOptions',

=2E..you could just omit the lines that don't add anything.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xTNTCeahJ7b2yrwmApn4fAVSZTfHbbREJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2ssQACgkQ3g5py3or
ov2Lzwf+Ky1XXYqceibbjZYS/BgutCS3m8HbK3OEpaM9fR/riAHA4FsDWO8CiLdT
m7mCBdKZT9z+TNBQU9JviZ6+lgdYmO3kGjKig0QwpOVRVMsuinOJHCBnB1e9dMEg
VFF85z7yv5mqIh0hBVjXVTBGAzCN+dsg2cJdb8nT/XDMetrqwfw8BfY8aWc0Sta2
0PZDLfVSBgzpd6onE47QMslsUp0YHFkKfTS5aWg3g9vDrlFZFWYPOfYGWzcO6wya
On9xCGH4e3r6LvF1jOOB2uTWZ/FAfHu3sV76XdpfJlK7XCv596iVjdW01OD777pB
IXInghFj6nIgdeq9PPneUE1GxS80pA==
=RBNi
-----END PGP SIGNATURE-----

--xTNTCeahJ7b2yrwmApn4fAVSZTfHbbREJ--
