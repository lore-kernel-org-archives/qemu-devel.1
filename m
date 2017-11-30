Received: from eggs.gnu.org ([2001:4830:134:3::10]:34611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKGIC-0000P6-LJ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKGIB-0002O7-41
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:17:44 -0500
Date: Thu, 30 Nov 2017 15:06:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130040604.GV3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-13-clg@kaod.org>
	<20171129051110.GI3023@umbus.fritz.box>
	<b0fd23cc-bc15-8023-69da-508ce5f6d0fe@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HqPpMaT+a6TeY/Q4"
Content-Disposition: inline
In-Reply-To: <b0fd23cc-bc15-8023-69da-508ce5f6d0fe@kaod.org>
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


--HqPpMaT+a6TeY/Q4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 10:55:34AM +0100, C=E9dric Le Goater wrote:
> On 11/29/2017 06:11 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 02:29:42PM +0100, C=E9dric Le Goater wrote:
> >> The XIVE interrupt presenter exposes a set of rings, also called
> >> Thread Interrupt Management Areas (TIMA), to handle priority
> >> management and interrupt acknowledgment among other things. There is
> >> one ring per level of privilege, four in all. The one we are
> >> interested in for the sPAPR machine is the OS ring.
> >>
> >> The TIMA is mapped at the same address for each CPU. 'current_cpu' is
> >> used to retrieve the targeted interrupt presenter object holding the
> >> cache data of the registers the model use.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/spapr_xive.c        | 271 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/intc/xive-internal.h     |  89 +++++++++++++++
> >>  include/hw/ppc/spapr_xive.h |  11 ++
> >>  3 files changed, 371 insertions(+)
> >>
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> index b1e3f8710cff..554b25e0884c 100644
> >> --- a/hw/intc/spapr_xive.c
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -23,9 +23,166 @@
> >>  #include "sysemu/dma.h"
> >>  #include "monitor/monitor.h"
> >>  #include "hw/ppc/spapr_xive.h"
> >> +#include "hw/ppc/xics.h"
> >> =20
> >>  #include "xive-internal.h"
> >> =20
> >> +struct sPAPRXiveICP {
> >=20
> > I'd really prefer to avoid calling anything in xive "icp" to avoid
> > confusion with xics.
>=20
> OK.=20
>=20
> The specs refers to the whole as an IVPE : Interrupt Virtualization=20
> Presentation Engine. In our model, we use the TIMA cached values of=20
> the OS ring and the qemu_irq for the CPU line.=20
>=20
> Would 'sPAPRXivePresenter' be fine ?

That'd be ok.  Or call if sPAPRIVPE.  Or even call it TIMA.  I'd be
fine with any of those.

[snip]
> >> +static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsig=
ned size)
> >> +{
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> >=20
> > So, strictly speaking this could be handled by setting each of the
> > CPUs address spaces separately, to something with their own TIMA
> > superimposed on address_space_memory.=20
>=20
> Ah. I didn't know we could do that.

I think that should work from having seen the code before.  I haven't
actually attempted it..

> > What you have might be more practical though.
>=20
> well, you will see at the end of the patchset how cpu->intc is
> assigned.

[snip]

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HqPpMaT+a6TeY/Q4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofg6wACgkQbDjKyiDZ
s5Ls7g/8DOctlVuAMr1vjil7O4FDp5OxIiF3Ye/yGy9p9+XTQ8ux7yS8g4O/Xhfp
42WPfly0GoveHjMNgxt13ZJQ7AID+U032/mMh9lpeYVGKiWC+dSVRfq/fOLXAqKQ
QiE8Wr54Uu5RZD7lH55KCAXpJqS10y3GFUHE1t9aKLWjczgfDMjoewVrbrA9YKAD
3I+2QKF0OzE+aNJ4xwtwOAQLG84j3lyTNGnDoNq+4SjmqZ0SaDqMdEzchLFOiDUE
5wHwsknBQGBUelxZ6d7qYgT0cIcY/WGO3BHPU48rBzcbOGdWGjr7+p7B0n8SqNTX
ggesbtxwK5KJnv9u18iuD9sQyQ4vxBG8FF3dt8t7Zq3a/DETkevK9xH3eAj62Sd8
q6YTcAfddRMc67mF+jPumd9F+MNk2WB+Xxvphc2MfVANr7IjqNZNExzukekyuTh0
vcBTVcf/JVbzT7Py3YB4VRBCDNLZbpYZGr4rSD8mRtJwRjJNvM/9C+EivZFZcN+6
3T3eYe1a8cX3MytCIlAQcz7Mi49COyHJJWTf3/Hby1wtbkCi7wdIIbkf6ZYoy1aq
Lj48SbPiy3gDEc3uPudsNTWVWzFCoIHlcgwZbEivN1Rr4aydHFhs9Wc5CpKRLS8I
MIWyhK2qReDETf2ZmHnjWXXMBCNHWpOdZtLXNZjMJEajVoZR7XQ=
=F2+/
-----END PGP SIGNATURE-----

--HqPpMaT+a6TeY/Q4--
