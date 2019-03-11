Received: from eggs.gnu.org ([209.51.188.92]:34436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qay-0004Hb-UB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007Wk-8A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:37539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007V4-UI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:57 +0100
Message-Id: <20190311191602.25796-7-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] target/hppa: ignore DIAG opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

DIAG is usually only used by diagnostics software as it's CPU
specific. In most of the cases it's better to ignore it and log
a message that it's not implemented.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/insns.decode | 3 +++
 target/hppa/translate.c  | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 55ff39dd05..098370c2f0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -525,3 +525,6 @@ fmpy_d          001110 ..... ..... 010 ..... ... .....  @f0e_d_3
 fdiv_d          001110 ..... ..... 011 ..... ... .....  @f0e_d_3
 
 xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
+
+# diag
+diag            000101 ----- ----- ---- ---- ---- ----
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7001c2eb80..441f0ea9d6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4292,3 +4292,9 @@ void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
        that the instruction was not nullified.  */
     env->psw_n = 0;
 }
+
+static bool trans_diag(DisasContext *ctx, arg_diag *a)
+{
+    qemu_log_mask(LOG_UNIMP, "DIAG opcode ignored\n");
+    return true;
+}
-- 
2.20.1
