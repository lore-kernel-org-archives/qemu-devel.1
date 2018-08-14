Received: from eggs.gnu.org ([2001:4830:134:3::10]:52431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdv1-0004YY-NC
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtn-0006aJ-Ft
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtm-0006ZX-Sg
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtl-0007BQ-HE
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:40 +0100
Message-Id: <20180814181815.23348-11-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/45] target/arm: Allow execution from small
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that we have full support for small regions, including execution,
we can remove the workarounds where we marked all small regions as
non-executable for the M-profile MPU and SAU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180710160013.26559-7-peter.maydell@linaro.org
---
 target/arm/helper.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 63a70065617..02c1c4d8404 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9795,17 +9795,6 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
-    /*
-     * Core QEMU code can't handle execution from small pages yet, so
-     * don't try it. This way we'll get an MPU exception, rather than
-     * eventually causing QEMU to exit in get_page_addr_code().
-     */
-    if (*page_size < TARGET_PAGE_SIZE && (*prot & PAGE_EXEC)) {
-        qemu_log_mask(LOG_UNIMP,
-                      "MPU: No support for execution from regions "
-                      "smaller than 1K\n");
-        *prot &= ~PAGE_EXEC;
-    }
     return !(*prot & (1 << access_type));
 }
 
@@ -10056,18 +10045,6 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
-    /*
-     * Core QEMU code can't handle execution from small pages yet, so
-     * don't try it. This means any attempted execution will generate
-     * an MPU exception, rather than eventually causing QEMU to exit in
-     * get_page_addr_code().
-     */
-    if (*is_subpage && (*prot & PAGE_EXEC)) {
-        qemu_log_mask(LOG_UNIMP,
-                      "MPU: No support for execution from regions "
-                      "smaller than 1K\n");
-        *prot &= ~PAGE_EXEC;
-    }
     return !(*prot & (1 << access_type));
 }
 
-- 
2.18.0
