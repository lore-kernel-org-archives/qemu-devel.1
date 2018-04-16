Received: from eggs.gnu.org ([2001:4830:134:3::10]:33118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f86lr-0004ue-Id
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f86lq-0007UO-Ek
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:14:23 -0400
References: <cover.1521016003.git.berto@igalia.com>
	<14bbd13c5c93211ed4e36188624f429087a6a273.1521016003.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6fea1d10-d959-4d98-4cb4-07d3afcc34ce@redhat.com>
Date: Mon, 16 Apr 2018 18:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <14bbd13c5c93211ed4e36188624f429087a6a273.1521016003.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QpHCx0auiS5AFdHo76ibNbmxPEPAREg6N"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: Give the refcount cache the
 minimum possible size by default
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
--QpHCx0auiS5AFdHo76ibNbmxPEPAREg6N
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <6fea1d10-d959-4d98-4cb4-07d3afcc34ce@redhat.com>
Subject: Re: [PATCH v2 1/2] qcow2: Give the refcount cache the minimum
 possible size by default
References: <cover.1521016003.git.berto@igalia.com>
 <14bbd13c5c93211ed4e36188624f429087a6a273.1521016003.git.berto@igalia.com>
In-Reply-To: <14bbd13c5c93211ed4e36188624f429087a6a273.1521016003.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-14 09:29, Alberto Garcia wrote:
> The L2 and refcount caches have default sizes that can be overridden
> using the l2-cache-size and refcount-cache-size (an additional
> parameter named cache-size sets the combined size of both caches).
>=20
> Unless forced by one of the aforementioned parameters, QEMU will set
> the unspecified sizes so that the L2 cache is 4 times larger than the
> refcount cache.
>=20
> This is based on the premise that the refcount metadata needs to be
> only a fourth of the L2 metadata to cover the same amount of disk
> space. This is incorrect for two reasons:
>=20
>  a) The amount of disk covered by an L2 table depends solely on the
>     cluster size, but in the case of a refcount block it depends on
>     the cluster size *and* the width of each refcount entry.
>     The 4/1 ratio is only valid with 16-bit entries (the default).
>=20
>  b) When we talk about disk space and L2 tables we are talking about
>     guest space (L2 tables map guest clusters to host clusters),
>     whereas refcount blocks are used for host clusters (including
>     L1/L2 tables and the refcount blocks themselves). On a fully
>     populated (and uncompressed) qcow2 file, image size > virtual size
>     so there are more refcount entries than L2 entries.
>=20
> Problem (a) could be fixed by adjusting the algorithm to take into
> account the refcount entry width. Problem (b) could be fixed by
> increasing a bit the refcount cache size to account for the clusters
> used for qcow2 metadata.
>=20
> However this patch takes a completely different approach and instead
> of keeping a ratio between both cache sizes it assigns as much as
> possible to the L2 cache and the remainder to the refcount cache.
>=20
> The reason is that L2 tables are used for every single I/O request
> from the guest and the effect of increasing the cache is significant
> and clearly measurable. Refcount blocks are however only used for
> cluster allocation and internal snapshots and in practice are accessed
> sequentially in most cases, so the effect of increasing the cache is
> negligible (even when doing random writes from the guest).
>=20
> So, make the refcount cache as small as possible unless the user
> explicitly asks for a larger one.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c              | 31 +++++++++++++++++++------------
>  block/qcow2.h              |  4 ----
>  tests/qemu-iotests/137.out |  2 +-
>  3 files changed, 20 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QpHCx0auiS5AFdHo76ibNbmxPEPAREg6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrUy9YACgkQ9AfbAGHV
z0CrCQf+N4AFe9fn3+CKAZbaTRh+9kFc4BPXMVUfrLEOX/O908erf4kQdFSfsztK
is5c5qtgxsldLubmNUhjePz/BYm2ETzoIi7pWTe/hOlqhwdvSCeiG1AhelR6UqYQ
OWf3YI2ZxhuVQL9woi6xZmtjyIi1H7Rch2Oy6OhtEGWQ9E4Nyb+Nvr2YPfC3hK5O
/JwFRQjowU5BDdIz6vepJ3v8mXPICXoCOjwvUTU6wNzDuH+ruBiNXOwmSG0h7VsO
bh/ruudMVfDEbW56dDqzsCaO8FUmG4dsr4BAydKzwdmdo2+GJBGgma6UEHr4+1QB
YDRQT/PXnnPC/zPn6jOYvmX0NU3jcg==
=QwiE
-----END PGP SIGNATURE-----

--QpHCx0auiS5AFdHo76ibNbmxPEPAREg6N--
