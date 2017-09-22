Received: from eggs.gnu.org ([2001:4830:134:3::10]:47049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQa-0007yg-Je
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dvPQZ-00048J-Hv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:59:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:59:54 +0100
Message-Id: <1506092407-26985-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/20] target/arm: Warn about restoring to
 unaligned stack
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

Attempting to do an exception return with an exception frame that
is not 8-aligned is UNPREDICTABLE in v8M; warn about this.
(It is not UNPREDICTABLE in v7M, and our implementation can
handle the merely-4-aligned case fine, so we don't need to
do anything except warn.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a2e46fb..979129e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6403,6 +6403,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                                               return_to_sp_process);
         uint32_t frameptr = *frame_sp_p;
 
+        if (!QEMU_IS_ALIGNED(frameptr, 8) &&
+            arm_feature(env, ARM_FEATURE_V8)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M profile exception return with non-8-aligned SP "
+                          "for destination state is UNPREDICTABLE\n");
+        }
+
         /* Pop registers. TODO: make these accesses use the correct
          * attributes and address space (S/NS, priv/unpriv) and handle
          * memory transaction failures.
-- 
2.7.4
