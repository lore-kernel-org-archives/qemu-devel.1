Received: from eggs.gnu.org ([2001:4830:134:3::10]:52898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duJUS-0005u3-D8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1duJUQ-0004W8-RN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:27:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1duJUQ-0004UJ-Iu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:27:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Sep 2017 16:26:54 +0200
Message-Id: <20170919142654.16369-4-david@redhat.com>
In-Reply-To: <20170919142654.16369-1-david@redhat.com>
References: <20170919142654.16369-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] s390x/tcg: add basic MSA features
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

The STFLE bits for the MSA (extension) facilities simply indicate that
the respective instructions can be executed. The QUERY subfunction can then
be used to identify which features exactly are available.

Availability of subfunctions can also vary on real hardware. For now, we
simply implement a CPU model without any available subfunctions except
QUERY (which is always around).

As all MSA functions behave quite similarly, we can use one translation
handler for now. Prepare the code for implementation of actual subfunctions.

At least MSA is helpful for now, as older Linux kernels require this
facility when compiled for a z9 model. Allow to enable the facilities
for the qemu cpu model.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs   |  2 +-
 target/s390x/cpu_models.c    |  4 +++
 target/s390x/crypto_helper.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/helper.h        |  1 +
 target/s390x/insn-data.def   | 13 +++++++++
 target/s390x/translate.c     | 56 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 target/s390x/crypto_helper.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 9615256d81..c88ac81e84 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y += cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.o
 obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
-obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o
+obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 5169379db5..1051a16ece 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -825,6 +825,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_STFLE,
         S390_FEAT_EXTENDED_IMMEDIATE,
         S390_FEAT_EXTENDED_TRANSLATION_2,
+        S390_FEAT_MSA,
         S390_FEAT_EXTENDED_TRANSLATION_3,
         S390_FEAT_LONG_DISPLACEMENT,
         S390_FEAT_LONG_DISPLACEMENT_FAST,
@@ -841,6 +842,9 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_STFLE_49,
         S390_FEAT_LOCAL_TLB_CLEARING,
         S390_FEAT_STFLE_53,
+        S390_FEAT_MSA_EXT_5,
+        S390_FEAT_MSA_EXT_3,
+        S390_FEAT_MSA_EXT_4,
     };
     int i;
 
diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
new file mode 100644
index 0000000000..5b210b4080
--- /dev/null
+++ b/target/s390x/crypto_helper.c
@@ -0,0 +1,65 @@
+/*
+ *  s390x crypto helpers
+ *
+ *  Copyright (c) 2017 Red Hat Inc
+ *
+ *  Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "internal.h"
+#include "exec/helper-proto.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+
+uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
+                     uint32_t type)
+{
+    const uintptr_t ra = GETPC();
+    const uint8_t mod = env->regs[0] & 0x80ULL;
+    const uint8_t fc = env->regs[0] & 0x7fULL;
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+    uint8_t subfunc[16] = { 0 };
+    uint64_t param_addr;
+    int i;
+
+    switch (type) {
+    case S390_FEAT_TYPE_KMAC:
+    case S390_FEAT_TYPE_KIMD:
+    case S390_FEAT_TYPE_KLMD:
+    case S390_FEAT_TYPE_PCKMO:
+    case S390_FEAT_TYPE_PCC:
+        if (mod) {
+            cpu_restore_state(cs, ra);
+            program_interrupt(env, PGM_SPECIFICATION, 4);
+            return 0;
+        }
+        break;
+    }
+
+    s390_get_feat_block(type, subfunc);
+    if (fc >= 128 || !test_be_bit(fc, subfunc)) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIFICATION, 4);
+        return 0;
+    }
+
+    switch (fc) {
+    case 0: /* query subfunction */
+        for (i = 0; i < 16; i++) {
+            param_addr = wrap_address(env, env->regs[1] + i);
+            cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
+        }
+        break;
+    default:
+        /* we don't implement any other subfunction yet */
+        g_assert_not_reached();
+    }
+
+    return 0;
+}
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 4b0290774e..75ba04fc15 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -115,6 +115,7 @@ DEF_HELPER_4(cu21, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu24, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
 DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
+DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 84233a456d..d09f2ed538 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -941,6 +941,19 @@
 /* UNPACK UNICODE */
     C(0xe200, UNPKU,   SS_a,  E2,  la1, a2, 0, 0, unpku, 0)
 
+/* MSA Instructions */
+    D(0xb91e, KMAC,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMAC)
+    D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCKMO)
+    D(0xb92a, KMF,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMF)
+    D(0xb92b, KMO,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMO)
+    D(0xb92c, PCC,     RRE,   MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PCC)
+    D(0xb92d, KMCTR,   RRF_b, MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMCTR)
+    D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
+    D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
+    D(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO)
+    D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
+    D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 59fde44d55..78ffd8ff24 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2422,6 +2422,58 @@ static ExitStatus op_iske(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static ExitStatus op_msa(DisasContext *s, DisasOps *o)
+{
+    int r1 = have_field(s->fields, r1) ? get_field(s->fields, r1) : 0;
+    int r2 = have_field(s->fields, r2) ? get_field(s->fields, r2) : 0;
+    int r3 = have_field(s->fields, r3) ? get_field(s->fields, r3) : 0;
+    TCGv_i32 t_r1, t_r2, t_r3, type;
+
+    switch (s->insn->data) {
+    case S390_FEAT_TYPE_KMCTR:
+        if (r3 & 1 || !r3) {
+            gen_program_exception(s, PGM_SPECIFICATION);
+            return EXIT_NORETURN;
+        }
+        /* FALL THROUGH */
+    case S390_FEAT_TYPE_PPNO:
+    case S390_FEAT_TYPE_KMF:
+    case S390_FEAT_TYPE_KMC:
+    case S390_FEAT_TYPE_KMO:
+    case S390_FEAT_TYPE_KM:
+        if (r1 & 1 || !r1) {
+            gen_program_exception(s, PGM_SPECIFICATION);
+            return EXIT_NORETURN;
+        }
+        /* FALL THROUGH */
+    case S390_FEAT_TYPE_KMAC:
+    case S390_FEAT_TYPE_KIMD:
+    case S390_FEAT_TYPE_KLMD:
+        if (r2 & 1 || !r2) {
+            gen_program_exception(s, PGM_SPECIFICATION);
+            return EXIT_NORETURN;
+        }
+        /* FALL THROUGH */
+    case S390_FEAT_TYPE_PCKMO:
+    case S390_FEAT_TYPE_PCC:
+        break;
+    default:
+        g_assert_not_reached();
+    };
+
+    t_r1 = tcg_const_i32(r1);
+    t_r2 = tcg_const_i32(r2);
+    t_r3 = tcg_const_i32(r3);
+    type = tcg_const_i32(s->insn->data);
+    gen_helper_msa(cc_op, cpu_env, t_r1, t_r2, t_r3, type);
+    set_cc_static(s);
+    tcg_temp_free_i32(t_r1);
+    tcg_temp_free_i32(t_r2);
+    tcg_temp_free_i32(t_r3);
+    tcg_temp_free_i32(type);
+    return NO_EXIT;
+}
+
 static ExitStatus op_keb(DisasContext *s, DisasOps *o)
 {
     gen_helper_keb(cc_op, cpu_env, o->in1, o->in2);
@@ -5505,6 +5557,10 @@ enum DisasInsnEnum {
 #define FAC_PPA         S390_FEAT_STFLE_49 /* processor-assist */
 #define FAC_LZRB        S390_FEAT_STFLE_53 /* load-and-zero-rightmost-byte */
 #define FAC_ETF3        S390_FEAT_EXTENDED_TRANSLATION_3
+#define FAC_MSA         S390_FEAT_MSA /* message-security-assist facility */
+#define FAC_MSA3        S390_FEAT_MSA_EXT_3 /* msa-extension-3 facility */
+#define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
+#define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
-- 
2.13.5
