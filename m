Received: from eggs.gnu.org ([209.51.188.92]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggOnp-0003s5-HU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggOno-0008VT-II
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:54:25 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:46116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggOno-0008V9-C4
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:54:24 -0500
Received: from player787.ha.ovh.net (unknown [10.109.159.248])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 99D6A1EEF40
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 07:54:22 +0100 (CET)
References: <20190102055743.5052-1-clg@kaod.org>
	<20190107044815.GF13339@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <93414fb8-2100-53a3-2925-3c44bfcf829e@kaod.org>
Date: Mon, 7 Jan 2019 07:54:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190107044815.GF13339@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/10] spapr: introduce the 'dual'
 interrupt mode XICS/XIVE
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

On 1/7/19 5:48 AM, David Gibson wrote:
> On Wed, Jan 02, 2019 at 06:57:33AM +0100, C=E9dric Le Goater wrote:
>> Hello,
>>
>> This series adds a new sPAPR IRQ backend called 'dual' which supports
>> both interrupt mode, the XIVE native exploitation mode and the legacy
>> compatibility mode (XICS).
>>
>> The machine operates with the legacy mode by default and lets CAS
>> negotiate a new interrupt mode. If a new mode is selected, it is
>> activated after a machine reset to take into account the required
>> changes. These impact the device tree layout, the interrupt presenter
>> object and the exposed MMIO regions in the case of XIVE.
>>
>> The preliminary changes for this new IRQ backend are the introduction
>> of a second interrupt presenter object under the PowerPCCPU to support
>> XIVE. The qemu_irq array of each interrupt controller model is also
>> made common and moved under the machine.
>=20
> Ok, I've now applied all of this series to ppc-for-4.0.

Thanks,

We should pursue with KVM XIVE support now. Shall I send the Linux KVM =20
and the QEMU KVM patchsets in parallel ?

I still have some work to be done on the QEMU PowerNV before resending.

Thanks,

C.     =20

>=20
>>
>>
>> GitHub trees available here :
>> =20
>> QEMU sPAPR:
>>
>>   https://github.com/legoater/qemu/commits/xive-next
>>  =20
>> QEMU PowerNV:
>>
>>   https://github.com/legoater/qemu/commits/powernv-3.1
>>
>> Linux/KVM:
>>
>>   https://github.com/legoater/linux/commits/xive-4.20
>>
>> OPAL:
>>
>>   https://github.com/legoater/skiboot/commits/xive
>>
>> Best wishes for 2019 !=20
>>
>> C.
>>
>>
>>
>> C=E9dric Le Goater (10):
>>   spapr: modify the prototype of the cpu_intc_create() method
>>   ppc/xive: introduce a XiveTCTX pointer under PowerPCCPU
>>   ppc: replace the 'Object *intc' by a 'ICPState *icp' pointer under t=
he
>>     CPU
>>   spapr/xive: simplify the sPAPR IRQ qirq method for XIVE
>>   ppc: export the XICS and XIVE set_irq handlers
>>   pnv/psi: move the ICSState qemu_irq array under the PSI device model
>>   spapr: move the ICSState qemu_irq array under the machine
>>   ppc/xics: allow ICSState to have an offset 0
>>   spapr: introduce a new sPAPR IRQ backend supporting XIVE and XICS
>>   spapr: enable XIVE MMIOs at reset
>>
>>  include/hw/ppc/pnv.h        |   2 +-
>>  include/hw/ppc/pnv_psi.h    |   1 +
>>  include/hw/ppc/spapr.h      |   1 +
>>  include/hw/ppc/spapr_irq.h  |   6 +-
>>  include/hw/ppc/spapr_xive.h |   2 +-
>>  include/hw/ppc/xics.h       |   6 +-
>>  include/hw/ppc/xive.h       |   9 +-
>>  target/ppc/cpu.h            |   5 +-
>>  hw/intc/spapr_xive.c        |  23 ++-
>>  hw/intc/xics.c              |   4 +-
>>  hw/intc/xics_kvm.c          |   3 +-
>>  hw/intc/xics_spapr.c        |  10 +-
>>  hw/intc/xive.c              |  11 +-
>>  hw/ppc/pnv.c                |  27 ++--
>>  hw/ppc/pnv_core.c           |   4 +-
>>  hw/ppc/pnv_psi.c            |   7 +-
>>  hw/ppc/spapr.c              |  12 +-
>>  hw/ppc/spapr_cpu_core.c     |   9 +-
>>  hw/ppc/spapr_hcall.c        |  11 ++
>>  hw/ppc/spapr_irq.c          | 270 ++++++++++++++++++++++++++++++++++-=
-
>>  20 files changed, 342 insertions(+), 81 deletions(-)
>>
>=20
