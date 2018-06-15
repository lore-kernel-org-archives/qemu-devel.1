Received: from eggs.gnu.org ([2001:4830:134:3::10]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTnId-0007sK-V4
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTnIa-0000je-St
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:53:52 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:46910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTnIa-0000hB-Lm
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:53:48 -0400
Received: from player734.ha.ovh.net (unknown [10.109.105.20])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 14C221BDA6C
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:53:39 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Jun 2018 13:53:00 +0200
Message-Id: <20180615115303.31125-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] introduce a fixed IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a proposal for a new IRQ number space layout using static
numbers and a bitmap allocator for the MSIs. The previous layout is
kept for compatibly in machines raising the 'xics_legacy' flag.

These are just the basics preparing ground for the new XIVE
controller. I would also like to introduce a structure like below to
abstract the IRQ controller in the sPAPR machine :


typedef struct sPAPRIrq {
    uint32_t    nr_irqs;
    uint8_t     ov5;

    void (*init)(sPAPRMachineState *spapr, uint32_t nr_servers, Error **e=
rrp);
    int (*claim)(sPAPRMachineState *spapr, uint32_t range, uint32_t irq,
                  Error **errp);
    void (*free)(sPAPRMachineState *spapr, int irq, int num, Error **errp=
);
    qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
    void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                        void *fdt, uint32_t phandle);
    Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                               Error **errp);
    void (*post_load)(sPAPRMachineState *spapr);
} sPAPRIrq;


Let's discuss !

Cheers,

C.

C=C3=A9dric Le Goater (3):
  spapr: split the IRQ allocation sequence
  spapr: remove unused spapr_irq routines
  spapr: introduce a fixed IRQ number space

 include/hw/ppc/spapr.h     |  11 +++--
 include/hw/ppc/spapr_irq.h |  30 ++++++++++++
 hw/ppc/spapr.c             | 115 ++++++++++++++++++++++++++-------------=
------
 hw/ppc/spapr_events.c      |  26 ++++++++--
 hw/ppc/spapr_irq.c         |  57 ++++++++++++++++++++++
 hw/ppc/spapr_pci.c         |  35 ++++++++++++--
 hw/ppc/spapr_vio.c         |  17 ++++++-
 hw/ppc/Makefile.objs       |   2 +-
 8 files changed, 232 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

--=20
2.13.6
