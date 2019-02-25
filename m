Received: from eggs.gnu.org ([209.51.188.92]:49096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTu-0006uE-Lt
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTq-00011B-Pc
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:04:04 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 21:03:17 +0100
Message-Id: <20190225200318.16102-7-david@redhat.com>
In-Reply-To: <20190225200318.16102-1-david@redhat.com>
References: <20190225200318.16102-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/7] s390x/tcg: Implement LOAD LENGTHENED
 short HFP to long HFP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Nice trick to load a 32 bit value into vector element 0 (32 bit element
size) from memory, zeroing out element1. The short HFP to long HFP
conversion really only is a shift.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 61582372ab..fb6ee18650 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -598,6 +598,8 @@
     F(0xed04, LDEB,    RXE,   Z,   0, m2_32u, new, f1, ldeb, 0, IF_BFP)
     F(0xed05, LXDB,    RXE,   Z,   0, m2_64, new_P, x1, lxdb, 0, IF_BFP)
     F(0xed06, LXEB,    RXE,   Z,   0, m2_32u, new_P, x1, lxeb, 0, IF_BFP)
+    F(0xb324, LDER,    RXE,   Z,   0, e2, new, f1, lde, 0, IF_AFP1)
+    F(0xed24, LDE,     RXE,   Z,   0, m2_32u, new, f1, lde, 0, IF_AFP1)
 /* LOAD ROUNDED */
     F(0xb344, LEDBR,   RRE,   Z,   0, f2, new, e1, ledb, 0, IF_BFP)
     F(0xb345, LDXBR,   RRE,   Z,   x2h, x2l, new, f1, ldxb, 0, IF_BFP)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index cc52300334..6515aa028a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2725,6 +2725,12 @@ static DisasJumpType op_lxeb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_lde(DisasContext *s, DisasOps *o)
+{
+    tcg_gen_shli_i64(o->out, o->in2, 32);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_llgt(DisasContext *s, DisasOps *o)
 {
     tcg_gen_andi_i64(o->out, o->in2, 0x7fffffff);
-- 
2.17.2
