Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctzID-0006O7-Pi
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctzIC-0006T9-IS
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:20:53 -0400
Date: Fri, 31 Mar 2017 17:20:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170331162043.GB18974@stefanha-x1.localdomain>
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 03:47:39PM +0200, Max Reitz wrote:
> On 31.03.2017 15:13, Peter Maydell wrote:
> > Coverity (CID 1307776) points out that in the multiply:
> >   space =3D to_allocate * s->tracks;
> > we are trying to calculate a 64 bit result but the types
> > of to_allocate and s->tracks mean that we actually calculate
> > a 32 bit result. Add an explicit cast to force a 64 bit
> > multiply.
> >=20
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > NB: compile-and-make-check tested only...
> > ---
> >  block/parallels.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/block/parallels.c b/block/parallels.c
> > index 4173b3f..3886c30 100644
> > --- a/block/parallels.c
> > +++ b/block/parallels.c
> > @@ -206,7 +206,7 @@ static int64_t allocate_clusters(BlockDriverState *=
bs, int64_t sector_num,
> >      }
> > =20
> >      to_allocate =3D DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
> > -    space =3D to_allocate * s->tracks;
> > +    space =3D (int64_t)to_allocate * s->tracks;
> >      if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SEC=
TOR_BITS) {
> >          int ret;
> >          space +=3D s->prealloc_size;
>=20
> I think the division is technically fine because to_allocate will
> roughly be *pnum / s->tracks (and since *pnum is an int, the
> multiplication cannot overflow).
>=20
> However, it's still good to fix this, but I would do it differently:
> Make idx, to_allocate, and i all uint64_t or int64_t instead of
> uint32_t. This would also prevent accidental overflow when storing the
> result of the division in:
>=20
> idx =3D sector_num / s->tracks;
> if (idx >=3D s->bat_size) {
>     [...]
>=20
> The much greater problem to me appears to be that we don't check that
> idx + to_allocate <=3D s->bat_size. I'm not sure whether there can be a
> buffer overflow in the for loop below, but I'm not sure I really want to
> know either... I think the block_status() call limits *pnum so that
> there will not be an overflow, but then we should at least assert this.

Will you send a new patch that supercedes this one?

Stefan

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY3oHbAAoJEJykq7OBq3PIkXYIAMSSwOt5+M+dPkBGWDhHNK2n
5WOYObJkwup+bRaEsKECjzBKWNT/nir1sbnw5fwZATlpbykwCkP7wwAHzyNinTPA
NZt4nemjHubLCS0A/S3zKU701FHosyFNsHhyJmIxzij2WtSrgQxS6fmgF7atdU/I
NFFZcA9XlWQe66IiN3jLA83dARzyyjemNDoErAbnGkEbgU0tjLze2+YL3m/amWZV
w+X1bbvAqvwvZdgZRuBmqrjsn8hxVVFHgcDxfRXu1suNoAePN53xrCjOZEQdvCBF
C8djkAB20J8OZXq/lTwsBNJJDCjZc9e9b3alHfYqkIrMvDM2bpecteElB8CfGbI=
=BoZ0
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
