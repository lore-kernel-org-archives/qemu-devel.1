Received: from eggs.gnu.org ([2001:4830:134:3::10]:49613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdI-00018K-BQ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdH-00023C-M8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:04 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAdH-00022o-G3
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:03 -0500
Received: by mail-wr0-x242.google.com with SMTP id q9so16996508wre.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:40:03 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:49 -0800
Message-Id: <1513661932-6849-14-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 13/16] target/xtensa: implement salt/saltu
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
