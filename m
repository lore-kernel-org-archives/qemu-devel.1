Received: from eggs.gnu.org ([2001:4830:134:3::10]:44403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f1E7J-0000cf-02
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f1E7I-0000hr-2D
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:40:05 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f1E7H-0000h1-QA
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:40:03 -0400
Received: by mail-lf0-x241.google.com with SMTP id c78-v6so4443978lfh.1
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:40:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Mar 2018 09:39:43 -0700
Message-Id: <20180328163943.23783-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix flush_window_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

flush_window_regs uses wrong stack frame to save overflow registers in
call8 and call12 frames, which results in wrong register values in
callers of a function that received a signal.
Reimplement flush_window_regs closely following window overflow
sequence.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/signal.c | 55 +++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ea3e0321f4d..33d5ced30c98 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -7094,52 +7094,45 @@ static abi_ulong get_sigframe(struct target_sigaction *sa,
 
 static int flush_window_regs(CPUXtensaState *env)
 {
-    const uint32_t nareg_mask = env->config->nareg - 1;
     uint32_t wb = env->sregs[WINDOW_BASE];
-    uint32_t ws = (xtensa_replicate_windowstart(env) >> (wb + 1)) &
-        ((1 << env->config->nareg / 4) - 1);
-    uint32_t d = ctz32(ws) + 1;
-    uint32_t sp;
-    abi_long ret = 0;
-
-    wb += d;
-    ws >>= d;
+    uint32_t ws = xtensa_replicate_windowstart(env) >> (wb + 1);
+    unsigned d = ctz32(ws) + 1;
+    unsigned i;
+    int ret = 0;
 
-    xtensa_sync_phys_from_window(env);
-    sp = env->phys_regs[(wb * 4 + 1) & nareg_mask];
+    for (i = d; i < env->config->nareg / 4; i += d) {
+        uint32_t ssp, osp;
+        unsigned j;
 
-    while (ws && ret == 0) {
-        int d;
-        int i;
-        int idx;
+        ws >>= d;
+        xtensa_rotate_window(env, d);
 
         if (ws & 0x1) {
-            ws >>= 1;
+            ssp = env->regs[5];
             d = 1;
         } else if (ws & 0x2) {
-            ws >>= 2;
+            ssp = env->regs[9];
+            ret |= get_user_ual(osp, env->regs[1] - 12);
+            osp -= 32;
             d = 2;
-            for (i = 0; i < 4; ++i) {
-                idx = (wb * 4 + 4 + i) & nareg_mask;
-                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 12) * 4);
-            }
         } else if (ws & 0x4) {
-            ws >>= 3;
+            ssp = env->regs[13];
+            ret |= get_user_ual(osp, env->regs[1] - 12);
+            osp -= 48;
             d = 3;
-            for (i = 0; i < 8; ++i) {
-                idx = (wb * 4 + 4 + i) & nareg_mask;
-                ret |= put_user_ual(env->phys_regs[idx], sp + (i - 16) * 4);
-            }
         } else {
             g_assert_not_reached();
         }
-        sp = env->phys_regs[((wb + d) * 4 + 1) & nareg_mask];
-        for (i = 0; i < 4; ++i) {
-            idx = (wb * 4 + i) & nareg_mask;
-            ret |= put_user_ual(env->phys_regs[idx], sp + (i - 4) * 4);
+
+        for (j = 0; j < 4; ++j) {
+            ret |= put_user_ual(env->regs[j], ssp - 16 + j * 4);
+        }
+        for (j = 4; j < d * 4; ++j) {
+            ret |= put_user_ual(env->regs[j], osp - 16 + j * 4);
         }
-        wb += d;
     }
+    xtensa_rotate_window(env, d);
+    g_assert(env->sregs[WINDOW_BASE] == wb);
     return ret == 0;
 }
 
-- 
2.11.0
