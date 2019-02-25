Received: from eggs.gnu.org ([209.51.188.92]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyIOQ-0000av-BL
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyIOP-0008BP-G5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:42:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gyIOP-0008Ag-71
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:42:09 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 16:42:04 +0100
Message-Id: <20190225154204.26751-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tcg: Implement tcg_gen_shri2_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Will be helpful for s390x. Input 128 bit and output 64 bit only, which
is sufficient for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Use one output (lower part) only
- Shield off big shifts by an assert

 tcg/tcg-op.c | 15 +++++++++++++++
 tcg/tcg-op.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1bd7ef24af..e4fa75c074 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2381,6 +2381,21 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
+void tcg_gen_shri2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah, int64_t count)
+{
+    tcg_debug_assert(count >= 0 && count <= 64);
+    if (count == 0) {
+        tcg_gen_mov_i64(ret, al);
+    } else if (count == 64) {
+        tcg_gen_mov_i64(ret, ah);
+    } else {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        tcg_gen_shri_i64(t0, al, count);
+        tcg_gen_deposit_i64(ret, t0, ah, 64 - count, count);
+        tcg_temp_free_i64(t0);
+    }
+}
+
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i64) {
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index d3e51b15af..1ffe689276 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -513,6 +513,7 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
+void tcg_gen_shri2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah, int64_t count);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-- 
2.17.2
