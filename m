Received: from eggs.gnu.org ([2001:4830:134:3::10]:43631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iZ-000578-Ox
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iW-0007py-7N
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iV-0007pN-SQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJHs092819
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:42 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf63hetk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:42 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:41 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:32 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-12-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 11/54] hw/intc/arm_gicv3: Make reserved
 register addresses RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The GICv3 specification says that reserved register addresses
should RAZ/WI. This means we need to return MEMTX_OK, not MEMTX_ERROR,
because now that we support generating external aborts the
latter will cause an abort on new board models.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1513183941-24300-2-git-send-email-peter.maydell@linaro.org
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
(cherry picked from commit f1945632b43e36bd9f3e0c2feb0e5b152be7ed91)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gicv3_dist.c       | 13 +++++++++++++
 hw/intc/arm_gicv3_its_common.c |  8 +++-----
 hw/intc/arm_gicv3_redist.c     | 13 +++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 3ea3dd0d40..93fe936862 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -817,6 +817,13 @@ MemTxResult gicv3_dist_read(void *opaque, hwaddr offset, uint64_t *data,
                       "%s: invalid guest read at offset " TARGET_FMT_plx
                       "size %u\n", __func__, offset, size);
         trace_gicv3_dist_badread(offset, size, attrs.secure);
+        /* The spec requires that reserved registers are RAZ/WI;
+         * so use MEMTX_ERROR returns from leaf functions as a way to
+         * trigger the guest-error logging but don't return it to
+         * the caller, or we'll cause a spurious guest data abort.
+         */
+        r = MEMTX_OK;
+        *data = 0;
     } else {
         trace_gicv3_dist_read(offset, *data, size, attrs.secure);
     }
@@ -852,6 +859,12 @@ MemTxResult gicv3_dist_write(void *opaque, hwaddr offset, uint64_t data,
                       "%s: invalid guest write at offset " TARGET_FMT_plx
                       "size %u\n", __func__, offset, size);
         trace_gicv3_dist_badwrite(offset, data, size, attrs.secure);
+        /* The spec requires that reserved registers are RAZ/WI;
+         * so use MEMTX_ERROR returns from leaf functions as a way to
+         * trigger the guest-error logging but don't return it to
+         * the caller, or we'll cause a spurious guest data abort.
+         */
+        r = MEMTX_OK;
     } else {
         trace_gicv3_dist_write(offset, data, size, attrs.secure);
     }
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index f2cce597a9..48a85524b7 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -67,7 +67,8 @@ static MemTxResult gicv3_its_trans_read(void *opaque, hwaddr offset,
                                         MemTxAttrs attrs)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "ITS read at offset 0x%"PRIx64"\n", offset);
-    return MEMTX_ERROR;
+    *data = 0;
+    return MEMTX_OK;
 }
 
 static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
@@ -82,15 +83,12 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
         if (ret <= 0) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ITS: Error sending MSI: %s\n", strerror(-ret));
-            return MEMTX_DECODE_ERROR;
         }
-
-        return MEMTX_OK;
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "ITS write at bad offset 0x%"PRIx64"\n", offset);
-        return MEMTX_DECODE_ERROR;
     }
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps gicv3_its_trans_ops = {
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 77e5cfa327..8a8684d76e 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -455,6 +455,13 @@ MemTxResult gicv3_redist_read(void *opaque, hwaddr offset, uint64_t *data,
                       "size %u\n", __func__, offset, size);
         trace_gicv3_redist_badread(gicv3_redist_affid(cs), offset,
                                    size, attrs.secure);
+        /* The spec requires that reserved registers are RAZ/WI;
+         * so use MEMTX_ERROR returns from leaf functions as a way to
+         * trigger the guest-error logging but don't return it to
+         * the caller, or we'll cause a spurious guest data abort.
+         */
+        r = MEMTX_OK;
+        *data = 0;
     } else {
         trace_gicv3_redist_read(gicv3_redist_affid(cs), offset, *data,
                                 size, attrs.secure);
@@ -505,6 +512,12 @@ MemTxResult gicv3_redist_write(void *opaque, hwaddr offset, uint64_t data,
                       "size %u\n", __func__, offset, size);
         trace_gicv3_redist_badwrite(gicv3_redist_affid(cs), offset, data,
                                     size, attrs.secure);
+        /* The spec requires that reserved registers are RAZ/WI;
+         * so use MEMTX_ERROR returns from leaf functions as a way to
+         * trigger the guest-error logging but don't return it to
+         * the caller, or we'll cause a spurious guest data abort.
+         */
+        r = MEMTX_OK;
     } else {
         trace_gicv3_redist_write(gicv3_redist_affid(cs), offset, data,
                                  size, attrs.secure);
-- 
2.11.0
