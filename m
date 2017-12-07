Received: from eggs.gnu.org ([2001:4830:134:3::10]:39375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzR4-0004PD-QQ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzQz-000716-VN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:10 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 17:53:46 +0100
Message-Id: <20171207165355.7559-2-david@redhat.com>
In-Reply-To: <20171207165355.7559-1-david@redhat.com>
References: <20171207165355.7559-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 01/10] s390x/tcg: ASI/ASGI are
 atomic with interlocked-acccess facility 1
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

The semantics of these operations changed. Let's implement them just
like LOAD AND ADD, so they are atomic.

This fixes random crashes when booting a Linux kernel compiled for
z196+ with SMP + MTTCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def |  4 ++--
 target/s390x/translate.c   | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 43ab1963c8..57f2e5133f 100644
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
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5e051fdd03..79d2ee650c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1364,6 +1364,17 @@ static ExitStatus op_addc(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_asi(DisasContext *s, DisasOps *o)
+{
+    o->in1 = tcg_temp_new_i64();
+    /* Perform the atomic addition in memory. */
+    tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
+                                 s->insn->data);
+    /* However, we need to recompute the addition for setting CC.  */
+    tcg_gen_add_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_aeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_aeb(o->out, cpu_env, o->in1, o->in2);
-- 
2.14.3
