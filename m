Received: from eggs.gnu.org ([209.51.188.92]:46457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJ7-0000Ck-DU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJ6-0000Zu-Aq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:57 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:53 +0100
Message-Id: <20190304120210.31500-11-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/27] s390x/tcg: Factor out
 gen_addi_and_wrap_i64() from get_address()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Also properly wrap in 24bit mode. While at it, convert the comment (and
drop the comment about fundamental TCG optimizations).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225200318.16102-6-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 41 +++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 933bf29331a2..f7de77192c7e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -382,32 +382,43 @@ static inline void gen_trap(DisasContext *s)
     gen_data_exception(0xff);
 }
 
+static void gen_addi_and_wrap_i64(DisasContext *s, TCGv_i64 dst, TCGv_i64 src,
+                                  int64_t imm)
+{
+    tcg_gen_addi_i64(dst, src, imm);
+    if (!(s->base.tb->flags & FLAG_MASK_64)) {
+        if (s->base.tb->flags & FLAG_MASK_32) {
+            tcg_gen_andi_i64(dst, dst, 0x7fffffff);
+        } else {
+            tcg_gen_andi_i64(dst, dst, 0x00ffffff);
+        }
+    }
+}
+
 static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
-    bool need_31 = !(s->base.tb->flags & FLAG_MASK_64);
-
-    /* Note that d2 is limited to 20 bits, signed.  If we crop negative
-       displacements early we create larger immedate addends.  */
 
-    /* Note that addi optimizes the imm==0 case.  */
+    /*
+     * Note that d2 is limited to 20 bits, signed.  If we crop negative
+     * displacements early we create larger immedate addends.
+     */
     if (b2 && x2) {
         tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
-        tcg_gen_addi_i64(tmp, tmp, d2);
+        gen_addi_and_wrap_i64(s, tmp, tmp, d2);
     } else if (b2) {
-        tcg_gen_addi_i64(tmp, regs[b2], d2);
+        gen_addi_and_wrap_i64(s, tmp, regs[b2], d2);
     } else if (x2) {
-        tcg_gen_addi_i64(tmp, regs[x2], d2);
-    } else {
-        if (need_31) {
-            d2 &= 0x7fffffff;
-            need_31 = false;
+        gen_addi_and_wrap_i64(s, tmp, regs[x2], d2);
+    } else if (!(s->base.tb->flags & FLAG_MASK_64)) {
+        if (s->base.tb->flags & FLAG_MASK_32) {
+            tcg_gen_movi_i64(tmp, d2 & 0x7fffffff);
+        } else {
+            tcg_gen_movi_i64(tmp, d2 & 0x00ffffff);
         }
+    } else {
         tcg_gen_movi_i64(tmp, d2);
     }
-    if (need_31) {
-        tcg_gen_andi_i64(tmp, tmp, 0x7fffffff);
-    }
 
     return tmp;
 }
-- 
2.17.2
