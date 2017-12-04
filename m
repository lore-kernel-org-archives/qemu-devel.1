Received: from eggs.gnu.org ([2001:4830:134:3::10]:55107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eLoCP-0001OR-8s
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eLoCO-0001Ez-6K
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:42:09 -0500
Date: Mon, 4 Dec 2017 10:41:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171204104155.GB11502@stefanha-x1.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
	<f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
	<CAFEAcA_9wnMkJ+BHjrU8Eb_0vQMK-cYyxtgtsoFN2OWpSHbsCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_9wnMkJ+BHjrU8Eb_0vQMK-cYyxtgtsoFN2OWpSHbsCw@mail.gmail.com>
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 07:03:15PM +0000, Peter Maydell wrote:
> On 1 December 2017 at 17:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Same here.  Just like fixing the C code provides a good foundation for a
> > language switch, some more battle-tested code could be converted from
> > QEMU to Rust, in order to get familiar with it and probe whether the
> > benefits are real.  Maybe the memory API could be a good candidate; it
> > certainly would benefit from generics.
>=20
> At the moment I feel like betting the future of the project on
> Rust would be quite a courageous decision. On the other hand
> it might be interesting to look at prototyping to see what
> benefits it might bring. (One candidate I had in mind was the
> device API -- given that we have had quite a few buffer overruns
> in device code, converting some of the device models to Rust
> might cut off that particular security issue.)
>=20
> I agree with you that trying to tackle conversion without at
> least one developer with reasonably-expert Rust knowledge is
> likely to be fraught, though -- what you really need is to be
> able to design APIs which are idiomatic for the language, rather
> than the kind of thing you'd write in C but transliterated across...

My main concern beyond lack of Rust experience is that quite a bit of
glue code is necessary to mix Rust and C:

  https://doc.rust-lang.org/book/first-edition/ffi.html

You need to redefine structs and functions in Rust.  To make the C
functions easily callable from Rust without unsafe code, you then need
to write Rust wrapper functions.

This means a lot of boilerplate and duplication.  It makes documenting
code harder.

IMO it will be very hard to replace a component in the QEMU codebase
with Rust code unless we're willing to put up with a lot of boilerplate
and duplication.

Where Rust makes a lot of sense to me is for new programs like
qemu-pr-helper, vhost-user programs, etc.  They have a clearly-defined
boundary (command-line, socket protocol, etc) where switching to Rust
doesn't require redeclaring a bunch of existing C interfaces.

Stefan

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJSZzAAoJEJykq7OBq3PIX0cH/3BZZ1ceN9H4DJSNc4zHp8FF
CTjo3KT8sLU+jJIIb+j4tH/J5P2NLREVc4pXTWQ1ATmodr5j0/tvPCwOI6TkMij7
qyG/i9LGJ3H4EvX86N8Plj3CTgsyHuKQTlfZ23yUnfqMmqOLmy1rfKFSjhhXujvK
CC0vfNkYwnV99NwNBgbLb5/SRSWDoa8p39vgTrusTOLTwTfhfCUYAtdf14/lha3D
Dk3fYdlN2aUDcJxhaqn2NEwSOcvhfjkUt14jrQW8x7m9wtYCTT5lm9sbev8yhn58
qXlaFNBjvSCVjwThfc37VhgnRtDZQZoLBXDTfuk3wc0BxzsGsNJeQeqFTp9KJfI=
=2v94
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
