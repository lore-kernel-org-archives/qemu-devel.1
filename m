Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcs-0002Uo-6g
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcq-0007qy-N2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:01:15 +1000
Message-Id: <20170510070115.13063-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/22] pnv: Fix build failures on some host
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

This makes some changes to fix build failures on the 'min-glib' docker
image, and maybe other platforms with a buildchain that's less tolerant
about duplicated typedefs.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv.h     | 3 +--
 include/hw/ppc/pnv_lpc.h | 4 ++--
 include/hw/ppc/pnv_occ.h | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c1288f9..9c5437d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -21,6 +21,7 @@
 
 #include "hw/boards.h"
 #include "hw/sysbus.h"
+#include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
@@ -118,8 +119,6 @@ typedef struct PnvChipClass {
 #define POWERNV_MACHINE(obj) \
     OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)
 
-typedef struct IPMIBmc IPMIBmc;
-
 typedef struct PnvMachineState {
     /*< private >*/
     MachineState parent_obj;
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index ccf969a..023b4f0 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -19,12 +19,12 @@
 #ifndef _PPC_PNV_LPC_H
 #define _PPC_PNV_LPC_H
 
+#include "hw/ppc/pnv_psi.h"
+
 #define TYPE_PNV_LPC "pnv-lpc"
 #define PNV_LPC(obj) \
      OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV_LPC)
 
-typedef struct PnvPsi PnvPsi;
-
 typedef struct PnvLpcController {
     DeviceState parent;
 
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index f8ec330..82f299d 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -19,11 +19,11 @@
 #ifndef _PPC_PNV_OCC_H
 #define _PPC_PNV_OCC_H
 
+#include "hw/ppc/pnv_psi.h"
+
 #define TYPE_PNV_OCC "pnv-occ"
 #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
 
-typedef struct PnvPsi PnvPsi;
-
 typedef struct PnvOCC {
     DeviceState xd;
 
-- 
2.9.3
