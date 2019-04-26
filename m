Received: from eggs.gnu.org ([209.51.188.92]:47984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aQ-0008Tq-P0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aP-0006VT-MA
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:37923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aP-0006SD-Fh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id j26so1936424pgl.5
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:13 -0700
Message-Id: <20190426172421.27133-8-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/15] tcg/aarch64: Support
 INDEX_op_extract2_{i32, i64}
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  4 ++--
 tcg/aarch64/tcg-target.inc.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 6600a54a02..ce2bb1f90b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -77,7 +77,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -114,7 +114,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
-#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index d57f9e500f..8b93598bce 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2058,6 +2058,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
         break;
 
+    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2_i32:
+        tcg_out_extr(s, ext, a0, a1, a2, args[3]);
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
                         (int32_t)args[4], args[5], const_args[4],
@@ -2300,6 +2305,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rAL" } };
     static const TCGTargetOpDef dep
         = { .args_ct_str = { "r", "0", "rZ" } };
+    static const TCGTargetOpDef ext2
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
     static const TCGTargetOpDef movc
         = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
     static const TCGTargetOpDef add2
@@ -2430,6 +2437,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_deposit_i64:
         return &dep;
 
+    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2_i64:
+        return &ext2;
+
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
-- 
2.17.1
