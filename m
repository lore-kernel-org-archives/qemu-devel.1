Received: from eggs.gnu.org ([2001:4830:134:3::10]:39144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6j-0002yu-IR
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6f-0005QH-LW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:37 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:01:59 +0100
Message-Id: <20171208160207.26494-7-david@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 06/14] s390x/tcg:
 ASI/ASGI/ALSI/ALSGI are atomic with Interlocked-acccess facility 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

The semantics of ASI/ASGI/ALSI/ALSGI changed. Let's implement them just
like LOAD AND ADD, so they are atomic. Emulate old behavior.

This fixes random crashes when booting a Linux kernel compiled for
z196+ with SMP + MTTCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def |  8 ++++----
 target/s390x/translate.c   | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 43ab1963c8..166ee7c80b 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -39,10 +39,10 @@
     C(0xb9d8, AHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, add, adds32)
 /* ADD IMMEDIATE */
     C(0xc209, AFI,     RIL_a, EI,  r1, i2, new, r1_32, add, adds32)
-    C(0xeb6a, ASI,     SIY,   GIE, m1_32s, i2, new, m1_32, add, adds32)
+    D(0xeb6a, ASI,     SIY,   GIE, la1, i2, new, 0, asi, adds32, MO_TESL)
     C(0xecd8, AHIK,    RIE_d, DO,  r3, i2, new, r1_32, add, adds32)
     C(0xc208, AGFI,    RIL_a, EI,  r1, i2, r1, 0, add, adds64)
-    C(0xeb7a, AGSI,    SIY,   GIE, m1_64, i2, new, m1_64, add, adds64)
+    D(0xeb7a, AGSI,    SIY,   GIE, la1, i2, new, 0, asi, adds64, MO_TEQ)
     C(0xecd9, AGHIK,   RIE_d, DO,  r3, i2, r1, 0, add, adds64)
 /* ADD IMMEDIATE HIGH */
     C(0xcc08, AIH,     RIL_a, HW,  r1_sr32, i2, new, r1_32h, add, adds32)
@@ -70,9 +70,9 @@
     C(0xc20b, ALFI,    RIL_a, EI,  r1, i2_32u, new, r1_32, add, addu32)
     C(0xc20a, ALGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, add, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE */
-    C(0xeb6e, ALSI,    SIY,   GIE, m1_32u, i2, new, m1_32, add, addu32)
+    D(0xeb6e, ALSI,    SIY,   GIE, la1, i2, new, 0, asi, addu32, MO_TEUL)
     C(0xecda, ALHSIK,  RIE_d, DO,  r3, i2, new, r1_32, add, addu32)
-    C(0xeb7e, ALGSI,   SIY,   GIE, m1_64, i2, new, m1_64, add, addu64)
+    D(0xeb7e, ALGSI,   SIY,   GIE, la1, i2, new, 0, asi, addu64, MO_TEQ)
     C(0xecdb, ALGHSIK, RIE_d, DO,  r3, i2, r1, 0, add, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE HIGH */
     C(0xcc0a, ALSIH,   RIL_a, HW,  r1_sr32, i2, new, r1_32h, add, addu32)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 08c1ace0d8..7ab8e853ab 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1364,6 +1364,27 @@ static ExitStatus op_addc(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_asi(DisasContext *s, DisasOps *o)
+{
+    o->in1 = tcg_temp_new_i64();
+
+    if (!s390_has_feat(S390_FEAT_STFLE_45)) {
+        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+    } else {
+        /* Perform the atomic addition in memory. */
+        tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
+                                     s->insn->data);
+    }
+
+    /* Recompute also for atomic case: needed for setting CC. */
+    tcg_gen_add_i64(o->out, o->in1, o->in2);
+
+    if (!s390_has_feat(S390_FEAT_STFLE_45)) {
+        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+    }
+    return NO_EXIT;
+}
+
 static ExitStatus op_aeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_aeb(o->out, cpu_env, o->in1, o->in2);
-- 
2.14.3
