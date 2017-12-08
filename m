Received: from eggs.gnu.org ([2001:4830:134:3::10]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6Z-0002Zt-60
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6Y-0005NV-CY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:27 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:01:57 +0100
Message-Id: <20171208160207.26494-5-david@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 04/14] s390x/tcg: indicate value of
 TODPR in STCKE
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

We were not yet using the value of the TOD Programmable Register.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d13f531c5b..38e1770e5e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3897,7 +3897,10 @@ static ExitStatus op_stcke(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 c1 = tcg_temp_new_i64();
     TCGv_i64 c2 = tcg_temp_new_i64();
+    TCGv_i64 todpr = tcg_temp_new_i64();
     gen_helper_stck(c1, cpu_env);
+    /* 16 bit value store in an uint32_t (only valid bits set) */
+    tcg_gen_ld32u_i64(todpr, cpu_env, offsetof(CPUS390XState, todpr));
     /* Shift the 64-bit value into its place as a zero-extended
        104-bit value.  Note that "bit positions 64-103 are always
        non-zero so that they compare differently to STCK"; we set
@@ -3905,11 +3908,13 @@ static ExitStatus op_stcke(DisasContext *s, DisasOps *o)
     tcg_gen_shli_i64(c2, c1, 56);
     tcg_gen_shri_i64(c1, c1, 8);
     tcg_gen_ori_i64(c2, c2, 0x10000);
+    tcg_gen_or_i64(c2, c2, todpr);
     tcg_gen_qemu_st64(c1, o->in2, get_mem_index(s));
     tcg_gen_addi_i64(o->in2, o->in2, 8);
     tcg_gen_qemu_st64(c2, o->in2, get_mem_index(s));
     tcg_temp_free_i64(c1);
     tcg_temp_free_i64(c2);
+    tcg_temp_free_i64(todpr);
     /* ??? We don't implement clock states.  */
     gen_op_movi_cc(s, 0);
     return NO_EXIT;
-- 
2.14.3
