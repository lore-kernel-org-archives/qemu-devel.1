Received: from eggs.gnu.org ([2001:4830:134:3::10]:40723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1emnzQ-0006ln-RC
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1emnzP-0007QA-SJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:20 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1emnzP-0007Pv-Jv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:19 -0500
Received: by mail-pl0-x242.google.com with SMTP id bd10so2396504plb.1
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:56:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Feb 2018 13:56:07 -0800
Message-Id: <20180216215608.13227-5-richard.henderson@linaro.org>
In-Reply-To: <20180216215608.13227-1-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 4/5] aarch64-linux-user: Add support for
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
Cc: peter.maydell@linaro.org

The EXTRA record allows for additional space to be allocated
beyon what is currently reserved.  Add code to emit and read
this record type.

Nothing uses extra space yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index f9eef3d753..ca0ba28c98 100644
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
@@ -1554,14 +1572,16 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
-    struct target_aarch64_ctx *ctx;
+    struct target_aarch64_ctx *ctx, *extra = NULL;
     struct target_fpsimd_context *fpsimd = NULL;
+    uint64_t extra_datap = 0;
+    bool used_extra = false;
 
     target_restore_general_frame(env, sf);
 
     ctx = (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
     while (ctx) {
-        uint32_t magic, size;
+        uint32_t magic, size, extra_size;
 
         __get_user(magic, &ctx->magic);
         __get_user(size, &ctx->size);
@@ -1570,7 +1590,12 @@ static int target_restore_sigframe(CPUARMState *env,
             if (size != 0) {
                 return 1;
             }
-            ctx = NULL;
+            if (used_extra) {
+                ctx = NULL;
+            } else {
+                ctx = extra;
+                used_extra = true;
+            }
             continue;
 
         case TARGET_FPSIMD_MAGIC:
@@ -1580,6 +1605,17 @@ static int target_restore_sigframe(CPUARMState *env,
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_EXTRA_MAGIC:
+            if (extra || size != sizeof(struct target_extra_context)) {
+                return 1;
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
@@ -1595,6 +1631,9 @@ static int target_restore_sigframe(CPUARMState *env,
     }
     target_restore_fpsimd_record(env, fpsimd);
 
+    if (extra) {
+        unlock_user(extra, extra_datap, 0);
+    }
     return 0;
 }
 
@@ -1621,7 +1660,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                CPUARMState *env)
 {
     int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
-    int fpsimd_ofs, end1_ofs, fr_ofs;
+    int fpsimd_ofs, end1_ofs, fr_ofs, end2_ofs = 0;
+    int extra_ofs = 0, extra_base = 0, extra_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
@@ -1641,7 +1681,14 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
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
