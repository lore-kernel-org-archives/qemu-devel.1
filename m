Received: from eggs.gnu.org ([2001:4830:134:3::10]:45358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0c0-0007Ph-RF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0bz-0001bA-Nv
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:35:08 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd58d0a5-3838-5ef7-cb8b-0b74e5e22d27@redhat.com>
Date: Tue, 9 Jan 2018 14:34:59 -0600
MIME-Version: 1.0
In-Reply-To: <20171207155102.66622-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cCDbWhFIOcY6KMnMJDbPTkxvRWFpLjSQA"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] iotests: implement
 QemuIoInteractive class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cCDbWhFIOcY6KMnMJDbPTkxvRWFpLjSQA
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <dd58d0a5-3838-5ef7-cb8b-0b74e5e22d27@redhat.com>
Subject: Re: [PATCH v2 5/6] iotests: implement QemuIoInteractive class
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:

The subject says what, but there is no commit body that says why.

Presumably this makes writing the test in the next patch easier, but
some details in the commit message would make this obvious.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 38 +++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 38 insertions(+)
>=20

My python is not strong; it looks good overall, although I have a few
questions that may warrant a v3 before I give R-b.

> +class QemuIoInteractive:
> +    def __init__(self, *args):
> +        self.args =3D qemu_io_args + list(args)
> +        self._p =3D subprocess.Popen(self.args, stdin=3Dsubprocess.PIP=
E,
> +                                   stdout=3Dsubprocess.PIPE,
> +                                   stderr=3Dsubprocess.STDOUT)

Why STDOUT instead of STDERR?  Is the redirection intentional?


> +    def _read_output(self):
> +        pattern =3D 'qemu-io> '
> +        n =3D len(pattern)
> +        pos =3D 0
> +        s =3D []
> +        while pos !=3D n:
> +            c =3D self._p.stdout.read(1)
> +            #check unexpected EOF

pep8 doesn't like this comment style (it wants space after #).  The file
is already unclean under pep8, but you shouldn't make it worse.

> +            assert c !=3D ''

Is assert really the nicest control flow when early EOF is present? Or
is it because we are only using this in tests, where we don't expect
early EOF, so asserting is just fine for our usage?

> +            s.append(c)
> +            if c =3D=3D pattern[pos]:
> +                pos +=3D 1
> +            else:
> +                pos =3D 0
> +
> +        return ''.join(s[:-n])

Is it necessary to use join() on the empty string here, compared to just
returning the array slice directly?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cCDbWhFIOcY6KMnMJDbPTkxvRWFpLjSQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVJ3MACgkQp6FrSiUn
Q2o9OQf+Irthf516fofyO7qJx/QieLlXTB9aP2cPCEY6Wh46Iub9rs4X32UxL1j3
0D9MMGhaM3y+v4wIXZr0Yoa1sh4FjOz2hxreKJ6pZYonztgi3ElsFMs94axKZuwF
YmvxpRPtxix4ROZvpQzq0//MMLPVr8j1Ce0zklXEQGqW7w/8XZpyBcFXrYxK2Nl1
nqQd3hCKo9V6aS6VDlKK/EDS9C0PrE0YVg9ng7YI9+djWC+i52XdKom8wtwUlh0Q
plkM7rvaOAM0HIELIfNnR1Uh4+CZMm096rT1WnxKqukJlhtE0CcuHqA9FDHmfqfN
Zt9xCmgZZrYyIPjorP/7ErsiZMo0dQ==
=q2YJ
-----END PGP SIGNATURE-----

--cCDbWhFIOcY6KMnMJDbPTkxvRWFpLjSQA--
