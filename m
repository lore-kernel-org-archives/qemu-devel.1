Received: from eggs.gnu.org ([2001:4830:134:3::10]:57371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcvRf-0005LJ-G1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcvRe-0006YN-MW
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:24:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 17:00:13 +0100
Message-Id: <20180710160013.26559-7-peter.maydell@linaro.org>
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] target/arm: Allow execution from small
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

Now that we have full support for small regions, including execution,
we can remove the workarounds where we marked all small regions as
non-executable for the M-profile MPU and SAU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a2ac96084e7..ed96e6c02fb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9784,17 +9784,6 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
 
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
 
@@ -10014,18 +10003,6 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
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
2.17.1
