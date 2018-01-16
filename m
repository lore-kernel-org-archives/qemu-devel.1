Received: from eggs.gnu.org ([2001:4830:134:3::10]:41471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWWj-0006NW-GA
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWWi-0003is-Ax
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:04:05 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09ebf4d6-3b9e-5a57-9ff4-1b3b66041bdc@redhat.com>
Date: Tue, 16 Jan 2018 13:03:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sFmhDs9F3uptnf8sWNEL2tMOBUTEECy6A"
Subject: Re: [Qemu-devel] [RFC PATCH 03/10] qcow2: Let qcow2_create() handle
 protocol layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sFmhDs9F3uptnf8sWNEL2tMOBUTEECy6A
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <09ebf4d6-3b9e-5a57-9ff4-1b3b66041bdc@redhat.com>
Subject: Re: [RFC PATCH 03/10] qcow2: Let qcow2_create() handle protocol layer
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-4-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> Currently, qcow2_create() only parses the QemuOpts and then calls
> qcow2_create2() for the actual image creation, which includes both the
> creation of the actual file on the file system and writing a valid empt=
y
> qcow2 image into that file.
>=20
> The plan is that qcow2_create2() becomes the function that implements
> the functionality for a future 'blockdev-create' QMP command, which onl=
y
> creates the qcow2 layer on an already opened file node.
>=20
> This is a first step towards that goal: Let's move out anything that
> deals with the protocol layer from qcow2_create2() into qcow2_create().=

> This means that qcow2_create2() doesn't need a file name any more.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 64 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 38 insertions(+), 26 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4348b2c0c5..b02bc39a01 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2690,7 +2690,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(Q=
emuOpts *opts, int version,
>      return refcount_bits;
>  }
> =20
> -static int qcow2_create2(const char *filename, int64_t total_size,
> +static int qcow2_create2(BlockDriverState *bs, int64_t total_size,

Might be worth adding a high-level comment before the two functions to
document the division of labor, rather than just the commit message.

> @@ -2962,12 +2948,38 @@ static int qcow2_create(const char *filename, Q=
emuOpts *opts, Error **errp)
> =20
>      refcount_order =3D ctz32(refcount_bits);
> =20
> -    ret =3D qcow2_create2(filename, size, backing_file, backing_fmt, f=
lags,
> +    /* Create and open the file (protocol layer */

Closing )

With the nit fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sFmhDs9F3uptnf8sWNEL2tMOBUTEECy6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeTJsACgkQp6FrSiUn
Q2pmpQf+KIFP5SDk4KCk4tQqL6+HSwOBMzkW6Mb9hYlISrVFVbNdqF2cLb8aUW4+
BYULUHyLO3VBGr3Nj2bJ0JBiD2Zk/mNDqy41Y/+dmzpQbM3RnYiecJEglGZ776im
06nJVa0/RX98H+SVz+c+1+RqNsHQkYWvp5jt1OBGUeLImObK1b0n6lQIE1Up5u3K
ouXcH8GmGi869Db6H3xVA06NwmzSLzprP+WTSwdBwN3QkbBqUTQMKCwbbsbx+Wrf
/WgvYCKim5XmYB7et6NFG1pjqnXDvL/j/fT4Si9fWG42tfV9k3f+GqWM/RSM84b6
Xz77wWP0C6inzOWcm+kphLFv7clTJg==
=w1kB
-----END PGP SIGNATURE-----

--sFmhDs9F3uptnf8sWNEL2tMOBUTEECy6A--
