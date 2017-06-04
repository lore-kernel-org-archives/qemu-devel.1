Received: from eggs.gnu.org ([2001:4830:134:3::10]:50594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRo-0007wN-KP
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRk-0003gv-SN
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:16 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRk-0003fo-MN
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:12 -0400
Received: by mail-pf0-x244.google.com with SMTP id n23so18101287pfb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:43 -0700
Message-Id: <20170604173509.29684-44-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 43/69] target/s390x: implement TEST AND SET
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
Message-Id: <20170531220129.27724-5-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f818437..0f70ace 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -810,6 +810,9 @@
 /* SUPERVISOR CALL */
     C(0x0a00, SVC,     I,     Z,   0, 0, 0, 0, svc, 0)
 
+/* TEST AND SET */
+    C(0x9300, TS,      S,     Z,   0, a2, 0, 0, ts, 0)
+
 /* TEST DATA CLASS */
     C(0xed10, TCEB,    RXE,   Z,   e1, a2, 0, 0, tceb, 0)
     C(0xed11, TCDB,    RXE,   Z,   f1_o, a2, 0, 0, tcdb, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f160b62..0cfa8cc 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4129,6 +4129,16 @@ static ExitStatus op_trt(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_ts(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 t1 = tcg_const_i32(0xff);
+    tcg_gen_atomic_xchg_i32(t1, o->in2, t1, get_mem_index(s), MO_UB);
+    tcg_gen_extract_i32(cc_op, t1, 7, 1);
+    tcg_temp_free_i32(t1);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_unpk(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-- 
2.9.4
