Received: from eggs.gnu.org ([2001:4830:134:3::10]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqj8H-0001j6-6I
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqj8G-0005U7-1d
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:29:09 -0400
Date: Wed, 22 Mar 2017 16:28:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170322162859.GC16717@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
	<20170320101828.GC17887@stefanha-x1.localdomain>
	<56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 01/16] block: Add
 PreallocMode to BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 04:07:16PM +0100, Max Reitz wrote:
> On 20.03.2017 11:18, Stefan Hajnoczi wrote:
> > On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
> >> diff --git a/block/iscsi.c b/block/iscsi.c
> >> index ab559a6f71..5d6265c4a6 100644
> >> --- a/block/iscsi.c
> >> +++ b/block/iscsi.c
> >> @@ -2060,11 +2060,16 @@ static void iscsi_reopen_commit(BDRVReopenStat=
e *reopen_state)
> >>      }
> >>  }
> >> =20
> >> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error=
 **errp)
> >> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
> >> +                          PreallocMode prealloc, Error **errp)
> >>  {
> >>      IscsiLun *iscsilun =3D bs->opaque;
> >>      Error *local_err =3D NULL;
> >> =20
> >> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
> >> +        return -ENOTSUP;
> >> +    }
> >> +
> >>      if (iscsilun->type !=3D TYPE_DISK) {
> >>          return -ENOTSUP;
> >>      }
> >=20
> > Nevermind what I said about adding a BiteSizedTasks entry:
> >=20
> > The missing errp usage is not in qemu.git/master yet.  Please fix up
> > your bdrv_truncate() errp patch to use errp in all cases, e.g.
> > error_setg("Unable to truncate non-disk LUN").
>=20
> The thing is that I wasn't comfortable doing that for all block drivers.
> I mean, I can take another look but I'd rather have vague error messages
> ("truncation failed: #{strerror}") than outright wrong ones because I
> didn't know what error message to use.
>=20
> Of course you could argue that this may probably come out during review
> but that implies that every submaintainer for every block driver would
> actually come out for review...

I'm worried about errp being set in only a subset of error cases.

This is likely to cause bugs if callers use if (local_err).  Grepping
through the codebase I can see instances of:

  ret =3D foo(..., &local_err);
  if (local_err) { /* no ret check! */
      ...
  }

The code would work fine with qcow2 but not iscsi, for example.

IMO we should always set errp, even if the error message is vague
("truncation failed: #{strerror}").

Stefan

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0qZLAAoJEJykq7OBq3PIT7oH/0Ajsmi92SGZ/yIlOr++Hipj
wfDfkXpo4mZjjQgSo5VGZOqL1Qb7R9KGztkEO9c9MwMvZZQGbQCJFE6xKH42o4Bd
/l9bMUyfqQZ5dD/R8HQCFKEOZKzqe/f0KGULRtIgXV/byvFafzGthCElcRaOdlrs
B+hoaxHUV+UYXPO4zUOdJKhuDmAbX1is6CxJGAoYGfVm7qinxdT5p5zX9vWaqdEm
Bbj2Nmv4wvkRflnnJfTuLFLlqXMnnlxYnCbCWiF3WISeUvTLnzrFUAaYxZQBE7xI
pJOcQvQPlt4MgAF1oj8tDro4gxIhVL6eq0tP4eWUcAuhLIWK6KIrkjYQG2ClIKw=
=wztW
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
