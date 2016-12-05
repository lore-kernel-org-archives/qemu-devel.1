Received: from eggs.gnu.org ([2001:4830:134:3::10]:39806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cDxYJ-0005Kl-HN
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cDxYI-0001Ze-Jb
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:59:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cDxYI-0001Wp-CM
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:59:46 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Dec 2016 17:59:35 +0000
Message-Id: <1480960775-5002-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1480960775-5002-1-git-send-email-peter.maydell@linaro.org>
References: <1480960775-5002-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] target-arm/translate-a64: fix
 gen_load_exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Alex Bennée <alex.bennee@linaro.org>

While testing rth's latest TCG patches with risu I found ldaxp was
broken. Investigating further I found it was broken by 1dd089d0 when
the cmpxchg atomic work was merged. As part of that change the code
attempted to be clever by doing a single 64 bit load and then shuffle
the data around to set the two 32 bit registers.

As I couldn't quite follow the endian magic I've simply partially
reverted the change to the original code gen_load_exclusive code. This
doesn't affect the cmpxchg functionality as that is all done on in
gen_store_exclusive part which is untouched.

I've also restored the comment that was removed (with a slight tweak
to mention cmpxchg).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <rth@twiddle.net>
Message-id: 20161202173454.19179-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target-arm/translate-a64.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/target-arm/translate-a64.c b/target-arm/translate-a64.c
index de48747..6dc27a6 100644
--- a/target-arm/translate-a64.c
+++ b/target-arm/translate-a64.c
@@ -1839,41 +1839,37 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
     }
 }
 
+/*
+ * Load/Store exclusive instructions are implemented by remembering
+ * the value/address loaded, and seeing if these are the same
+ * when the store is performed. This is not actually the architecturally
+ * mandated semantics, but it works for typical guest code sequences
+ * and avoids having to monitor regular stores.
+ *
+ * The store exclusive uses the atomic cmpxchg primitives to avoid
+ * races in multi-threaded linux-user and when MTTCG softmmu is
+ * enabled.
+ */
 static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                                TCGv_i64 addr, int size, bool is_pair)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
-    TCGMemOp be = s->be_data;
+    TCGMemOp memop = s->be_data + size;
 
     g_assert(size <= 3);
+    tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), memop);
+
     if (is_pair) {
+        TCGv_i64 addr2 = tcg_temp_new_i64();
         TCGv_i64 hitmp = tcg_temp_new_i64();
 
-        if (size == 3) {
-            TCGv_i64 addr2 = tcg_temp_new_i64();
-
-            tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s),
-                                MO_64 | MO_ALIGN_16 | be);
-            tcg_gen_addi_i64(addr2, addr, 8);
-            tcg_gen_qemu_ld_i64(hitmp, addr2, get_mem_index(s),
-                                MO_64 | MO_ALIGN | be);
-            tcg_temp_free_i64(addr2);
-        } else {
-            g_assert(size == 2);
-            tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s),
-                                MO_64 | MO_ALIGN | be);
-            if (be == MO_LE) {
-                tcg_gen_extr32_i64(tmp, hitmp, tmp);
-            } else {
-                tcg_gen_extr32_i64(hitmp, tmp, tmp);
-            }
-        }
-
+        g_assert(size >= 2);
+        tcg_gen_addi_i64(addr2, addr, 1 << size);
+        tcg_gen_qemu_ld_i64(hitmp, addr2, get_mem_index(s), memop);
+        tcg_temp_free_i64(addr2);
         tcg_gen_mov_i64(cpu_exclusive_high, hitmp);
         tcg_gen_mov_i64(cpu_reg(s, rt2), hitmp);
         tcg_temp_free_i64(hitmp);
-    } else {
-        tcg_gen_qemu_ld_i64(tmp, addr, get_mem_index(s), size | MO_ALIGN | be);
     }
 
     tcg_gen_mov_i64(cpu_exclusive_val, tmp);
-- 
2.7.4
