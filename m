Received: from eggs.gnu.org ([2001:4830:134:3::10]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVIMp-0006xZ-CZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVIMl-0000S3-9t
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:16:23 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:56560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVIMl-0000RU-2Y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:16:19 -0400
Received: from player714.ha.ovh.net (unknown [10.109.108.117])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 38ACC1BE40A
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 17:16:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Jun 2018 17:16:00 +0200
Message-Id: <20180619151600.22985-1-clg@kaod.org>
In-Reply-To: <20180619140729.21949-1-clg@kaod.org>
References: <20180619140729.21949-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/3 bonus] spapr: remove the XICS header
 from the machine and device models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XICS routines are now completely hidden behind the sPAPR IRQ
interface. There is no need to include the header files anymore.

The only remaining direct use of XICS is done by the sPAPR cores which
need to create the IRQ presenter. This part will be removed when the
XIVE backend is introduced.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     | 2 +-
 include/hw/ppc/spapr_irq.h | 2 ++
 hw/ppc/spapr.c             | 1 -
 hw/ppc/spapr_cpu_core.c    | 1 +
 hw/ppc/spapr_vio.c         | 1 -
 5 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index acc2c01e1123..190d7f04d8d0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -3,7 +3,6 @@
=20
 #include "sysemu/dma.h"
 #include "hw/boards.h"
-#include "hw/ppc/xics.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
@@ -15,6 +14,7 @@ struct sPAPRNVRAM;
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 typedef struct sPAPRPendingHPT sPAPRPendingHPT;
+typedef struct ICSState ICSState;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index f02544934c93..0c2ea54ba0a0 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -21,6 +21,8 @@
 #define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range cove=
red
                                       * by the bitmap allocator */
=20
+typedef struct sPAPRMachineState sPAPRMachineState;
+
 void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis);
 int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool ali=
gn,
                         Error **errp);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fb3ba90eaefa..73f7342edb82 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -54,7 +54,6 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/pci-host/spapr.h"
-#include "hw/ppc/xics.h"
 #include "hw/pci/msi.h"
=20
 #include "hw/pci/pci.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 56fe403fc540..aedb15dd2083 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -11,6 +11,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/xics.h" /* for icp_create() - to be removed */
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 2ecee3e8d0ed..b8a80bcc91ca 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -37,7 +37,6 @@
=20
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
-#include "hw/ppc/xics.h"
 #include "hw/ppc/fdt.h"
 #include "trace.h"
=20
--=20
2.13.6
