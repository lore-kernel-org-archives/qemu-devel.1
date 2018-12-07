Received: from eggs.gnu.org ([2001:4830:134:3::10]:43268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV5cf-0004Ng-SZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV5cZ-0002OJ-4g
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:12:09 -0500
Date: Fri, 7 Dec 2018 12:57:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207015753.GW768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-5-clg@kaod.org>
	<20181206034124.GM768@umbus.fritz.box>
	<0ed7f319-7ae1-e407-96c1-266463d2a472@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qndya+I13rh6QJ0p"
Content-Disposition: inline
In-Reply-To: <0ed7f319-7ae1-e407-96c1-266463d2a472@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 04/37] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--qndya+I13rh6QJ0p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 07:22:54AM +0100, C=E9dric Le Goater wrote:
> On 12/6/18 4:41 AM, David Gibson wrote:
> > On Thu, Dec 06, 2018 at 12:22:18AM +0100, C=E9dric Le Goater wrote:
> >> The XiveRouter models the second sub-engine of the XIVE architecture :
> >> the Interrupt Virtualization Routing Engine (IVRE).
> >>
> >> The IVRE handles event notifications of the IVSE and performs the
> >> interrupt routing process. For this purpose, it uses a set of tables
> >> stored in system memory, the first of which being the Event Assignment
> >> Structure (EAS) table.
> >>
> >> The EAT associates an interrupt source number with an Event Notificati=
on
> >> Descriptor (END) which will be used in a second phase of the routing
> >> process to identify a Notification Virtual Target.
> >>
> >> The XiveRouter is an abstract class which needs to be inherited from
> >> to define a storage for the EAT, and other upcoming tables.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xive.h      | 31 ++++++++++++++++
> >>  include/hw/ppc/xive_regs.h | 50 +++++++++++++++++++++++++
> >>  hw/intc/xive.c             | 76 ++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 157 insertions(+)
> >>  create mode 100644 include/hw/ppc/xive_regs.h
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 6770cffec67d..57ec9f84f527 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -141,6 +141,8 @@
> >>  #define PPC_XIVE_H
> >> =20
> >>  #include "hw/qdev-core.h"
> >> +#include "hw/sysbus.h"
> >> +#include "hw/ppc/xive_regs.h"
> >> =20
> >>  /*
> >>   * XIVE Fabric (Interface between Source and Router)
> >> @@ -297,4 +299,33 @@ static inline void xive_source_irq_set(XiveSource=
 *xsrc, uint32_t srcno,
> >>      }
> >>  }
> >> =20
> >> +/*
> >> + * XIVE Router
> >> + */
> >> +
> >> +typedef struct XiveRouter {
> >> +    SysBusDevice    parent;
> >=20
> > I thought the plan was to make XiveRouter as well as XiveSource a
> > TYPE_DEVICE descendent rather than a SysBusDevice?
>=20
> We start talking about that, indeed, but then :
>=20
> 	https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06407.html
>=20
> I thought we concluded that it was going to get too complex.
>=20
> Also, sPAPRXive is a direct descendant of XiveRouter and we want sPAPRXiv=
e=20
> on SysBus.

Ah, good point.  So, to clarify my thinking here - I think from a
theoretical point of view, having XiveRouter not be sysbus and
including it by composition is probably the "correct" approach.

But I can also see that that will be a bit of a pain in practice.  So
yes, keeping it as a SysBusDevice is ok, at least as long as any
migration stuff is in the "outermost" / most specific type, which I
believe it is.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qndya+I13rh6QJ0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ058ACgkQbDjKyiDZ
s5JrXw/9HpZ1j8/C0+6rZ8ks0q4Yilf88Ro7WxD2WtRdcPoQUU9EBNaM5mx7NizB
iiYgpS8mYrGXw3TfpDDVB//tB6lWs0+3bwTIUW6M9HWmSFtwHv1N1qslQ2zhtJRQ
pFduggdWmaVndynn63WvZn6b2pOaYdN2bLvOwcFTHnvwIY2WdxiXuottYOg444uW
znwtwwHQc+c3EYhqtsdVBR+WvSa65TgoiWMUYtxFPGAc5l1GWKYIW0i6UYRzvi/n
s1Xzop8rDUsJtxAaFqZfvLSaDk7Q4/cWu0L/unHuEZx1T37y+aJqDOy/hcEu81TU
/uE2hyzIG3nE3yaSsmk7vrq5m7kef2QWIabk/hi+lXqnvD9ZPkvtB7vK5Ua4/CFR
i/Wa9gGVVvsdiUk/eqCPqeSPptShwRmzGSn7LxPzLJ5W7Rp++3zOoghtAZwKoW/R
jpLp6ikFDZbqb2ics6+CkxHlkhhWeF3FP5Rzay/giYe4nuwUy/lDZNHgqXsfXHcK
ZDGigmzcKBB8fDurlqhgMSJj7X7aPg2w0r4XUsiMQs6smeDM3KhmAYr6sxM4WrU1
Lcytkzv6Bfj1qTsXYoaIKsoZpk+KpHFB5tTI7z6CE7iJOkxdnsKDl1XmA7O7rgYg
0q0b8Gl69DJOL3VSu2Lb3zoyygo97Bz9yYwAv08r0G4t2Ar3pOI=
=h5uf
-----END PGP SIGNATURE-----

--qndya+I13rh6QJ0p--
