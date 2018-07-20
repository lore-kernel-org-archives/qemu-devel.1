Received: from eggs.gnu.org ([2001:4830:134:3::10]:48702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fgWq5-0000UI-S3
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fgWq4-00062n-RW
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:57:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 15:56:46 +0100
Message-Id: <20180720145647.8810-4-peter.maydell@linaro.org>
In-Reply-To: <20180720145647.8810-1-peter.maydell@linaro.org>
References: <20180720145647.8810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] target/arm: Restore M-profile
 CONTROL.SPSEL before any tailchaining
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

On exception return for M-profile, we must restore the CONTROL.SPSEL
bit from the EXCRET value before we do any kind of tailchaining,
including for the derived exceptions on integrity check failures.
Otherwise we will give the guest an incorrect EXCRET.SPSEL value on
exception entry for the tailchained exception.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index efcadfc7fa9..ff947416c9d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7131,6 +7131,16 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         }
     }
 
+    /*
+     * Set CONTROL.SPSEL from excret.SPSEL. Since we're still in
+     * Handler mode (and will be until we write the new XPSR.Interrupt
+     * field) this does not switch around the current stack pointer.
+     * We must do this before we do any kind of tailchaining, including
+     * for the derived exceptions on integrity check failures, or we will
+     * give the guest an incorrect EXCRET.SPSEL value on exception entry.
+     */
+    write_v7m_control_spsel_for_secstate(env, return_to_sp_process, exc_secure);
+
     if (sfault) {
         env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
@@ -7152,12 +7162,6 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
 
-    /* Set CONTROL.SPSEL from excret.SPSEL. Since we're still in
-     * Handler mode (and will be until we write the new XPSR.Interrupt
-     * field) this does not switch around the current stack pointer.
-     */
-    write_v7m_control_spsel_for_secstate(env, return_to_sp_process, exc_secure);
-
     switch_v7m_security_state(env, return_to_secure);
 
     {
-- 
2.17.1
