Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f86mg-0005Xd-C6
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f86mf-0007w1-6C
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:15:14 -0400
References: <cover.1521016003.git.berto@igalia.com>
	<e8ecd7dd92900230c2027c75ea0be1aac264a676.1521016003.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6e01b00-8e5d-cbf4-b0c7-e6f7d65cd0cc@redhat.com>
Date: Mon, 16 Apr 2018 18:15:05 +0200
MIME-Version: 1.0
In-Reply-To: <e8ecd7dd92900230c2027c75ea0be1aac264a676.1521016003.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yaKHg17gvXEXU3HT0FPZnPgzHjlkfRPzA"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs: Document the new default
 sizes of the qcow2 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yaKHg17gvXEXU3HT0FPZnPgzHjlkfRPzA
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <b6e01b00-8e5d-cbf4-b0c7-e6f7d65cd0cc@redhat.com>
Subject: Re: [PATCH v2 2/2] docs: Document the new default sizes of the qcow2
 caches
References: <cover.1521016003.git.berto@igalia.com>
 <e8ecd7dd92900230c2027c75ea0be1aac264a676.1521016003.git.berto@igalia.com>
In-Reply-To: <e8ecd7dd92900230c2027c75ea0be1aac264a676.1521016003.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-14 09:29, Alberto Garcia wrote:
> We have just reduced the refcount cache size to the minimum unless
> the user explicitly requests a larger one, so we have to update the
> documentation to reflect this change.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/qcow2-cache.txt | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 170191a242..c640d45d06 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -116,31 +116,28 @@ There are three options available, and all of the=
m take bytes:
>  "refcount-cache-size":   maximum size of the refcount block cache
>  "cache-size":            maximum size of both caches combined
> =20
> -There are two things that need to be taken into account:
> +There are a few things that need to be taken into account:
> =20
>   - Both caches must have a size that is a multiple of the cluster size=

>     (or the cache entry size: see "Using smaller cache sizes" below).
> =20
> - - If you only set one of the options above, QEMU will automatically
> -   adjust the others so that the L2 cache is 4 times bigger than the
> -   refcount cache.
> + - The default L2 cache size is 8 clusters or 1MB (whichever is more),=

> +   and the minimum is 2 clusters (or 2 cache entries, see below).
> =20
> -This means that these options are equivalent:
> + - The default (and minimum) refcount cache size is 4 clusters.
> =20
> -   -drive file=3Dhd.qcow2,l2-cache-size=3D2097152
> -   -drive file=3Dhd.qcow2,refcount-cache-size=3D524288
> -   -drive file=3Dhd.qcow2,cache-size=3D2621440
> + - If only "cache-size" is specified then QEMU will assign as much
> +   memory as possible to the L2 cache before increasing the refcount
> +   cache size.
> =20
> -The reason for this 1/4 ratio is to ensure that both caches cover the
> -same amount of disk space. Note however that this is only valid with
> -the default value of refcount_bits (16). If you are using a different
> -value you might want to calculate both cache sizes yourself since QEMU=

> -will always use the same 1/4 ratio.
> +Unlike L2 tables, refcount blocks are not used during normal I/O but
> +only during allocations and internal snapshots. In most cases they are=

> +accessed sequentially (even during random guest I/O) so increasing the=

> +refcount cache size won't have any measurable effect in performance.

Could you add a note that it can have a measurable effect when using
internal snapshots and the user may want to think about increasing its
size when making heavy use of them?

Max

> -It's also worth mentioning that there's no strict need for both caches=

> -to cover the same amount of disk space. The refcount cache is used
> -much less often than the L2 cache, so it's perfectly reasonable to
> -keep it small.
> +Before QEMU 2.12 the refcount cache had a default size of 1/4 of the
> +L2 cache size. This resulted in unnecessarily large caches, so now the=

> +refcount cache is as small as possible unless overridden by the user.
> =20
> =20
>  Using smaller cache entries
>=20



--yaKHg17gvXEXU3HT0FPZnPgzHjlkfRPzA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrUzAkACgkQ9AfbAGHV
z0AhMAf9E1CkcGR75J7YcwRVP68HZJyMJWFmynv/vcifWb6FkQAwKQLq/F3X2DcT
ikOezVb+Q1AtmQWvuZ1i2QSGl9qdQ0w2sPzV451Lo/bKT8Hal1F6n51fCKnExgi9
ZAChlmS82bCBUWpqJRTl7+fD9OsqFRueX9xkdI1rXMnr0br7idCBZR2PgBkFN1Pi
8o32e//DUYlmpGoQFgKsupOU5l6hSpovWjORRZgKxqEsOWTw2br7jXN6cBiF9bS4
G10TVUe9oafbHTfjRvgqtF0T4h1SbxauSiN9nxAyc/9bD3GsY7O5EJFf1IRjpmXX
JFDBzlss7YH6jpr554LQbkJX/7XSWQ==
=vsCK
-----END PGP SIGNATURE-----

--yaKHg17gvXEXU3HT0FPZnPgzHjlkfRPzA--
