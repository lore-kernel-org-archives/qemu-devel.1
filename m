Received: from eggs.gnu.org ([2001:4830:134:3::10]:43350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciYre-0005Kl-76
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciYrd-00043N-0A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:14 -0500
Date: Tue, 28 Feb 2017 14:54:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228035400.GA12655@umbus.fritz.box>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/26] ppc/xics: simplify ICS and ICP
 creation
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


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Feb 27, 2017 at 03:29:07PM +0100, C=E9dric Le Goater wrote:
>=20
> Hello,
>=20
> The goal behind this series is to simplify the XICS interface by
> moving back in the machine the way the ICS and ICP objects interact
> together. It's up to the machine to implement this "fabric" logic by
> providing a set of handlers of a QOM interface. These handlers are
> used to grab an ICS or an ICP object and also do irq resends. The idea
> was suggested by David Gibson.
>=20
>=20
> The patchset is organised as follow. It starts with a preliminary
> cleanup to get rid of the set_nr_irqs() and set_nr_servers()
> handlers. It also moves the creation of the ICS and ICP objects from
> the XICS object to the sPAPR machine. This simplifies the code
> significantly and prepares ground for future changes.
>=20
> As the sPAPR machine only makes use of a single ICS, we can store it
> at the machine level. This lets us remove dependencies on the list of
> ICS of the XICS object and simplify even more the code for the
> following changes.
>=20
> The QOM interface to interact with the ICS and ICP objects is then
> introduced. These are moved under the machine and cleanups are done
> accordingly.
>=20
> Finally, the XICSState classes are removed as they have been
> deprecated by the QOM interface.
>=20
>=20
> After the initial cleanups, which are rather big, each patch are small
> and simple. The make target 'check-qtest-ppc64' runs succesfully for
> each of them and so does migration of HV and TCG guests.
>=20
> The tree is available here :
>=20
> 	   https://github.com/legoater/qemu/tree/ppc-2.9

There are some things I'd do differently, and I think there's room for
some future improvements, but this is certainly much better than where
we started.  So I've merged this into ppc-for-2.9.  Assuming my usual
tests pass, I hope to send a pull request shortly, to squeeze in just
in time for the soft freeze.

>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
> Caveats:
>=20
>  - The kernel ICP file descriptor 'kernel_xics_fd' was made static to
>    ease changes but that could be an issue. We could move it under the
>    sPAPR machine if needed.
>=20
> Changes since v3:
>=20
>  - reintroduced 'xics' backlinks to remove useless calls to
>    qdev_get_machine()
>  - moved InterruptStatsProvider to the sPAPR machine for a better
>    output
>  - moved move ics-simple post_load under the machine and removed the
>    icp_resend() XICSFabric handler
> =20
> Changes since v2:
>=20
>  - renamed QOM Interface to XICSFabric
>=20
> C=E9dric Le Goater (25):
>   ppc/xics: fix ICP and ICS reset
>   ppc/xics: remove set_nr_irqs() handler from XICSStateClass
>   ppc/xics: remove set_nr_servers() handler from XICSStateClass
>   ppc/xics: store the ICS object under the sPAPR machine
>   ppc/xics: add an InterruptStatsProvider interface to ICS and ICP
>     objects
>   ppc/xics: introduce a XICSFabric QOM interface to handle ICSs
>   ppc/xics: use the QOM interface under the sPAPR machine
>   ppc/xics: use the QOM interface to get irqs
>   ppc/xics: use the QOM interface to resend irqs
>   ppc/xics: remove xics_find_source()
>   ppc/xics: register the reset handler of ICS objects
>   ppc/xics: remove the XICS list of ICS
>   ppc/xics: extend the QOM interface to handle ICPs
>   ppc/xics: move kernel_xics_fd out of KVMXICSState
>   ppc/xics: simplify the cpu_setup() handler
>   ppc/xics: move the cpu_setup() handler under the ICPState class
>   ppc/xics: use the QOM interface to grab an ICP
>   ppc/xics: simplify spapr_dt_xics() interface
>   ppc/xics: register the reset handler of ICP objects
>   ppc/xics: move the ICP array under the sPAPR machine
>   ppc/xics: export the XICS init routines
>   ppc/xics: remove the XICSState classes
>   ppc/xics: move ics-simple post_load under the machine
>   ppc/xics: move InterruptStatsProvider to the sPAPR machine
>   ppc/xics: rename 'ICPState *' variables to 'icp'
>=20
> David Gibson (1):
>   xics: XICS should not be a SysBusDevice
>=20
>  hw/intc/xics.c              | 461 +++++++++++++++++---------------------=
------
>  hw/intc/xics_kvm.c          | 184 +++++-------------
>  hw/intc/xics_spapr.c        | 128 +++---------
>  hw/ppc/spapr.c              | 134 ++++++++++---
>  hw/ppc/spapr_cpu_core.c     |   4 +-
>  hw/ppc/spapr_events.c       |  10 +-
>  hw/ppc/spapr_pci.c          |  10 +-
>  hw/ppc/spapr_vio.c          |   2 +-
>  include/hw/pci-host/spapr.h |   2 +-
>  include/hw/ppc/spapr.h      |   5 +-
>  include/hw/ppc/spapr_vio.h  |   2 +-
>  include/hw/ppc/xics.h       |  97 ++++------
>  12 files changed, 424 insertions(+), 615 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtPRVAAoJEGw4ysog2bOSoqQQAI238Xb2qH7zsKf8AsX6S/jh
6j4s2ujjyJd0QwZgJAKNej45WxjhxEm89CP8ebtZlInVk4Euy4pimzzbyH7cb2ZN
DPr7GYMifsxDt0BdHZOdfbJ6CCl+TUNx4sKOwlYzQhW2d1nSAqqWKFrQQ2WdwtbF
Ylp4F2kmaVOsoKH/6OxgyHctiqxYlahHVHrpStwvMdPoZmNsA7YdUXhv95qP0eEF
IZwdbbIGMXqBtyYYue/a3dtwUY5PziAg66YPir4JsrrIt6rHcUil16/vpLnjF4z2
j2D1wc25px0DXNnE/Y6hyERUKOqiwVFt2WfZ8xqZkP6PPwjPaqxZBm+B3Qp/8mtU
QelPyleXSD2ujj2eWeuSmGQ9TLwKF5CT6kgQb38MZhRa9e5wA8u1Fr1M0mPbI/rz
qNBIDRB/t+DxUJcM5Lts4DXGMSOj9RsZvRMkHJuvfPTuz8TbXJenAi4refywl/nz
iFgwHkCOeT7PVSrk2N0BvHZcYN8dbnJSHOhR8Gj0Ndvmb64V2+95SAsK+JRDJti2
PwAeYsTrGmTg0NuHH2T8NOj3lqTYJLiau9Evj+ywVB7M/TUEvOhP4tDKuiPCg01S
roQJW/8w6hEF6ObtczWtyuSHwzBu9hf8ge9OUVcfTiQiDESTq520AuQ4dfg7QeDH
JUx3wbBORuccWCFTbohj
=1/6K
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
