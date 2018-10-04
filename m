Received: from eggs.gnu.org ([2001:4830:134:3::10]:53637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aF-0000bz-Gq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aC-0005q4-9H
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:56 +0200
Message-Id: <20181004152857.14525-15-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] s390x/tcg: refactor specification checking
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

We can fit this nicely into less LOC, without harming readability.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f6813d0674..18861cd186 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6092,34 +6092,12 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
     /* Check for insn specification exceptions.  */
     if (insn->spec) {
-        int spec = insn->spec, excp = 0, r;
-
-        if (spec & SPEC_r1_even) {
-            r = get_field(&f, r1);
-            if (r & 1) {
-                excp = PGM_SPECIFICATION;
-            }
-        }
-        if (spec & SPEC_r2_even) {
-            r = get_field(&f, r2);
-            if (r & 1) {
-                excp = PGM_SPECIFICATION;
-            }
-        }
-        if (spec & SPEC_r3_even) {
-            r = get_field(&f, r3);
-            if (r & 1) {
-                excp = PGM_SPECIFICATION;
-            }
-        }
-        if (spec & SPEC_r1_f128 && !is_fp_pair(get_field(&f, r1))) {
-            excp = PGM_SPECIFICATION;
-        }
-        if (spec & SPEC_r2_f128 && !is_fp_pair(get_field(&f, r2))) {
-            excp = PGM_SPECIFICATION;
-        }
-        if (excp) {
-            gen_program_exception(s, excp);
+        if ((insn->spec & SPEC_r1_even && get_field(&f, r1) & 1) ||
+            (insn->spec & SPEC_r2_even && get_field(&f, r2) & 1) ||
+            (insn->spec & SPEC_r3_even && get_field(&f, r3) & 1) ||
+            (insn->spec & SPEC_r1_f128 && !is_fp_pair(get_field(&f, r1))) ||
+            (insn->spec & SPEC_r2_f128 && !is_fp_pair(get_field(&f, r2)))) {
+            gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
     }
-- 
2.14.4
