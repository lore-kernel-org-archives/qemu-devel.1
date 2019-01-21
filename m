Received: from eggs.gnu.org ([209.51.188.92]:35408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glgb4-00087v-2J
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glgb3-0004k7-6Y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:55:05 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
Date: Mon, 21 Jan 2019 14:55:01 -0600
MIME-Version: 1.0
In-Reply-To: <20181221234750.23577-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h2GhPAVC1GpzE649sTKMUwZeaXGRLmlIJ"
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h2GhPAVC1GpzE649sTKMUwZeaXGRLmlIJ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <fd55396f-47d6-2836-46c3-0c44c8248a8b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: Add qemu_nbd_pipe()
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-2-mreitz@redhat.com>
In-Reply-To: <20181221234750.23577-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/18 5:47 PM, Max Reitz wrote:
> In some cases, we may want to deal with qemu-nbd errors (e.g. by
> launching it in a different configuration until it no longer throws
> any).  In that case, we do not want its output ending up in the test
> output.
>=20
> It may still be useful for handling the error, though, so add a new
> function that works basically like qemu_nbd(), only that it returns the=

> qemu-nbd output instead of making it end up in the log.  In contrast to=

> qemu_img_pipe(), it does still return the exit code as well, though,

In contrast to qemu_nbd(),

> because that is even more important for error handling.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index d537538ba0..9c3eb9e2f8 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -190,6 +190,20 @@ def qemu_nbd(*args):
>      '''Run qemu-nbd in daemon mode and return the parent's exit code''=
'
>      return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
> =20
> +def qemu_nbd_pipe(*args):
> +    '''Run qemu-nbd in daemon mode and return both the parent's exit c=
ode
> +       and its output'''
> +    subp =3D subprocess.Popen(qemu_nbd_args + ['--fork'] + list(args),=

> +                            stdout=3Dsubprocess.PIPE,
> +                            stderr=3Dsubprocess.STDOUT,
> +                            universal_newlines=3DTrue)
> +    exitcode =3D subp.wait()
> +    if exitcode < 0:
> +        sys.stderr.write('qemu-nbd received signal %i: %s\n' %
> +                         (-exitcode,
> +                          ' '.join(qemu_nbd_args + ['--fork'] + list(a=
rgs))))
> +    return exitcode, subp.communicate()[0]
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--h2GhPAVC1GpzE649sTKMUwZeaXGRLmlIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxGMaUACgkQp6FrSiUn
Q2osrggAg9xGp/uZmMRr2fJNVgfcpiyCUukN2KWVjEvyc3UEkax5NXXEM808R5lM
JIfgKq2dyT0fOXwCuzOBIMIjMcPoAe0ae2/XaTu2eR3gg70dYZ9jC6Go2lgnqU54
u7kEYEOiqbNwwihZWyJSJFE/jIdLaOFyeXuEbUbIXC5Fi8/yQg7aI5pDTCaY9Tcc
GIaqejkhWH8v1zPo3IRQrd9xfK6NjtcA8T4zHN/fHUR7uYlj+1uH5uq2cTs/lV97
QeAwsXfWLvYagHRNJRuEGkj3cM88dzn74N3Hc8R72Zg70dVsTCcvNU8kVpS97jcq
d/SRse/+LPudYy3IooyCAJ2IR/TFQw==
=P9Z/
-----END PGP SIGNATURE-----

--h2GhPAVC1GpzE649sTKMUwZeaXGRLmlIJ--
