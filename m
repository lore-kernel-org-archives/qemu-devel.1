Received: from eggs.gnu.org ([209.51.188.92]:46480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJB-0000FD-65
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJ8-0000gU-Rs
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:59 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:54 +0100
Message-Id: <20190304120210.31500-12-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/27] s390x/tcg: Implement LOAD LENGTHENED
 short HFP to long HFP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Nice trick to load a 32 bit value into vector element 0 (32 bit element
size) from memory, zeroing out element1. The short HFP to long HFP
conversion really only is a shift.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225200318.16102-7-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 61582372abb7..fb6ee1865057 100644
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
index f7de77192c7e..59e71128d2bf 100644
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
