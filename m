Received: from eggs.gnu.org ([2001:4830:134:3::10]:40557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBt0R-0000a1-Hu
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 22:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBt0N-0004ki-GB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 22:21:03 -0400
Date: Fri, 27 Apr 2018 12:14:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180427021422.GL8800@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
	<20180426005555.GA8800@umbus.fritz.box>
	<1524732340.23669.21.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oY1uq2ONqt5kuovO"
Content-Disposition: inline
In-Reply-To: <1524732340.23669.21.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--oY1uq2ONqt5kuovO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 10:45:40AM +0200, Andrea Bolognani wrote:
> On Thu, 2018-04-26 at 10:55 +1000, David Gibson wrote:
> > On Wed, Apr 25, 2018 at 06:09:26PM +0200, Andrea Bolognani wrote:
> > > The new parameter would make it possible to make sure you will
> > > actually be able to use the page size you're interested in inside
> > > the guest, by preventing it from starting at all if the host didn't
> > > provide big enough backing pages;
> >=20
> > That's right
> >=20
> > > it would also ensure the guest
> > > gets access to different page sizes when running using TCG as an
> > > accelerator instead of KVM.
> >=20
> > Uh.. it would ensure the guest *doesn't* get access to different page
> > sizes in TCG vs. KVM.  Is that what you meant to say?
>=20
> Oops, looks like I accidentally a word there. Of course you got it
> right and I meant exactly the opposite of what I actually wrote :/

:)

