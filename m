Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3k-0000I0-Bp
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3g-0000bL-7z
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 14:27:55 +0200
Message-Id: <20180830122756.13991-9-david@redhat.com>
In-Reply-To: <20180830122756.13991-1-david@redhat.com>
References: <20180830122756.13991-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/9] s390x/tcg: fix FP register pair checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Valid register pairs are 0/2, 1/3, 4/6, 5/7, 8/10, 9/11, 12/14, 13/15.

R1/R2 always selects the lower number, so the current checks are not
correct as e.g. 2/4 could be selected as a pair.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 1ca6ef45a1..5cc65b0840 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1110,7 +1110,7 @@ typedef struct {
 #define IF_HFP3     0x0004      /* r3 points at fp reg for HFP instructions */
 #define IF_BFP      0x0008      /* binary floating point instruction */
 #define IF_DFP      0x0010      /* decimal floating point instruction */
-#define IF_PRIV     0x0020      /* priviledged instruction */
+#define IF_PRIV     0x0020      /* privileged instruction */
 
 struct DisasInsn {
     unsigned opc:16;
@@ -5985,6 +5985,12 @@ static bool is_afp_reg(int reg)
     return reg % 2 || reg > 6;
 }
 
+static bool is_fp_pair(int reg)
+{
+    /* 0,1,4,5,8,9,12,13: to exclude the others, check for single bit */
+    return !(reg & 0x2);
+}
+
 static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 {
     const DisasInsn *insn;
@@ -6013,7 +6019,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
     /* process flags */
     if (insn->flags) {
-        /* priviledged instruction */
+        /* privileged instruction */
         if ((s->base.tb->flags & FLAG_MASK_PSTATE) && (insn->flags & IF_PRIV)) {
             gen_program_exception(s, PGM_PRIVILEGED);
             return DISAS_NORETURN;
@@ -6067,17 +6073,11 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
                 excp = PGM_SPECIFICATION;
             }
         }
-        if (spec & SPEC_r1_f128) {
-            r = get_field(&f, r1);
-            if (r > 13) {
-                excp = PGM_SPECIFICATION;
-            }
+        if (spec & SPEC_r1_f128 && !is_fp_pair(get_field(&f, r1))) {
+            excp = PGM_SPECIFICATION;
         }
-        if (spec & SPEC_r2_f128) {
-            r = get_field(&f, r2);
-            if (r > 13) {
-                excp = PGM_SPECIFICATION;
-            }
+        if (spec & SPEC_r2_f128 && !is_fp_pair(get_field(&f, r2))) {
+            excp = PGM_SPECIFICATION;
         }
         if (excp) {
             gen_program_exception(s, excp);
-- 
2.17.1
