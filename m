Received: from eggs.gnu.org ([209.51.188.92]:44424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWvu-0007k8-Ku
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWvt-0008HE-Je
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:04:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMWvt-0008D2-Ck
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:04:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so7566889wrp.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:04:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 May 2019 13:04:48 +0100
Message-Id: <20190503120448.13385-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] target/arm: Stop using variable length
 array in dc_zva
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Currently the dc_zva helper function uses a variable length
array. In fact we know (as the comment above remarks) that
the length of this array is bounded because the architecture
limits the block size and QEMU limits the target page size.
Use a fixed array size and assert that we don't run off it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * use ARRAY_SIZE() instead of sizeof()
 * add a comment to make it a bit clearer that the
   expected size of hostaddr[] is only 2 entries
---
 target/arm/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 81a92ab4911..10444d12b18 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "target/arm/idau.h"
 #include "trace.h"
 #include "cpu.h"
@@ -13099,14 +13100,17 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
          * We know that in fact for any v8 CPU the page size is at least 4K
          * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
          * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable.
+         * same QEMU executable. So in practice the hostaddr[] array has
+         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
          */
         int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[maxidx];
+        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
         int try, i;
         unsigned mmu_idx = cpu_mmu_index(env, false);
         TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
+        assert(maxidx <= ARRAY_SIZE(hostaddr));
+
         for (try = 0; try < 2; try++) {
 
             for (i = 0; i < maxidx; i++) {
-- 
2.20.1
