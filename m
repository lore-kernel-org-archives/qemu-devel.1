Received: from eggs.gnu.org ([2001:4830:134:3::10]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRIL-0000dI-3p
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRII-0007Wx-2S
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:48:21 -0400
Date: Wed, 20 Jun 2018 10:19:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620001919.GE3546@umbus.fritz.box>
References: <20180618173402.23405-1-clg@kaod.org>
	<20180618173402.23405-4-clg@kaod.org>
	<20180619010244.GN25461@umbus.fritz.box>
	<4c253a54-d5df-c0dd-9fac-17f7f36af9d9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <4c253a54-d5df-c0dd-9fac-17f7f36af9d9@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 12:05:21PM +0200, C=E9dric Le Goater wrote:
> On 06/19/2018 03:02 AM, David Gibson wrote:
> > On Mon, Jun 18, 2018 at 07:34:02PM +0200, C=E9dric Le Goater wrote:
> >> This proposal introduces a new IRQ number space layout using static
> >> numbers for all devices and a bitmap allocator for the MSI numbers
> >> which are negotiated by the guest at runtime.
> >>
> >> The previous layout is kept in machines raising the 'xics_legacy'
> >> flag.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr.h     |  4 ++++
> >>  include/hw/ppc/spapr_irq.h | 30 +++++++++++++++++++++++++
> >>  hw/ppc/spapr.c             | 31 +++++++++++++++++++++++++
> >>  hw/ppc/spapr_events.c      | 12 ++++++++--
> >>  hw/ppc/spapr_irq.c         | 56 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/ppc/spapr_pci.c         | 28 ++++++++++++++++++-----
> >>  hw/ppc/spapr_vio.c         | 19 ++++++++++++----
> >>  hw/ppc/Makefile.objs       |  2 +-
> >>  8 files changed, 169 insertions(+), 13 deletions(-)
> >>  create mode 100644 include/hw/ppc/spapr_irq.h
> >>  create mode 100644 hw/ppc/spapr_irq.c
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 9decc66a1915..4c63b1fac13b 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -7,6 +7,7 @@
> >>  #include "hw/ppc/spapr_drc.h"
> >>  #include "hw/mem/pc-dimm.h"
> >>  #include "hw/ppc/spapr_ovec.h"
> >> +#include "hw/ppc/spapr_irq.h"
> >> =20
> >>  struct VIOsPAPRBus;
> >>  struct sPAPRPHBState;
> >> @@ -164,6 +165,9 @@ struct sPAPRMachineState {
> >>      char *kvm_type;
> >> =20
> >>      const char *icp_type;
> >> +    bool xics_legacy;
> >=20
> > This flag can go in the class, rather than the instance.
> >=20
> > And maybe call it 'legacy_irq_allocation'.  It assumes XICS, but
> > otherwise isn't strongly tied to it.
>=20
> Here's another idea.
>=20
> Instead of a bool, we could use a find() operation if it is defined=20
> by the spapr_irq backend.

So, I don't think find() should go into the irq backend you've been
describing elsewhere.  I think that should be restricted to the
claim() side stuff.  But you could make it a sPAPRMachineClass method,
and use the static allocations if it's NULL.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlspnYcACgkQbDjKyiDZ
s5JG0hAAiKFJlejsCoQPpUzaIB/nDRTudhzv0OSiU3mKPQDPVY3FEmkaxhN4GYMr
YnH9SQ4sqknL0dyiBW9MqYuX02cdfG4MSko/psTsWJMDEaHFxKAKXVamtXDF0w34
kMvVp1IUF5HtLHvfgSuE1/2Iq9dBHUXiMEPHthVLVc5My6OzyV9/9CgHKKXL3u7L
/+C1fv5JuPSRSTJLUnV307qaiZ3CRvfVK2WM4sGrjQnm9Lqdd18ja9VjIdJpMFY0
7YEXxpcruAAutiTfbIypyeUuNXWWcKXPaw8rI9AisjXUXnumnOI0t0w9Pky6s92R
JQ9XjQe5J35Hn/1LKQ4dvR4bay4mA9hCRAQjS4IoOS/NYg6QzoVl6AYB23jqpUCy
TgYlhrSVVwwZxtrDEs4cI/t9pTsG0VCZ+Xrlq/pSaxXALRZbDwdvFyk7PVJeup27
sGeaSLMPbGnkct//jHhpZ+l6G934Hd+sP8G8Tn6m42/N4f15VvdfI5u5LKT8N8rd
m+5o89AzPaTqOR4C9yN6ZdijJnHTdAOcvStRbsddCUXPjzJz1zMl9i85yfokXUAp
Q15VzdiEKtPbQqA7G9v5JJ9obfHfcsIU8sBEjoiTi15Iq+s4gdgqi18CmgFSqWom
GYug62RLFl2KL5XqN9KMJk4yuPHgOPzoJ/14dmvDceVMdXT6Xi4=
=zt+y
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
