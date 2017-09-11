Received: from eggs.gnu.org ([2001:4830:134:3::10]:41804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP8F-0001pK-Lw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP8E-0002K4-Sv
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:52:08 +0100
Message-Id: <1505137930-13255-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/7] target/arm: Remove unnecessary '|
 0xf0000000' from do_v7m_exception_exit()
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

In do_v7m_exception_exit(), there's no need to force the high 4
bits of 'type' to 1 when calling v7m_exception_taken(), because
we know that they're always 1 or we could not have got to this
"handle return to magic exception return address" code. Remove
the unnecessary ORs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1741e0d..fdd5cc6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6306,7 +6306,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
          */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
-        v7m_exception_taken(cpu, type | 0xf0000000);
+        v7m_exception_taken(cpu, type);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
                       "stackframe: failed exception return integrity check\n");
         return;
@@ -6348,7 +6348,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         v7m_push_stack(cpu);
-        v7m_exception_taken(cpu, type | 0xf0000000);
+        v7m_exception_taken(cpu, type);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
                       "failed exception return integrity check\n");
         return;
-- 
2.7.4
