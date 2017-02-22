Received: from eggs.gnu.org ([2001:4830:134:3::10]:47835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgOPR-0000id-BR
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 23:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgOPP-0006gc-SQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 23:20:09 -0500
Date: Wed, 22 Feb 2017 14:34:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170222033423.GK12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/22] ppc/xics: simplify ICS and ICP
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


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:23PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> The goal behind this series is to simplify the XICS interface by
> moving back in the machine the way the ICS and ICP objects interact
> together. It's up to the machine to implement this "fabric" logic by
> providing a set of handlers of a QOM interface. These handlers are
> used to grab an ICS or an ICP object and also do irq resends. This
> idea was suggested by David Gibson.
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
> After the initial cleanups, which are rather big, I have tried to keep
> the each patch small enough to ease the review and to spot any
> problem. Each should be bisectable. The tree is available here :
>=20
> 	   https://github.com/legoater/qemu/tree/ppc-2.9

So, after you posted this, I discover the patch I sent the other day -
changing XICS away from a SysBusDevice breaks the postcopy migration
test on KVM.  I haven't had a chance to debug this yet, so for the
time being I've pulled my patch from ppc-for-2.9.  I've moved it into
a new 'xics-cleanup' branch.

>=20
>=20
> Thanks,
>=20
> C.
>=20
>=20
> Changes since v1:
>=20
>  - address the full picture.
>=20
> C=E9dric Le Goater (22):
>   ppc/xics: remove set_nr_irqs() handler from XICSStateClass
>   ppc/xics: remove set_nr_servers() handler from XICSStateClass
>   ppc/xics: store the ICS object under the sPAPR machine
>   ppc/xics: add an InterruptStatsProvider interface to ICS and ICP
>     objects
>   ppc/xics: introduce a QOM interface to handle ICSs
>   ppc/xics: use the QOM interface under the sPAPR machine
>   ppc/xics: use the QOM interface to get irqs
>   ppc/xics: use the QOM interface to resend irqs
>   ppc/xics: remove xics_find_source()
>   ppc/xics: register the reset handler of ICS objects
>   ppc/xics: remove the XICS list of ICS
>   ppc/xics: extend the QOM interface to handle ICPs
>   ppc/xics: simplify the cpu_setup() handler
>   ppc/xics: use the QOM interface to grab an ICP
>   ppc/xics: simplify spapr_dt_xics() interface
>   ppc/xics: register the reset handler of ICP objects
>   ppc/xics: move the ICP array under the sPAPR machine
>   ppc/xics: move kernel_xics_fd out of KVMXICSState
>   ppc/xics: move the cpu_setup() handler under the ICPState class
>   ppc/xics: remove the 'xics' backlinks
>   ppc/xics: export the XICS init routines
>   ppc/xics: remove the XICSState classes
>=20
>  hw/intc/xics.c              | 295 +++++++++++++-------------------------=
------
>  hw/intc/xics_kvm.c          | 154 ++++++-----------------
>  hw/intc/xics_spapr.c        | 128 ++++---------------
>  hw/ppc/spapr.c              | 116 +++++++++++++----
>  hw/ppc/spapr_cpu_core.c     |   4 +-
>  hw/ppc/spapr_events.c       |  10 +-
>  hw/ppc/spapr_pci.c          |  10 +-
>  hw/ppc/spapr_vio.c          |   2 +-
>  include/hw/pci-host/spapr.h |   2 +-
>  include/hw/ppc/spapr.h      |   5 +-
>  include/hw/ppc/spapr_vio.h  |   2 +-
>  include/hw/ppc/xics.h       |  93 ++++++--------
>  12 files changed, 294 insertions(+), 527 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrQa9AAoJEGw4ysog2bOS0dUP/1rXzLMdPO/Pir3sMlffI+wF
Ka7GrF9u6kM6zhOYCdpSKvuYXZDnopKAuX8LJEbbaL23QWzoGckZW5B1tCrLNeN2
zAqqiyVYZQqwdRfXYZLAjLyw48tM10huj3JI44w+yDG9iueRhW3Y7FhgCDj0tuWF
qyo20OeYwGGFJ4m3rEY+SzWkITh7hG1laDKlCHjKyVylIYqSQyqPEv6it0uTn9Rt
jo7wDA9A3FWU2XVYuOv9wXr7nau6Bp0yH4JvqTRsm6/Z4EGLO5Yla5q3nOvg6Ukb
riggsm+Z4r80JML43JDT1DWhCGcFitKanRYGz435L2pCBJpbl7j7dCIZIhqBHLGz
KPPoW1VOpI/P/uDRboLrmnRF4qeKmJ4m4RJ009tc/jjmb+/ocPm7v5M9SAKvR+gQ
ZEFCNk2ReQXfXNSR3tt4FXkz21l9Pv5tnS6G9pf+OEIMdII/lwNlaYJx393fNN/c
qXHP8mmTwwyj7re2/yPpm//z4Gi/8K2mnhlQMeJtQTpUPmPNw4/VilGKQjB182IQ
Nah28ls61aDeUKpLudNhGFXTqAbdRpQ0sOO19hUUqhxy55z1WLx8L8WruMrtpEgx
QDbqp7/8/iRCHIfZJ7bKKqn8foAQnIUJXlDgZo4CPRAkznhP5qwxUV2RoVVIyJ+k
vxx+lDXcN41q/M12adW2
=Ex7D
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
