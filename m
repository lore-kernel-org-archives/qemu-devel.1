Received: from eggs.gnu.org ([2001:4830:134:3::10]:45582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fGHiM-00065S-Al
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fGHiL-00023O-5C
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:32:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fGHiK-0001uJ-6k
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:32:33 -0400
Date: Wed, 9 May 2018 15:32:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180509053207.GA19425@umbus>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
	<CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
	<20180506133955.GP13229@umbus.fritz.box>
	<CAFEAcA-bYHDSFL07f3BE_Lj-Dou+GeZod6cdX4-LSxzpRmQaDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-bYHDSFL07f3BE_Lj-Dou+GeZod6cdX4-LSxzpRmQaDA@mail.gmail.com>
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 04:04:02PM +0100, Peter Maydell wrote:
> On 6 May 2018 at 14:39, David Gibson <david@gibson.dropbear.id.au> wrote:
> > Well, I'm biased of course, but I think we'd be better off just
> > ditching the wrapper.  In its present form it is so limited as to not
> > really add any value.  If it was rewritten to do something useful
> > (e.g. handling reallocations), I think it would be even better if
> > done as an extension to libfdt itself so it can benefit everyone, not
> > just qemu.
>=20
> Well, some of it is working around infelicities in libfdt's
> API (like all the getprop/setprop functions taking an offset
> value rather than a node name), but yes, it would be better
> to fix the libfdt API if possible.
>=20
> > Although, that said, I'll re-iterate that I think qemu's fdt
> > manipulation is now sufficiently complex that it would be better off
> > using a "live" (dynamically allocated & pointer based) tree
> > representation that we just flatten immediately before loading it into
> > the guest.
>=20
> This sounds to me like something that should be handled
> by libfdt.

No, it's really not.  libfdt is specifically for reading and writing
flattened trees in place, in flattened form.  That's the whole basis
of the design and it's directly responsible for some of the
infelicities you mention.

I was never intended as a general runtime t manipulation library.  A
libdt that does that (using an allocator and internal pointer
representation) would be a nice thing to have, but libfdt isn't it.
Obviously being able to use libfdt to flatten and unflatten trees
would be a very good feature for such a library.

> internal representation of the data structure is, I just
> want to be able to (a) hand it an fdt read in from a file
> (b) call various functions to modify the data structure
> and then (c) write the resulting thing out to an fdt in
> guest memory. Whether libfdt prefers to do that by
> modifying the flat representation or by converting into
> a dynamically allocated unflattened tree and back again
> is something I'd rather leave to it as an implementation
> detail.

Sort of.  But there design constraints in libfdt which means that's
not really feasible.  Such as:
  * not requiring an allocator
  * not requiring a "read / unflatten" pass before reading values from
    an fdt
  * not requiring allocation or creation of a "context" state for
    manipulating a tree

Those aren't aren't really relevant to qemu and perhaps aren't part of
what you'd usually think of as the API.  But they do matter to real
libfdt use cases.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlryh9QACgkQbDjKyiDZ
s5JzrhAAk5lzPYpG15QfRE8JiOmD9ciY4zO534xuMeRxUnhEx4ZCPolkvfqY8cym
+TYp5lzEFcm/Ofrx+PBieRyz5Tl+x3trfl+M7TXuG934XuviLkGsb+aghb6inYM6
Vne98k3/J4nTBSZnvtgcN6hMLHsE05EjxLZ4Di78Q//Dmuvs7fa+DUyp1bDIyWrE
A6rttVYAKswn9eJRSsLM0SLV9C8Po+8+19bPFY3smNhngEOb3vM0h8aAKYaq8oQQ
NCJakHnvHDMmYkGJbBAFssTRHaAc0Of3k3/TnaykUIMe5mXOG2wyh2xUJC0b9zmf
OatLUJtY0X5QIMQdbqYl7Eb8Z56xKAGfYL2h1sxF0ZmJYF6G5VdAyf3p4/Ke5tX0
L/D/TpfMr3Hj0lkvihChWv/+ZogX+0Y1j24+2zD5i//g5sDUdjW4CVi/jP8Xuush
t1tyJxO5EqboJXluZ6PYVWcDFSwXzH1Sqt0urQDaGM34Vm9/ZSHiGTDTKWSKMaP3
/cqvMRtnMlli6U/+4Tt3kO1imK1ASf1UB3uOJWRiQvRzz9CFwEj/1lK1wJGSHK4F
rOoBsWcfQK5NX/zZsoIlGTeRz4CifCHrgOAh4vVV/YUD6bpF2WM0kKxo3KSTdNLE
RQ07slsM0kH1WDOE5Mlsvy13Si7yR7aOlzxCBucMRqhs74C6iXw=
=hu5e
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
