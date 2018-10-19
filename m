Received: from eggs.gnu.org ([2001:4830:134:3::10]:59413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFw-000508-VN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFl-0003ON-Ap
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFk-00035s-IE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:18 -0400
Message-Id: <20181019010625.25294-50-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 49/56] mips: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Soon we will call cpu_has_work without the BQL.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/cpu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e30aec6851..ea30c3c474 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
@@ -51,12 +52,14 @@ static void mips_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
     env->hflags |= tb->flags & MIPS_HFLAG_BMASK;
 }
 
-static bool mips_cpu_has_work(CPUState *cs)
+static bool mips_cpu_has_work_locked(CPUState *cs)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
     bool has_work = false;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /* Prior to MIPS Release 6 it is implementation dependent if non-enabled
        interrupts wake-up the CPU, however most of the implementations only
        check for interrupts that can be taken. */
@@ -92,6 +95,21 @@ static bool mips_cpu_has_work(CPUState *cs)
     return has_work;
 }
 
+static bool mips_cpu_has_work(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = mips_cpu_has_work_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return mips_cpu_has_work_locked(cs);
+}
+
 /* CPUClass::reset() */
 static void mips_cpu_reset(CPUState *s)
 {
-- 
2.17.1
