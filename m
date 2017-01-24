Received: from eggs.gnu.org ([2001:4830:134:3::10]:44895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6qx-000886-9G
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6qw-0006us-Ic
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:34:03 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:16 +0000
Message-Id: <1485285380-10565-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/10] armv7m: set CFSR.UNDEFINSTR on undefined
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Liviu Ionescu <ilg@livius.net>

From: Michael Davidsaver <mdavidsaver@gmail.com>

When we take an exception for an undefined instruction, set the
appropriate CFSR bit.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
[PMM: tweaked commit message, comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7dc30f5..e6b1c36 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6072,6 +6072,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     switch (cs->exception_index) {
     case EXCP_UDEF:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
+        env->v7m.cfsr |= R_V7M_CFSR_UNDEFINSTR_MASK;
         return;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
-- 
2.7.4
