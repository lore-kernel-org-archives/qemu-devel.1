Received: from eggs.gnu.org ([2001:4830:134:3::10]:55097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwZ-0005cs-4U
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwY-0001J9-9v
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:15 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwY-0001Ic-41
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:14 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:45 +0200
Message-Id: <20170525210508.4910-4-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 03/26] target/s390x: implement TEST AND SET
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
index f818437069..0f70acea5c 100644
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
index 850df26ce1..1e16f3d1f7 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4126,6 +4126,16 @@ static ExitStatus op_trt(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_ts(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 t1 = tcg_const_i32(0xff);
+    tcg_gen_atomic_fetch_or_i32(t1, o->in2, t1, get_mem_index(s), MO_UB);
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
2.11.0
