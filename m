Received: from eggs.gnu.org ([2001:4830:134:3::10]:50592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRo-0007wL-Jm
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRm-0003i5-4U
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:16 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRl-0003hi-V4
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:14 -0400
Received: by mail-pg0-x241.google.com with SMTP id v14so3630624pgn.1
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:44 -0700
Message-Id: <20170604173509.29684-45-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 44/69] target/s390x: implement TEST ADDRESSING
 MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-6-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0f70ace..170b50e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -810,6 +810,9 @@
 /* SUPERVISOR CALL */
     C(0x0a00, SVC,     I,     Z,   0, 0, 0, 0, svc, 0)
 
+/* TEST ADDRESSING MODE */
+    C(0x010b, TAM,     E,     Z,   0, 0, 0, 0, tam, 0)
+
 /* TEST AND SET */
     C(0x9300, TS,      S,     Z,   0, a2, 0, 0, ts, 0)
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 0cfa8cc..7f265ae 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4063,6 +4063,16 @@ static ExitStatus op_svc(DisasContext *s, DisasOps *o)
     return EXIT_NORETURN;
 }
 
+static ExitStatus op_tam(DisasContext *s, DisasOps *o)
+{
+    int cc = 0;
+
+    cc |= (s->tb->flags & FLAG_MASK_64) ? 2 : 0;
+    cc |= (s->tb->flags & FLAG_MASK_32) ? 1 : 0;
+    gen_op_movi_cc(s, cc);
+    return NO_EXIT;
+}
+
 static ExitStatus op_tceb(DisasContext *s, DisasOps *o)
 {
     gen_helper_tceb(cc_op, cpu_env, o->in1, o->in2);
-- 
2.9.4
