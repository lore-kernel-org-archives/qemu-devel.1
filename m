Received: from eggs.gnu.org ([2001:4830:134:3::10]:52896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duJUS-0005to-3W
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duJUM-0004Ru-Ak
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:27:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1duJUM-0004RI-4y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:27:02 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Sep 2017 16:26:52 +0200
Message-Id: <20170919142654.16369-2-david@redhat.com>
In-Reply-To: <20170919142654.16369-1-david@redhat.com>
References: <20170919142654.16369-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] s390x/tcg: implement spm (SET PROGRAM
 MASK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

Missing and is used inside Linux in the context of CPACF.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  2 ++
 target/s390x/insn-data.def |  2 ++
 target/s390x/translate.c   | 11 +++++++++++
 3 files changed, 15 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9b549dc491..4414485089 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -292,6 +292,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #undef PSW_SHIFT_ASC
 #undef PSW_MASK_CC
 #undef PSW_MASK_PM
+#undef PSW_SHIFT_MASK_PM
 #undef PSW_MASK_64
 #undef PSW_MASK_32
 #undef PSW_MASK_ESA_ADDR
@@ -309,6 +310,7 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #define PSW_SHIFT_ASC           46
 #define PSW_MASK_CC             0x0000300000000000ULL
 #define PSW_MASK_PM             0x00000F0000000000ULL
+#define PSW_SHIFT_MASK_PM       40
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
 #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ad84c748e3..84233a456d 100644
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
index 5abd34fb34..59fde44d55 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3796,6 +3796,17 @@ static ExitStatus op_srnm(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_spm(DisasContext *s, DisasOps *o)
+{
+    tcg_gen_extrl_i64_i32(cc_op, o->in1);
+    tcg_gen_extract_i32(cc_op, cc_op, 28, 2);
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
2.13.5
