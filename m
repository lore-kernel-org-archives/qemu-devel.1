Received: from eggs.gnu.org ([209.51.188.92]:53095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBU-00082j-8g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBG-0003zn-Qy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:24 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50158 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkCBG-0002T0-Ii
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:18 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 17 Jan 2019 19:12:59 +0100
Message-Id: <1547748785-14030-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 06/12] target/mips: Add field and R/W access to
 ITU control register ICR0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add field and R/W access to ITU control register ICR0.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/misc/mips_itu.c         | 22 +++++++++++++++++++++-
 include/hw/misc/mips_itu.h |  4 ++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 43bbec4..4801958 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -55,9 +55,17 @@ typedef enum ITCView {
     ITCVIEW_EF_SYNC = 2,
     ITCVIEW_EF_TRY  = 3,
     ITCVIEW_PV_SYNC = 4,
-    ITCVIEW_PV_TRY  = 5
+    ITCVIEW_PV_TRY  = 5,
+    ITCVIEW_PV_ICR0 = 15,
 } ITCView;
 
+#define ITC_ICR0_CELL_NUM        16
+#define ITC_ICR0_BLK_GRAIN       8
+#define ITC_ICR0_BLK_GRAIN_MASK  0x7
+#define ITC_ICR0_ERR_AXI         2
+#define ITC_ICR0_ERR_PARITY      1
+#define ITC_ICR0_ERR_EXEC        0
+
 MemoryRegion *mips_itu_get_tag_region(MIPSITUState *itu)
 {
     return &itu->tag_io;
@@ -382,6 +390,9 @@ static uint64_t itc_storage_read(void *opaque, hwaddr addr, unsigned size)
     case ITCVIEW_PV_TRY:
         ret = view_pv_try_read(cell);
         break;
+    case ITCVIEW_PV_ICR0:
+        ret = s->icr0;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "itc_storage_read: Bad ITC View %d\n", (int)view);
@@ -417,6 +428,15 @@ static void itc_storage_write(void *opaque, hwaddr addr, uint64_t data,
     case ITCVIEW_PV_TRY:
         view_pv_try_write(cell);
         break;
+    case ITCVIEW_PV_ICR0:
+        if (data & 0x7) {
+            /* clear ERROR bits */
+            s->icr0 &= ~(data & 0x7);
+        }
+        /* set BLK_GRAIN */
+        s->icr0 &= ~0x700;
+        s->icr0 |= data & 0x700;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "itc_storage_write: Bad ITC View %d\n", (int)view);
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 030eb4a..45a0c51 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -66,6 +66,10 @@ typedef struct MIPSITUState {
     /* ITC Configuration Tags */
     uint64_t ITCAddressMap[ITC_ADDRESSMAP_NUM];
     MemoryRegion tag_io;
+
+    /* ITU Control Register */
+    uint64_t icr0;
+
 } MIPSITUState;
 
 /* Get ITC Configuration Tag memory region. */
-- 
2.7.4
