Received: from eggs.gnu.org ([2001:4830:134:3::10]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXU1-00041A-74
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXTw-0002P5-9X
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYXTw-0002Oo-3I
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:36 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 21 Jul 2017 14:56:06 +0200
Message-Id: <20170721125609.11117-4-david@redhat.com>
In-Reply-To: <20170721125609.11117-1-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/6] target/s390x: implement spm (SET
 PROGRAM MASK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  2 ++
 target/s390x/insn-data.def |  2 ++
 target/s390x/translate.c   | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7732d01..4f7c6b7 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -308,6 +308,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #undef PSW_SHIFT_ASC
 #undef PSW_MASK_CC
 #undef PSW_MASK_PM
+#undef PSW_SHIFT_MASK_PM
 #undef PSW_MASK_64
 #undef PSW_MASK_32
 #undef PSW_MASK_ESA_ADDR
@@ -325,6 +326,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define PSW_SHIFT_ASC           46
 #define PSW_MASK_CC             0x0000300000000000ULL
 #define PSW_MASK_PM             0x00000F0000000000ULL
+#define PSW_SHIFT_MASK_PM       40
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
 #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ad84c74..84233a4 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -755,6 +755,8 @@
     C(0xb2b8, SRNMB,   S,     FPE, 0, 0, 0, 0, srnm, 0)
 /* SET DFP ROUNDING MODE */
     C(0xb2b9, SRNMT,   S,     DFPR, 0, 0, 0, 0, srnm, 0)
+/* SET PROGRAM MASK */
+    C(0x0400, SPM,     RR_a,  Z,   r1, 0, 0, 0, spm, 0)
 
 /* SHIFT LEFT SINGLE */
     D(0x8b00, SLA,     RS_a,  Z,   r1, sh32, new, r1_32, sla, 0, 31)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 1dffcee..7fc07a4 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3854,6 +3854,22 @@ static ExitStatus op_srnm(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_spm(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 cc = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(cc, o->in1);
+    tcg_gen_shri_i32(cc, cc, 28);
+    tcg_gen_andi_i32(cc, cc, 0x3ul);
+    tcg_gen_mov_i32(cc_op, cc);
+    tcg_temp_free_i32(cc);
+    set_cc_static(s);
+
+    tcg_gen_shri_i64(o->in1, o->in1, 24);
+    tcg_gen_deposit_i64(psw_mask, psw_mask, o->in1, PSW_SHIFT_MASK_PM, 4);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_spka(DisasContext *s, DisasOps *o)
 {
-- 
2.9.4
