Received: from eggs.gnu.org ([2001:4830:134:3::10]:52843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvp-0005DC-P5
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduK-0006rY-Tv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduK-0006nb-AP
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduH-0007OE-5X
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:19:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:09 +0100
Message-Id: <20180814181815.23348-40-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/45] target/arm: Initialize exc_secure
 correctly in do_v7m_exception_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In do_v7m_exception_exit(), we use the exc_secure variable to track
whether the exception we're returning from is secure or non-secure.
Unfortunately the statement initializing this was accidentally
inside an "if (env->v7m.exception != ARMV7M_EXCP_NMI)" conditional,
which meant that we were using the wrong value for NMI handlers.
Move the initialization out to the right place.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180720145647.8810-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1b60c8d66c9..9d908f1c663 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7052,6 +7052,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             /* For all other purposes, treat ES as 0 (R_HXSR) */
             excret &= ~R_V7M_EXCRET_ES_MASK;
         }
+        exc_secure = excret & R_V7M_EXCRET_ES_MASK;
     }
 
     if (env->v7m.exception != ARMV7M_EXCP_NMI) {
@@ -7062,7 +7063,6 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          * which security state's faultmask to clear. (v8M ARM ARM R_KBNF.)
          */
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            exc_secure = excret & R_V7M_EXCRET_ES_MASK;
             if (armv7m_nvic_raw_execution_priority(env->nvic) >= 0) {
                 env->v7m.faultmask[exc_secure] = 0;
             }
-- 
2.18.0
