Received: from eggs.gnu.org ([2001:4830:134:3::10]:46132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmZ-0001Ak-EX
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008HO-QU
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008G1-K0
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:50 -0400
Message-Id: <1500235468-15341-8-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 07/45] cpu-exec: rename have_tb_lock to
 acquired_tb_lock in tb_find
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Reusing the have_tb_lock name, which is also defined in translate-all.c,
makes code reviewing unnecessarily harder.

Avoid potential confusion by renaming the local have_tb_lock variable
to something else.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d84b01d..c4c289b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -337,7 +337,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
-    bool have_tb_lock = false;
+    bool acquired_tb_lock = false;
 
     /* we record a subset of the CPU state. It will
        always be the same before a given translated block
@@ -356,7 +356,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
              */
             mmap_lock();
             tb_lock();
-            have_tb_lock = true;
+            acquired_tb_lock = true;
 
             /* There's a chance that our desired tb has been translated while
              * taking the locks so we check again inside the lock.
@@ -384,15 +384,15 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
 #endif
     /* See if we can patch the calling TB. */
     if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        if (!have_tb_lock) {
+        if (!acquired_tb_lock) {
             tb_lock();
-            have_tb_lock = true;
+            acquired_tb_lock = true;
         }
         if (!tb->invalid) {
             tb_add_jump(last_tb, tb_exit, tb);
         }
     }
-    if (have_tb_lock) {
+    if (acquired_tb_lock) {
         tb_unlock();
     }
     return tb;
-- 
2.7.4
