Received: from eggs.gnu.org ([2001:4830:134:3::10]:47956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpn-0001It-BT
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpl-0002IG-8C
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:39 -0500
Date: Fri, 1 Dec 2017 15:03:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201040301.GD30161@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-13-clg@kaod.org>
	<20171129051110.GI3023@umbus.fritz.box>
	<b0fd23cc-bc15-8023-69da-508ce5f6d0fe@kaod.org>
	<20171130040604.GV3023@umbus.fritz.box>
	<d35fe0fe-ae4a-3bba-ac74-ea07701d331b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <d35fe0fe-ae4a-3bba-ac74-ea07701d331b@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 12/25] spapr: introduce a XIVE interrupt
 presenter model
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


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 01:44:51PM +0000, C=E9dric Le Goater wrote:
> On 11/30/2017 04:06 AM, David Gibson wrote:
> > On Wed, Nov 29, 2017 at 10:55:34AM +0100, C=E9dric Le Goater wrote:
> >> On 11/29/2017 06:11 AM, David Gibson wrote:
> >>> On Thu, Nov 23, 2017 at 02:29:42PM +0100, C=E9dric Le Goater wrote:
> >>>> The XIVE interrupt presenter exposes a set of rings, also called
> >>>> Thread Interrupt Management Areas (TIMA), to handle priority
> >>>> management and interrupt acknowledgment among other things. There is
> >>>> one ring per level of privilege, four in all. The one we are
> >>>> interested in for the sPAPR machine is the OS ring.
> >>>>
> >>>> The TIMA is mapped at the same address for each CPU. 'current_cpu' is
> >>>> used to retrieve the targeted interrupt presenter object holding the
> >>>> cache data of the registers the model use.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/spapr_xive.c        | 271 +++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  hw/intc/xive-internal.h     |  89 +++++++++++++++
> >>>>  include/hw/ppc/spapr_xive.h |  11 ++
> >>>>  3 files changed, 371 insertions(+)
> >>>>
> >>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >>>> index b1e3f8710cff..554b25e0884c 100644
> >>>> --- a/hw/intc/spapr_xive.c
> >>>> +++ b/hw/intc/spapr_xive.c
> >>>> @@ -23,9 +23,166 @@
> >>>>  #include "sysemu/dma.h"
> >>>>  #include "monitor/monitor.h"
> >>>>  #include "hw/ppc/spapr_xive.h"
> >>>> +#include "hw/ppc/xics.h"
> >>>> =20
> >>>>  #include "xive-internal.h"
> >>>> =20
> >>>> +struct sPAPRXiveICP {
> >>>
> >>> I'd really prefer to avoid calling anything in xive "icp" to avoid
> >>> confusion with xics.
> >>
> >> OK.=20
> >>
> >> The specs refers to the whole as an IVPE : Interrupt Virtualization=20
> >> Presentation Engine. In our model, we use the TIMA cached values of=20
> >> the OS ring and the qemu_irq for the CPU line.=20
> >>
> >> Would 'sPAPRXivePresenter' be fine ?
> >=20
> > That'd be ok.  Or call if sPAPRIVPE.  Or even call it TIMA.  I'd be
> > fine with any of those.
>=20
> In this model, I am making a lot of shortcuts in the XIVE concepts
> (which I don't master completely yet ...)=20
>=20
> The IVPE is the part of the overall controller doing the interrupt=20
> presentation.
>=20
> The TIMA refers to the MMIO region in which the thread interrupt=20
> management is done.=20
>=20
> The XIVE structure that contains the 'virtual processor' interrupt=20
> state is the NVT: Notification Virtual Target. An index to an NVT=20
> is stored in the EQs to do the routing. I did not introduce the NVT=20
> in sPAPRXive because it's rather big, 128 bytes, and we don't need=20
> much of it (NSR, CPPR, PIPR, IPB) but we could use a shorten one.
>=20
> So I think sPAPRXiveNVT, or sPAPRXiveVP (VP for virtual processor)
> would be better names.

Ok.  I prefer sPAPRXiveNVT of these two.

>=20
> We will need more of the NVT structure to support the hcalls=20
> doing the set and the get of the address of the Reporting Cache=20
> line (H_INT_{S,G}ET_OS_REPORTING_LINE). We can extend it when=20
> time comes. =20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlog1HQACgkQbDjKyiDZ
s5KksRAAsDd2ALvm+kFheCGiqWi2gFAU1jZQPDICGLzyfZIF5MSRrorOwcZ7naTH
vNTemWQ/aGHbky1eL06mAYKuNlGqYzIpYbwLDlfoRYzkhEMMigqjvNSfhg+Uzgi1
s3gjUt0Enl5DjI4UkQUl2k490qptdDoSwFZICTvjg4YQalzT0ItlKSycKuKXJLZU
jAHqmfbUq6pTrqzJ715122dVQgmJkDXloTqGxn9Eu2e/E5jcOspokAXzR/aLrz5Q
tv4Fm74j1sjzqXnVEFMXWkUQ6wvMj73qzmJXXUAEf2IqFmVlTjMTqm2/IeIKIr+u
hqGENYZP/QFxuyjAclAAhjQtcmUzEC4fyVPaE5CQ3P/3O8no9sM2tiwlrI+fCx1y
67g7WAWe2gDVQv2MFuRqsBJevxT87uKbggOvkBeFP0cBpMe6H55vJKadK7DdayUq
lnvOD3sbxh1gTHmzm+0b+PA6Iwl16hdsfKqOtxg7ivMI3LLTwU0FHMNIlRsNh70t
6dc9paTyvRA6rkydnnwGceDO2p6EHkLbQt+JqZACfp+Cu7TnECnxx5y/CNIwzgAW
c56z+g3E8cWV1IeZ3Chym4NryZ2D7p1uHNWQC7ooRuXUZDgguwFiOJdleocgRIyg
zBAPcZTFipHmXo9pY1vlBdjfaVe+VKtVIV8l+pUkDAyPulHQ7ck=
=dJeH
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
