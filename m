Received: from eggs.gnu.org ([2001:4830:134:3::10]:36368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNgq9-0002PG-7O
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNgq8-0002kU-94
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:42:41 -0400
References: <20170619173455.18805-1-berrange@redhat.com>
	<20170619173455.18805-14-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <79345f33-2cf6-bec1-c96d-981fc7e3fedd@redhat.com>
Date: Wed, 21 Jun 2017 16:42:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170619173455.18805-14-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NwkSAr3uExBA01g6mlGHFj2RCQX6Ix3A9"
Subject: Re: [Qemu-devel] [PATCH v9 13/20] qcow2: add support for LUKS
 encryption format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NwkSAr3uExBA01g6mlGHFj2RCQX6Ix3A9
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <79345f33-2cf6-bec1-c96d-981fc7e3fedd@redhat.com>
Subject: Re: [PATCH v9 13/20] qcow2: add support for LUKS encryption format
References: <20170619173455.18805-1-berrange@redhat.com>
 <20170619173455.18805-14-berrange@redhat.com>
In-Reply-To: <20170619173455.18805-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-19 19:34, Daniel P. Berrange wrote:
> This adds support for using LUKS as an encryption format
> with the qcow2 file, using the new encrypt.format parameter
> to request "luks" format. e.g.
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> The legacy "encryption=3Don" parameter still results in
> creation of the old qcow2 AES format (and is equivalent
> to the new 'encryption-format=3Daes'). e.g. the following are
> equivalent:
>=20
>   # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption=3Don,encrypt.key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
>  # qemu-img create --object secret,data=3D123456,id=3Dsec0 \
>        -f qcow2 -o encryption-format=3Daes,encrypt.key-secret=3Dsec0 \
>        test.qcow2 10G
>=20
> With the LUKS format it is necessary to store the LUKS
> partition header and key material in the QCow2 file. This
> data can be many MB in size, so cannot go into the QCow2
> header region directly. Thus the spec defines a FDE
> (Full Disk Encryption) header extension that specifies
> the offset of a set of clusters to hold the FDE headers,
> as well as the length of that region. The LUKS header is
> thus stored in these extra allocated clusters before the
> main image payload.
>=20
> Aside from all the cryptographic differences implied by
> use of the LUKS format, there is one further key difference
> between the use of legacy AES and LUKS encryption in qcow2.
> For LUKS, the initialiazation vectors are generated using
> the host physical sector as the input, rather than the
> guest virtual sector. This guarantees unique initialization
> vectors for all sectors when qcow2 internal snapshots are
> used, thus giving stronger protection against watermarking
> attacks.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2-cluster.c      |   4 +-
>  block/qcow2-refcount.c     |  10 ++
>  block/qcow2.c              | 268 +++++++++++++++++++++++++++++++++++++=
+------
>  block/qcow2.h              |   9 ++
>  qapi/block-core.json       |   5 +-
>  tests/qemu-iotests/082.out | 270 ++++++++++++++++++++++++++++++++++++-=
--------
>  6 files changed, 478 insertions(+), 88 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NwkSAr3uExBA01g6mlGHFj2RCQX6Ix3A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSoXREhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKJy
CAC33jK0ywQagHmEHi/ElXile8qE3vctLZMQQDRjv1lnrbxwMoaGQRMlVm7hSqrU
juurvollxMm60t77gn0TjD2ejSSRhEfn4k9J8FfUdh9BHL6oaeEUQ6Bx5MmB41AG
3q4SZLNypheV1mxg5bycYhZHvsxAthJQ/jXwir8fkVZsiVvrR1Mm4N2OTk1DUCgx
zdIRMK4rI3AZUF1uQYiLQgqFTxBTckjwNkfCFzr0HtWCJZ7EaUXE09pyDkKzd+Di
+NgJn9ux+/8ydz69vmG3qBUvgTP3ERp5UCFpH742jYA5eaGgCNysLCObDbCsVebO
LEp1mA+jezWpTybtc617/E/X
=cBJv
-----END PGP SIGNATURE-----

--NwkSAr3uExBA01g6mlGHFj2RCQX6Ix3A9--
