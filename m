Received: from eggs.gnu.org ([2001:4830:134:3::10]:34323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBor-0003YW-40
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBoq-00068c-Ad
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:11:41 -0400
Date: Wed, 28 Jun 2017 13:11:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170628121130.GB7538@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170626143055.GC29664@stefanha-x1.localdomain>
	<20170626162641.cavidsn7d67absxb@postretch>
	<20170627124540.GF8555@stefanha-x1.localdomain>
	<20170627133422.eyyvurl5pje34lr3@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20170627133422.eyyvurl5pje34lr3@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 04:34:22PM +0300, Manos Pitsidianakis wrote:
> On Tue, Jun 27, 2017 at 01:45:40PM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jun 26, 2017 at 07:26:41PM +0300, Manos Pitsidianakis wrote:
> > > On Mon, Jun 26, 2017 at 03:30:55PM +0100, Stefan Hajnoczi wrote:
> > > > > +    bs->file =3D bdrv_open_child(NULL, options, "file",
> > > > > +                                    bs, &child_file, false, &loc=
al_err);
> > > > > +
> > > > > +    if (local_err) {
> > > > > +        error_propagate(errp, local_err);
> > > > > +        return -EINVAL;
> > > > > +    }
> > > > > +
> > > > > +    qdict_flatten(options);
> > > > > +    return throttle_configure_tgm(bs, tgm, options, errp);
> > > >
> > > > Who destroys bs->file on error?
> > >=20
> > > It is reaped by bdrv_open_inherit() on failure, if I'm not mistaken.
> > > That's how other drivers handle this as well. Some (eg block/qcow2.c)
> > > check if bs->file is NULL instead of the error pointer they pass, so
> > > this is not not very consistent.
> >=20
> > Maybe I'm missing it but I don't see relevant bs->file cleanup in
> > bdrv_open_inherit() or bdrv_open_common().
> >=20
> > Please post the exact line where it happens.
> >=20
> > Stefan
>=20
> Relevant commit: de234897b60e034ba94b307fc289e2dc692c9251 block: Do not
> unref bs->file on error in BD's open
>=20
> bdrv_open_inherit() does this on failure:
>=20
> fail:
>    blk_unref(file);
>    if (bs->file !=3D NULL) {
>        bdrv_unref_child(bs, bs->file);
>    }

Thanks, you are right.  I missed it.

> While looking into this I noticed bdrv_new_open_driver() doesn't handle
> bs->file on failure. It simply unrefs the bs but because its child's ref
> still remains, it is leaked.

That's a good candidate for a separate bug fix patch.

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZU5zyAAoJEJykq7OBq3PIVF0IAKtQm7owI+fCkLZ0we5L/G3v
AUbWcVbmf0Nzr3S6DP13mNfFx/Tg0qeoCaJbvR1iZoTXIouFA5VW4F0I/Ij1veeB
nuq65l0YO3RZ0TyhHtdrBppC8wJuzTLzqrI0WD+IwRT+26odZSZGwLMEy1SRkBV9
GRaLiXO+41XkRIElzGZ9S703yM7FO0pcXk+mK8r+bWb8Gx5C4ZXZ17RUqRlq/pzA
1/bhJYTtNScjzBCogAPvkKZCuTLOqFUAge7YAhDp34wpc+MV3aJletvig1x6pAPS
OyGz3qICsRFcKKTDFCBpFTfAV43PXKOagfj8/2pDOPOWEa/dEFleco8ab3Occsg=
=qgcG
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
