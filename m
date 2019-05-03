Received: from eggs.gnu.org ([209.51.188.92]:44352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMejF-0008Sh-UE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMejE-0006jl-R4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hMejE-0006jC-Hy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:24:20 -0400
References: <20190503193141.GA17700@erokenlabserver>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
Date: Fri, 3 May 2019 15:24:06 -0500
MIME-Version: 1.0
In-Reply-To: <20190503193141.GA17700@erokenlabserver>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T"
Subject: Re: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
 character device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ernest Esene <eroken1@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T
From: Eric Blake <eblake@redhat.com>
To: Ernest Esene <eroken1@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
 character device
References: <20190503193141.GA17700@erokenlabserver>
In-Reply-To: <20190503193141.GA17700@erokenlabserver>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 5/3/19 2:31 PM, Ernest Esene wrote:
> Add support for Linux I2C character device for I2C device passthrough
> For example:
> -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
>=20
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
> ---

Just an interface review:

> +++ b/qapi/char.json
> @@ -240,6 +240,21 @@
>    'data': { 'device': 'str' },
>    'base': 'ChardevCommon' }
> =20
> +##
> +# @ChardevI2c:
> +#
> +# Configuration info for i2c chardev (only on linux).

Rather than a parenthetical comment, you could use:

> +#
> +# @device: The name of the special file for the device,
> +#          i.e. /dev/i2c-0 on linux
> +# @address: The address of the i2c device on the host.
> +#
> +##

Missing a 'Since: 4.1' line.

> +{ 'struct': 'ChardevI2c',
> +  'data': { 'device': 'str',
> +            'address': 'int16'},
> +  'base': 'ChardevCommon'}

'if': 'defined(CONFIG_LINUX)'

as part of the usage of this struct, so that introspection will only see
the struct where it can be used.

> +
>  ##
>  # @ChardevSocket:
>  #
> @@ -398,6 +413,7 @@
>    'data': { 'file': 'ChardevFile',
>              'serial': 'ChardevHostdev',
>              'parallel': 'ChardevHostdev',
> +            'i2c': 'ChardevI2c',
>              'pipe': 'ChardevHostdev',
>              'socket': 'ChardevSocket',
>              'udp': 'ChardevUdp',
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzMo2YACgkQp6FrSiUn
Q2rwswf/QuCvomakkSEIKszFbrcjiNzaJ+LfYqlRP1m2a8y4nMLlgGHwxivEgZ3N
xcL3VbclxVcl/YnFQgznBvUgmgTe7pR1k3z/fFbbgLCMGNaOF0qslOuqKlMT3ThX
55qv7yZDVokbHyfariasd1uhSU/vVMBX3gg6TWlgq153QycMHRQFFmLD1A0ZnH0V
yAgv8yYuMWPHhenTBhrrNgm5vVZU+IN8+gb/3CnS3WxqZmciApycl9l12xUOZq+n
C6OjDeI0dD1Y3DEbj2VSsWzz97EVqw3DpXuUGQhXCUTZ14A72bLAjSSMBi8MCaKi
AQzNwFATDlOCxeTxiZCrKsYg4k7uQQ==
=btx/
-----END PGP SIGNATURE-----

--4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T--
