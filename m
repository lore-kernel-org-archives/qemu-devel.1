Received: from eggs.gnu.org ([2001:4830:134:3::10]:49188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1gXK-00015A-AN
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1gXJ-0006vB-88
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:28:34 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <474ed8c0-6ffc-b565-45c0-c9890826897c@redhat.com>
Date: Mon, 9 Oct 2017 17:28:21 -0500
MIME-Version: 1.0
In-Reply-To: <20171009215533.12530-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a17v0c5SCv5H9du5JENBaFCeJuR18febG"
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Always execute preallocate() in
 a coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a17v0c5SCv5H9du5JENBaFCeJuR18febG
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <474ed8c0-6ffc-b565-45c0-c9890826897c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Always execute preallocate() in a
 coroutine
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-3-mreitz@redhat.com>
In-Reply-To: <20171009215533.12530-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 04:55 PM, Max Reitz wrote:
> Some qcow2 functions (at least perform_cow()) expect s->lock to be
> taken.  Therefore, if we want to make use of them, we should execute
> preallocate() (as "preallocate_co") in a coroutine so that we can use
> the qemu_co_mutex_* functions.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
>=20

> +++ b/block/qcow2.c
> @@ -2460,6 +2460,14 @@ static int qcow2_set_up_encryption(BlockDriverSt=
ate *bs, const char *encryptfmt,
>  }
> =20
> =20
> +typedef struct PreallocCo {
> +    BlockDriverState *bs;
> +    uint64_t offset;
> +    uint64_t new_length;
> +
> +    int ret;
> +} PreallocCo;

Because you create a typedef here...


> +static void coroutine_fn preallocate_co(void *opaque)
>  {
> +    struct PreallocCo *params =3D opaque;

you could drop 'struct' here, the way you already dropped it...

> +static int preallocate(BlockDriverState *bs,
> +                       uint64_t offset, uint64_t new_length)
> +{
> +    PreallocCo params =3D {
> +        .bs         =3D bs,
> +        .offset     =3D offset,
> +        .new_length =3D new_length,
> +        .ret        =3D -EINPROGRESS,
> +    };

=2E..here.  But that doesn't change semantics, so either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--a17v0c5SCv5H9du5JENBaFCeJuR18febG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnb+AUACgkQp6FrSiUn
Q2oJnAgAsHyHRoRikT3N7Bl/RAZPcKD5+02YQYKpIwJ+O2TNfVVwuDE7dbgQfpgk
KoTvfkbmclF/lS4n89b5DM71ZPGOjwAxSSvpBGQYpCRyZoS6dfVMTQJjejod17eO
dgOrRLa17HuqHBXzkSHytHpeIHMyEA81kdFRxd+XDiSHNugKLsV+RwmYPp10sOXa
NVNhegcV57wmI6JFfPVR05LTSR2e6O9D8ZobvZVP8NdS3wuJQG8UHazCq/6YMeMR
V/DHzBramU7DN2vf1ap/MOoqefHniyqREs7BJ2oqCm7SkkirJ8s192Obaj46OCb/
nRBsa1FiYizb9+hbQAYPWhp301GbDA==
=ypv0
-----END PGP SIGNATURE-----

--a17v0c5SCv5H9du5JENBaFCeJuR18febG--
