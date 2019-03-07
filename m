Received: from eggs.gnu.org ([209.51.188.92]:44021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvq-00045v-Uw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvp-0007VN-Rd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvo-0007UJ-I1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:52 +0100
Message-Id: <20190307100656.14044-6-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/9] Fix breakpoint support in Nios II user-mode
 emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Sandra Loosemore <sandra@codesourcery.com>, Peter Maydell <peter.maydell@linaro.org>

From: Sandra Loosemore <sandra@codesourcery.com>

Nios II user-mode emulation was missing handling for EXCP_DEBUG,
making the gdb stub essentially useless.  This patch adds the missing
piece.  The new code was copied from the existing EXCP_TRAP handling
and is also similar to what other targets (e.g., arm) do with EXCP_DEBUG.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1550076626-7202-1-git-send-email-sandra@codesourcery.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/nios2/cpu_loop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index b96b1aa1195a..5aa1eca740de 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -73,6 +73,12 @@ void cpu_loop(CPUNios2State *env)
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                 break;
             }
+        case EXCP_DEBUG:
+            info.si_signo = TARGET_SIGTRAP;
+            info.si_errno = 0;
+            info.si_code = TARGET_TRAP_BRKPT;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case 0xaa:
             switch (env->regs[R_PC]) {
             /*case 0x1000:*/  /* TODO:__kuser_helper_version */
-- 
2.20.1
