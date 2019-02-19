Received: from eggs.gnu.org ([209.51.188.92]:55483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw18C-0002Kh-FD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw18B-0000yp-Lh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:00 -0500
Date: Tue, 19 Feb 2019 09:51:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219085141.GC4727@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
	<67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.02.2019 um 00:57 hat Max Reitz geschrieben:
> On 31.01.19 18:55, Kevin Wolf wrote:
> > This adds a .bdrv_open option to specify the external data file node.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json |  3 ++-
> >  block/qcow2.h        |  4 +++-
> >  block/qcow2.c        | 25 +++++++++++++++++++++++--
> >  3 files changed, 28 insertions(+), 4 deletions(-)
>=20
> [...]
>=20
> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index c161970882..e2114900b4 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
>=20
> [...]
>=20
> > @@ -205,7 +206,8 @@ enum {
> >      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_=
BITNR,
> > =20
> >      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
> > -                                 | QCOW2_INCOMPAT_CORRUPT,
> > +                                 | QCOW2_INCOMPAT_CORRUPT
> > +                                 | QCOW2_INCOMPAT_DATA_FILE,
>=20
> This hunk seems to belong somewhere else.

Isn't this the first patch that actually allows opening images that have
QCOW2_INCOMPAT_DATA_FILE set in their header?

> >  };
> > =20
> >  /* Compatible feature bits */
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index ac9934b3ed..376232d3f0 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1441,8 +1441,22 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
> >          goto fail;
> >      }
> > =20
> > -    /* TODO Open external data file */
> > -    s->data_file =3D bs->file;
> > +    /* Open external data file */
> > +    if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
> > +        s->data_file =3D bdrv_open_child(NULL, options, "data-file", b=
s,
> > +                                       &child_file, false, errp);
> > +        if (!s->data_file) {
> > +            ret =3D -EINVAL;
> > +            goto fail;
> > +        }
> > +    } else if (qdict_get(options, QCOW2_OPT_DATA_FILE)) {
>=20
> I get the idea, but this isn't crumpled so this key may not exist (but
> data-file.driver and data-file.filename may).  Of course the fact that
> these options remain unused will be caught by the block layer, but that
> makes the error message below a bit less useful.

Hmm, good point... So you'd just leave out the check and always let the
block layer complain (with a less than helpful message)? Or are you
suggesting I should try and catch all cases somehow, even if that makes
things quite a bit more complicated?

Kevin

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJca8OdAAoJEH8JsnLIjy/WawYP/AgDottTcCB6n5MbUXffpDRd
TWhnEilcQDNa30n2XUhd6XuiAiMGZso9bP7/BtZbsLfx8vj9sJTOlMjXGHrYOoYs
THpOlYTrQj6IGTEyKOnCYi0zik7c94r6FqwajRnS2ehlNUTPtUSTHP5pe7XICiyJ
UFTJo5JnSOKr5piPLK9keTqcs1oVCi6u2kbnA51Av3edmZX4nS2ceiXrket/cJTb
BiOeVIuldGDhdwz6Jj74boYK8Cc6Zq/5AZIpdujLrA1T7Fg3/ufggXK3uveYFxb9
j+V7xcCLyzNWl3fNm5zRG74s+RdOdPv5OvxK/m7q5GOzufoBXtqCjjnATsZRcEdA
J6IFLBUiihpWhQqsaKWr8Mhe3Ov37o4RKYs2nwdT9TfhipFMFIyBsDmm24XvuMJh
EETvtdHMPQObAfOisbWTqytCtBmtFxjFIkX11be6pEfzV1zBjiJsZR4mrTtZFgCT
3q91QXsIAsJyQDFQycsiv0ES2xdxHQRvB6ST+oPJoYujUdvSth6uzZsu63mrSbUa
T1c7xFWY7m1n+Gb7UZ9EeCBTmW+zO476DnQ/u/iG0BUur9NqbyloOYwO6m1ZifpL
+nhLqNJxgmRNHVO+yCUQd6AF4necoaamQppbEMs6LoIEplE7yTVK06KwDgmnvLpM
lk3T4pC/qZ2rYqW7P9vA
=dtsr
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
