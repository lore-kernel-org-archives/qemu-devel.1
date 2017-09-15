Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvws-0007PK-So
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvwr-0006xL-N8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:06:46 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <726a7ef6-820b-2695-4ce5-ffa06da078d1@redhat.com>
Date: Fri, 15 Sep 2017 14:06:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170915101008.16646-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bLiElVtbVOmtmSVVts722p4TDBuHMAQBj"
Subject: Re: [Qemu-devel] [PATCH 6/6] block: Fix permissions after
 bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bLiElVtbVOmtmSVVts722p4TDBuHMAQBj
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <726a7ef6-820b-2695-4ce5-ffa06da078d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] block: Fix permissions after
 bdrv_reopen()
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915101008.16646-7-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> If we switch between read-only and read-write, the permissions that
> image format drivers need on bs->file change, too. Make sure to update
> the permissions during bdrv_reopen().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  1 +
>  block.c               | 64 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 65 insertions(+)
>=20

> +static BlockReopenQueueEntry *find_parent_in_reopen_queue(BlockReopenQ=
ueue *q,
> +                                                          BdrvChild *c=
)
> +{
> +    BlockReopenQueueEntry *entry;
> +
> +    QSIMPLEQ_FOREACH(entry, q, entry) {
> +        BlockDriverState *bs =3D entry->state.bs;
> +        BdrvChild *child;
> +
> +        QLIST_FOREACH(child, &bs->children, next) {
> +            if (child =3D=3D c) {
> +                return entry;

An O(n^2) loop. Is it going to bite us at any point in the future, or
are we generally dealing with a small enough queue size and BDS graph to
not worry about it?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bLiElVtbVOmtmSVVts722p4TDBuHMAQBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8JLoACgkQp6FrSiUn
Q2qzpQgArssYSA7HBeRkJDwcYGwrjtoTmVNPiZ5oRFpyu3h9cqVKKT/f6xWGeWgL
ZvlAq6/r2YEz7gHoKgZ0yNjJpNHeIrgJ4PA18hBIIm6h0nlqxCozirH1lbzOWVVu
osNqyb/7QAHGahyumUdej6DEu+3fuUMfkeAfb5x4JWI/kLYFnpfJnoT5Qq9/F84y
P0E2iTL/EHkX4S2MUOub/VSav6MRN3xThPD0kXMtluJ77hphJFJZH/5gP4rDRdS5
FBy+jYN+KQHH1Y7XD+TZd7VH/VFDI8aiAxjZn6yLjCU5cuoseVLhCiFr6QLNdGtT
ubh4Uv9WB/5FdAvJv8NV5oOJBPwxag==
=3qT2
-----END PGP SIGNATURE-----

--bLiElVtbVOmtmSVVts722p4TDBuHMAQBj--
