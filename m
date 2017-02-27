Received: from eggs.gnu.org ([2001:4830:134:3::10]:60773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciQGz-0002OG-IV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciQGy-0005Or-GE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:43:49 -0500
Date: Mon, 27 Feb 2017 19:43:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227184338.GH6356@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-37-git-send-email-kwolf@redhat.com>
	<f875d1a5-f91f-7306-e422-692bc8952ced@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <f875d1a5-f91f-7306-e422-692bc8952ced@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 36/54] commit: Use real permissions in
 commit block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.02.2017 um 18:29 hat Max Reitz geschrieben:
> On 21.02.2017 15:58, Kevin Wolf wrote:
> > This is probably one of the most interesting conversions to the new
> > op blocker system because a commit block job intentionally leaves some
> > intermediate block nodes in the backing chain that aren't valid on their
> > own any more; only the whole chain together results in a valid view.
> >=20
> > In order to provide the 'consistent read' permission to the parents of
> > the 'top' node of the commit job, a new filter block driver is inserted
> > above 'top' which doesn't require 'consistent read' on its backing
> > chain. Subsequently, the commit job can block 'consistent read' on all
> > intermediate nodes without causing a conflict.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > @@ -262,34 +305,62 @@ void commit_start(const char *job_id, BlockDriver=
State *bs,
> >          }
> >      }
> > =20
> > +    /* Insert commit_top block node above top, so we can block consist=
ent read
> > +     * on the backing chain below it */
> > +    commit_top_bs =3D bdrv_new_open_driver(&bdrv_commit_top, NULL, BDR=
V_O_RDWR,
>=20
> Why RDWR when the driver only allows reads anyway?

Good question. I'll try to change it, maybe it doesn't break everything.

> > +                                         errp);
> > +    if (commit_top_bs =3D=3D NULL) {
> > +        goto fail;
> > +    }
> > +
> > +    bdrv_set_backing_hd(commit_top_bs, top);
> > +    bdrv_set_backing_hd(overlay_bs, commit_top_bs);
> > +
> > +    s->commit_top_bs =3D commit_top_bs;
> > +    bdrv_unref(commit_top_bs);
> > =20
> >      /* Block all nodes between top and base, because they will
> >       * disappear from the chain after this operation. */
> >      assert(bdrv_chain_contains(top, base));
> > -    for (iter =3D top; iter !=3D backing_bs(base); iter =3D backing_bs=
(iter)) {
> > -        /* FIXME Use real permissions */
> > -        block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
> > -                           BLK_PERM_ALL, &error_abort);
> > +    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
> > +        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ou=
rselves
> > +         * at s->base.
>=20
> As far as I can see, the loop doesn't even touch base, though...?

If bs isn't writable, bs->backing generally isn't writable either, and
we are touching a parent of base.

> >                         The other options would be a second filter driv=
er above
> > +         * s->base. */
> > +        ret =3D block_job_add_bdrv(&s->common, "intermediate node", it=
er, 0,
>=20
> Don't we need CONSISTENT_READ at least for top?

top can't provide CONSISTENT_READ because its backing files can't
provide it. It's the job (one of the jobs) of commit_top_bs to shield
the parents of top from the loss of CONSISTENT_READ.

> > +                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_W=
RITE,
> > +                                 errp);
> > +        if (ret < 0) {
> > +            goto fail;
> > +        }
> >      }
> > +
> > +    ret =3D block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_A=
LL, errp);
> > +    if (ret < 0) {
> > +        goto fail;
> > +    }
> > +
> >      /* overlay_bs must be blocked because it needs to be modified to
> > -     * update the backing image string, but if it's the root node then
> > -     * don't block it again */
> > -    if (bs !=3D overlay_bs) {
> > -        /* FIXME Use real permissions */
> > -        block_job_add_bdrv(&s->common, "overlay of top", overlay_bs, 0,
> > -                           BLK_PERM_ALL, &error_abort);
> > +     * update the backing image string. */
> > +    ret =3D block_job_add_bdrv(&s->common, "overlay of top", overlay_b=
s,
> > +                             BLK_PERM_GRAPH_MOD, BLK_PERM_ALL, errp);
> > +    if (ret < 0) {
> > +        goto fail;
> >      }
> > =20
> > -    /* FIXME Use real permissions */
> > -    s->base =3D blk_new(0, BLK_PERM_ALL);
> > +    s->base =3D blk_new(BLK_PERM_CONSISTENT_READ
>=20
> Do we actually need CONSISTENT_READ for the base?

If base doesn't provide CONSISTENT_READ, commit_top_bs wouldn't be able
to provide it either.

If we ever find a case where this is too restrictive because the parents
of commit_top_bs don't need CONSISTENT_READ, we can probably be less
strict in this case, but just getting commit to work is already tricky
enough that I wouldn't like to do it in this patch (or even series).

Kevin

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYtHNaAAoJEH8JsnLIjy/WWC0P/RU7aaO9ZbqE9+U3pDQOEdO7
xe42wCYA1z8SIc/P0kVj1RTYUmb3N3GLyxw1vJWFMRmojBt8bGDdk8I0ujGPvFr0
aB8n45W9T8Vua9MqLYR9stigInVhuJrCE24bsC5OtdoA4CronCZDdbQ5f085A0J+
DfwCXBkqOk96sv0JCA0tEmWml1qOR1Gf3BLgC8nFNsL1JeiWx+aYvRAdqSHjp/Yu
qDTB6jNBIMlD5kCGGPCd2Xkne7xitnHz2CV2S+flXb6gtanIsrzeDxuRgCMVKv0E
5cXQMwD5H6pyoh2R5oXBmCx0OWFxviUOssjStlert2fCI5YMgAy6q7D17QLj9FCj
5CfeaHZkDu4aH2d5kDDt1FLhbNd9AbaaoA4scvZJ+ZKu4Abm3rUyD8qwABwAslXA
rNWO6W+EaUfSh7AZ1Vc7Btw19OEnrnTaVL3+QgqgZrtu6mfbG+pPTQFh12pbpe2z
7BTn4I2F9j7gURlSAoCrU0ApRrbRpHAilFQqT7XzDw4QxB0TjgILCJaZ0rZgfAjK
bRtt09/EyORmVel4fxVdqeFntdP3razhiYwV30BID3SxqvQ634VlW2X9MUPBrWTw
1UJw74zldHxSlRy+a6pUO8EqfkPdZ3hLRfaSaPXIZpK5MbS6weOaOhagai4wcuUi
aCEvlPaIdXWQQCFWmXsx
=MD4r
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
