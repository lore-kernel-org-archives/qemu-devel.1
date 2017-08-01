Received: from eggs.gnu.org ([2001:4830:134:3::10]:39837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSGw-0003D9-FO
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dcSGu-0008In-BF
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:22 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:44533
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dcSGu-0008I0-5C
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:11:20 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Tue,  1 Aug 2017 10:10:48 +0200
Message-Id: <1501575048-13485-3-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
References: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/2] xilinx-spips: add a migration
 blocker when using mmio_execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, alistair.francis@xilinx.com, dgilbert@redhat.com, quintela@redhat.com, frederic.konrad@adacore.com

This adds a migration blocker when mmio_execution has been used.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/ssi/xilinx_spips.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index e833028..d46491f 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -31,6 +31,8 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "hw/ssi/xilinx_spips.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
 
 #ifndef XILINX_SPIPS_ERR_DEBUG
 #define XILINX_SPIPS_ERR_DEBUG 0
@@ -139,6 +141,7 @@ typedef struct {
 
     uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
     hwaddr lqspi_cached_addr;
+    Error *migration_blocker;
 } XilinxQSPIPS;
 
 typedef struct XilinxSPIPSClass {
@@ -603,6 +606,14 @@ static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
     XilinxQSPIPS *q = opaque;
     hwaddr offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
 
+    /* mmio_execution breaks migration better aborting than having strange
+     * bugs.
+     */
+    if (!q->migration_blocker) {
+        error_setg(&q->migration_blocker, "booting from SPI breaks migration");
+        migrate_add_blocker(q->migration_blocker, &error_fatal);
+    }
+
     lqspi_load_cache(opaque, offset_within_the_region);
     *size = LQSPI_CACHE_SIZE;
     *offset = offset_within_the_region;
-- 
1.8.3.1
