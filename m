Received: from eggs.gnu.org ([2001:4830:134:3::10]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dXqx9-0000it-NR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dXqx8-00038D-DT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:31:55 -0400
Date: Wed, 19 Jul 2017 17:31:50 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170719153150.GC8266@andariel.pipo.sk>
References: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 15:58:05 +0200, Kevin Wolf wrote:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.
>=20
> This is true as far as commands issued by libvirt are concerned. It only
> uses BlockBackend names to address nodes, so any operations it performs
> still operate on the root of the tree as intended.
>=20
> However, the assumption breaks down when you consider query commands,
> which return data for the wrong node now. These commands also return
> information on some child nodes (bs->file and/or bs->backing), which
> libvirt does make use of, and which refer to the wrong nodes, too.
>=20
> One of the consequences is that oVirt gets wrong information about the
> image size and stops the VM in response as long as a mirror or commit
> job is running:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1470634
>=20
> This patch fixes the problem by hiding the implicit nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user
> doesn't indicate that they are aware of those nodes by providing a node
> name for them in the QMP command to start the block job.
>=20
> The node-based commands query-named-block-nodes and query-blockstats
> with query-nodes=3Dtrue still show all nodes, including implicit ones.
> This ensures that users that are capable of node-level management can
> still access the full information; users that only know BlockBackends
> won't use these commands.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>=20
> v2:
> - Skip implicit nodes not only on the top level, but also during the recu=
rsive
>   calls [Peter]
> - Spelling fix in the commit message [Manos]
>=20
>  block/commit.c             |  3 +++
>  block/mirror.c             |  3 +++
>  block/qapi.c               | 30 +++++++++++++++++++++++++-----
>  include/block/block_int.h  |  1 +
>  qapi/block-core.json       |  6 ++++--
>  tests/qemu-iotests/041     | 23 +++++++++++++++++++++++
>  tests/qemu-iotests/041.out |  4 ++--
>  7 files changed, 61 insertions(+), 9 deletions(-)
>=20

[...]

> diff --git a/block/qapi.c b/block/qapi.c
> index 95b2e2d..d370d0f 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -133,6 +133,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend=
 *blk,
>              qapi_free_BlockDeviceInfo(info);
>              return NULL;
>          }
> +
> +        /* Skip automatically inserted nodes that the user isn't aware o=
f for
> +         * query-block (blk !=3D NULL), but not for query-named-block-no=
des */
> +        while (blk && bs0 && bs0->drv && bs0->implicit) {
> +            bs0 =3D backing_bs(bs0);
> +        }

I don't think that the ordering of this part is correct.

This checks that the current bds in 'bs0' is not an 'implicit' node
, and if not ...

> +
>          if (bs0->drv && bs0->backing) {
>              bs0 =3D bs0->backing->bs;

=2E.. this then fills bs0 with the backing file and in the next loop, the
first thing we do is to populate the data. At this point it's not
guaranteed though that the backing image is not a implicit node added
by a commit job.

I think you want to check if bs0 is implicit after you populate it by
the backing image pointer.

>              (*p_image_info)->has_backing_image =3D true;

[...]

> @@ -434,8 +446,8 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds=
, BlockBackend *blk)
>      }
>  }
> =20
> -static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
> -                                 bool query_backing)
> +static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
> +                                        bool blk_level)
>  {
>      BlockStats *s =3D NULL;
> =20
> @@ -446,6 +458,14 @@ static BlockStats *bdrv_query_bds_stats(const BlockD=
riverState *bs,
>          return s;
>      }
> =20
> +    /* Skip automatically inserted nodes that the user isn't aware of in
> +     * a BlockBackend-level command. Stay at the exact node for a node-l=
evel
> +     * command. */
> +    while (blk_level && bs->drv && bs->implicit) {
> +        bs =3D backing_bs(bs);
> +        assert(bs);
> +    }
> +
>      if (bdrv_get_node_name(bs)[0]) {
>          s->has_node_name =3D true;
>          s->node_name =3D g_strdup(bdrv_get_node_name(bs));


This is okay, but what puzzles me is that it looks like
bdrv_query_bds_stats recursively fills in the whole backing chain (but
does not really enter much stats, besides the highest offset and the
node name [1]).

But then in qmp_query_blockstats only the top layer is populated by
bdrv_query_blk_stats. I guess it makes some sense since not all stats
are available for the lower levels of backing chain, but I find it weird
that the whole nested structure full of empty fields is reported.

Peter

[1] The nested node name structure is great, since the current libvirt
node name detection code is very fragile. This will allow making it much
more robust. (the code is used to set the block write threshold event)

Obviously the plan is still to supply the node names explicitly.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAllve2AACgkQHGwCByjY
1Gr2oA/9HGll/3ab8s/N6wRAXF6ZZe0gb/VYrpnnsgiLkrXJrJaKrUuJttMTqgGJ
WkUzc/DKp8OzHLl5GTD4VZjZBbZmPYc78s+9d1aYYNIpGijyPyRZmPgdL1T5sSHN
KwEIAL/En4Gq1AngIKnLsIuipX0CKgyQzDCUapuwkwfBU8ugd5ALS0n9V3F/bq3X
iiThLT6Nt9F8ebXI5MW4gU1MgmYZOvXDO9UsOLDpnAv0jujzjGPERjqUoA7E2Kqh
Y/4s1uetIOu8kn6g5mD+wivP1SC8Dgw/NgpLrcIhgun5GimqeIgLRWu+HrPlVPc7
f2yfSVx7W7Z1ahRa2PuHDxFx3BPh8dVMTith1Q58P1fo69+x01cDzJbQuNrZQx+d
ECGgWmTD6OwCWVuthEkvFFO3Ik9riLBrm5DOzM/aEzlpP29w34y7KUd7NchlAk2T
YeGSVJBrWO7EchjOY84cg5+Wygpkq4sQH0FkImIfciKsWfRTPWPRlVMLtmn0o5F9
9L9yLyvyo1RqEBl+wEJNo9/ht+sKiHjV9+Y9TNUhTFAx2nbgaLFXZzZiDig9IYfX
FBEbKe6MTQlqAq28K/WrwECF/1KPG7w/9GeQKNn3rV2/MoBwalTo+EjGl4oEGt0Q
gUTVtRNaP81g89qR/2zRJ8P9QgeTen/0BZji1i5MIE95juyG2Lw=
=JyHx
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
