Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIO7-0000Ww-Tb
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIO6-0000ex-OK
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNIO6-0000ei-F5
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 20 Jun 2017 14:35:53 +0200
Message-Id: <20170620123553.16186-4-david@redhat.com>
In-Reply-To: <20170620123553.16186-1-david@redhat.com>
References: <20170620123553.16186-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/3] target/s390x: Implement idte instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

Let's keep it very simple for now and flush the complete tlb,
we currently can't find the right entries in our tlb, we would have
to store the used tables for each element.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 11 ++++++++++
 4 files changed, 65 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 69249a5..d219ae4 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -130,6 +130,7 @@ DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
 DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
 DEF_HELPER_FLAGS_2(sacf, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d089707..82c5d53 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -900,6 +900,8 @@
     C(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0)
 /* INSERT STORAGE KEY EXTENDED */
     C(0xb229, ISKE,    RRE,   Z,   0, r2_o, new, r1_8, iske, 0)
+/* INVALIDATE DAT TABLE ENTRY */
+    C(0xb98e, IPDE,    RRF_b, Z,   r1_o, r2_o, 0, 0, idte, 0)
 /* INVALIDATE PAGE TABLE ENTRY */
     C(0xb221, IPTE,    RRF_a, Z,   r1_o, r2_o, 0, 0, ipte, 0)
 /* LOAD CONTROL */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bce7750..0e4f473 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1539,6 +1539,57 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint64_t a2)
     return cc;
 }
 
+void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
+{
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+    const uintptr_t ra = GETPC();
+    uint64_t table, entry, raddr;
+    uint16_t entries, i, index = 0;
+
+    if (r2 & 0xff000ul) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+    }
+
+    if (!(r1 & 0x800u)) {
+        /* invalidation-and-clearing operation */
+        table = r1 & _ASCE_ORIGIN;
+        entries = (r2 & 0x7ff) + 1;
+
+        switch (r1 & _ASCE_TYPE_MASK) {
+        case _ASCE_TYPE_REGION1:
+            index = (r2 >> 53) & 0x7ff;
+            break;
+        case _ASCE_TYPE_REGION2:
+            index = (r2 >> 42) & 0x7ff;
+            break;
+        case _ASCE_TYPE_REGION3:
+            index = (r2 >> 31) & 0x7ff;
+            break;
+        case _ASCE_TYPE_SEGMENT:
+            index = (r2 >> 20) & 0x7ff;
+            break;
+        }
+        for (i = 0; i < entries; i++) {
+            /* addresses are not wrapped in 24/31bit mode but table index is */
+            raddr = table + ((index + i) & 0x7ff) * sizeof(entry);
+            entry = ldq_phys(cs->as, raddr);
+            if (!(entry & _REGION_ENTRY_INV)) {
+                /* we are allowed to not store if already invalid */
+                entry |= _REGION_ENTRY_INV;
+                stq_phys(cs->as, raddr, entry);
+            }
+        }
+    }
+
+    /* We simply flush the complete tlb, therefore we can ignore r3. */
+    if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING) && (m4 & 1)) {
+        tlb_flush(cs);
+    } else {
+        tlb_flush_all_cpus_synced(cs);
+    }
+}
+
 /* invalidate pte */
 void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
                   uint32_t m4)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8c055b7..3dc40bb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2407,6 +2407,17 @@ static ExitStatus op_ipm(DisasContext *s, DisasOps *o)
 }
 
 #ifndef CONFIG_USER_ONLY
+static ExitStatus op_idte(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 m4;
+
+    check_privileged(s);
+    m4 = tcg_const_i32(get_field(s->fields, m4));
+    gen_helper_idte(cpu_env, o->in1, o->in2, m4);
+    tcg_temp_free_i32(m4);
+    return NO_EXIT;
+}
+
 static ExitStatus op_ipte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
-- 
2.9.4
