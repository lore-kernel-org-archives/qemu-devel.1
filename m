Received: from eggs.gnu.org ([2001:4830:134:3::10]:58071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1k-0004B1-A5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1j-0007o0-Js
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1j-0007kt-Cf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1d-0002vL-JO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:35 +0100
Message-Id: <1507305585-20608-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
References: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/20] target/arm: Warn about restoring to
 unaligned stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Attempting to do an exception return with an exception frame that
is not 8-aligned is UNPREDICTABLE in v8M; warn about this.
(It is not UNPREDICTABLE in v7M, and our implementation can
handle the merely-4-aligned case fine, so we don't need to
do anything except warn.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1506092407-26985-8-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bee0f5d..bb57be7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6413,6 +6413,13 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
