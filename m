Received: from eggs.gnu.org ([2001:4830:134:3::10]:34279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCSLX-0000PI-Ku
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCSLR-00026U-F4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:32:55 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eCSLR-00025i-70
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:32:49 -0500
Received: by mail-wm0-x244.google.com with SMTP id r68so11663995wmr.3
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 07:32:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  8 Nov 2017 15:32:44 +0000
Message-Id: <20171108153245.20740-2-alex.bennee@linaro.org>
In-Reply-To: <20171108153245.20740-1-alex.bennee@linaro.org>
References: <20171108153245.20740-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] accel/tcg/translate-all: expand
 cpu_restore_state addr check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

We are still seeing signals during translation time when we walk over
a page protection boundary. This expands the check to ensure the host
PC is inside the code generation buffer. The original suggestion was
to check versus tcg_ctx.code_gen_ptr but as we now segment the
translation buffer we have to settle for just a general check for
being inside.

I've also fixed up the declaration to make it clear it can deal with
invalid addresses. A later patch will fix up the call sites.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>

---
v2:
  - add doc comment to exec-all.h
  - retaddr->host_pc
  - re-word comments on host_pc
  - simplify logic as per rth suggestion
---
 accel/tcg/translate-all.c | 52 ++++++++++++++++++++++++++---------------------
 include/exec/exec-all.h   | 11 ++++++++++
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 34c5e28d07..e7f0329a52 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -352,36 +352,42 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     return 0;
 }
 
-bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
 {
     TranslationBlock *tb;
     bool r = false;
+    uintptr_t check_offset;
 
-    /* A retaddr of zero is invalid so we really shouldn't have ended
-     * up here. The target code has likely forgotten to check retaddr
-     * != 0 before attempting to restore state. We return early to
-     * avoid blowing up on a recursive tb_lock(). The target must have
-     * previously survived a failed cpu_restore_state because
-     * tb_find_pc(0) would have failed anyway. It still should be
-     * fixed though.
+    /* The host_pc has to be in the region of current code buffer. If
+     * it is not we will not be able to resolve it here. The two cases
+     * where host_pc will not be correct are:
+     *
+     *  - fault during translation (instruction fetch)
+     *  - fault from helper (not using GETPC() macro)
+     *
+     * Either way we need return early to avoid blowing up on a
+     * recursive tb_lock() as we can't resolve it here.
+     *
+     * We are using unsigned arithmetic so if host_pc <
+     * tcg_init_ctx.code_gen_buffer check_offset will wrap to way
+     * above the code_gen_buffer_size
      */
-
-    if (!retaddr) {
-        return r;
-    }
-
-    tb_lock();
-    tb = tb_find_pc(retaddr);
-    if (tb) {
-        cpu_restore_state_from_tb(cpu, tb, retaddr);
-        if (tb->cflags & CF_NOCACHE) {
-            /* one-shot translation, invalidate it immediately */
-            tb_phys_invalidate(tb, -1);
-            tb_remove(tb);
+    check_offset = host_pc - (uintptr_t) tcg_init_ctx.code_gen_buffer;
+
+    if (check_offset < tcg_init_ctx.code_gen_buffer_size) {
+        tb_lock();
+        tb = tb_find_pc(host_pc);
+        if (tb) {
+            cpu_restore_state_from_tb(cpu, tb, host_pc);
+            if (tb->cflags & CF_NOCACHE) {
+                /* one-shot translation, invalidate it immediately */
+                tb_phys_invalidate(tb, -1);
+                tb_remove(tb);
+            }
+            r = true;
         }
-        r = true;
+        tb_unlock();
     }
-    tb_unlock();
 
     return r;
 }
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 923ece3e9b..0f51c92adb 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -45,6 +45,17 @@ void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb,
                           target_ulong *data);
 
 void cpu_gen_init(void);
+
+/**
+ * cpu_restore_state:
+ * @cpu: the vCPU state is to be restore to
+ * @searched_pc: the host PC the fault occurred at
+ * @return: true if state was restored, false otherwise
+ *
+ * Attempt to restore the state for a fault occurring in translated
+ * code. If the searched_pc is not in translated code no state is
+ * restored and the function returns false.
+ */
 bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc);
 
 void QEMU_NORETURN cpu_loop_exit_noexc(CPUState *cpu);
-- 
2.14.2
