Received: from eggs.gnu.org ([2001:4830:134:3::10]:52206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd42-0007Sp-GQ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-000084-N7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd41-0008UD-BN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3o-0005b5-Gi
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:24 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:37:57 +0000
Message-Id: <1515677902-23436-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/26] linux-user: Add support for big-endian
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Weiser <michael.weiser@gmx.de>

Enable big-endian mode for data accesses on aarch64 for big-endian linux
user mode. Activate it for all exception levels as documented by ARM:
Set the SCTLR EE bit for ELs 1 through 3. Additionally set bit E0E in
EL1 to enable it in EL0 as well.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20171220212308.12614-2-michael.weiser@gmx.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 99a551b..450eb3c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4629,6 +4629,12 @@ int main(int argc, char **argv, char **envp)
         }
         env->pc = regs->pc;
         env->xregs[31] = regs->sp;
+#ifdef TARGET_WORDS_BIGENDIAN
+        env->cp15.sctlr_el[1] |= SCTLR_E0E;
+        for (i = 1; i < 4; ++i) {
+            env->cp15.sctlr_el[i] |= SCTLR_EE;
+        }
+#endif
     }
 #elif defined(TARGET_ARM)
     {
-- 
2.7.4
