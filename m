Received: from eggs.gnu.org ([2001:4830:134:3::10]:55416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqhx1-0005fY-AM
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqhwy-0007ZN-3r
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:17:59 -0500
Date: Tue, 27 Feb 2018 16:17:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180227161743.GC32480@stefanha-x1.localdomain>
References: <20180226170313.8178-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20180226170313.8178-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
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


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 06:03:13PM +0100, Max Reitz wrote:
> There are filesystems (among which is tmpfs) that have a hard time
> reporting allocation status.  That is definitely a bug in them.
>=20
> However, there is no good reason why qemu-img convert should query the
> allocation status in the first place.  It does zero detection by itself
> anyway, so we can detect unallocated areas ourselves.
>=20
> Furthermore, if a filesystem driver has any sense, reading unallocated
> data should take just as much time as lseek(SEEK_DATA) + memset().  So
> the only overhead we introduce by dropping the manual lseek() call is a
> memset() in the driver and a buffer_is_zero() in qemu-img, both of which
> should be relatively quick.

This makes sense.  Which file systems did you test this patch on?

XFS, ext4, and tmpfs would be a good minimal test set to prove the
patch.  Perhaps with two input files:
1. A file that is mostly filled with data.
2. A file that is only sparsely populated with data.

The time taken should be comparable with the time before this patch.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalYSnAAoJEJykq7OBq3PIbSYH/iCq5TNNYZZQGqGvxSw6HOax
YBr0ZuBI2C2f+EeG0tlN5gr2s5yc6/U2xW3HImBC+s2QsaadrUqyOewaxUIqkGIk
/cq/raUrz3KKhyjp8sm1hmWYN/A7PTC0CxvxkqOlvzcTHW7xT7DH8DEfr5aRirZS
m4QW8dhMLAfBRz9ep5BGa9jhloGHjPN+NvyThH3yMu7E7ha+N0ObRa5JBAphrRvb
7BV5/vCngrorH33y9ynGqTvdhQYpPTV7juYS6Sk5WztuTS5wv0vKIR6+mzyEPaqC
04aG07QLLJAhFm59dxXFhlhd1tHRa6LF1w/dDrWgCo4vlY4kYxuFoJP5uBNe1PY=
=9BTM
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
