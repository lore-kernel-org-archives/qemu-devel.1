Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1chFmS-0003IR-Bs
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1chFmP-0008Vx-Nh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:19:28 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:36738 helo=tegan.suse.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ebischoff@suse.com>) id 1chFmP-0008V3-Dl
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:19:25 -0500
From: Eric Bischoff <ebischoff@suse.com>
Date: Fri, 24 Feb 2017 14:19:18 +0100
Message-Id: <20170224131918.15480-2-ebischoff@suse.com>
In-Reply-To: <20170224131918.15480-1-ebischoff@suse.com>
References: <20170224131918.15480-1-ebischoff@suse.com>
Subject: [Qemu-devel] [PATCH] Adding support for LPD and LPDG instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Bischoff <ebischoff@nerim.net>

From: Eric Bischoff <ebischoff@nerim.net>

LPD = LOAD PAIR DISJOINT
---
 target/s390x/insn-data.def |  4 +++-
 target/s390x/translate.c   | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 075ff59..5a0231f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -504,7 +504,9 @@
     C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
     C(0xebf2, LOC,     RSY_b, LOC, r1, m2_32u, new, r1_32, loc, 0)
     C(0xebe2, LOCG,    RSY_b, LOC, r1, m2_64, r1, 0, loc, 0)
-/* LOAD PAIR DISJOINT TODO */
+/* LOAD PAIR DISJOINT */
+    C(0xc804, LPD,     SSF,   ILA, m1_32s, m2_32s, 0, r3_P32, movx, 0)
+    C(0xc805, LPDG,    SSF,   ILA, m1_64, m2_64, 0, r3_P64, movx, 0)
 /* LOAD POSITIVE */
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c6217..70397b6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4420,6 +4420,22 @@ static void wout_r1_D32(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_wout_r1_D32 SPEC_r1_even
 
+static void wout_r3_P32(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    int r3 = get_field(f, r3);
+    store_reg32_i64(r3, o->out);
+    store_reg32_i64(r3 + 1, o->out2);
+}
+#define SPEC_wout_r3_P32 SPEC_r3_even
+
+static void wout_r3_P64(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    int r3 = get_field(f, r3);
+    store_reg(r3, o->out);
+    store_reg(r3 + 1, o->out2);
+}
+#define SPEC_wout_r3_P64 SPEC_r3_even
+
 static void wout_e1(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     store_freg32_i64(get_field(f, r1), o->out);
-- 
2.10.2
