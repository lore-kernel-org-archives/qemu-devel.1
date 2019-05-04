Received: from eggs.gnu.org ([209.51.188.92]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbj-0007fx-1o
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbg-00045w-St
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbf-00040g-5e
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so3752275pgv.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:31 -0700
Message-Id: <20190504055300.18426-3-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/31] tcg: Do not recreate INDEX_op_neg_vec
 unless supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

Use tcg_can_emit_vec_op instead of just TCG_TARGET_HAS_neg_vec,
so that we check the type and vece for the actual operation.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5150c38a25..24faa06260 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -734,9 +734,13 @@ void tcg_optimize(TCGContext *s)
                 } else if (opc == INDEX_op_sub_i64) {
                     neg_op = INDEX_op_neg_i64;
                     have_neg = TCG_TARGET_HAS_neg_i64;
-                } else {
+                } else if (TCG_TARGET_HAS_neg_vec) {
+                    TCGType type = TCGOP_VECL(op) + TCG_TYPE_V64;
+                    unsigned vece = TCGOP_VECE(op);
                     neg_op = INDEX_op_neg_vec;
-                    have_neg = TCG_TARGET_HAS_neg_vec;
+                    have_neg = tcg_can_emit_vec_op(neg_op, type, vece) > 0;
+                } else {
+                    break;
                 }
                 if (!have_neg) {
                     break;
-- 
2.17.1
