Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqJ19-0007kK-Br
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqJ18-0002Gg-8j
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:40:35 -0500
References: <cover.1518711805.git.berto@igalia.com>
	<894433c083e20bbb82e208ea8b067b13609dbc19.1518711805.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e56321ad-d08f-5061-b356-2bebae25dc98@redhat.com>
Date: Mon, 26 Feb 2018 14:40:08 +0100
MIME-Version: 1.0
In-Reply-To: <894433c083e20bbb82e208ea8b067b13609dbc19.1518711805.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bpf235V80NgTBivQxdbebwWIpD0zY0zwy"
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] qcow2: Allow checking and
 repairing corrupted internal snapshots
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
--Bpf235V80NgTBivQxdbebwWIpD0zY0zwy
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <e56321ad-d08f-5061-b356-2bebae25dc98@redhat.com>
Subject: Re: [RFC PATCH 1/2] qcow2: Allow checking and repairing corrupted
 internal snapshots
References: <cover.1518711805.git.berto@igalia.com>
 <894433c083e20bbb82e208ea8b067b13609dbc19.1518711805.git.berto@igalia.com>
In-Reply-To: <894433c083e20bbb82e208ea8b067b13609dbc19.1518711805.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-15 17:30, Alberto Garcia wrote:
> The L1 table parameters of internal snapshots are generally not
> checked by QEMU. This patch allows 'qemu-img check' to detect broken
> snapshots and to skip them when doing the refcount consistency check.
>=20
> Since without an L1 table we don't have a reliable way to recover the
> data from the snapshot, when 'qemu-img check' runs in repair mode this
> patch simply removes the corrupted snapshots.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-snapshot.c | 53 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c          |  7 ++++++-
>  block/qcow2.h          |  2 ++
>  3 files changed, 61 insertions(+), 1 deletion(-)

I think shouldn't delete things in qemu-img check.  I think we do need a
new mode (-r lossy? -r destructive?), although I'd personally even
prefer indeed asking the user before every destructive change.  The only
reason I'm not strongly in favor of this is because we don't have an
infrastructure for that (yet).

> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index cee25f582b..7a36073e3e 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -736,3 +736,56 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
> =20
>      return 0;
>  }
> +
> +/* Check the snapshot table and optionally delete the corrupted entrie=
s */
> +int qcow2_snapshot_table_check(BlockDriverState *bs, BdrvCheckResult *=
result,
> +                               BdrvCheckMode fix)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    bool keep_checking;
> +    int ret, i;
> +
> +    do {
> +        keep_checking =3D false;
> +
> +        for (i =3D 0; i < s->nb_snapshots; i++) {> +            QCowSn=
apshot *sn =3D s->snapshots + i;
> +            bool found_corruption =3D false;
> +
> +            if (offset_into_cluster(s, sn->l1_table_offset)) {
> +                fprintf(stderr, "%s snapshot %s (%s) l1_offset=3D%#" P=
RIx64 ": "
> +                        "L1 table is not cluster aligned; snapshot tab=
le entry "
> +                        "corrupted\n",
> +                        (fix & BDRV_FIX_ERRORS) ? "Deleting" : "ERROR"=
,
> +                        sn->id_str, sn->name, sn->l1_table_offset);
> +                found_corruption =3D true;
> +            } else if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_=
t)) {
> +                fprintf(stderr, "%s snapshot %s (%s) l1_size=3D%#" PRI=
x32 ": "
> +                        "L1 table is too large; snapshot table entry c=
orrupted\n",
> +                        (fix & BDRV_FIX_ERRORS) ? "Deleting" : "ERROR"=
,
> +                        sn->id_str, sn->name, sn->l1_size);
> +                found_corruption =3D true;
> +            }

This code assumes the snapshot table itself has been valid.  Why should
it be when it contains garbage entries?

> +
> +            if (found_corruption) {
> +                result->corruptions++;
> +                sn->l1_size =3D 0; /* Prevent this L1 table from being=
 used */
> +                if (fix & BDRV_FIX_ERRORS) {
> +                    ret =3D qcow2_snapshot_delete(bs, sn->id_str, sn->=
name, NULL);

So calling this is actually very dangerous.  It modifies the snapshot
table which I wouldn't trust is actually just a snapshot table.  It
could intersect any other structure in the qcow2 image.  Yes, we do an
overlap check, but that only protects metadata, and I don't really want
to see an overlap check corruption when repairing the image; especially
since this means you cannot fix the corruption.

I don't quite know myself what to do instead, but I guess my main point
would be:  Before any (potentially) destructive changes are made, the
user should have the chance of still opening the image read-only and
copying all the data off somewhere else.  Which of course again means we
shouldn't prevent the user from opening an image because a snapshot is
broken.

(This would at least allow the user to convert the image to raw, then
invoke -r destructive, and then compare the result to see whether
anything has visibly changed.)

Max

> +                    if (ret < 0) {
> +                        return ret;
> +                    }
> +                    result->corruptions_fixed++;
> +                    /* If we modified the snapshot table we can't keep=

> +                     * iterating. We have to start again from the
> +                     * beginning instead. */
> +                    keep_checking =3D true;
> +                    break;
> +                }
> +            }
> +        }
> +
> +    } while (keep_checking);
> +
> +    return 0;
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2c6c33b67c..20e16ea602 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -546,7 +546,12 @@ int qcow2_mark_consistent(BlockDriverState *bs)
>  static int qcow2_check(BlockDriverState *bs, BdrvCheckResult *result,
>                         BdrvCheckMode fix)
>  {
> -    int ret =3D qcow2_check_refcounts(bs, result, fix);
> +    int ret =3D qcow2_snapshot_table_check(bs, result, fix);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D qcow2_check_refcounts(bs, result, fix);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1a84cc77b0..19f14bfc1e 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -637,6 +637,8 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
>                              const char *snapshot_id,
>                              const char *name,
>                              Error **errp);
> +int qcow2_snapshot_table_check(BlockDriverState *bs, BdrvCheckResult *=
result,
> +                               BdrvCheckMode fix);
> =20
>  void qcow2_free_snapshots(BlockDriverState *bs);
>  int qcow2_read_snapshots(BlockDriverState *bs);
>=20



--Bpf235V80NgTBivQxdbebwWIpD0zY0zwy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqUDjgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIfwIALEhOvB77Jm2ItPpEb4UIKQPDCcvL8Wa
7EKuiSFBDDsRC/4Q9xC/Pr6rSxWnqdu7OpMf24fQPewxrSbftNJ4AY0Qhw6qkPwY
b7SahpN6d7LawPP9hMHYBZo/celLej8C/vIqZ7itgQ+ECkad4waBwL0W4kGs8jeF
N+EV0rvWo9N4vCD3IHNf9UuJjwfnBdt9wkH8QIbEG7noUNpC7JlhNwzcbLQCz9d7
8boa0EoQaeU89UctcYqXOHwBtUvgZOU2bzlgKSt9RttiuUzbODizF1KdVHuCjxrj
C9K39ROGzvHwZgzV4X4HAf0Z+VubYvewQvZ3q/uhV9PsI5PAaEhMGgs=
=LCVj
-----END PGP SIGNATURE-----

--Bpf235V80NgTBivQxdbebwWIpD0zY0zwy--
