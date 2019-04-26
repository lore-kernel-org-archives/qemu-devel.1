Received: from eggs.gnu.org ([209.51.188.92]:37858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK8eQ-0005ws-GJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK8eP-0004ne-I3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:44:58 -0400
References: <20190331111747.14685-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b7523e98-54f4-3144-af47-c0338f776fa8@redhat.com>
Date: Fri, 26 Apr 2019 23:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LFD9Tie4pEwGjhuSAT2JSWrbWIzTcQFTS"
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Use bdrv_unref_child() for
 all children in bdrv_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LFD9Tie4pEwGjhuSAT2JSWrbWIzTcQFTS
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b7523e98-54f4-3144-af47-c0338f776fa8@redhat.com>
Subject: Re: [PATCH for-4.1] block: Use bdrv_unref_child() for all children in
 bdrv_close()
References: <20190331111747.14685-1-berto@igalia.com>
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.03.19 13:17, Alberto Garcia wrote:
> bdrv_unref_child() does the following things:
>=20
>   - Updates the child->bs->inherits_from pointer.
>   - Calls bdrv_detach_child() to remove the BdrvChild from bs->children=
=2E
>   - Calls bdrv_unref() to unref the child BlockDriverState.
>=20
> When bdrv_unref_child() was introduced in commit 33a604075c it was not
> used in bdrv_close() because the drivers that had additional children
> (like quorum or blkverify) had already called bdrv_unref() on their
> children during their own close functions.
>=20
> This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
> blkverify) so there's no reason not to use bdrv_unref_child() in
> bdrv_close() anymore.

Hm.  Sounds reasonable.  But the commit dates are interesting.  The TODO
was introduced in commit 33a604075c51, so actually Kevin wrote that
patch just one day before the patches for vmdk, quorum, and blkverify.
They hit the mailing list two months apart, though (July vs. September
2015).

But still I wonder whether there was really no other reason nobody
resolved this TODO until now.

Hm.  Perhaps because it looks like we want to keep the children list
central to the block layer so no block driver would have to ever even
call bdrv_unref_child().  But that sounds overly complicated for no
gain; and as long as e.g. quorum has the children list in its own state
object, it should unref all children when it deletes the list, because
that's the right thing to do.

So, yeah, I'm a bit wary, but I can't see why not.

> After this there's also no need to remove bs->backing and bs->file
> separately from the rest of the children, so bdrv_close() can be
> simplified.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--LFD9Tie4pEwGjhuSAT2JSWrbWIzTcQFTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDe9IACgkQ9AfbAGHV
z0DsTwgAjYji7VYhgj6HSXws0GkabcSEb4I6uTAxyw7rctTfFSvSFrp3xW+6OCF5
NbNO5k1rkIsMNMLfNQ4fQjVjVj0THuSClTBKT8JyB+0Rj5/ynCrbaoU9qBTHr8vq
VxkolZ3F/dNgZQVySLU3tJxyT9/cSLuWj317DI/ryh55AN+QTZn68I7CyRI+K/X+
ANYq8os3Ya+F2Pyl044GK6WDZkFYp/DJ/4C6EVz2bIv0veph+ffw7ehHgwKBw7yA
1FsZnCjxm575uRWgagmSNllELj6qG3fCwOqLIPYdLVvx1pJUI6JQUMeRM0re2BWt
zbumOkvZOiZ3NBSy8ngLJoxzAvSXMg==
=Deqa
-----END PGP SIGNATURE-----

--LFD9Tie4pEwGjhuSAT2JSWrbWIzTcQFTS--
