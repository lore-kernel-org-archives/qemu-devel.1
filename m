Received: from eggs.gnu.org ([2001:4830:134:3::10]:54508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQP-0000bO-11
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ewYQL-00061B-Tn
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ewYQL-0005zJ-Cn
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:20:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 15 Mar 2018 20:19:58 +0100
Message-Id: <20180315191958.28937-4-laurent@vivier.eu>
In-Reply-To: <20180315191958.28937-1-laurent@vivier.eu>
References: <20180315191958.28937-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 3/3] m68k: Test if we overflow the temp variable
 array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Since commit 15fa08f845 ("tcg: Dynamically allocate TCGOps")
we have no limit to fill the TCGOps cache and we can fill
the entire TCG variables array and overflow it.

To avoid that, we stop the translation when the array is close to
be full.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 2 +-
 tcg/tcg.h               | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 03aa701dde..e235be46ba 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6155,7 +6155,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
         dc->insn_pc = dc->pc;
 	disas_m68k_insn(env, dc);
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
+    } while (!dc->is_jmp && !tcg_op_buf_full() && !tcg_temp_full(64) &&
              !cs->singlestep_enabled &&
              !singlestep &&
              (pc_offset) < (TARGET_PAGE_SIZE - 32) &&
diff --git a/tcg/tcg.h b/tcg/tcg.h
index e6d9dc0643..ccfe050e27 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -836,6 +836,12 @@ static inline bool tcg_op_buf_full(void)
 {
     return false;
 }
+/* Test if we overflow the temp variable array */
+
+static inline bool tcg_temp_full(int marging)
+{
+    return tcg_ctx->nb_temps > TCG_MAX_TEMPS - marging;
+}
 
 /* pool based memory allocation */
 
-- 
2.14.3
