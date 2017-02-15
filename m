Received: from eggs.gnu.org ([2001:4830:134:3::10]:42770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce1Hn-0007Ao-8W
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ce1Hk-0008JZ-2I
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:14:27 -0500
Date: Wed, 15 Feb 2017 15:14:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170215151419.GD16064@stefanha-x1.localdomain>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maor Lipchuk <mlipchuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, Max Reitz <mreitz@redhat.com>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 05:46:19PM +0200, Maor Lipchuk wrote:
> I was wondering if that is possible to provide a new API that
> estimates the size of
> qcow2 image converted from a raw image. We could use this new API to
> allocate the
> size more precisely before the convert operation.
>=20
[...]
> We think that the best way to solve this issue is to return this info
> from qemu-img, maybe as a flag to qemu-img convert that will
> calculate the size of the converted image without doing any writes.

Sounds reasonable.  qcow2 actually already does some of this calculation
internally for image preallocation in qcow2_create2().

Let's try this syntax:

  $ qemu-img query-max-size -f raw -O qcow2 input.raw
  1234678000

As John explained, it is only an estimate.  But it will be a
conservative maximum.

Internally BlockDriver needs a new interface:

struct BlockDriver {
    /*
     * Return a conservative estimate of the maximum host file size
     * required by a new image given an existing BlockDriverState (not
     * necessarily opened with this BlockDriver).
     */
    uint64_t (*bdrv_query_max_size)(BlockDriverState *other_bs,
                                    Error **errp);
};

This interface allows individual block drivers to probe other_bs in
whatever way necessary (e.g. querying block allocation status).

Since this is a conservative max estimate there's no need to read all
data to check for zero regions.  We should give the best estimate that
can be generated quickly.

Stefan

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpHBLAAoJEJykq7OBq3PIPWMH/iTCg4lFEI95aoJrFGZ5vXr3
TVO3p/zZWTql3vwt0fPpu5nJAhIHLA6TjdaxSs5Gi6kVkzA6i7XDIEnSX+SKWTbo
g4si/IztpcXTEwOy3BXlD8YWsl3KmnU9L9yftzqProGAzkK3Uf5W4o+IF86PfOki
MwhYa07PHFmniNl7E2w+0tJgBhK6RPj9zZw4A7RqP+Eo70QKNR0R8cmaS/s4BQH8
lsPBbvno3z+j106oyiztshT/5+LsGoa7UoFC/Owg2QnKtgY6FwRNg29LxS+Z0/AD
BK95U0m9L4naacUqkhO8oBqKLVK+zymNDHMVbA9zUSOY2tx/0OdnAE1+/nXMC0c=
=3ySC
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
