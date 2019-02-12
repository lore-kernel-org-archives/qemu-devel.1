Received: from eggs.gnu.org ([209.51.188.92]:39584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtcle-0002xd-BZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtcld-0005xz-8v
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:26:50 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <987e83f6-2a6f-9547-a6d2-afe7a323181d@redhat.com>
Date: Tue, 12 Feb 2019 12:26:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190212010248.11056-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XcLwFLmlmsoRZpeWH80Bmt1k7aKu04BII"
Subject: Re: [Qemu-devel] [PATCH 2/5] block/dirty-bitmaps: rename frozen
 predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XcLwFLmlmsoRZpeWH80Bmt1k7aKu04BII
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <987e83f6-2a6f-9547-a6d2-afe7a323181d@redhat.com>
Subject: Re: [PATCH 2/5] block/dirty-bitmaps: rename frozen predicate helper
References: <20190212010248.11056-1-jsnow@redhat.com>
 <20190212010248.11056-3-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 7:02 PM, John Snow wrote:
> "Frozen" was a good description a long time ago, but it isn't adequate =
now.
> Rename the frozen predicate to has_successor to make the semantics of t=
he
> predicate more clear to outside callers.
>=20
> In the process, remove some calls to frozen() that no longer semantical=
ly
> make sense. For enabled and disabled in particular, it's actually okay =
for
> the internals to do this but only forbidden for users to invoke them, a=
nd
> all of the QMP entry uses already check against qmp_locked.
>=20
> Several other assertions really want to check that the bitmap isn't in-=
use
> by another operation -- use the qmp_locked function for this instead, w=
hich
> presently also checks for has_successor.
> ---

Missing S-o-b on entire series, so you have to send v2 anyway :)

> @@ -244,12 +244,16 @@ int bdrv_dirty_bitmap_create_successor(BlockDrive=
rState *bs,
>      uint64_t granularity;
>      BdrvDirtyBitmap *child;
> =20
> -    if (bdrv_dirty_bitmap_frozen(bitmap)) {
> -        error_setg(errp, "Cannot create a successor for a bitmap that =
is "
> -                   "currently frozen");
> +    if (bdrv_dirty_bitmap_has_successor(bitmap)) {
> +        error_setg(errp, "Cannot create a successor for a bitmap that =
already "
> +                   "has one");
> +        return -1;
> +    }
> +    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
> +        error_setg(errp, "Cannot create a successor for a bitmap that =
is in-use "
> +                   "by an operation.");
>          return -1;

No trailing dot in error_setg().

Should these two errors be swapped (check for locked before
has_successor)?  After all, having a successor is an internal detail,
whereas being in use by something I already triggered is fairly
straightforward to understand.


> @@ -325,7 +328,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDr=
iverState *bs,
>  /**
>   * In cases of failure where we can no longer safely delete the parent=
,
>   * we may wish to re-join the parent and child/successor.
> - * The merged parent will be un-frozen, but not explicitly re-enabled.=

> + * The merged parent will not be user_locked, but not explicitly re-en=
abled.

s/but not/nor/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XcLwFLmlmsoRZpeWH80Bmt1k7aKu04BII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjD9sACgkQp6FrSiUn
Q2r8DAgAnQMdbQD0nqbrO6pi7Ca/HtVpYYJ5xpjvFaL86/HcAyltSw1ipV1QiXMy
aFcnAw1WRfGXByafmG/p3OMqIXOLZemtZX14W9WmXt++dy7SZs9+iAmPZxoki9Am
DCuG7t5enAtgTR6I32Zo8eyqPK9+hJCje1hdaPiM8elKP+RuhuC6O9KLCTLL/gCd
DskDDqZTFHRmkuzWhQRnFbyaisasK6o93nCmQH72Bc6LPQmfR+hWE1r6k0WNEIIs
1irp+VJ29mpp79L1QV85ZLFgSjIcf0WIMboVTI4JZlGanT7PjbK5xKEa5d0aQC8c
myyMvv9oueR20L+2mgekmvcejRWJiA==
=MEp9
-----END PGP SIGNATURE-----

--XcLwFLmlmsoRZpeWH80Bmt1k7aKu04BII--
