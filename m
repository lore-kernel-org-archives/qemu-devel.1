Received: from eggs.gnu.org ([2001:4830:134:3::10]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cloJ8-0001v6-E6
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cloJ4-0003yW-Jr
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:00:02 -0500
Received: from ozlabs.org ([103.22.144.67]:40135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cloJ4-0003wt-6N
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 21:59:58 -0500
Date: Thu, 9 Mar 2017 12:31:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170309013150.GK19967@umbus.fritz.box>
References: <20170308124955.35623-1-aik@ozlabs.ru>
	<CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
	<4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Content-Disposition: inline
In-Reply-To: <4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 11:52:17AM +1100, Alexey Kardashevskiy wrote:
> On 09/03/17 01:21, Peter Maydell wrote:
> > On 8 March 2017 at 13:49, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >> After 6e85fce0225f "dtc: Update requirement to v1.4.2" QEMU stopped
> >> compiling in CentOS7:
> >>
> >> In file included from /home/aik/p/qemu/dtc/libfdt/libfdt.h:54:0,
> >>                  from /home/aik/p/qemu/device_tree.c:30:
> >> /home/aik/p/qemu/dtc/libfdt/libfdt_env.h:64:0: error: "__bitwise" rede=
fined [-Werror]
> >>  #define __bitwise
> >>  ^
> >> In file included from /usr/include/asm/ptrace.h:27:0,
> >>                  from /usr/include/asm/sigcontext.h:11,
> >>                  from /usr/include/bits/sigcontext.h:27,
> >>                  from /usr/include/signal.h:340,
> >>                  from /home/aik/p/qemu/include/qemu/osdep.h:86,
> >>                  from /home/aik/p/qemu/device_tree.c:14:
> >> /usr/include/linux/types.h:21:0: note: this is the location of the pre=
vious definition
> >>  #define __bitwise __bitwise__
> >>  ^
> >> cc1: all warnings being treated as errors
> >> make: *** [device_tree.o] Error 1
> >> make: *** Waiting for unfinished jobs....
> >>
> >> The reason is that CentOS7 comes with libfdt 1.4.0 so QEMU tries using
> >> the internal one which does not compile as CentOS7 comes with gcc v4.8=
=2E5
> >> which reports warnings which it would not if the OS's libfdt was used
> >> (libfdt_env.h has not changed between 1.4.0 and 1.4.2).
> >>
> >> gcc 6.2.0 from Ubuntu v16.10 handles this fine.
> >>
> >> This replaces -I with -isystem to suppress the warning (which turns
> >> to an error because of -Werror).
> >=20
> > Thanks for the bug report. I think it would be cleaner to fix this
>=20
> Agree.
>=20
> > by fixing the problem upstream in libfdt and then moving our
> > submodule forward to the fixed version. (libfdt should not be
> > defining __ prefixed symbols as these are reserved for the
> > system.)

Yes.  I've now fixed this in upstream libfdt, at Paolo's suggestion.
Unfortunately, it came just after the 1.4.3 release.  I was just leery
about making a new release and qemu pull so soon after the last one.
Should I do that anyway?

> Also agree, regardless my proposal, libfdt should be fixed. However v2.9
> won't compile on CentOS7 (and I suppose on RHEL7) which is a bit annoying.
> And having "-isystem" makes some sense as these headers are normally syst=
em
> ones and I'd think they should be treated the same way (i.e. path should =
be
> included via -isystem vs. -I).

I'm not really clear on why -isystem fixes this problem anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwLCGAAoJEGw4ysog2bOSf7gP/A5x2/XOaIpYV4LlE0Ke4MBA
voSW2a55oVa9xP4FlJ3BFX7sTp4SEcAawLVemHYBoopVv4hE2tyzPNWpJz6Eur8L
HulXpwoTBmrNHR093PDWYzr6NEfdU+mnRAn3GQNy5i5dkkvogngS6QYtLEYivfI7
Dxmu/w1l9F3PXCS+tYsoCBB6xCZVwzcikdY130Q1LcbFIp2OiJYFri5eyidCYmLP
957Jl/D13RnbXwZzq7w3Sy6S+EUctU2/zHywxXgS9SO1zwB3hpfxcZyJ0KLuMrGL
wsrRMZQ6kN5QpMpw6nsmE87DtR/TGeN1ifDToN07HowNRScUh3kOGhCLQG6EDdPa
Fdlhr5vYqDfQbem/FHLIR00ZXj+UJs/kEEtn7JYhvmxhhqOPTDp2eZcfTz3YCuxH
KuX8y0CZ8knoIhDyqqwmO+aIl5hfTVXLptnavP0XMM3u/7qI+Ns/EjLr3Kx3J30Q
e1EQsO6wA18X0n7faJxpeag/y99Ux0nByi5cjK6WTXD3Dz696ckO7nRM7UXmWQ8C
hWv14N8m6KsQQveDhyFotgPHxwFwLBcx2ViEGwF0Y7OMjcaKCWknM0BG3pOhNBpN
6u1GpdncFEfCLmxK2RHC8MEZt2WBnZ5aifKhFlRnpsaQPK6s+wwJ2l3DOdR7leMN
mCtuDiLBEJ1bOeyqoeMF
=0WUD
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--
