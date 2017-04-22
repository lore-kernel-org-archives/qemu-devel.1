Received: from eggs.gnu.org ([2001:4830:134:3::10]:48484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1y75-0003nP-Q9
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 12:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1y74-00058h-Gr
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 12:42:23 -0400
References: <20170401155751.14322-1-mreitz@redhat.com>
	<20170421155114.GC28249@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5b1b7a17-61c6-dae6-3ef4-be8f01be47d1@redhat.com>
Date: Sat, 22 Apr 2017 18:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170421155114.GC28249@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5xufciqNdcAdvCkgI52v0mUvjiQNdHl3p"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC for-3.0 0/4] block: Add
 qcow2-rust block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5xufciqNdcAdvCkgI52v0mUvjiQNdHl3p
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <5b1b7a17-61c6-dae6-3ef4-be8f01be47d1@redhat.com>
Subject: Re: [Qemu-block] [RFC for-3.0 0/4] block: Add qcow2-rust block driver
References: <20170401155751.14322-1-mreitz@redhat.com>
 <20170421155114.GC28249@stefanha-x1.localdomain>
In-Reply-To: <20170421155114.GC28249@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21.04.2017 17:51, Stefan Hajnoczi wrote:
> On Sat, Apr 01, 2017 at 05:57:47PM +0200, Max Reitz wrote:
>> The issues of using C are well understood and nobody likes it. Let's u=
se
>> a better language. C++ is not a better language, Rust is. Everybody
>> loves Rust. Rust is good. Rust is hip. It will attract developers, it
>> will improve code quality, it will improve performance, it will even
>> improve your marriage. Rust is the future and the future is now.
>>
>> As the block layer, let's show our commitment to the future by replaci=
ng
>> one of our core parts, the the LEGACY (Bah! Yuck! Ugh!) qcow2 driver, =
by
>> a shiny (Oooh! Aaah!) Rust driver. Much better. My VMs now run thrice =
as
>> fast. Promise.
>=20
> This is actually a good exercise.
>=20
> Did you feel like there were places where Rust allowed you to express
> things better than C?

Well, I very much like the try!() macro and generally the fact that you
can return both a success and an error value at the same time.

(Which allowed me to represent the Error ** thing we generally use in a
much more natural way.)

> I like pattern matching, wish C had it.

That, including the (Haskell-like (?)) enums, is nice, too, yes.

I would like to say I hate that you have to explicitly cast integers
when converting between different widths, but if we had to do that in C,
it would have probably prevented quite some bugs we had in the past. (It
still is pretty annoying most of the time.)

Something that's not better than C but which surprised me in a really
positive way was how nice Rust's C interface is.


Having said that, there are things that really enrange me every time I
try my hands at Rust; most of which are intentional and probably
familiar to anyone having done so. But there are some things I have
missed for which there are proposed solutions, but they have been in a
"should be done soon" state for some years now.

For instance, when implementing methods for a generic type:

impl<T> BlockDriver<T> { ... }

you cannot test *whether* the type implements a certain trait.
https://github.com/XanClic/qemu/blob/rust-qcow2/block/rust/src/interface/=
mod.rs#L651
is where I complain.
You can implement functions only if T implements a trait:

impl<T: BlockDriverOpen> BlockDriver<T> {
    pub fn provides_open(&mut self) { ... }
}

But you cannot implement e.g. the same function but with a different
body (e.g. doing nothing) if T does not implement a trait, or provide a
generic implementation that is overwritten by these specialized
implementations. Both have been proposed and especially the first one is
supposed to be added in some form at some point in the future; but it
has been in that proposal state since 2014 or so...

(This is also a good thing, mind you, because it means they don't just
throw anything into the language just because it looks useful to
someone. They really think long and hard about what they add and what
implications it will have so it doesn't end up as a second C++.)


So all in all, Rust is not completely unusable, but of course you swear
a lot (at least I do) and it still feels kind of unfinished. I hate it
very much but at the same time, *for me*, I think it's the best language
for cases where I would have used C or C++ in the past.

Max


--5xufciqNdcAdvCkgI52v0mUvjiQNdHl3p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj7h+QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A1akH/272X5isN/Si7JnpOSphjWgKnhcqtjHF
eP/EB7frTaS7jjDvVeh3mTRlQUGY4esjLfHhutb/vOo3XothfSLAnS2oV8S7fpiR
pxcNf5WyDpT2B4AveBeZt4KLVstGGEGAH+3sEn/dsAGAtBG3r/mkOnPyWfQaEaEg
pYKzR9kFDL2UScz1uTbal9Ie+u1ktvkAKam2gxjn0XTiH00cg8C/byyIR3fkRyqx
dj2PFouSk/xZpdQ0hfZgLfnjC6rY3vrqk9adKLuxRi3rM44aPNPO6YVF3Y1tJnDN
jnwFM7OTiCMfkjF401vRjmbqJQLTq+fnI8PYFjC7mlaZu96kxvozhjs=
=ujwl
-----END PGP SIGNATURE-----

--5xufciqNdcAdvCkgI52v0mUvjiQNdHl3p--
