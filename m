Received: from eggs.gnu.org ([2001:4830:134:3::10]:52400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd4A-0007ab-Bo
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd49-0000HY-55
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd48-0000Fq-Ss
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd47-0005mK-Ra
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:21 +0000
Message-Id: <1515677902-23436-26-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/26] hw/intc/arm_gicv3: Make reserved register
 addresses RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The GICv3 specification says that reserved register addresses
should RAZ/WI. This means we need to return MEMTX_OK, not MEMTX_ERROR,
because now that we support generating external aborts the
latter will cause an abort on new board models.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1513183941-24300-2-git-send-email-peter.maydell@linaro.org
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/intc/arm_gicv3_dist.c       | 13 +++++++++++++
 hw/intc/arm_gicv3_its_common.c |  8 +++-----
 hw/intc/arm_gicv3_redist.c     | 13 +++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 3ea3dd0..93fe936 100644
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
index 2bd2f0f..284c0a7 100644
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
index 77e5cfa..8a8684d 100644
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
2.7.4
