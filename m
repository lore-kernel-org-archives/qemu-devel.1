Received: from eggs.gnu.org ([2001:4830:134:3::10]:57000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du1gi-0007GM-Ge
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1du1gh-00043E-HY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:26:36 -0400
References: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1ff0af0b-cbcf-7184-3542-ccce908b130e@redhat.com>
Date: Mon, 18 Sep 2017 21:26:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6cIcQrMH5ra0LtcFPeNEiuTubAXrOPuJM"
Subject: Re: [Qemu-devel] Disk Image Read Location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Derrick McKee <derrick.mckee@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6cIcQrMH5ra0LtcFPeNEiuTubAXrOPuJM
From: Max Reitz <mreitz@redhat.com>
To: Derrick McKee <derrick.mckee@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <1ff0af0b-cbcf-7184-3542-ccce908b130e@redhat.com>
Subject: Re: [Qemu-devel] Disk Image Read Location
References: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
In-Reply-To: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 20:47, Derrick McKee wrote:
> Hi,
>=20
> I am trying to figure out if a particular disk operation is reading fro=
m
> the same location in an image file.  I am simulating a USB disk, and du=
ring
> an operation the guest OS performs, I would like to know how many times=
 the
> backing image file is read.  I have identified the function
> address_space_write as the function that writes the data to the guest O=
S
> from the image, but I am not sure what to compare with past writes.  Th=
ere
> are AddressSpace*, MemoryRegion*, and hwaddr types in that function.  C=
an
> any of those be used to compare image read locations?  I am hoping that=
 if,
> for example, the AddressSpace* passed into address_space_write during o=
ne
> invocation equals the AddressSpace* of another invocation means that th=
e
> same location within the image file was read twice.  Any help would be
> appreciated.

If you're referring to images as in images of block devices, then the
block layer contains the functionality you're looking for.

bdrv_driver_preadv() from block/io.c is a function that every read
request should go through.  However, at this point it's already aligned
to (host) sectors, so maybe bdrv_co_preadv() is better suited.

But then again, because of how the block layer works you'll likely see
every read request twice there (once for the disk image's format (e.g.
qcow2 or raw) and once for the storage backend used for the image (e.g.
file for normal files or http)).  So you either correct for that or you
instead go one layer above into block/block-backend.c.

All read requests from the guest go through either blk_co_preadv() or
blk_aio_preadv(), and they should go through there only once.

Max


--6cIcQrMH5ra0LtcFPeNEiuTubAXrOPuJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnAHeESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ate0H/3bTxSPFySkp1OlfAvMZn/1E6UHvXsRv
+WPCATlv/44E7Vh2/hIr26WogifKpO8oLJX9ohkQbrG8mfiGc+VYRAHlBvH2QuCB
RIg1aVV4v5ilvadOYojrxR1QSKGEAoNQ8fbrrqeLm7MP1kx8DJkZ8kTCAbBHSy8v
FN4Vq8O4Xdcet82GzxvtHMK1tsLoAcbN72trLNdnCTXNj3v89GVf4cv8LkBzZ8Hj
kCO/67iWm9b6ekZtOvcnhO8E8x0zHP4nor/Cf4J76aOgG0bMlFtyOgfJ71W5HqvJ
xq3cz9smqwyLcOxdKXNrJsf3kQbf2IuEzMe57OvT3wIP/d6oIx+HGQw=
=l24Y
-----END PGP SIGNATURE-----

--6cIcQrMH5ra0LtcFPeNEiuTubAXrOPuJM--
