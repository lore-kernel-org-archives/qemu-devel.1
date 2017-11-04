Received: from eggs.gnu.org ([2001:4830:134:3::10]:44955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPg-0006FQ-Ou
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPe-00012T-MZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:28 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:56641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPe-00011k-Ej
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:26 -0400
Received: by mail-lf0-x244.google.com with SMTP id 90so5134921lfs.13
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:18 -0700
Message-Id: <1509767121-26925-14-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 13/16] target/xtensa: implement salt/saltu
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

SALT/SALTU are recent additions to the core Xtensa ISA that do
signed/unsigned setcond.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f644d9fed22a..da1f712badc7 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2199,6 +2199,16 @@ static void translate_s32e(DisasContext *dc, const uint32_t arg[],
     }
 }
 
+static void translate_salt(DisasContext *dc, const uint32_t arg[],
+                           const uint32_t par[])
+{
+    if (gen_window_check3(dc, arg[0], arg[1], arg[2])) {
+        tcg_gen_setcond_i32(par[0],
+                            cpu_R[arg[0]],
+                            cpu_R[arg[1]], cpu_R[arg[2]]);
+    }
+}
+
 static void translate_sext(DisasContext *dc, const uint32_t arg[],
                            const uint32_t par[])
 {
@@ -3667,6 +3677,14 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, true},
     }, {
+        .name = "salt",
+        .translate = translate_salt,
+        .par = (const uint32_t[]){TCG_COND_LT},
+    }, {
+        .name = "saltu",
+        .translate = translate_salt,
+        .par = (const uint32_t[]){TCG_COND_LTU},
+    }, {
         .name = "sext",
         .translate = translate_sext,
     }, {
-- 
2.1.4
