Received: from eggs.gnu.org ([2001:4830:134:3::10]:45128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUkMt-0007Gh-FZ
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 22:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUkMs-0002j2-Bh
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 22:58:11 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fUkMr-0002i3-Ja
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 22:58:10 -0400
Date: Mon, 18 Jun 2018 12:58:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618025801.GQ25461@umbus.fritz.box>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
	<CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
	<20180506133955.GP13229@umbus.fritz.box>
	<CAFEAcA-bYHDSFL07f3BE_Lj-Dou+GeZod6cdX4-LSxzpRmQaDA@mail.gmail.com>
	<20180509053207.GA19425@umbus>
	<CAFEAcA-w4o72z-x+5bC8O+eC9A_0BG4opk=sSRB7J7c5VB+uTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eLe8FOcWSbbyMVJD"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-w4o72z-x+5bC8O+eC9A_0BG4opk=sSRB7J7c5VB+uTA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>


--eLe8FOcWSbbyMVJD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 12:23:49PM +0100, Peter Maydell wrote:
> On 9 May 2018 at 06:32, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Sun, May 06, 2018 at 04:04:02PM +0100, Peter Maydell wrote:
> >> On 6 May 2018 at 14:39, David Gibson <david@gibson.dropbear.id.au> wro=
te:
> >> > Although, that said, I'll re-iterate that I think qemu's fdt
> >> > manipulation is now sufficiently complex that it would be better off
> >> > using a "live" (dynamically allocated & pointer based) tree
> >> > representation that we just flatten immediately before loading it in=
to
> >> > the guest.
> >>
> >> This sounds to me like something that should be handled
> >> by libfdt.
> >
> > No, it's really not.  libfdt is specifically for reading and writing
> > flattened trees in place, in flattened form.  That's the whole basis
> > of the design and it's directly responsible for some of the
> > infelicities you mention.
> >
> > I was never intended as a general runtime t manipulation library.  A
> > libdt that does that (using an allocator and internal pointer
> > representation) would be a nice thing to have, but libfdt isn't it.
> > Obviously being able to use libfdt to flatten and unflatten trees
> > would be a very good feature for such a library.
>=20
> The difficulty is that libfdt is the closest we have to a
> dt manipulation library. The current wrapper layer is sort
> of trying to fix up its deficiencies for this use case.
> I just think that libfdt (as project, not necessarily as
> a single source file or library) is better placed to design
> and implement a more featured dt manipulation library layer
> than QEMU is.

Well, libfdt is already a subcomponent of the dtc project.  And yes,
an unflattened dt manipulation library would also make sense as a
component of that project.  Someone just has to write it...

> (Possibly we have here a slight terminology confusion: when
> I think about "libfdt" what I mean is "the project that has
> code for manipulating device trees and provides a library
> and some source files you can compile directly into a kernel
> or bootloader and a standalone dtc compiler binary and so on",
> not "specifically a single library". So it seems to me more
> natural for generic library code for manipulating DTs with
> an unflatten-manipulate-flatten approach would also be part
> of that project.)

Ah, yes, I think  you're right as to the source of confusion.  I think
of libfdt as specifically that one library, whose design is very much
based around *flattened* dt manipulation (hence the name).  It's
interface design is very much based around that, and an unflattened
manipulation library would really have to be separate, and wouldn't
actually share much code at all.

> >> internal representation of the data structure is, I just
> >> want to be able to (a) hand it an fdt read in from a file
> >> (b) call various functions to modify the data structure
> >> and then (c) write the resulting thing out to an fdt in
> >> guest memory. Whether libfdt prefers to do that by
> >> modifying the flat representation or by converting into
> >> a dynamically allocated unflattened tree and back again
> >> is something I'd rather leave to it as an implementation
> >> detail.
> >
> > Sort of.  But there design constraints in libfdt which means that's
> > not really feasible.  Such as:
> >   * not requiring an allocator
> >   * not requiring a "read / unflatten" pass before reading values from
> >     an fdt
> >   * not requiring allocation or creation of a "context" state for
> >     manipulating a tree
> >
> > Those aren't aren't really relevant to qemu and perhaps aren't part of
> > what you'd usually think of as the API.  But they do matter to real
> > libfdt use cases.
>=20
> Yes, you'd certainly want to keep the compile time option
> to just have the "no allocation" parts of the library so
> you could build it into kernels and boot loaders.
>=20
> thanks
> -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eLe8FOcWSbbyMVJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnH7YACgkQbDjKyiDZ
s5K+7Q//RR8JkEH6ewnv8ElkWwUvMs6Yn+l+mcBLvxQHYHnbnjvXCzfJAt9t/HCC
ptFtytrQmfgdHCvunFa5C3o7Tbvh427UW72Vnps3NWk+O7l/ZhDZDqazdxXQpnL5
iaHXhvGR1FJRV77t2LvRCpeoir1O+9/Nkwb7/3PrBTit0hOvLIlPtNz28Y6GcOUK
L1XyMRfCJwlczbp4dl5YG1lEC58v7PrZI2qhnfCSBTWt46uXqUhxZtp5obscUbF6
Iiz/VFsTWSuGpbmpmMETLG1Bhn+Rh7aC7BfGbPn8Cgy3dp+ge6FLybuugUivQT2i
XjeuNi169ZoyvPSRDX07iciyiWJl7xUQyLRdbBUmWPthunYVazDsjpouNCcI7B/l
vvfLAWOHxPj26ZQ/J90h3KMlBZmIavhOL1U3CTq/Q0LVnW32c+vWPNZlaXKSxQEq
78tGzY2x0r4u9agtN+JHXdMquO5l4mEA23VcqO5vompGOlAkAwIADvvBXex63g2K
z1vsU+XXRiO+urk5kwJGkgXFgljgYzXkJnIY6s9ZaqlaeM3t1N6JEyqjBhYa86cc
t+l3XSTJnPsdKzYUgn2SCwy7796xPMj5gd0qq1j3HJv4r4SfjGGR5aDOVIVe14ea
DgTFv5G/HaczeFy6qhN64Kei6Bm3VP3ljv2tPP8+GY4OgDW+Q+I=
=8z6y
-----END PGP SIGNATURE-----

--eLe8FOcWSbbyMVJD--
