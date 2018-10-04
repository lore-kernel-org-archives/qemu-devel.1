Received: from eggs.gnu.org ([2001:4830:134:3::10]:53645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aG-0000ca-1J
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aA-0005o1-76
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:55 +0200
Message-Id: <20181004152857.14525-14-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] s390x/tcg: fix FP register pair checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Valid register pairs are 0/2, 1/3, 4/6, 5/7, 8/10, 9/11, 12/14, 13/15.

R1/R2 always selects the lower number, so the current checks are not
correct as e.g. 2/4 could be selected as a pair.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-9-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f93ad20951..f6813d0674 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6024,6 +6024,12 @@ static bool is_afp_reg(int reg)
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
@@ -6106,17 +6112,11 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
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
2.14.4
