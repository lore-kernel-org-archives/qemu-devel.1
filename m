Received: from eggs.gnu.org ([2001:4830:134:3::10]:58230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diLSB-0001yT-HU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diLS7-0000Zc-H0
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:07:19 -0400
Date: Thu, 17 Aug 2017 15:06:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170817140649.GA3677@stefanha-x1.localdomain>
References: <20170815081854.14568-1-el13635@mail.ntua.gr>
	<20170815081854.14568-2-el13635@mail.ntua.gr>
	<20170816132544.GF3180@stefanha-x1.localdomain>
	<20170816201144.x3uvqrmptacuvubz@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20170816201144.x3uvqrmptacuvubz@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/2] block: use internal
 filter node in backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 11:11:44PM +0300, Manos Pitsidianakis wrote:
> On Wed, Aug 16, 2017 at 02:25:44PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Aug 15, 2017 at 11:18:53AM +0300, Manos Pitsidianakis wrote:
> > > @@ -3142,7 +3174,7 @@ static bool should_update_child(BdrvChild *c, B=
lockDriverState *to)
> > >          return false;
> > >      }
> > >=20
> > > -    if (c->role =3D=3D &child_backing) {
> > > +    if (c->role =3D=3D &child_backing || c->role =3D=3D &child_file)=
 {
> > >          /* If @from is a backing file of @to, ignore the child to av=
oid
> > >           * creating a loop. We only want to change the pointer of ot=
her
> > >           * parents. */
> >=20
> > This may have unwanted side-effects.  I think you're using is so that
> > bdrv_set_file() + bdrv_replace_node() does not create a loop in the
> > graph.  That is okay if there is only one parent with child_file.  If
> > there are multiple parents with that role then it's not clear to me that
> > they should all be skipped.
>=20
> I am afraid I don't understand what you're saying. What is the difference
> with the child_backing scenario here?  In both cases we should update all
> from->parents children unless they also happen to be a child of `to`. If
> there are multiple parents with child_file, they are not skipped except f=
or
> the ones where `to` is the parent.

Okay, I'll have to look at this again.  Thanks!

> > > +static BlockDriver backup_top =3D {
> > > +    .format_name                        =3D   "backup-top",
> > > +    .instance_size                      =3D   sizeof(BackupBlockJob =
*),
> > > +
> > > +    .bdrv_open                          =3D   backup_top_open,
> >=20
> > .bdrv_open may be NULL.  There's no need to define this function.
> >=20
> > > +    .bdrv_close                         =3D   backup_top_close,
> > > +
> > > +    .bdrv_co_flush                      =3D   backup_top_co_flush,
> > > +    .bdrv_co_preadv                     =3D   backup_top_co_preadv,
> > > +    .bdrv_co_pwritev                    =3D   backup_top_co_pwritev,
> > > +    .bdrv_co_pwrite_zeroes              =3D   backup_top_co_pwrite_z=
eroes,
> > > +    .bdrv_co_pdiscard                   =3D   backup_top_co_pdiscard,
> > > +
> > > +    .bdrv_getlength                     =3D   backup_top_getlength,
> > > +    .bdrv_child_perm                    =3D   bdrv_filter_default_pe=
rms,
> > > +    .bdrv_recurse_is_first_non_filter   =3D   backup_recurse_is_firs=
t_non_filter,
> >=20
> > I think this is dead code since .is_filter =3D true.  It will not be
> > called.
>=20
> bdrv_recurse_is_first_non_filter() is only called if is_filter is true and
> the driver implements it to allow recursion to its children.

You are right, I misread the code.

Stefan

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlaL5AAoJEJykq7OBq3PIUP0H/0kOaryaSNiFmfcnnpaTcOjL
wZh32yHL1UsgV0PSrFbQPja2lppCQBCOqeVuoLpVRXykNlZyReXLcx/CgK+ukd0t
vO1n9v+VkOy69G1eicoRGUl6sc1VHE7yaKpWWTWvTEPA+bE6zT4lFdGlaICnvxgV
swKNLMDrnX3KRMdo7uSdoKVtBMBvHqibir2WizdbuHnzTtxwIPKUUYdl42OoX3OE
6pTtnR01fT5ZtkdwEYeOyvyKIT1B3ot0wVjpjpmG3Pd3JGxfxhOEi3wYqBiWPYdC
DAcsrMjyaS76OldFEECnCPbyQMOQEiyk70h+ZLWOfT/drXdcm/4H+zAysoeFCik=
=oeRe
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
