Received: from eggs.gnu.org ([2001:4830:134:3::10]:43244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgx-0003MF-9i
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgw-0006NK-4P
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:50 +0100
Message-Id: <1505240046-11454-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/19] nvic: Add cached vectpending_is_s_banked
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

With banked exceptions, just the exception number in
s->vectpending is no longer sufficient to uniquely identify
the pending exception. Add a vectpending_is_s_banked bool
which is true if the exception is using the sec_vectors[]
array.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 11 +++++++++--
 hw/intc/armv7m_nvic.c         |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 317601e..87c78b3 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -57,10 +57,17 @@ typedef struct NVICState {
     VecInfo sec_vectors[NVIC_INTERNAL_VECTORS];
     uint32_t prigroup;
 
-    /* vectpending and exception_prio are both cached state that can
-     * be recalculated from the vectors[] array and the prigroup field.
+    /* The following fields are all cached state that can be recalculated
+     * from the vectors[] and sec_vectors[] arrays and the prigroup field:
+     *  - vectpending
+     *  - vectpending_is_secure
+     *  - exception_prio
      */
     unsigned int vectpending; /* highest prio pending enabled exception */
+    /* true if vectpending is a banked secure exception, ie it is in
+     * sec_vectors[] rather than vectors[]
+     */
+    bool vectpending_is_s_banked;
     int exception_prio; /* group prio of the highest prio active exception */
 
     MemoryRegion sysregmem;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 694b9e0..417a456 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1250,6 +1250,7 @@ static void armv7m_nvic_reset(DeviceState *dev)
 
     s->exception_prio = NVIC_NOEXC_PRIO;
     s->vectpending = 0;
+    s->vectpending_is_s_banked = false;
 }
 
 static void nvic_systick_trigger(void *opaque, int n, int level)
-- 
2.7.4
