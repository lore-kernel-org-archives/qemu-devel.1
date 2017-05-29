Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHc-0006Tu-6f
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-000744-AS
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:52 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHZ-00072d-Vf
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:16 +0200
Message-Id: <20170529192440.5990-6-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 05/29] target/s390x: implement TEST
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0f70acea5c..170b50ef2e 100644
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
index 0cfa8cc05e..7f265aeb40 100644
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
2.11.0
