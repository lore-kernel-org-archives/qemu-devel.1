Received: from eggs.gnu.org ([2001:4830:134:3::10]:43758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dij2y-00009H-Ve
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dij2x-0007sy-Sf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:18:52 -0400
References: <20170818133118.8650-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
Date: Fri, 18 Aug 2017 10:18:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170818133118.8650-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UBsHjQP3eFeJ4r91OQ2qJtotHtgNT7mmN"
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UBsHjQP3eFeJ4r91OQ2qJtotHtgNT7mmN
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
References: <20170818133118.8650-1-stefanha@redhat.com>
In-Reply-To: <20170818133118.8650-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
> Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1=
)
> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
> s->cluster_data when the first read operation is performance on a
> compressed cluster.
>=20
> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any=

> code paths that can allocate these buffers, so remove the free function=
s
> in the error code path.
>=20
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Alexey: Does this improve your memory profiling results?

Is this a regression from earlier versions?  Likely, it is NOT -rc4
material, and thus can wait for 2.11; but it should be fine for -stable
as part of 2.10.1 down the road.

> +++ b/block/qcow2-cluster.c
> @@ -1516,6 +1516,23 @@ int qcow2_decompress_cluster(BlockDriverState *b=
s, uint64_t cluster_offset)
>          nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csize=
_mask) + 1;
>          sector_offset =3D coffset & 511;
>          csize =3D nb_csectors * 512 - sector_offset;
> +
> +        /* Allocate buffers on first decompress operation, most images=
 are
> +         * uncompressed and the memory overhead can be avoided.  The b=
uffers
> +         * are freed in .bdrv_close().
> +         */
> +        if (!s->cluster_data) {
> +            /* one more sector for decompressed data alignment */
> +            s->cluster_data =3D qemu_try_blockalign(bs->file->bs,
> +                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> +            if (!s->cluster_data) {
> +                return -EIO;

Is -ENOMEM any better than -EIO here?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UBsHjQP3eFeJ4r91OQ2qJtotHtgNT7mmN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmXBU0ACgkQp6FrSiUn
Q2qokwf8CJtc0eEm7VBR8nvO+PNsuUKDTszuJNP6vGk8RPhBwwsWz8Y0gR0CqOQb
KZhOuQ3Ne0I9NGAeFbDGZX8Un9G7t5iDEEDIcukNWkcKpjdqe1MQOG0vyvwq/KNH
heHK4jyUbkjYFXns63rcynsnCQmJFFvytjsaxOjbmgjYgpbYlNtQXFGV5WMN3pV4
RaCQ6Zk0jMhTDpWlw0ZotEEPyF5no0UrI9YzQWgQ04cs2xBj2X6aFKc5DXbI5egH
hd8GFfYxh05E9RiM15D0h3mvPDBmS/0eZMqbye5tlkbyjz7ke5goFe7/gXAx4qdz
X+HW40jKWhLT2nAFwjexIAbfnhWc+g==
=Ispc
-----END PGP SIGNATURE-----

--UBsHjQP3eFeJ4r91OQ2qJtotHtgNT7mmN--
