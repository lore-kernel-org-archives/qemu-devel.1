Received: from eggs.gnu.org ([2001:4830:134:3::10]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehDIK-0006xO-8I
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehDIF-0007sy-NV
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:44:44 -0500
Date: Thu, 1 Feb 2018 11:44:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201114425.GD5783@stefanha-x1.localdomain>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
	<b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
	<20180130163820.GC4503@localhost.localdomain>
	<20180131141247.GC23336@stefanha-x1.localdomain>
	<20180131142249.GB3598@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20180131142249.GB3598@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 03:22:49PM +0100, Kevin Wolf wrote:
> Am 31.01.2018 um 15:12 hat Stefan Hajnoczi geschrieben:
> > There should be a separate paragraph in docs/qemu-block-drivers.texi
> > explaining that share-rw=3Don can be used safely with format=3Draw if t=
he
> > guests are configured to safely access a shared disk.  It should also
> > mention that share-rw=3Don is unsafe for image formats.
>=20
> share-rw=3Don is a -device option and only about the guest, not about the
> backend. It is never unsafe if the guest can cope with external writers.
> It just doesn't prevent qemu from locking the image file for image
> formats.

Thanks for the explanation.  Documentation on share-rw=3Don|off would be
nice.

Maybe something like:

  By default the guest has exclusive write access to its disk image.
  This is enforced by QEMU via file locking.  If the guest can safely
  share the disk image with other writers the -device ...,share-rw=3Don
  parameter can be used.  This is only safe if the guest is running
  software, such as a cluster file system, that coordinates disk
  accesses to avoid corruption.

  Note that share-rw=3Don only declares the guest's ability to share the
  disk.  Some QEMU features, such as image file formats, require
  exclusive write access to the disk image and this is unaffected by the
  share-rw=3Don option.

For anyone else reading this, here is the code that protects qcow2 and
other image formats:

  void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                 const BdrvChildRole *role,
                                 BlockReopenQueue *reopen_queue,
                                 uint64_t perm, uint64_t shared,
                                 uint64_t *nperm, uint64_t *nshared)
  {
      ...

      /* bs->file always needs to be consistent because of the metadata. We
       * can never allow other users to resize or write to it. */
      if (!(flags & BDRV_O_NO_IO)) {
          perm |=3D BLK_PERM_CONSISTENT_READ;
      }
      shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);

Stefan

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacv2ZAAoJEJykq7OBq3PIvwMH+gMw9TcVCP78cSpGy3+zUiGx
2tNChzDdjK/I+iGgqMq78EFoftjlFZu2GbLu6y/ew1JnyM3Rey3JWgf9qx1S4HmC
MP4KqBhPqKPDiOiIzufDGcOg5tJR8JsMuhwkcupiTDk4uwp8UFqee547kDPId3Im
xnuUYtdudwXCaxKeS9TyBwNlJ0BMRKlpDJKjIjoMD7x7coFkGiviDb1nVr9asMKv
fPcQp7udN0lefrfqyGsmS728SXrwjUp4iCKkH69of2r1roBAiMGVhStiy83s+H7N
l+GhNhejMM78R6lhpx7TwrN1LIV2RSPaIfugDY6FocctymD13njEI9SBYN6Ylkg=
=OZPn
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
