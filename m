Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCsYd-0003Zp-Kj
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCsYa-0006BN-EE
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:32:11 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:36415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCsYa-00064Q-8c
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:32:08 -0500
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4253BCAFF9
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 20:31:57 +0100 (CET)
References: <20171109101439.390-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <decc5fca-12a7-ce70-7f88-19d3d9f280c0@kaod.org>
Date: Thu, 9 Nov 2017 18:33:51 +0000
MIME-Version: 1.0
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.12 v2 00/12] spapr:
 introduce an IRQ allocator at the machine level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

David,

On 11/09/2017 10:14 AM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Currently, the ICSState 'ics' object of the sPAPR machine acts as the
> global interrupt source handler and also as the IRQ number allocator
> for the machine. Some IRQ numbers are allocated very early in the
> machine initialization sequence to populate the device tree, and this
> is a problem to introduce the new POWER XIVE interrupt model, as it
> needs to share the IRQ numbers with the older model.
>=20
> To prepare ground for XIVE, here is a proposal adding a set of new
> XICSFabric operations to let the machine handle directly the IRQ
> number allocation and to decorrelate the allocation from the interrupt
> source object :
>=20
>     bool (*irq_test)(XICSFabric *xi, int irq);
>     int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>     bool (*irq_is_lsi)(XICSFabric *xi, int irq);
>=20
> In these prototypes, the 'irq' parameter refers to a number in the
> global IRQ number space.
>=20
> On the sPAPR platform, these operations are simply backed by a bitmap
> and to handle migration compatibility, we introduce a machine class
> flag 'has_irq_bitmap', which is set to false for older machines.

Talking with Greg, I have found a better solution to handle migration=20
compatibility which is to do like the phb_placement. That is to use=20
two sets of XICS IRQ operations : one for the latest pseries machine=20
using the bitmap and another one for the older pseries machine using=20
the ICSIRQState. It impacts mostly patch 5.

This solution is cleaner and I will send a v3 in my morning unless
you start reviewing and have some obvious comments in the v2 series.


Thanks,

C.=20


> To completely remove the use of the ICSState object (required to
> introduce XIVE), we also need to change how the nature of an
> interrupt, MSI or LSI, is stored. Today, this is done using the flag
> attribute of the ICSIRQState array. We change that by splitting the
> IRQ number space of the machine in two: first the LSIs and then the
> MSIs. This has the benefit to keep the LSI IRQ numbers in a well known
> range which is useful for PHB hotplug.
>=20
> The git repo for this pachset can be found here along with the latest
> XIVE model:
>=20
>     https://github.com/legoater/qemu/commits/xive
>=20
> Thanks,
>=20
> C.
>=20
> Tests :
>=20
>  - make check on each patch
>  - migration :
>      qemu-2.12 (pseries-2.12) <->  qemu-2.12 (pseries-2.12)
>      qemu-2.12 (pseries-2.10) <->  qemu-2.12 (pseries-2.10)
>      qemu-2.10 (pseries-2.10) <->  qemu-2.12 (pseries-2.10)
>=20
> Changes since v1 :
>=20
>  - reorganised patchset to introduce the XICSFabric operations before
>    the major changes: bitmap and IRQ number space split  =20
>  - introduced a reference bitmap to save some state in migration
>=20
> C=C3=A9dric Le Goater (12):
>   spapr: add pseries 2.12 machine type
>   ppc/xics: remove useless if condition
>   spapr: introduce new XICSFabric operations for an IRQ allocator
>   spapr: move current IRQ allocation under the machine
>   spapr: introduce an IRQ allocator using a bitmap
>   spapr: store a reference IRQ bitmap
>   spapr: introduce an 'irq_base' number
>   spapr: remove the use of ics_valid_irq()
>   spapr: introduce a XICSFabric is_lsi() operation
>   spapr: split the IRQ number space for LSI interrupts
>   sparp: merge ics_set_irq_type() in irq_alloc_block() operation
>   spapr: use sPAPRMachineState in spapr_ics_ prototypes
>=20
>  hw/intc/trace-events   |   2 -
>  hw/intc/xics.c         |  37 ++++++-----
>  hw/intc/xics_kvm.c     |   4 +-
>  hw/intc/xics_spapr.c   |  76 ++++-----------------
>  hw/ppc/pnv.c           |  34 ++++++++++
>  hw/ppc/pnv_psi.c       |   4 --
>  hw/ppc/spapr.c         | 174 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  hw/ppc/spapr_events.c  |   4 +-
>  hw/ppc/spapr_pci.c     |   8 +--
>  hw/ppc/spapr_vio.c     |   2 +-
>  hw/ppc/trace-events    |   2 +
>  include/hw/ppc/spapr.h |   6 ++
>  include/hw/ppc/xics.h  |  20 ++++--
>  13 files changed, 267 insertions(+), 106 deletions(-)
>=20
