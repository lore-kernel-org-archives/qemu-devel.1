Received: from eggs.gnu.org ([2001:4830:134:3::10]:42266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3k-0000Hy-9v
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3g-0000bm-Ai
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 14:27:56 +0200
Message-Id: <20180830122756.13991-10-david@redhat.com>
In-Reply-To: <20180830122756.13991-1-david@redhat.com>
References: <20180830122756.13991-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 9/9] s390x/tcg: refactor specification
 checking
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

We can fit this nicely into less LOC, without harming readability.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5cc65b0840..6c6db47a82 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6053,34 +6053,12 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
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
2.17.1
