Received: from eggs.gnu.org ([2001:4830:134:3::10]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYQC-00041Y-2p
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYQA-0000F5-Dc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:05:27 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<97419f591a3aeb5c69c9b24a495f3e603cacb32f.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82955b47-0b64-fccf-2173-711ad86d1a6f@redhat.com>
Date: Tue, 16 Jan 2018 15:05:08 -0600
MIME-Version: 1.0
In-Reply-To: <97419f591a3aeb5c69c9b24a495f3e603cacb32f.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3pNxSNQPQLrzNrrXOxBDr4RmLw4iywt3R"
Subject: Re: [Qemu-devel] [PATCH v2 02/32] qcow2: Add table size field to
 Qcow2Cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3pNxSNQPQLrzNrrXOxBDr4RmLw4iywt3R
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <82955b47-0b64-fccf-2173-711ad86d1a6f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/32] qcow2: Add table size field to
 Qcow2Cache
References: <cover.1513342045.git.berto@igalia.com>
 <97419f591a3aeb5c69c9b24a495f3e603cacb32f.1513342045.git.berto@igalia.com>
In-Reply-To: <97419f591a3aeb5c69c9b24a495f3e603cacb32f.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> The table size in the qcow2 cache is currently equal to the cluster
> size. This doesn't allow us to use the cache memory efficiently,
> particularly with large cluster sizes, so we need to be able to have
> smaller cache tables that are independent from the cluster size. This
> patch adds a new field to Qcow2Cache that we can use instead of the
> cluster size.
>=20
> The current table size is still being initialized to the cluster size,
> so there are no semantic changes yet, but this patch will allow us to
> prepare the rest of the code and simplify a few function calls.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> @@ -331,7 +330,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs,=
 Qcow2Cache *c,
>      trace_qcow2_cache_get(qemu_coroutine_self(), c =3D=3D s->l2_table_=
cache,
>                            offset, read_from_disk);
> =20
> -    if (offset_into_cluster(s, offset)) {
> +    if (offset & (c->table_size - 1)) {

Worth writing that as QEMU_IS_ALIGNED(offset, c->table_size) instead of
open-coding the bit-wise math?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3pNxSNQPQLrzNrrXOxBDr4RmLw4iywt3R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeaQQACgkQp6FrSiUn
Q2pgUQf/Y5zHy1iI0jp/so0XI6mSIV914YJsKmFRGmXgPW/2gMDWbc6GV0LaCroY
gxmQNNzLjQzCYeqch5yJfVYIIwnDLhvO3SYdAIa7B5Gb24UvXG7nek7bDHuFXTTX
vadEyG8o2RqAAJp1pnZmikAHeknj313CvclUEdjjf4r0/F7GLAZ9h1bpOQ89Zsv/
s1XOmQfhB5fYrxVW/NsjdugqYn993cxSaRiZ/GDKbQqsJJn5UdBbY7OEKbyIGrXZ
5UyH8yCsTL7UdFOVErvwiJBCljAVd0Ru2V7RVOrHEaA5xzgbBp+Lxy82dog5emtw
QL5Dy6J7xeil3Fd3WTLBMWZ/L8EOBg==
=K03z
-----END PGP SIGNATURE-----

--3pNxSNQPQLrzNrrXOxBDr4RmLw4iywt3R--
