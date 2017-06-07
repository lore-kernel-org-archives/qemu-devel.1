Received: from eggs.gnu.org ([2001:4830:134:3::10]:34156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtb-0003FL-H8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOta-00029l-HI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:23 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOta-00029P-Cw
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:22 -0400
Received: by mail-qk0-x242.google.com with SMTP id u129so439644qka.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:53 -0700
Message-Id: <20170607003119.14778-45-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 44/70] target/s390x: implement TEST
 ADDRESSING MODE
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
index 2d45132..854a66a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4068,6 +4068,16 @@ static ExitStatus op_svc(DisasContext *s, DisasOps *o)
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
