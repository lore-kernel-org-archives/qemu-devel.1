Received: from eggs.gnu.org ([2001:4830:134:3::10]:42402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWuS-0008Rq-4h
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWuQ-00054x-TC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:32:28 -0500
Date: Tue, 11 Dec 2018 12:20:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211012027.GA4261@umbus.fritz.box>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
	<20181210025943.GE4261@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="enQ4buem96rqs4uP"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org


--enQ4buem96rqs4uP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:54:51PM +0100, BALATON Zoltan wrote:
> On Mon, 10 Dec 2018, David Gibson wrote:
> > On Mon, Dec 10, 2018 at 01:33:53AM +0100, BALATON Zoltan wrote:
> > > On Fri, 7 Dec 2018, Mark Cave-Ayland wrote:
> > > > This patchset is an attempt at trying to improve the VMX (Altivec) =
instruction
> > > > performance by making use of the new TCG vector operations where po=
ssible.
> > >=20
> > > This is very welcome, thanks for doing this.
> > >=20
> > > > In order to use TCG vector operations, the registers must be access=
ible from cpu_env
> > > > whilst currently they are accessed via arrays of static TCG globals=
=2E Patches 1-3
> > > > are therefore mechanical patches which introduce access helpers for=
 FPR, AVR and VSR
> > > > registers using the supplied TCGv_i64 parameter.
> > >=20
> > > Have you tried some benchmarks or tests to measure the impact of these
> > > changes? I've tried the (very unscientific) benchmarks I've written a=
bout
> > > before here:
> > >=20
> > > http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html
> > >=20
> > > (which seem to use AltiVec/VMX instructions but not sure which) on ma=
c99
> > > with MorphOS and I could not see any performance increase. I haven't =
run
> > > enough tests but results with or without this series on master were m=
ostly
> > > the same within a few percents, and sometimes even seen lower perform=
ance
> > > with these patches than without. I haven't tried to find out why (no =
time
> > > for that now) so can't really draw any conclusions from this. I'm als=
o not
> > > sure if I've actually tested what you've changed or these use instruc=
tions
> > > that your patches don't optimise yet, or the changes I've seen were j=
ust
> > > normal changes between runs; but I wonder if the increased number of
> > > temporaries could result in lower performance in some cases?
> >=20
> > What was your host machine.  IIUC this change will only improve
> > performance if the host tcg backend is able to implement TCG vector
> > ops in terms of vector ops on the host.
>=20
> Tried it on i5 650 which has: sse sse2 ssse3 sse4_1 sse4_2. I assume x86_=
64
> should be supported but not sure what are the CPU requirements.
>=20
> > In addition, this series only converts a subset of the integer and
> > logical vector instructions.  If your testcase is mostly floating
> > point (vectored or otherwise), it will still be softfloat and so not
> > see any speedup.
>=20
> Yes, I don't really know what these tests use but I think "lame" test is
> mostly floating point but tried with "lame_vmx" which should at least use
> some vector ops and "mplayer -benchmark" test is more vmx dependent based=
 on
> my previous profiling and testing with hardfloat but I'm not sure. (When
> testing these with hardfloat I've found that lame was benefiting from
> hardfloat but mplayer wasn't and more VMX related functions showed up with
> mplayer so I assumed it's more VMX bound.)

I should clarify here.  When I say "floating point" above, I'm not
meaning things using the regular FPU instead of the vector unit.  I'm
saying *anything* involving floating point calculations whether
they're done in the FPU or the vector unit.

The patches here don't convert all VMX instructions to use vector TCG
ops - they only convert a few, and those few are about using the
vector unit for integer (and logical) operations.  VMX instructions
involving floating point calculations are unaffected and will still
use soft-float.

> I've tried to do some profiling again to find out what's used but I can't
> get good results with the tools I have (oprofile stopped working since I'=
ve
> updated my machine and Linux perf provides results that are hard to
> interpret for me, haven't tried if gprof would work now it didn't before)
> but I've seen some vector related helpers in the profile so at least some
> vector ops are used. The "helper_vperm" came up top at about 11th (not su=
re
> where is it called from), other vector helpers were lower.
>=20
> I don't remember details now but previously when testing hardfloat I've
> written this: "I've looked at vperm which came out top in one of the
> profiles I've taken and on little endian hosts it has the loop backwards =
and
> also accesses vector elements from end to front which I wonder may be eno=
ugh
> for the compiler to not be able to optimise it? But I haven't checked
> assembly. The altivec dependent mplayer video decoding test did not change
> much with hardfloat, it took 98% compared to master so likely altivec is
> dominating here." (Although this was with the PPC specific vector helpers
> before VMX patch so not sure if this is still relevant.)
>=20
> The top 10 in profile were still related to low level memory access and M=
MU
> management stuff as I've found before:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03609.html
> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03704.html
>=20
> I think implementing i2c for mac99 may help this and some other
> optimisations may also be possible but I don't know enough about these to
> try that.
>=20
> It also looks like with --enable-debug something is always flusing tlb and
> blowing away tb caches so these will be top in profile and likely dominate
> runtime so can't really use profile to measure impact of VMX patch. Witho=
ut
> --enable-debug I can't get call graphs so can't get useful profile. I thi=
nk
> I've looked at this before as well but can't remember now which check
> enabled by --enable-debug is responsible for constant tb cache flush and =
if
> that could be avoided. I just don't use --enable-debug since unless need =
to
> debug somthing.
>=20
> Maybe the PPC softmmu should be reviewed and optimised by someone who kno=
ws
> it...

I'm not sure there is anyone who knows it at this point.  I probably
know it as well as anybody, and the ppc32 code scares me.  It's a
crufty mess and it would be nice to clean up, but that requires
someone with enough time and interest.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--enQ4buem96rqs4uP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPENsACgkQbDjKyiDZ
s5L8fQ//Yl+3H+xuqgmzUo9sk+uRHVLWvpftdoYKQwZuhoJMuXhIK6nTK8VvUl2l
PksC0CcS9U08sRcCm0prXWOScft7f+tF4azIX90psGLvZABlp+rzilwiDJKhENpY
KDs9AYdZvvgzZTmlDVg276+5g0hGSk7h/OrJI0j7t2sWkUOMMMlqKx+4TJZwpeVY
x/Oq/Aw0Qp/cjmTpOAED7NmZ7J/jaIzN8IIlOjlHNWs00V3DkTV9+Xc6dPeS5CvL
2pqMGZ5OK2HIYSo3ww3BVCnK4ZWvze5Y0hr+doOH/bhZkUzrfdgfETxckkp0P0Vt
Mxf0Q+QGMo77vTrc72TdR8VklCHeKCed08PYGPlHHXpmPIjGoFLM9MBQtfI263cz
l9SALIqhNuYQ/phrD4XrWA3z/fokjPI3Fa2hV32Z2IYijedJir9bFliKZx617V+L
uerV3ijvAlJzP7XmYiX/LgaN01EcZWcXKuKD/lXVSxxv4l4wwkYLxkoPzD/HvSP5
t8UquImKu9ZAnacyKKGrRjbiB4Bpc/MELzzn5ZEdGuJXIO8bCU3qXkhhXDQD8u9K
pE63iKA2WrxUsgOVliCa7N+N911fqVAeS6a7GtnOjTV8n2WXAyc+9gg+x8930BE2
mliXWcZ1B7Cl4vaK/wBgmDrH+gvE+fAwVVtFeY6uOjXCPk48wY8=
=f2YS
-----END PGP SIGNATURE-----

--enQ4buem96rqs4uP--
