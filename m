Received: from eggs.gnu.org ([2001:4830:134:3::10]:52206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5w-0003wp-Pq
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5v-0001SY-Oh
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:24 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3i5v-0001S5-I9
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:23 -0400
Received: by mail-wr0-x244.google.com with SMTP id v42so3520993wrc.3
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:00:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 27 Apr 2017 13:59:54 +0200
Message-Id: <20170427120006.20564-8-rth@twiddle.net>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 07/19] tcg: export
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Instead of exporting goto_ptr directly to TCG frontends, export
tcg_gen_lookup_and_goto_ptr(), which calls goto_ptr with the pointer
returned by the lookup_tb_ptr() helper. This is the only use case
we have for goto_ptr and lookup_tb_ptr, so having this function is
very convenient. Furthermore, it trivially allows us to avoid calling
the lookup helper if goto_ptr is not implemented by the backend.

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-5-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/README   |  8 ++++++++
 tcg/tcg-op.c | 13 +++++++++++++
 tcg/tcg-op.h | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/tcg/README b/tcg/README
index a9858c2..bf49e82 100644
--- a/tcg/README
+++ b/tcg/README
@@ -477,6 +477,14 @@ current TB was linked to this TB. Otherwise execute the next
 instructions. Only indices 0 and 1 are valid and tcg_gen_goto_tb may be issued
 at most once with each slot index per TB.
 
+* lookup_and_goto_ptr tb_addr
+
+Look up a TB address ('tb_addr') and jump to it if valid. If not valid,
+jump to the TCG epilogue to go back to the exec loop.
+
+This operation is optional. If the TCG backend does not implement the
+goto_ptr opcode, emitting this op is equivalent to emitting exit_tb(0).
+
 * qemu_ld_i32/i64 t0, t1, flags, memidx
 * qemu_st_i32/i64 t0, t1, flags, memidx
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6b1f415..660dac9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2587,6 +2587,19 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, idx);
 }
 
+void tcg_gen_lookup_and_goto_ptr(TCGv addr)
+{
+    if (TCG_TARGET_HAS_goto_ptr) {
+        TCGv_ptr ptr = tcg_temp_new_ptr();
+
+        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env, addr);
+        tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
+        tcg_temp_free_ptr(ptr);
+    } else {
+        tcg_gen_exit_tb(0);
+    }
+}
+
 static inline TCGMemOp tcg_canonicalize_memop(TCGMemOp op, bool is64, bool st)
 {
     /* Trigger the asserts within as early as possible.  */
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index c68e300..5d3278f 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -796,6 +796,17 @@ static inline void tcg_gen_exit_tb(uintptr_t val)
  */
 void tcg_gen_goto_tb(unsigned idx);
 
+/**
+ * tcg_gen_lookup_and_goto_ptr() - look up a TB and jump to it if valid
+ * @addr: Guest address of the target TB
+ *
+ * If the TB is not valid, jump to the epilogue.
+ *
+ * This operation is optional. If the TCG backend does not implement goto_ptr,
+ * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
+ */
+void tcg_gen_lookup_and_goto_ptr(TCGv addr);
+
 #if TARGET_LONG_BITS == 32
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_reg_new tcg_global_reg_new_i32
-- 
2.9.3
