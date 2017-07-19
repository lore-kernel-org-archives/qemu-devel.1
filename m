Received: from eggs.gnu.org ([2001:4830:134:3::10]:41738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dXn58-0007oN-8Y
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dXn56-0001Tv-Qa
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 07:23:54 -0400
Date: Wed, 19 Jul 2017 13:15:29 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170719111529.GB7802@andariel.pipo.sk>
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ddcd+dsiJrvLd0CP"
Content-Disposition: inline
In-Reply-To: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] block: Skip implicit nodes in
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
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org


--ddcd+dsiJrvLd0CP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 10:44:47 +0200, Kevin Wolf wrote:
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
> This patch fixes the problem by hiding the implict nodes created
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
>  block/commit.c             |  3 +++
>  block/mirror.c             |  3 +++
>  block/qapi.c               | 13 ++++++++++++-
>  include/block/block_int.h  |  1 +
>  qapi/block-core.json       |  6 ++++--
>  tests/qemu-iotests/041     | 23 +++++++++++++++++++++++
>  tests/qemu-iotests/041.out |  4 ++--
>  7 files changed, 48 insertions(+), 5 deletions(-)

Fails to apply to master, thus I didn't do a functional check, but from
reading the code ...

> diff --git a/block/qapi.c b/block/qapi.c
> index 95b2e2d..0ed23b8 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -324,6 +324,11 @@ static void bdrv_query_info(BlockBackend *blk, Block=
Info **p_info,
>      BlockDriverState *bs =3D blk_bs(blk);
>      char *qdev;
> =20
> +    /* Skip automatically inserted nodes that the user isn't aware of */
> +    while (bs && bs->drv && bs->implicit) {
> +        bs =3D backing_bs(bs);
> +    }

So bdrv_query_info then calls bdrv_block_device_info, which also
populates the backing chain for that bs. That function does not do this
trick of skipping the implicit nodes.

=46rom what I've understood from the 'commit' job, it's possible to have
the implicit node inserted even at the @top bs of the commit job, so it
looks to me as if bdrv_block_device_info will need such a tweak too.

> +
>      info->device =3D g_strdup(blk_name(blk));
>      info->type =3D g_strdup("unknown");
>      info->locked =3D blk_dev_is_medium_locked(blk);
> @@ -518,12 +523,18 @@ BlockStatsList *qmp_query_blockstats(bool has_query=
_nodes,
>          }
>      } else {
>          for (blk =3D blk_next(NULL); blk; blk =3D blk_next(blk)) {
> +            BlockDriverState *bs =3D blk_bs(blk);
>              BlockStatsList *info =3D g_malloc0(sizeof(*info));
>              AioContext *ctx =3D blk_get_aio_context(blk);
>              BlockStats *s;
> =20
> +            /* Skip automatically inserted nodes that the user isn't awa=
re of */
> +            while (bs && bs->drv && bs->implicit) {
> +                bs =3D backing_bs(bs);
> +            }
> +
>              aio_context_acquire(ctx);
> -            s =3D bdrv_query_bds_stats(blk_bs(blk), true);
> +            s =3D bdrv_query_bds_stats(bs, true);

Same here. The recursive call in bdrv_query_bds_stats does not skip the
implicitly added layers IIUC.

>              s->has_device =3D true;
>              s->device =3D g_strdup(blk_name(blk));
>              bdrv_query_blk_stats(s->stats, blk);

Feel free to add a 'Reviewed-by' if I did not understand what's
happening in the commit job properly, or if you add the skipping into
the gathering functions as well.

Peter

--ddcd+dsiJrvLd0CP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAllvP08ACgkQHGwCByjY
1GpARg/9GAshsFIHFt84A8aXsF05wZkQEacNaS1W7xkY7zebgsCxhComXeL0edlO
DDAJGhzFcZFY+FuxxMLpzlAM/jbeG4cJUBGHB40hqfRcinfcKTW+AeGLSA22Zki6
/1ssVMwxpyKYd3ZNDVtJKs0pJt8/3n4giWswy75PD6D2I9LmebnYZipl2urk7c2B
wWrHTbSQNKU+fq3Wcl6yX0hN4WBkJCZjHNdt1OX+VXdq9SrBmWVMcbvSWnI8rUIp
JFRuau+cRf64/g5CLugP67Rpon4oXxvDtTk4aCXaSk6iQTg0ptiFovG+YsUXRL0B
4rfFOjnQF5DoF9lssnIXthJsCedltcc+MTurtiwlrDk24JQ2M13pvvRHMEyeUR2d
meV3gNWvlW8eaKZTX7iTqXvs69wsqhF0E/G4CUW0llXnYMgOoKK1Z9tPYGoE3eO+
NdoWfYze/lIXBPIqNzvPu2TU/XTkoAR2Js7/0P2HvPkCp95QrJb+c1dur+0o95YO
BL/tj5smT0Hdj6xJrrNy6DKnML5Oyga+YyOx1GSzTW553441rwQy906R1AYfVreD
mjoobsrXn5IAKEsJ1Useuh0WxLNgUI0Ti7KaDo9V4xcUZ0JzoMChbFaOqghXn09A
s+AX6EBkNfwGilFpj5FtGrIABeOakU6uACLoNYCJdhUuOe5oA4o=
=Soeq
-----END PGP SIGNATURE-----

--ddcd+dsiJrvLd0CP--
