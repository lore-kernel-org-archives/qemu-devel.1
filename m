Received: from eggs.gnu.org ([2001:4830:134:3::10]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj1-0000EF-MM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCix-0003aN-U2
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCiw-0003Ti-3g
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id q26so12173210wmf.5
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:44 +0100
Message-Id: <20181123144558.5048-24-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 23/37] tcg/ppc: Change
 TCG_TARGET_CALL_ALIGN_ARGS to bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

Cleaner not to treat this as #ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 484d90ead2..f7c33f3b7f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -30,6 +30,8 @@
 #endif
 #ifdef _CALL_SYSV
 # define TCG_TARGET_CALL_ALIGN_ARGS   1
+#else
+# define TCG_TARGET_CALL_ALIGN_ARGS   0
 #endif
 
 /* For some memory operations, we need a scratch that isn't R0.  For the AIX
@@ -1675,9 +1677,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     lo = lb->addrlo_reg;
     hi = lb->addrhi_reg;
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-#ifdef TCG_TARGET_CALL_ALIGN_ARGS
-        arg |= 1;
-#endif
+        arg |= TCG_TARGET_CALL_ALIGN_ARGS;
         tcg_out_mov(s, TCG_TYPE_I32, arg++, hi);
         tcg_out_mov(s, TCG_TYPE_I32, arg++, lo);
     } else {
@@ -1720,9 +1720,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     lo = lb->addrlo_reg;
     hi = lb->addrhi_reg;
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-#ifdef TCG_TARGET_CALL_ALIGN_ARGS
-        arg |= 1;
-#endif
+        arg |= TCG_TARGET_CALL_ALIGN_ARGS;
         tcg_out_mov(s, TCG_TYPE_I32, arg++, hi);
         tcg_out_mov(s, TCG_TYPE_I32, arg++, lo);
     } else {
@@ -1736,9 +1734,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     if (TCG_TARGET_REG_BITS == 32) {
         switch (s_bits) {
         case MO_64:
-#ifdef TCG_TARGET_CALL_ALIGN_ARGS
-            arg |= 1;
-#endif
+            arg |= TCG_TARGET_CALL_ALIGN_ARGS;
             tcg_out_mov(s, TCG_TYPE_I32, arg++, hi);
             /* FALLTHRU */
         case MO_32:
-- 
2.17.2
