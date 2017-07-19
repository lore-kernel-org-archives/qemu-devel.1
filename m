Received: from eggs.gnu.org ([2001:4830:134:3::10]:52178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXnnI-0007rY-QC
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXnnH-0003If-BK
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:09:32 -0400
Date: Wed, 19 Jul 2017 14:09:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170719120921.GD4617@noname.redhat.com>
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
	<20170719111529.GB7802@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20170719111529.GB7802@andariel.pipo.sk>
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
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.07.2017 um 13:15 hat Peter Krempa geschrieben:
> On Wed, Jul 19, 2017 at 10:44:47 +0200, Kevin Wolf wrote:
> > Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> > nodes above the top layer of mirror and commit block jobs. The
> > assumption made there was that since libvirt doesn't do node-level
> > management of the block layer yet, it shouldn't be affected by added
> > nodes.
> >=20
> > This is true as far as commands issued by libvirt are concerned. It only
> > uses BlockBackend names to address nodes, so any operations it performs
> > still operate on the root of the tree as intended.
> >=20
> > However, the assumption breaks down when you consider query commands,
> > which return data for the wrong node now. These commands also return
> > information on some child nodes (bs->file and/or bs->backing), which
> > libvirt does make use of, and which refer to the wrong nodes, too.
> >=20
> > One of the consequences is that oVirt gets wrong information about the
> > image size and stops the VM in response as long as a mirror or commit
> > job is running:
> >=20
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1470634
> >=20
> > This patch fixes the problem by hiding the implict nodes created
> > automatically by the mirror and commit block jobs in the output of
> > query-block and BlockBackend-based query-blockstats as long as the user
> > doesn't indicate that they are aware of those nodes by providing a node
> > name for them in the QMP command to start the block job.
> >=20
> > The node-based commands query-named-block-nodes and query-blockstats
> > with query-nodes=3Dtrue still show all nodes, including implicit ones.
> > This ensures that users that are capable of node-level management can
> > still access the full information; users that only know BlockBackends
> > won't use these commands.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/commit.c             |  3 +++
> >  block/mirror.c             |  3 +++
> >  block/qapi.c               | 13 ++++++++++++-
> >  include/block/block_int.h  |  1 +
> >  qapi/block-core.json       |  6 ++++--
> >  tests/qemu-iotests/041     | 23 +++++++++++++++++++++++
> >  tests/qemu-iotests/041.out |  4 ++--
> >  7 files changed, 48 insertions(+), 5 deletions(-)
>=20
> Fails to apply to master, thus I didn't do a functional check, but from
> reading the code ...

My last pull request was just merged into master, so now it should apply
cleanly.

> > diff --git a/block/qapi.c b/block/qapi.c
> > index 95b2e2d..0ed23b8 100644
> > --- a/block/qapi.c
> > +++ b/block/qapi.c
> > @@ -324,6 +324,11 @@ static void bdrv_query_info(BlockBackend *blk, Blo=
ckInfo **p_info,
> >      BlockDriverState *bs =3D blk_bs(blk);
> >      char *qdev;
> > =20
> > +    /* Skip automatically inserted nodes that the user isn't aware of =
*/
> > +    while (bs && bs->drv && bs->implicit) {
> > +        bs =3D backing_bs(bs);
> > +    }
>=20
> So bdrv_query_info then calls bdrv_block_device_info, which also
> populates the backing chain for that bs. That function does not do this
> trick of skipping the implicit nodes.
>=20
> From what I've understood from the 'commit' job, it's possible to have
> the implicit node inserted even at the @top bs of the commit job, so it
> looks to me as if bdrv_block_device_info will need such a tweak too.

Ah, yes, I missed the recursive calls. I will add another loop as you
suggest.

> > +
> >      info->device =3D g_strdup(blk_name(blk));
> >      info->type =3D g_strdup("unknown");
> >      info->locked =3D blk_dev_is_medium_locked(blk);
> > @@ -518,12 +523,18 @@ BlockStatsList *qmp_query_blockstats(bool has_que=
ry_nodes,
> >          }
> >      } else {
> >          for (blk =3D blk_next(NULL); blk; blk =3D blk_next(blk)) {
> > +            BlockDriverState *bs =3D blk_bs(blk);
> >              BlockStatsList *info =3D g_malloc0(sizeof(*info));
> >              AioContext *ctx =3D blk_get_aio_context(blk);
> >              BlockStats *s;
> > =20
> > +            /* Skip automatically inserted nodes that the user isn't a=
ware of */
> > +            while (bs && bs->drv && bs->implicit) {
> > +                bs =3D backing_bs(bs);
> > +            }
> > +
> >              aio_context_acquire(ctx);
> > -            s =3D bdrv_query_bds_stats(blk_bs(blk), true);
> > +            s =3D bdrv_query_bds_stats(bs, true);
>=20
> Same here. The recursive call in bdrv_query_bds_stats does not skip the
> implicitly added layers IIUC.

Indeed.

> >              s->has_device =3D true;
> >              s->device =3D g_strdup(blk_name(blk));
> >              bdrv_query_blk_stats(s->stats, blk);
>=20
> Feel free to add a 'Reviewed-by' if I did not understand what's
> happening in the commit job properly, or if you add the skipping into
> the gathering functions as well.

I'll send a v2 for this, it doesn't seem trivial enough to just add
Reviewed-by.

Kevin

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZb0vxAAoJEH8JsnLIjy/W+JIP/12ghDdGLnsDFN0Jdl095MJt
wBSPKp1k1vY7bn4yqlzlMHqRRWBQ2B8QcMv6vhiPrvNb5bjs7vHltRlkLdCAbcXJ
NUqyStdfjbLPEz33YG3NwwLjqrlEUpQ/WN1+TNX3lBZwKW2/TCRN8Tc4tjZsQS/n
B6r22ZK/YEQ/6H7FkftNDyKW1/p4+2MAb2VZqinUzxa3WNKE38M7BAq0Y49sj24c
KGFc5ebSI75VANBG9FDt0id7rCD2GUJPp1evaElLGWsWxEQBXc0XaaYIeqsAlaq3
mePM/mEPYcuOFWIu+0ivR/yAj7BmVjapC8dE0l2OWDNfYD/meX32BlUPtSAtRrwR
PkEhzk0AevqfHiOqzinkSpO+GpUQ74WvQZngW/J33RF/m7PwTFaAreugbTmkOcgC
LvCox472f3ZboA0AZTxzvagycuu/1XeNKo2+sZ5h2631Xf3wdZeoon60NXcLJhVE
hcvBsk+kpGlnp0VswOH2O1kezKNMZ8Ne1o9txLa6aCH+RzVPaD2U8yKDFj2cqhnL
JMf1lT5mN5O0cYrkkuJindFvKL5kJLjWKgiEcKPHtry6f8GZiNBFzhHEMJdm3zHN
eE75x30RxEThOxjDoRNEkv7cBDHYuVxoEit6T6nsv7FQtsjL+r63eIzX557jAmEy
30OKlVtUNtrz+xs/gZki
=A1OO
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
