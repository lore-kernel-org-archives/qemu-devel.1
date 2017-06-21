Received: from eggs.gnu.org ([2001:4830:134:3::10]:33911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhJ-0006UW-12
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhH-0002OU-TV
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:49 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhH-0002OQ-Oy
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:47 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so25678185qtb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:23 -0700
Message-Id: <20170621024831.26019-9-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 08/16] tcg: Introduce temp_arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 4 ++--
 tcg/tcg.h | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0bb88b1..0d758e4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1718,7 +1718,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                     TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
 
                     lop->args[0] = dir;
-                    lop->args[1] = temp_idx(s, its->mem_base);
+                    lop->args[1] = temp_arg(its->mem_base);
                     lop->args[2] = its->mem_offset;
 
                     /* Loaded, but synced with memory.  */
@@ -1789,7 +1789,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                 TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
 
                 sop->args[0] = dir;
-                sop->args[1] = temp_idx(s, its->mem_base);
+                sop->args[1] = temp_arg(its->mem_base);
                 sop->args[2] = its->mem_offset;
 
                 temp_state[arg] = TS_MEM;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6c357e7..80012b5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -728,6 +728,13 @@ struct TCGContext {
 extern TCGContext tcg_ctx;
 extern bool parallel_cpus;
 
+static inline TCGArg temp_arg(TCGTemp *ts)
+{
+    ptrdiff_t n = ts - tcg_ctx.temps;
+    tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
+    return n;
+}
+
 static inline TCGTemp *arg_temp(TCGArg a)
 {
     return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
-- 
2.9.4
