Received: from eggs.gnu.org ([2001:4830:134:3::10]:35661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VG-0006eI-FH
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VF-0003Vt-97
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:06 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VF-0003Vc-2X
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:05 -0500
Received: by mail-pf0-x242.google.com with SMTP id f144so12526416pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:05 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:05 -0800
Message-Id: <20170111021820.24416-51-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 50/65] tcg: Add helpers for clrsb
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

The number of actual invocations does not warrent an opcode,
and the backends generating it.  But at least we can eliminate
redundant helpers.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg-runtime.c     | 10 ++++++++++
 tcg/tcg-op.c      | 28 ++++++++++++++++++++++++++++
 tcg/tcg-op.h      |  4 ++++
 tcg/tcg-runtime.h |  2 ++
 4 files changed, 44 insertions(+)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index eb3bade..c8b98df 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -121,6 +121,16 @@ uint64_t HELPER(ctz_i64)(uint64_t arg, uint64_t zero_val)
     return arg ? ctz64(arg) : zero_val;
 }
 
+uint32_t HELPER(clrsb_i32)(uint32_t arg)
+{
+    return clrsb32(arg);
+}
+
+uint64_t HELPER(clrsb_i64)(uint64_t arg)
+{
+    return clrsb64(arg);
+}
+
 void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2b520c1..620e268 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -536,6 +536,20 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
     tcg_temp_free_i32(t);
 }
 
+void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    if (TCG_TARGET_HAS_clz_i32) {
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_sari_i32(t, arg, 31);
+        tcg_gen_xor_i32(t, t, arg);
+        tcg_gen_clzi_i32(t, t, 32);
+        tcg_gen_subi_i32(ret, t, 1);
+        tcg_temp_free_i32(t);
+    } else {
+        gen_helper_clrsb_i32(ret, arg);
+    }
+}
+
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rot_i32) {
@@ -1846,6 +1860,20 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
     }
 }
 
+void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    if (TCG_TARGET_HAS_clz_i64 || TCG_TARGET_HAS_clz_i32) {
+        TCGv_i64 t = tcg_temp_new_i64();
+        tcg_gen_sari_i64(t, arg, 63);
+        tcg_gen_xor_i64(t, t, arg);
+        tcg_gen_clzi_i64(t, t, 64);
+        tcg_gen_subi_i64(ret, t, 1);
+        tcg_temp_free_i64(t);
+    } else {
+        gen_helper_clrsb_i64(ret, arg);
+    }
+}
+
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rot_i64) {
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 7a24e84..c2f3db9 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -290,6 +290,7 @@ void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -477,6 +478,7 @@ void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
@@ -970,6 +972,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_ctz_tl tcg_gen_ctz_i64
 #define tcg_gen_clzi_tl tcg_gen_clzi_i64
 #define tcg_gen_ctzi_tl tcg_gen_ctzi_i64
+#define tcg_gen_clrsb_tl tcg_gen_clrsb_i64
 #define tcg_gen_rotl_tl tcg_gen_rotl_i64
 #define tcg_gen_rotli_tl tcg_gen_rotli_i64
 #define tcg_gen_rotr_tl tcg_gen_rotr_i64
@@ -1065,6 +1068,7 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
 #define tcg_gen_ctz_tl tcg_gen_ctz_i32
 #define tcg_gen_clzi_tl tcg_gen_clzi_i32
 #define tcg_gen_ctzi_tl tcg_gen_ctzi_i32
+#define tcg_gen_clrsb_tl tcg_gen_clrsb_i32
 #define tcg_gen_rotl_tl tcg_gen_rotl_i32
 #define tcg_gen_rotli_tl tcg_gen_rotli_i32
 #define tcg_gen_rotr_tl tcg_gen_rotr_i32
diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
index eb1cd76..0d30f1a 100644
--- a/tcg/tcg-runtime.h
+++ b/tcg/tcg-runtime.h
@@ -19,6 +19,8 @@ DEF_HELPER_FLAGS_2(clz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(ctz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(ctz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(clrsb_i32, TCG_CALL_NO_RWG_SE, i32, i32)
+DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
-- 
2.9.3
