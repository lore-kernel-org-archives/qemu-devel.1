Received: from eggs.gnu.org ([2001:4830:134:3::10]:56917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGYbF-0001vT-Or
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGYbC-0006ky-0v
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGYbB-0006kK-Ok
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:29:45 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-14-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6795a44e-a0c4-2c09-390b-af07f675363b@redhat.com>
Date: Thu, 1 Jun 2017 17:29:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xAa5qieCMFcUTQktaCF2RuDgu9EjOD9AN"
Subject: Re: [Qemu-devel] [PATCH 13/19] nbd/server: return original error
 codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xAa5qieCMFcUTQktaCF2RuDgu9EjOD9AN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <6795a44e-a0c4-2c09-390b-af07f675363b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/19] nbd/server: return original error
 codes
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> The code in many cases return -EINVAL or -EIO instead of original error=

> code from, for example, write_sync(). Following patch will need EPIPE
> handling, so, let's refactor this where possible (the only exclusion
> is nbd_co_receive_request, with own return-code convention)

Do we still want/need EPIPE handling, given the discussion on the
previous two patches?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 124 +++++++++++++++++++++++++++++++++++++--------------=
--------
>  1 file changed, 77 insertions(+), 47 deletions(-)
>=20

Feels weird to have a net gain in code, but maybe worthwhile.

> diff --git a/nbd/server.c b/nbd/server.c
> index a47f13e4fb..30dfb81a5c 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -136,30 +136,38 @@ static void nbd_client_receive_next_request(NBDCl=
ient *client);
>  static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
>                                        uint32_t opt, uint32_t len)
>  {
> +    int ret;
>      uint64_t magic;
> =20
>      TRACE("Reply opt=3D%" PRIx32 " type=3D%" PRIx32 " len=3D%" PRIu32,=

>            type, opt, len);
> =20
>      magic =3D cpu_to_be64(NBD_REP_MAGIC);
> -    if (write_sync(ioc, &magic, sizeof(magic), NULL) < 0) {
> +    ret =3D write_sync(ioc, &magic, sizeof(magic), NULL);
> +    if (ret < 0) {
>          LOG("write failed (rep magic)");
> -        return -EINVAL;
> +        return ret;
>      }

Constructs like this should get shorter once we plumb errp all the way
through.  Okay, I can live with the temporary verbosity.

You may still have to make changes due to rebasing (in which case I'll
definitely want to review again); but if this patch doesn't need further
rework, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xAa5qieCMFcUTQktaCF2RuDgu9EjOD9AN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMJVWAAoJEKeha0olJ0NqpJ8IAI1M69VNkdFaQXMC+TkRMQD1
lx15TxYVwjbJzs9mKInJVXylsyL9w5CwxxlnaDU6kQkxM4aXVsCLaYo+xgLYFxx9
R3eD1XVMma226PxGLAMBXYzhejNyU+J13u46Z75zmGMe9WULLTF0ir3fpaMWnU7n
hqZTtSPcuQgfhdSTIMlDO83my8z90c40RQgw4WdWMylO6b7WnQov7vIFm4hNPazh
UsrHFPr14FKE1anlPczj4qp56nydk0qsqnKv8svxC0VC/iV4TrAfMUUpY5JcRXFO
njyIZfula7xIhapl310YJ9aNGNCs2LTxSu8J5HAe71BFzxdmlVfHTC7taK8kidk=
=WY1i
-----END PGP SIGNATURE-----

--xAa5qieCMFcUTQktaCF2RuDgu9EjOD9AN--
