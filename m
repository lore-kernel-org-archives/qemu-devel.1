Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcul0-0004Wc-US
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcukz-0003FX-Tj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:36:18 -0400
Date: Wed, 2 Aug 2017 15:36:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802143607.GC10101@stefanha-x1.localdomain>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-4-el13635@mail.ntua.gr>
	<20170802100724.GD5531@stefanha-x1.localdomain>
	<20170802103446.cwpcjzhnrc5mbd6b@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20170802103446.cwpcjzhnrc5mbd6b@postretch>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 01:34:46PM +0300, Manos Pitsidianakis wrote:
> On Wed, Aug 02, 2017 at 11:07:24AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Aug 01, 2017 at 04:49:07PM +0300, Manos Pitsidianakis wrote:
> > > @@ -3729,6 +3731,12 @@ const char *bdrv_get_parent_name(const BlockDr=
iverState *bs)
> > >                  return name;
> > >              }
> > >          }
> > > +        if (c->parent_bs && c->parent_bs->implicit) {
> > > +            name =3D bdrv_get_parent_name(c->parent_bs);
> > > +            if (name && *name) {
> > > +                return name;
> > > +            }
> > > +        }
> > >      }
> > >=20
> > >      return NULL;
> >=20
> > This should be a separate patch.
> >=20
> > Who updates parent_bs if the parent is changed (e.g.
> > bdrv_replace_node())?
> >=20
> > We already have bs->parents.  Why is BdrvChild->parent_bs needed?
> >=20
>=20
> If I haven't misunderstood this, BdrvChild holds only the child part of t=
he
> parent-child relationship and there's no way to access a parent from
> bs->parents. bdrv_replace_node() will thus only replace the child part in
> BdrvChild from the aspect of the parent. In the old child bs's perspectiv=
e,
> one of the nodes of bs->parents is removed and in the new child bs's
> perspective a new node in bs->parents was inserted. parent_bs thus remains
> immutable.
>=20
> child->parent_bs is needed in this patch because in jobs if a job-ID is n=
ot
> specified the parent name is used, but this fails if the parent is an
> implicit node instead of BlockBackend and causes a regression (certain job
> setups suddenly need an explicit job ID instead of just working).

Please see Kevin's reply to my email.

> > > -    throttle_group_unregister_tgm(&blk->public.throttle_group_member=
);
> > > -    bdrv_drained_end(blk_bs(blk));
> > > +    BlockDriverState *bs, *throttle_node;
> > > +
> > > +    throttle_node =3D blk_get_public(blk)->throttle_node;
> >=20
> > Is blk_get_public() still necessary?  Perhaps we can do away with the
> > concept of the public struct now.  It doesn't need to be done in this
> > patch though.
>=20
> I can include a patch to move throttle_node to BlockBackend and remove all
> BlockBackendPublic code, is that okay?

That would be a nice cleanup, thanks!

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgeNXAAoJEJykq7OBq3PIIegH/2jGt3D93KZvbbtOHYq06yUJ
4Kg4KVVmHMOy8Af+hJnqyht4ab0SvuM8F/4dyUEAL2Xjmv9Zn9gxlQjg7rz+aifW
kCodvbsW1XU0tXcvjsitzyzSNItHMAFv/b+7FiQqbcnNBECDj6OEZfrGRfsVnL+b
b6QUKdSUAcKGR098Y+mMri8nHaL9H65fsbX8zSozFH8uAH+8oOQ6SXS+A78IqzWT
Fh1+IbrRXyKL6iBFXOf4hjrhBW69r5VQncmnz0dheI2O8ajnJJpAAhcTvsgfKTUT
E0iy5QvBF5mjCmqewYYkBnYUfMsrOLlDJmeSAw+DRuXTeNc74jfxVgJPKA+pNR8=
=Enkf
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
