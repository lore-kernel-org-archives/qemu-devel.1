Received: from eggs.gnu.org ([2001:4830:134:3::10]:49675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdN-0001Ds-8o
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdM-00026Z-EO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:09 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAdM-00025t-6x
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:08 -0500
Received: by mail-wr0-x244.google.com with SMTP id v21so6297372wrc.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:40:08 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:51 -0800
Message-Id: <1513661932-6849-16-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 15/16] target/xtensa: implement const16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

const16 is an opcode that shifts 16 lower bits of an address register
to the 16 upper bits and puts its immediate operand into the lower 16
bits. It is not controlled by an Xtensa option and doesn't have a fixed
opcode.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- reimplement translate_const16 using tcg_gen_deposit_i32.

 target/xtensa/translate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index a84bbf3bedc3..bf299dbf9a04 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1526,6 +1526,17 @@ static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
     tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0]));
 }
 
+static void translate_const16(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 c = tcg_const_i32(arg[1]);
+
+        tcg_gen_deposit_i32(cpu_R[arg[0]], c, cpu_R[arg[0]], 16, 16);
+        tcg_temp_free(c);
+    }
+}
+
 /* par[0]: privileged, par[1]: check memory access */
 static void translate_dcache(DisasContext *dc, const uint32_t arg[],
                              const uint32_t par[])
@@ -2742,6 +2753,9 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "clrb_expstate",
         .translate = translate_clrb_expstate,
     }, {
+        .name = "const16",
+        .translate = translate_const16,
+    }, {
         .name = "depbits",
         .translate = translate_depbits,
     }, {
-- 
2.1.4
