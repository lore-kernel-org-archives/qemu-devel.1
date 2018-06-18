Received: from eggs.gnu.org ([2001:4830:134:3::10]:36739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy2h-00060n-WF
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy2f-0001e4-DZ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:16 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:39259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUy2f-0001cz-6r
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:13 -0400
Received: from player688.ha.ovh.net (unknown [10.109.122.124])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 861D7B4201
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 19:34:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 18 Jun 2018 19:33:59 +0200
Message-Id: <20180618173402.23405-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Here is a proposal for a new IRQ number space layout using static
numbers and a bitmap allocator for the MSIs. The previous layout is
kept for compatibly in machines raising the 'xics_legacy' flag.

These are just the basics preparing ground for the new XIVE
controller. I would also like to introduce a structure like below to
abstract the IRQ controller in the sPAPR machine :
 =20
  typedef struct sPAPRIrq {
      uint32_t    nr_irqs;
      uint8_t     ov5;
 =20
      void (*init)(sPAPRMachineState *spapr, uint32_t nr_servers, Error *=
*errp);
      int (*claim)(sPAPRMachineState *spapr, uint32_t irq, bool lsi, Erro=
r **errp);
      void (*free)(sPAPRMachineState *spapr, int irq, int num, Error **er=
rp);
      qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
      void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                          void *fdt, uint32_t phandle);
      Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                                 Error **errp);
      void (*post_load)(sPAPRMachineState *spapr);
  } sPAPRIrq;

Thanks,

C.

Changes since v1 :

 - removed block allocation
 - spaced the IRQ offsets=20
 - check for overlaps when allocating VIO irqs
 - removed 'Error *' arg from spapr_irq_msi_init()=20

C=C3=A9dric Le Goater (3):
  spapr: split the IRQ allocation sequence
  spapr: remove unused spapr_irq routines
  spapr: introduce a fixed IRQ number space

 include/hw/ppc/spapr.h     |  12 ++++--
 include/hw/ppc/spapr_irq.h |  30 ++++++++++++++
 hw/ppc/spapr.c             | 101 +++++++++++++++++++++++----------------=
------
 hw/ppc/spapr_events.c      |  26 ++++++++++--
 hw/ppc/spapr_irq.c         |  56 +++++++++++++++++++++++++
 hw/ppc/spapr_pci.c         |  39 +++++++++++++++--
 hw/ppc/spapr_vio.c         |  21 +++++++++-
 hw/ppc/Makefile.objs       |   2 +-
 8 files changed, 225 insertions(+), 62 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

--=20
2.13.6
