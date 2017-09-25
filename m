Received: from eggs.gnu.org ([2001:4830:134:3::10]:50759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwbOa-00016p-Om
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwbOZ-0006cH-QL
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:58:32 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
	<20170925135801.144261-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <648e15f7-4d68-f1bf-64f1-24903d88312d@redhat.com>
Date: Mon, 25 Sep 2017 16:58:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170925135801.144261-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UFCgvfNORP3uFHB5hwbCeTV1ruHhqL2Cv"
Subject: Re: [Qemu-devel] [PATCH 1/8] block/nbd-client: assert qiov len once
 in nbd_co_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UFCgvfNORP3uFHB5hwbCeTV1ruHhqL2Cv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <648e15f7-4d68-f1bf-64f1-24903d88312d@redhat.com>
Subject: Re: [PATCH 1/8] block/nbd-client: assert qiov len once in
 nbd_co_request
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
 <20170925135801.144261-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 08:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20

> @@ -233,6 +231,7 @@ static int nbd_co_request(BlockDriverState *bs,
> =20
>      assert(!qiov || request->type =3D=3D NBD_CMD_WRITE ||
>             request->type =3D=3D NBD_CMD_READ);
> +    assert(!qiov || request->len =3D=3D iov_size(qiov->iov, qiov->niov=
));

Asserting !qiov twice in a row feels a bit odd, although I see why you
have to do it to prevent a NULL dereference.  Would this be any easier
to read as a single assertion:

assert(!qiov ||
       ((request->type =3D=3D NBD_CMD_WRITE ||
         request->type =3D=3D NBD_CMD_READ) &&
        request->len =3D=3D iov_size(qiov->iov, qiov->niov)));

Or, as a conditional:

if (qiov) {
    assert(request->type =3D=3D NBD_CMD_WRITE || request->type =3D=3D NBD=
_CMD_READ);
    assert(request->len =3D=3D iov_size(qiov->iov, qiov->niov));
} else {
    assert(request->type !=3D NBD_CMD_WRITE && request->type !=3D NBD_CMD=
_READ);
}

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UFCgvfNORP3uFHB5hwbCeTV1ruHhqL2Cv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJe/0ACgkQp6FrSiUn
Q2r81wf+LP9HTx7finfMwosozhm7nb7YemQThpGh8vJ2YGIDEzlKvMaqz9OT2ibL
GzQ72hC7Dew2ZOjMasxa7FeY21dPq3S1ex17eenzgbLU33mcmXiSsl/x3FOYD929
PfI1GXDODiPPX/AW9hP/rnhbytr7JDsUqfrHidKKZjEveE3Uj20rfRpqE7O4nkih
ITOohisDFVA1CElC5efg1WT9qukRWkfG8pFCvrGL4v+NBzXmq2vzPUUFEZtS6dns
jF2QaVznbXNOpNovOTUnjsFAAUsdTgWmlRgYgUPHS7a/SbDHYfNbN4QxhlQckW9T
RD5c5cFUAQzlgJOBJB5Ldsb2M8xYMA==
=Jq9Z
-----END PGP SIGNATURE-----

--UFCgvfNORP3uFHB5hwbCeTV1ruHhqL2Cv--
