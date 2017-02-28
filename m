Received: from eggs.gnu.org ([2001:4830:134:3::10]:47022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijA1-0000BQ-Dh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijA0-00052J-AH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:53:53 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-5-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <22686429-61f6-593f-9661-7b46932c388e@redhat.com>
Date: Tue, 28 Feb 2017 15:53:40 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tt6ADLiDibtjcIibOAwplXwoRghtbNI2i"
Subject: Re: [Qemu-devel] [PATCH v3 04/44] block: Involve block drivers in
 permission granting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tt6ADLiDibtjcIibOAwplXwoRghtbNI2i
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <22686429-61f6-593f-9661-7b46932c388e@redhat.com>
Subject: Re: [PATCH v3 04/44] block: Involve block drivers in permission
 granting
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:53, Kevin Wolf wrote:
> In many cases, the required permissions of one node on its children
> depend on what its parents require from it. For example, the raw format=

> or most filter drivers only need to request consistent reads if that's
> something that one of their parents wants.
>=20
> In order to achieve this, this patch introduces two new BlockDriver
> callbacks. The first one lets drivers first check (recursively) whether=

> the requested permissions can be set; the second one actually sets the
> new permission bitmask.
>=20
> Also add helper functions that drivers can use in their implementation
> of the callbacks to update their permissions on a specific child.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 206 ++++++++++++++++++++++++++++++++++++++=
+++++++-
>  include/block/block_int.h |  61 ++++++++++++++
>  2 files changed, 263 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Some irrelevant nagging below.

> diff --git a/block.c b/block.c
> index 9628c7a..cf3534f 100644
> --- a/block.c
> +++ b/block.c

[...]

> -static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new=
_bs)
> +static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new=
_bs,
> +                               bool check_new_perm)

I can't say I like this parameter name very much, but I can't come up
with anything better.

>  {
>      BlockDriverState *old_bs =3D child->bs;
> +    uint64_t perm, shared_perm;
> =20
>      if (old_bs) {
>          if (old_bs->quiesce_counter && child->role->drained_end) {
>              child->role->drained_end(child);
>          }
>          QLIST_REMOVE(child, next_parent);
> +
> +        /* Update permissions for old node. This is guaranteed to succ=
eed
> +         * because we're just taking a parent away, so we're loosening=

> +         * restrictions. */
> +        bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
> +        bdrv_check_perm(old_bs, perm, shared_perm, &error_abort);
> +        bdrv_set_perm(old_bs, perm, shared_perm);
>      }
> =20
>      child->bs =3D new_bs;
> @@ -1376,6 +1564,12 @@ static void bdrv_replace_child(BdrvChild *child,=
 BlockDriverState *new_bs)
>          if (new_bs->quiesce_counter && child->role->drained_begin) {
>              child->role->drained_begin(child);
>          }
> +
> +        bdrv_get_cumulative_perm(new_bs, &perm, &shared_perm);
> +        if (check_new_perm) {
> +            bdrv_check_perm(new_bs, perm, shared_perm, &error_abort);

Yeah, well, error_abort is not very good. But can be fixed later...

(We should at least pass it through and make that decision in
change_parent_backing_link().)

> +        }
> +        bdrv_set_perm(new_bs, perm, shared_perm);
>      }
>  }
> =20
> @@ -1390,6 +1584,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverStat=
e *child_bs,
> =20
>      ret =3D bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, =
errp);
>      if (ret < 0) {
> +        bdrv_abort_perm_update(child_bs);
>          return NULL;
>      }
> =20
> @@ -1403,7 +1598,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverStat=
e *child_bs,
>          .opaque         =3D opaque,
>      };
> =20
> -    bdrv_replace_child(child, child_bs);
> +    /* This performs the matching bdrv_set_perm() for the above check.=
 */
> +    bdrv_replace_child(child, child_bs, false);
> =20
>      return child;
>  }
> @@ -1434,7 +1630,7 @@ static void bdrv_detach_child(BdrvChild *child)
>          child->next.le_prev =3D NULL;
>      }
> =20
> -    bdrv_replace_child(child, NULL);
> +    bdrv_replace_child(child, NULL, false);

The bool is basically ignored, but I'd rather set it to true here
because there is no check call before; so if a new child was attached
(which it clearly isn't), we would indeed want check_new_perm =3D true.

(You see, just irrelevant nagging.)

Max

> =20
>      g_free(child->name);
>      g_free(child);


--tt6ADLiDibtjcIibOAwplXwoRghtbNI2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1jvQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AclYH/30ARgjcbtGBbDLsuVnuASVBD2DuAF8n
tJYAlBcKZZjY5b9AWpOt8yqsVonE8JDa+WCeDtiwV+/f2fmzEKvMgp83ufSRT0NJ
/TZb9VYlxtKWFWFZieM0p5bgpCtoZwVz4mvJGEil62Lju8qFJYwLi4PCpgx4Rrnn
y0Wi9nxsPZ/cEC+rkYk+4fJredFlJleQOm95Ms44xL9w9SCTQhUQrWFNoYdXLK2o
xlmbdgz225FKBvHG2b9Za98Q065j0zFw20nqEmbrbDuwdJBWlI31uXqqHlxITJ5S
ulrAiq9vSILA48khjLqvXtqFjo0DNKg8KB96uSXvxFp2SIj4dVbBMvA=
=o/SC
-----END PGP SIGNATURE-----

--tt6ADLiDibtjcIibOAwplXwoRghtbNI2i--
