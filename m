Received: from eggs.gnu.org ([2001:4830:134:3::10]:41683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP85-0001f9-R9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP85-0002Cc-05
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:52:06 +0100
Message-Id: <1505137930-13255-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/7] target/arm: Get PRECISERR and IBUSERR the
 right way round
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

For a bus fault, the M profile BFSR bit PRECISERR means a bus
fault on a data access, and IBUSERR means a bus fault on an
instruction access. We had these the wrong way around; fix this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 668e367..1741e0d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6430,15 +6430,15 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         case 0x8: /* External Abort */
             switch (cs->exception_index) {
             case EXCP_PREFETCH_ABORT:
-                env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_PRECISERR_MASK;
-                qemu_log_mask(CPU_LOG_INT, "...with CFSR.PRECISERR\n");
+                env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_IBUSERR_MASK;
+                qemu_log_mask(CPU_LOG_INT, "...with CFSR.IBUSERR\n");
                 break;
             case EXCP_DATA_ABORT:
                 env->v7m.cfsr[M_REG_NS] |=
-                    (R_V7M_CFSR_IBUSERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
+                    (R_V7M_CFSR_PRECISERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
                 env->v7m.bfar = env->exception.vaddress;
                 qemu_log_mask(CPU_LOG_INT,
-                              "...with CFSR.IBUSERR and BFAR 0x%x\n",
+                              "...with CFSR.PRECISERR and BFAR 0x%x\n",
                               env->v7m.bfar);
                 break;
             }
-- 
2.7.4
