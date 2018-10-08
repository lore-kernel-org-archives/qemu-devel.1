Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9bqx-0000hW-Pe
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9bqx-0000R3-2k
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:10:07 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-7-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c0168aed-d00f-5af7-917b-a0824c9b270f@redhat.com>
Date: Mon, 8 Oct 2018 22:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NbSqxtqqe7meHZzVE2PgZak0gwSxPPnD3"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/qcow2-refcount: fix
 out-of-file L1 entries to be zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NbSqxtqqe7meHZzVE2PgZak0gwSxPPnD3
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <c0168aed-d00f-5af7-917b-a0824c9b270f@redhat.com>
Subject: Re: [PATCH v2 6/7] block/qcow2-refcount: fix out-of-file L1 entries
 to be zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> Zero out corrupted L1 table entry, which reference L2 table out of
> underlying file.
> Zero L1 table entry means that "the L2 table and all clusters described=

> by this L2 table are unallocated."
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 44 ++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 44 insertions(+)

Hm.  The specification actually says nothing about offsets being allowed
past the end of the file, and I don't think we ever use them (outside of
a very short period during image creation, where we point to refcount
structures beyond the EOF).

So the patch looks OK to me, although I'd still prefer a separate
fprintf() and think it would be fine for check_refcounts_l1() to call
fix_table_entry() directly.

Max


--NbSqxtqqe7meHZzVE2PgZak0gwSxPPnD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7uZQACgkQ9AfbAGHV
z0Be0Qf+P67IrhWpHRqcgbkIEG4E3umtG3S4ZZ6QEs+rJdEal0HoId4aiHIrWAVa
anwxwNhITQLuEO2iAe91pCrefVryyDtO258eoNBZK3ZlRmdkv0rPtBH+Pem/uEKO
JcPgWxbLCEMM7gEIAuLRIoK8ZU4X4uYFtGQDEaLMCEzLOJUHtdjx9neVoppk0QBc
iZqe3MCuN8vEeEhxYnfKJWqTEjXFocz+nFYa7BbcKyaX3WUtAda75fnMgGgSzICM
5mGb9NKCH1W+wJ4KWvcwHX/WnpILZ5O+Kq1yHnHYrRZByh48EBO2vQyDVeiRgxnZ
pOZi1qrmznjjS8rO92I+ylb/xzXS6A==
=sZk1
-----END PGP SIGNATURE-----

--NbSqxtqqe7meHZzVE2PgZak0gwSxPPnD3--
