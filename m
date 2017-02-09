Received: from eggs.gnu.org ([2001:4830:134:3::10]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbqUw-0001I5-Lc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbqUv-0001Hs-K7
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:19:02 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-16-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17c4cf39-7272-549e-f40c-e5cbbfe369cf@redhat.com>
Date: Thu, 9 Feb 2017 09:18:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-16-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CRJ6bIWtuh1GqvTil37TXOIBBwTCxRlj0"
Subject: Re: [Qemu-devel] [PATCH 15/18] qmp: add block-dirty-bitmap-load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CRJ6bIWtuh1GqvTil37TXOIBBwTCxRlj0
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <17c4cf39-7272-549e-f40c-e5cbbfe369cf@redhat.com>
Subject: Re: [PATCH 15/18] qmp: add block-dirty-bitmap-load
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> For loading dirty bitmap from nbd server. Or for underlying storages fo=
r

s/storages/storage/

> other formats.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  blockdev.c           | 28 ++++++++++++++++++++++++++++
>  qapi/block-core.json | 14 ++++++++++++++
>  2 files changed, 42 insertions(+)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 1bc3fe386a..2529943e7f 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2790,6 +2790,34 @@ void qmp_block_dirty_bitmap_clear(const char *no=
de, const char *name,
>      aio_context_release(aio_context);
>  }
> =20
> +void qmp_block_dirty_bitmap_load(const char *node, const char *name,
> +                                 Error **errp)
> +{
> +    AioContext *aio_context;
> +    BlockDriverState *bs;
> +
> +    if (!node) {
> +        error_setg(errp, "Node cannot be NULL");
> +        return;
> +    }
> +    if (!name) {
> +        error_setg(errp, "Bitmap name cannot be NULL");
> +        return;
> +    }

QAPI guarantees that node and name are non-null for non-optional
arguments; these checks are dead code...

> +++ b/qapi/block-core.json
> @@ -1280,6 +1280,20 @@
>    'data': 'BlockDirtyBitmap' }
> =20
>  ##
> +# @block-dirty-bitmap-load:
> +#
> +# Load a dirty bitmap from the storage (qcow2 file or nbd export)
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
> +# Since: vz-7.4
> +##
> +  { 'command': 'block-dirty-bitmap-load',
> +    'data': 'BlockDirtyBitmap' }

=2E..since BlockDirtyBitmap defines them as required fields.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CRJ6bIWtuh1GqvTil37TXOIBBwTCxRlj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYnIhcAAoJEKeha0olJ0NqSTUIAIU/D423j8Rfn21j1xK2WgHH
MR/sL7cj0R1gtHzIte7u2m3+eyYFufctrKFTc04RrAuzTM7FUq+M+YV9Kyf+/B+e
xFNPFrMmmM+89vqNcLZxglJkbkt05k7tkkW5ClMJgKxWx2q4ONJHHIOHku3ce43r
m4uALqEGvIjc0jNafWZQgxQnKo1T1ch1xfTMLojr2/0BUx1m8M+aWIIu3u8YEW9v
9EVbeq9sJX/T14SXIgLBYd2lfGWWc9aNiRxwGzgyZzkeI9nsAuMcWKXUbB9/Mt7X
N1khYRNcmkC3Dap6ZSJQtgxy7J7btRRe0Eb8MhLN9O7bGflm47FbuOcezqHBC0k=
=tr0X
-----END PGP SIGNATURE-----

--CRJ6bIWtuh1GqvTil37TXOIBBwTCxRlj0--
