Received: from eggs.gnu.org ([2001:4830:134:3::10]:56876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1es8J1-000691-B0
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1es8J0-0003wo-8V
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:38:35 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1es8J0-0003wR-03
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:38:34 -0500
Received: by mail-wr0-x241.google.com with SMTP id l43so12899022wrc.2
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 06:38:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Mar 2018 14:38:22 +0000
Message-Id: <20180303143823.27055-5-richard.henderson@linaro.org>
In-Reply-To: <20180303143823.27055-1-richard.henderson@linaro.org>
References: <20180303143823.27055-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 4/5] aarch64-linux-user: Add support for
 EXTRA signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

The EXTRA record allows for additional space to be allocated
beyon what is currently reserved.  Add code to emit and read
this record type.

Nothing uses extra space yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 74 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index f9eef3d753..c31cf0601d 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1443,6 +1443,15 @@ struct target_fpsimd_context {
     uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
 };
 
+#define TARGET_EXTRA_MAGIC  0x45585401
+
+struct target_extra_context {
+    struct target_aarch64_ctx head;
+    uint64_t datap; /* 16-byte aligned pointer to extra space cast to __u64 */
+    uint32_t size; /* size in bytes of the extra space */
+    uint32_t reserved[3];
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -1502,6 +1511,15 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
     }
 }
 
+static void target_setup_extra_record(struct target_extra_context *extra,
+                                      uint64_t datap, uint32_t extra_size)
+{
+    __put_user(TARGET_EXTRA_MAGIC, &extra->head.magic);
+    __put_user(sizeof(struct target_extra_context), &extra->head.size);
+    __put_user(datap, &extra->datap);
+    __put_user(extra_size, &extra->size);
+}
+
 static void target_setup_end_record(struct target_aarch64_ctx *end)
 {
     __put_user(0, &end->magic);
@@ -1554,48 +1572,74 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
-    struct target_aarch64_ctx *ctx;
+    struct target_aarch64_ctx *ctx, *extra = NULL;
     struct target_fpsimd_context *fpsimd = NULL;
+    uint64_t extra_datap = 0;
+    bool used_extra = false;
+    bool err = false;
 
     target_restore_general_frame(env, sf);
 
     ctx = (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
     while (ctx) {
-        uint32_t magic, size;
+        uint32_t magic, size, extra_size;
 
         __get_user(magic, &ctx->magic);
         __get_user(size, &ctx->size);
         switch (magic) {
         case 0:
             if (size != 0) {
-                return 1;
+                err = true;
+                goto exit;
+            }
+            if (used_extra) {
+                ctx = NULL;
+            } else {
+                ctx = extra;
+                used_extra = true;
             }
-            ctx = NULL;
             continue;
 
         case TARGET_FPSIMD_MAGIC:
             if (fpsimd || size != sizeof(struct target_fpsimd_context)) {
-                return 1;
+                err = true;
+                goto exit;
             }
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_EXTRA_MAGIC:
+            if (extra || size != sizeof(struct target_extra_context)) {
+                err = true;
+                goto exit;
+            }
+            __get_user(extra_datap,
+                       &((struct target_extra_context *)ctx)->datap);
+            __get_user(extra_size,
+                       &((struct target_extra_context *)ctx)->size);
+            extra = lock_user(VERIFY_READ, extra_datap, extra_size, 0);
+            break;
+
         default:
             /* Unknown record -- we certainly didn't generate it.
              * Did we in fact get out of sync?
              */
-            return 1;
+            err = true;
+            goto exit;
         }
         ctx = (void *)ctx + size;
     }
 
     /* Require FPSIMD always.  */
-    if (!fpsimd) {
-        return 1;
+    if (fpsimd) {
+        target_restore_fpsimd_record(env, fpsimd);
+    } else {
+        err = true;
     }
-    target_restore_fpsimd_record(env, fpsimd);
 
-    return 0;
+ exit:
+    unlock_user(extra, extra_datap, 0);
+    return err;
 }
 
 static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
@@ -1621,7 +1665,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                CPUARMState *env)
 {
     int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
-    int fpsimd_ofs, end1_ofs, fr_ofs;
+    int fpsimd_ofs, end1_ofs, fr_ofs, end2_ofs = 0;
+    int extra_ofs = 0, extra_base = 0, extra_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -1641,7 +1686,14 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
+    if (extra_ofs) {
+        target_setup_extra_record((void *)frame + extra_ofs,
+                                  frame_addr + extra_base, extra_size);
+    }
     target_setup_end_record((void *)frame + end1_ofs);
+    if (end2_ofs) {
+        target_setup_end_record((void *)frame + end2_ofs);
+    }
 
     /* Set up the stack frame for unwinding.  */
     fr = (void *)frame + fr_ofs;
-- 
2.14.3
