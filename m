Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPk-0006IU-4m
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPj-00017V-A2
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:32 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:52161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPj-000161-2k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:31 -0400
Received: by mail-lf0-x243.google.com with SMTP id r129so5155440lff.8
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:30 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:20 -0700
Message-Id: <1509767121-26925-16-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 15/16] target/xtensa: implement const16
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
 target/xtensa/translate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index a84bbf3bedc3..f249e810d92c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1526,6 +1526,17 @@ static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
     tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0]));
 }
 
+static void translate_const16(DisasContext *dc, const uint32_t arg[],
+                             const uint32_t par[])
+{
+    if (gen_window_check1(dc, arg[0])) {
+        TCGv_i32 v = tcg_temp_new_i32();
+
+        tcg_gen_shli_i32(v, cpu_R[arg[0]], 16);
+        tcg_gen_ori_i32(cpu_R[arg[0]], v, arg[1] & 0xffff);
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
