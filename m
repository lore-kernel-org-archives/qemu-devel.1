Received: from eggs.gnu.org ([2001:4830:134:3::10]:56927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDT-0007v2-2G
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDR-0000jL-2H
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDQ-0000er-SF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDM-0007cc-EO
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:20 +0100
Message-Id: <20180410121724.8549-9-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/12] target/arm: Report unsupported MPU region
 sizes more clearly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently our PMSAv7 and ARMv7M MPU implementation cannot handle
MPU region sizes smaller than our TARGET_PAGE_SIZE. However we
report that in a slightly confusing way:

 DRSR[3]: No support for MPU (sub)region alignment of 9 bits. Minimum is 10

The problem is not the alignment of the region, but its size;
tweak the error message to say so:
 DRSR[3]: No support for MPU (sub)region size of 512 bytes. Minimum is 1024.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180405172554.27401-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dcb8476d9e..b14fdab140 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9625,9 +9625,9 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
             }
             if (rsize < TARGET_PAGE_BITS) {
                 qemu_log_mask(LOG_UNIMP,
-                              "DRSR[%d]: No support for MPU (sub)region "
-                              "alignment of %" PRIu32 " bits. Minimum is %d\n",
-                              n, rsize, TARGET_PAGE_BITS);
+                              "DRSR[%d]: No support for MPU (sub)region size of"
+                              " %" PRIu32 " bytes. Minimum is %d.\n",
+                              n, (1 << rsize), TARGET_PAGE_SIZE);
                 continue;
             }
             if (srdis) {
-- 
2.16.2
