Received: from eggs.gnu.org ([2001:4830:134:3::10]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePAGl-0002OE-2n
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePAGj-0004OM-VY
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:52:31 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 16:52:20 +0000
Message-Id: <1513183941-24300-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/intc/arm_gicv3: Make reserved register
 addresses RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

The GICv3 specification says that reserved register addresses
should RAZ/WI. This means we need to return MEMTX_OK, not MEMTX_ERROR,
because now that we support generating external aborts the
latter will cause an abort on new board models.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
