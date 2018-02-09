Received: from eggs.gnu.org ([2001:4830:134:3::10]:43737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wg-0002Me-KW
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wf-0006L0-0p
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:14 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:16 +0100
Message-Id: <20180209092524.31348-22-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

On s390x, pci support is implemented via a set of instructions
(no mmio). Unfortunately, none of them are documented in the
PoP; the code is based upon the existing implementation for KVM
and the Linux zpci driver.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      |   9 ++++
 target/s390x/insn-data.def |  13 ++++++
 target/s390x/misc_helper.c |  89 +++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   | 102 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 213 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 05d52ff309..59cba86a27 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -173,4 +173,13 @@ DEF_HELPER_3(stsch, void, env, i64, i64)
 DEF_HELPER_2(tpi, i32, env, i64)
 DEF_HELPER_3(tsch, void, env, i64, i64)
 DEF_HELPER_2(chsc, void, env, i64)
+
+DEF_HELPER_2(clp, void, env, i32)
+DEF_HELPER_3(pcilg, void, env, i32, i32)
+DEF_HELPER_3(pcistg, void, env, i32, i32)
+DEF_HELPER_4(stpcifc, void, env, i32, i64, i32)
+DEF_HELPER_3(sic, void, env, i64, i64)
+DEF_HELPER_3(rpcit, void, env, i32, i32)
+DEF_HELPER_5(pcistb, void, env, i32, i32, i64, i32)
+DEF_HELPER_4(mpcifc, void, env, i32, i64, i32)
 #endif
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c06c3884c0..621e10d615 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1068,4 +1068,17 @@
     /* ??? Not listed in PoO ninth edition, but there's a linux driver that
        uses it: "A CHSC subchannel is usually present on LPAR only."  */
     C(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0)
+
+/* zPCI Instructions */
+    /* None of these instructions are documented in the PoP, so this is all
+       based upon target/s390x/kvm.c and Linux code and likely incomplete */
+    C(0xebd0, PCISTB, RSY_a, PCI, la2, 0, 0, 0, pcistb, 0)
+    C(0xebd1, SIC, RSY_a, AIS, r1, r3, 0, 0, sic, 0)
+    C(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0)
+    C(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0)
+    C(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0)
+    C(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0)
+    C(0xe3d0, MPCIFC, RXY_a, PCI, la2, 0, 0, 0, mpcifc, 0)
+    C(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0)
+
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 45cab8c463..e0b23c1fd1 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -38,6 +38,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
+#include "hw/s390x/s390-pci-inst.h"
 #include "hw/boards.h"
 #endif
 
@@ -632,3 +633,91 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
     env->regs[0] = deposit64(env->regs[0], 0, 8, (max_bytes / 8) - 1);
     return count_bytes >= max_bytes ? 0 : 3;
 }
+
+#ifndef CONFIG_USER_ONLY
+/*
+ * Note: we ignore any return code of the functions called for the pci
+ * instructions, as the only time they return !0 is when the stub is
+ * called, and in that case we didn't even offer the zpci facility.
+ * The only exception is SIC, where program checks need to be handled
+ * by the caller.
+ */
+void HELPER(clp)(CPUS390XState *env, uint32_t r2)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    clp_service_call(cpu, r2, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(pcilg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    pcilg_service_call(cpu, r1, r2, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(pcistg)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    pcistg_service_call(cpu, r1, r2, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(stpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
+                     uint32_t ar)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    stpcifc_service_call(cpu, r1, fiba, ar, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
+{
+    int r;
+
+    qemu_mutex_lock_iothread();
+    r = css_do_sic(env, (r3 >> 27) & 0x7, r1 & 0xffff);
+    qemu_mutex_unlock_iothread();
+    /* css_do_sic() may actually return a PGM_xxx value to inject */
+    if (r) {
+        s390_program_interrupt(env, -r, 4, GETPC());
+    }
+}
+
+void HELPER(rpcit)(CPUS390XState *env, uint32_t r1, uint32_t r2)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    rpcit_service_call(cpu, r1, r2, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(pcistb)(CPUS390XState *env, uint32_t r1, uint32_t r3,
+                    uint64_t gaddr, uint32_t ar)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    pcistb_service_call(cpu, r1, r3, gaddr, ar, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
+void HELPER(mpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
+                    uint32_t ar)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    mpcifc_service_call(cpu, r1, fiba, ar, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+#endif
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 81abe40673..b470d691d3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4785,6 +4785,106 @@ static ExitStatus op_zero2(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+#ifndef CONFIG_USER_ONLY
+static ExitStatus op_clp(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+
+    check_privileged(s);
+    gen_helper_clp(cpu_env, r2);
+    tcg_temp_free_i32(r2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_pcilg(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+
+    check_privileged(s);
+    gen_helper_pcilg(cpu_env, r1, r2);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_pcistg(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+
+    check_privileged(s);
+    gen_helper_pcistg(cpu_env, r1, r2);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_stpcifc(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
+
+    check_privileged(s);
+    gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
+    tcg_temp_free_i32(ar);
+    tcg_temp_free_i32(r1);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_sic(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_sic(cpu_env, o->in1, o->in2);
+    return NO_EXIT;
+}
+
+static ExitStatus op_rpcit(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
+
+    check_privileged(s);
+    gen_helper_rpcit(cpu_env, r1, r2);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_pcistb(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
+    TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
+
+    check_privileged(s);
+    gen_helper_pcistb(cpu_env, r1, r3, o->addr1, ar);
+    tcg_temp_free_i32(ar);
+    tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r3);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
+static ExitStatus op_mpcifc(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
+
+    check_privileged(s);
+    gen_helper_mpcifc(cpu_env, r1, o->addr1, ar);
+    tcg_temp_free_i32(ar);
+    tcg_temp_free_i32(r1);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+#endif
+
 /* ====================================================================== */
 /* The "Cc OUTput" generators.  Given the generated output (and in some cases
    the original inputs), update the various cc data structures in order to
@@ -5716,6 +5816,8 @@ enum DisasInsnEnum {
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
+#define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
+#define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
-- 
2.13.6