> > > For a KVM guest running on a POWER8 host, the matrix would look
> > > like
> > >=20
> > >     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
> > >   -------- -------- -------- -------- -------- --------
> > >    64 KiB | 64 KiB | 64 KiB |        |        |        |
> > >   -------- -------- -------- -------- -------- --------
> > >    16 MiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
> > >   -------- -------- -------- -------- -------- --------
> > >    16 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
> > >   -------- -------- -------- -------- -------- --------
> > >=20
> > > with backing page sizes from top to bottom, requested max page
> > > sizes from left to right, actual max page sizes in the cells and
> > > empty cells meaning the guest won't be able to start; on a POWER9
> > > machine, the matrix would look like
> > >=20
> > >     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
> > >   -------- -------- -------- -------- -------- --------
> > >    64 KiB | 64 KiB | 64 KiB |        |        |        |
> > >   -------- -------- -------- -------- -------- --------
> > >     2 MiB | 64 KiB | 64 KiB |        |        |        |
> > >   -------- -------- -------- -------- -------- --------
> > >     1 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
> > >   -------- -------- -------- -------- -------- --------
> > >=20
> > > instead, and finally on TCG the backing page size wouldn't matter
> > > and you would simply have
> > >=20
> > >     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
> > >   -------- -------- -------- -------- -------- --------
> > >           | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
> > >   -------- -------- -------- -------- -------- --------
> > >=20
> > > Does everything up until here make sense?
> >=20
> > Yes, that all looks right.
>=20
> Cool.
>=20
> Unfortunately, that pretty much seals the deal on libvirt *not* being
> able to infer the value from other guest settings :(
>=20
> The only reasonable candidate would be the size of host pages used for
> backing guest memory; however

Right.

>   * TCG, RPT and KVM PR guests can't infer anything from it, as they
>     are not tied to it. Having different behaviors for TCG and KVM
>     would be easy, but differentiating between HPT KVM HV guest and
>     all other kinds is something we can't do at the moment, and that
>     in the past have actively resisted doing;

Yeah, I certainly wouldn't recommend that.  It's basically what we're
doing in qemu now, and I want to change, because it's a bad idea.

It still would be possible to key off the host side hugepage size, but
apply the limit to all VMs - in a sense crippling TCG guests to give
them matching behaviour to KVM guests.

>   * the user might want to limit things further, eg. preventing an
>     HPT KVM HV guest backed by 16 MiB pages or an HPT TCG guest from
>     using hugepages.

Right.. note that with the draft qemu patches a TCG guest will be
prevented from using hugepages *by default* (the default value of the
capability is 16).  You have to explicitly change it to allow
hugepages to be used in a TCG guest (but you don't have to supply
hugepage backing).

> With the second use case in mind: would it make sense, or even be
> possible, to make it so the capability works for RPT guests too?

Possible, maybe.. I think there's another property where RPT pagesizes
are advertised.  But I think it's a bad idea.  In order to have the
normal HPT case work consistently we need to set the default cap value
to 16 (64kiB page max).  If that applied to RPT guests as well, we'd
be unnecessarily crippling nearly all RPT guests.

> Thinking even further, what about other architectures? Is this
> something they might want to do too? The scenario I have in mind is
> guests backed by regular pages being prevented from using hugepages
> with the rationale that they wouldn't have the same performance
> characteristics as if they were backed by hugepages; on the opposite
> side of the spectrum, you might want to ensure the pages used to
> back guest memory are as big as the biggest page you plan to use in
> the guest, in order to guarantee the performance characteristics
> fully match expectations.

Hm, well, you'd have to ask other arch people if they see a use for
that.  It doesn't look very useful to me.  I don't think libvirt can
or should ensure identical performance characteristics for a guest
across all possible migrations.  But for HPT guests, it's not a matter
of performance characteristics: if it tries to use a large page size
and KVM doesn't have large enough backing pages, the guest will
quickly just freeze on a page fault that can never be satisfied.

> > > While trying to figure out this, one of the things I attempted to
> > > do was run a guest in POWER8 compatibility mode on a POWER9 host
> > > and use hugepages for backing, but that didn't seem to work at
> > > all, possibly hinting at the fact that not all of the above is
> > > actually accurate and I need you to correct me :)
> > > [...]
> >=20
> > Ok, so note that the scheme I'm talking about here is *not* merged as
> > yet.  The above command line will run the guest with 2MiB backing.
> >=20
> > With the existing code that should work, but the guest will only be
> > able to use 64kiB pages.
>=20
> Understood: even without the ability to limit it further, the max
> guest page size is obviously still capped by the backing page size.
>=20
> > If it didn't work at all.. there was a bug
> > fixed relatively recently that broke all hugepage backing, so you
> > could try updating to a more recent host kernel.
>=20
> That was probably it then!
>=20
> I'll see whether I can get a newer kernel running on the host, but
> my primary concern was not having gotten the command line (or the
> concepts above) completely wrong :)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oY1uq2ONqt5kuovO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrih3wACgkQbDjKyiDZ
s5J4Wg/+KBreDhtY1rmVaP6/VUXTn9gwrM4Njgk+Tl0Xn+Cg4arspnUEWjndpni4
FMvwHIb+JMIzBRRgGDCzxavHfPmV6eUHKs8FERhg92BEoniJ4z3+h9CX78PjMNS6
0KqmmzicCzJTJvAkpzGwiAd/gfw9ahfRFDhibO9zwcTpPwxJiLgVp8ko5/AjPrQI
MjJbE9S0qi29+GzOR3ZYlfsuwz7JkMr0RNeIpdPaeo8PVH4YOW0WT83IssRKzUZp
lTvy8A6zc3d53vaRG/ESwrT0Yy7WRA7YbCQzhpZpMVQvPKt2s3GCCMhlxLME2Hgm
XoN03Af6ReYLoY03vH0LwFJQ8uFxhVmmq5YF8Trp3FsFTDpE8E5Cb53kRuFXyppK
5HuXJZsNL0/afOr3gWTnTKdyntGR+jOSwlyNsHGByysU/wgJKuDTB53w/o99VL8g
82XB5pWflirqAU9V6tkUnohB16AFZvhC2mJ6xdmPqIf2MV2SLqcbTh+Wo8p/2x+6
7sTnOQdPnTdPVscpLWEVjldeDPcnyvvWzxWIHAHF4Q8GlPpDE8W3AHHIzCpcMcvx
uQd5eW7HNTn6pWYlzYGXyc41W6VrCnBY2MYKyqEkQphKx33I0MjDkUxCgZ411WdP
Poiatr6tluDN/dcJaS+s0zGXluQ2GGH9carLWbAw5r7Dn+NkPZY=
=Rsou
-----END PGP SIGNATURE-----

--oY1uq2ONqt5kuovO--
