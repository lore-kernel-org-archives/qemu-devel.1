Received: from eggs.gnu.org ([2001:4830:134:3::10]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDM3-0005y2-J0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDM0-0006DW-G0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:44:03 -0500
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:51916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chDM0-0006BX-9Z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:44:00 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CFEC1DCB38
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:43:57 +0100 (CET)
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b46934f9-f04b-8738-ca42-2cd76814ac28@kaod.org>
Date: Fri, 24 Feb 2017 11:41:34 +0100
MIME-Version: 1.0
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/24] ppc/xics: simplify ICS and ICP
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/24/2017 11:17 AM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> The goal behind this series is to simplify the XICS interface by
> moving back in the machine the way the ICS and ICP objects interact
> together. It's up to the machine to implement this "fabric" logic by
> providing a set of handlers of a QOM interface. These handlers are
> used to grab an ICS or an ICP object and also do irq resends. The idea
> was suggested by David Gibson.

David,

For some reason, my email filters went wild and I missed all your
comments a part from the one on XICSFabric ... So please ignore v3.

I will go through your emails now that I see them ...

Sorry for the noise,

C.=20


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
> Changes since v2:
>=20
>  - renamed QOM Interface to XICSFabric
>=20
> C=C3=A9dric Le Goater (23):
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
> David Gibson (1):
>   xics: XICS should not be a SysBusDevice
>=20
>  hw/intc/xics.c              | 295 +++++++++++++-----------------------=
--------
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
