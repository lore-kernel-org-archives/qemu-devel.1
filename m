Received: from eggs.gnu.org ([2001:4830:134:3::10]:38394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxJr-00049f-0K
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxJp-0000SZ-TL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:42:03 -0400
Date: Wed, 14 Jun 2017 09:41:42 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614014142.GF13420@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
	<20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
	<20170611093842.GA13479@umbus>
	<20170613094302.1cb4012c@bahia.ttt.fr.ibm.com>
	<8760g01eae.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <8760g01eae.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 01:59:29PM +0530, Nikunj A Dadhania wrote:
> Greg Kurz <groug@kaod.org> writes:
>=20
> > On Sun, 11 Jun 2017 17:38:42 +0800
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> >> On Fri, Jun 09, 2017 at 05:09:13PM +0200, Greg Kurz wrote:
> >> > On Fri, 9 Jun 2017 20:28:32 +1000
> >> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >> >  =20
> >> > > On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote: =20
> >> > > > On Fri, 9 Jun 2017 12:28:13 +1000
> >> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> >> > > >    =20
> >> > > > > On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote:   =
=20
> >> > > > > > I've provided answers for all comments from the v3 review th=
at I deliberately
> >> > > > > > don't address in v4.     =20
> >> > > > >=20
> >> > > > > I've merged patches 1-4.  5 & 6 I'm still reviewing.
> >> > > > >    =20
> >> > > >=20
> >> > > > Cool. FYI, I forgot to mention that I only tested with KVM.
> >> > > >=20
> >> > > > I'm now trying with TCG and I hit various guest crash on
> >> > > > the destination (using your ppc-for-2.10 branch WITHOUT
> >> > > > my patches):   =20
> >> > >=20
> >> > > Drat.  What's your reproducer for this crash?
> >> > >  =20
> >> >=20
> >> > 1) start guest
> >> >=20
> >> > qemu-system-ppc64 \
> >> >  -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
> >> >  -device virtio-net,netdev=3Dnetdev0,id=3Dnet0 \
> >> >  -netdev bridge,id=3Dnetdev0,br=3Dvirbr0,helper=3D/usr/libexec/qemu-=
bridge-helper \
> >> >  -device virtio-blk,drive=3Ddrive0,id=3Dblk0 \
> >> >  -drive file=3D/home/greg/images/sle12-sp1-ppc64le.qcow2,id=3Ddrive0=
,if=3Dnone \
> >> >  -machine type=3Dpseries,accel=3Dtcg -cpu POWER8
>=20
> Strangely, your command line does not have multiple threads. Need to see
> what is the side effect of enabling MTTCG by default here.
>=20
> >> >=20
> >> > 2) migrate
> >> >=20
> >> > 3) destination crashes (immediately or after very short delay) or
> >> > hangs =20
> >>=20
> >> Ok.  I'll bisect it when I can, but you might well get to it first.
> >>=20
> >>=20
> >
> > Heh, maybe you didn't see in my mail but I did bisect:
> >
> > f0b0685d6694a28c66018f438e822596243b1250 is the first bad commit
> > commit f0b0685d6694a28c66018f438e822596243b1250
> > Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> > Date:   Thu Apr 27 10:48:23 2017 +0530
> >
> >     tcg: enable MTTCG by default for PPC64 on x86
>=20
> Let me have a look at it.

Is this crash fixed by the patch from Thomas I merged yesterday?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJZQJRWAAoJEGw4ysog2bOSiIkP8QEZmlqWXXnle3Z6Ylim7CDa
htnZTIaApDOoe3WzWb7gsJwhRV89d4Jl+xogPFyRiJENIKO/GFLLVs02Ro5UDgOh
PvrFSF5NIEdkzKsiqJkHoivNbXhKHC8kKJRXluQ4yb89bl+Sq6nWkvsYIReUqX07
4lkWFhF3524CO5O0qmFgbJUDxNDTVM3MBlIrX1jdmcjXahTbJT5Ggig9abBKan/5
/1tjBFzhiYuqq//RGBlr6BRRUgs5Hqv1MEXIUM/ufZX8ZEjrpfTN2MeIDaB65uaB
zdzhS09+nwOTAeiL5ZFKKoYNkOZUXM9sYckXU0tS3K+/4QoEnN+I8u8i46Opqk+z
gcFx+E6QHKy9Xcx72OGziZxQY35yS0nhX1kT4O1fxl/YjiUQ2UewS+wyU41kiug8
meKYdsEcYhafw9OgJyT4mH8QxfCueZp1AE+JJ87JHKvzWrM4o0V/394jXUraDSqH
kWhXi0rm7a63HRkPoMM7Jt9psj7exn39FPPotVnFCxY/pNWgrManFI3CdOcXBl33
adu6DRKFiIO0OnQ2IpsCMJA4ocQdeR9f9LICiRD45xh3CJeVMRyXaRtCXps7IEI3
O0Zs+/fY7fpET5QW0Ll/b3Gu87kT+ujtRq28bH5qyA3ArUTbwoQgizSPJflbOq4/
95DhGhMrJs8795nSuwM=
=Nsd5
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
