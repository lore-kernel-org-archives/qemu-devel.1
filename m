Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71167C06510
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2C62146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2C62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwZc-0000f6-IH
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKc-00026N-Fy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKY-0002G6-J4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwK4-0001q7-T8; Mon, 01 Jul 2019 09:26:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4860C057F2E;
 Mon,  1 Jul 2019 13:26:14 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08B826085B;
 Mon,  1 Jul 2019 13:26:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:01 +0200
Message-Id: <20190701132516.26392-13-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 01 Jul 2019 13:26:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 12/27] target/arm: Move TLB related routines
 to tlb_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These routines are TCG specific.
The arm_deliver_fault() function is only used within the new
helper. Make it static.

Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/Makefile.objs |   1 +
 target/arm/cpu.c         |   6 +-
 target/arm/helper.c      |  53 -----------
 target/arm/internals.h   |   3 -
 target/arm/op_helper.c   | 135 --------------------------
 target/arm/tlb_helper.c  | 200 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 205 insertions(+), 193 deletions(-)
 create mode 100644 target/arm/tlb_helper.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 3fcda66132..5c154f01c5 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -32,6 +32,7 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
=20
+obj-y +=3D tlb_helper.o
 obj-y +=3D translate.o op_helper.o
 obj-y +=3D crypto_helper.o
 obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1f73631bac..f21261c8ff 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2566,8 +2566,6 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
     cc->gdb_write_register =3D arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->do_interrupt =3D arm_cpu_do_interrupt;
-    cc->do_unaligned_access =3D arm_cpu_do_unaligned_access;
-    cc->do_transaction_failed =3D arm_cpu_do_transaction_failed;
     cc->get_phys_page_attrs_debug =3D arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs =3D arm_asidx_from_attrs;
     cc->vmsd =3D &vmstate_arm_cpu;
@@ -2590,6 +2588,10 @@ static void arm_cpu_class_init(ObjectClass *oc, vo=
id *data)
 #ifdef CONFIG_TCG
     cc->tcg_initialize =3D arm_translate_init;
     cc->tlb_fill =3D arm_cpu_tlb_fill;
+#if !defined(CONFIG_USER_ONLY)
+    cc->do_unaligned_access =3D arm_cpu_do_unaligned_access;
+    cc->do_transaction_failed =3D arm_cpu_do_transaction_failed;
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 #endif
 }
=20
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 063f4778e0..4ef908c611 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13244,59 +13244,6 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32=
_t addr, uint32_t op)
=20
 #endif
=20
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-
-#ifdef CONFIG_USER_ONLY
-    cpu->env.exception.vaddress =3D address;
-    if (access_type =3D=3D MMU_INST_FETCH) {
-        cs->exception_index =3D EXCP_PREFETCH_ABORT;
-    } else {
-        cs->exception_index =3D EXCP_DATA_ABORT;
-    }
-    cpu_loop_exit_restore(cs, retaddr);
-#else
-    hwaddr phys_addr;
-    target_ulong page_size;
-    int prot, ret;
-    MemTxAttrs attrs =3D {};
-    ARMMMUFaultInfo fi =3D {};
-
-    /*
-     * Walk the page table and (if the mapping exists) add the page
-     * to the TLB.  On success, return true.  Otherwise, if probing,
-     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
-     * register format, and signal the fault.
-     */
-    ret =3D get_phys_addr(&cpu->env, address, access_type,
-                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL=
);
-    if (likely(!ret)) {
-        /*
-         * Map a single [sub]page. Regions smaller than our declared
-         * target page size are handled specially, so for those we
-         * pass in the exact addresses.
-         */
-        if (page_size >=3D TARGET_PAGE_SIZE) {
-            phys_addr &=3D TARGET_PAGE_MASK;
-            address &=3D TARGET_PAGE_MASK;
-        }
-        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
-                                prot, mmu_idx, page_size);
-        return true;
-    } else if (probe) {
-        return false;
-    } else {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr, true);
-        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
-    }
-#endif
-}
-
 /* Note that signed overflow is undefined in C.  The following routines =
are
    careful to use unsigned types where modulo arithmetic is required.
    Failure to do so _will_ break on newer gcc.  */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ff5ab0328e..46a1313d69 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -765,9 +765,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
=20
-void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
-                       int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
-
 /* Return true if the stage 1 translation regime is using LPAE format pa=
ge
  * tables */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx=
);
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 7c835d3ce7..9850993c11 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -88,141 +88,6 @@ uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def=
, void *vn,
     return val;
 }
=20
-#if !defined(CONFIG_USER_ONLY)
-
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
-                                            unsigned int target_el,
-                                            bool same_el, bool ea,
-                                            bool s1ptw, bool is_write,
-                                            int fsc)
-{
-    uint32_t syn;
-
-    /*
-     * ISV is only set for data aborts routed to EL2 and
-     * never for stage-1 page table walks faulting on stage 2.
-     *
-     * Furthermore, ISV is only set for certain kinds of load/stores.
-     * If the template syndrome does not have ISV set, we should leave
-     * it cleared.
-     *
-     * See ARMv8 specs, D7-1974:
-     * ISS encoding for an exception from a Data Abort, the
-     * ISV field.
-     */
-    if (!(template_syn & ARM_EL_ISV) || target_el !=3D 2 || s1ptw) {
-        syn =3D syn_data_abort_no_iss(same_el,
-                                    ea, 0, s1ptw, is_write, fsc);
-    } else {
-        /*
-         * Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the templ=
ate
-         * syndrome created at translation time.
-         * Now we create the runtime syndrome with the remaining fields.
-         */
-        syn =3D syn_data_abort_with_iss(same_el,
-                                      0, 0, 0, 0, 0,
-                                      ea, 0, s1ptw, is_write, fsc,
-                                      false);
-        /* Merge the runtime syndrome with the template syndrome.  */
-        syn |=3D template_syn;
-    }
-    return syn;
-}
-
-void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
-                       int mmu_idx, ARMMMUFaultInfo *fi)
-{
-    CPUARMState *env =3D &cpu->env;
-    int target_el;
-    bool same_el;
-    uint32_t syn, exc, fsr, fsc;
-    ARMMMUIdx arm_mmu_idx =3D core_to_arm_mmu_idx(env, mmu_idx);
-
-    target_el =3D exception_target_el(env);
-    if (fi->stage2) {
-        target_el =3D 2;
-        env->cp15.hpfar_el2 =3D extract64(fi->s2addr, 12, 47) << 4;
-    }
-    same_el =3D (arm_current_el(env) =3D=3D target_el);
-
-    if (target_el =3D=3D 2 || arm_el_is_aa64(env, target_el) ||
-        arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        /*
-         * LPAE format fault status register : bottom 6 bits are
-         * status code in the same form as needed for syndrome
-         */
-        fsr =3D arm_fi_to_lfsc(fi);
-        fsc =3D extract32(fsr, 0, 6);
-    } else {
-        fsr =3D arm_fi_to_sfsc(fi);
-        /*
-         * Short format FSR : this fault will never actually be reported
-         * to an EL that uses a syndrome register. Use a (currently)
-         * reserved FSR code in case the constructed syndrome does leak
-         * into the guest somehow.
-         */
-        fsc =3D 0x3f;
-    }
-
-    if (access_type =3D=3D MMU_INST_FETCH) {
-        syn =3D syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
-        exc =3D EXCP_PREFETCH_ABORT;
-    } else {
-        syn =3D merge_syn_data_abort(env->exception.syndrome, target_el,
-                                   same_el, fi->ea, fi->s1ptw,
-                                   access_type =3D=3D MMU_DATA_STORE,
-                                   fsc);
-        if (access_type =3D=3D MMU_DATA_STORE
-            && arm_feature(env, ARM_FEATURE_V6)) {
-            fsr |=3D (1 << 11);
-        }
-        exc =3D EXCP_DATA_ABORT;
-    }
-
-    env->exception.vaddress =3D addr;
-    env->exception.fsr =3D fsr;
-    raise_exception(env, exc, syn, target_el);
-}
-
-/* Raise a data fault alignment exception for the specified virtual addr=
ess */
-void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
-                                 MMUAccessType access_type,
-                                 int mmu_idx, uintptr_t retaddr)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    ARMMMUFaultInfo fi =3D {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.type =3D ARMFault_Alignment;
-    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
-}
-
-/*
- * arm_cpu_do_transaction_failed: handle a memory system error response
- * (eg "no device/memory present at address") by raising an external abo=
rt
- * exception
- */
-void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-                                   vaddr addr, unsigned size,
-                                   MMUAccessType access_type,
-                                   int mmu_idx, MemTxAttrs attrs,
-                                   MemTxResult response, uintptr_t retad=
dr)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    ARMMMUFaultInfo fi =3D {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.ea =3D arm_extabort_type(response);
-    fi.type =3D ARMFault_SyncExternal;
-    arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
-}
-
-#endif /* !defined(CONFIG_USER_ONLY) */
-
 void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
 {
     /*
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
new file mode 100644
index 0000000000..5feb312941
--- /dev/null
+++ b/target/arm/tlb_helper.c
@@ -0,0 +1,200 @@
+/*
+ * ARM TLB (Translation lookaside buffer) helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "exec/exec-all.h"
+
+#if !defined(CONFIG_USER_ONLY)
+
+static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
+                                            unsigned int target_el,
+                                            bool same_el, bool ea,
+                                            bool s1ptw, bool is_write,
+                                            int fsc)
+{
+    uint32_t syn;
+
+    /*
+     * ISV is only set for data aborts routed to EL2 and
+     * never for stage-1 page table walks faulting on stage 2.
+     *
+     * Furthermore, ISV is only set for certain kinds of load/stores.
+     * If the template syndrome does not have ISV set, we should leave
+     * it cleared.
+     *
+     * See ARMv8 specs, D7-1974:
+     * ISS encoding for an exception from a Data Abort, the
+     * ISV field.
+     */
+    if (!(template_syn & ARM_EL_ISV) || target_el !=3D 2 || s1ptw) {
+        syn =3D syn_data_abort_no_iss(same_el,
+                                    ea, 0, s1ptw, is_write, fsc);
+    } else {
+        /*
+         * Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the templ=
ate
+         * syndrome created at translation time.
+         * Now we create the runtime syndrome with the remaining fields.
+         */
+        syn =3D syn_data_abort_with_iss(same_el,
+                                      0, 0, 0, 0, 0,
+                                      ea, 0, s1ptw, is_write, fsc,
+                                      false);
+        /* Merge the runtime syndrome with the template syndrome.  */
+        syn |=3D template_syn;
+    }
+    return syn;
+}
+
+static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
+                                            MMUAccessType access_type,
+                                            int mmu_idx, ARMMMUFaultInfo=
 *fi)
+{
+    CPUARMState *env =3D &cpu->env;
+    int target_el;
+    bool same_el;
+    uint32_t syn, exc, fsr, fsc;
+    ARMMMUIdx arm_mmu_idx =3D core_to_arm_mmu_idx(env, mmu_idx);
+
+    target_el =3D exception_target_el(env);
+    if (fi->stage2) {
+        target_el =3D 2;
+        env->cp15.hpfar_el2 =3D extract64(fi->s2addr, 12, 47) << 4;
+    }
+    same_el =3D (arm_current_el(env) =3D=3D target_el);
+
+    if (target_el =3D=3D 2 || arm_el_is_aa64(env, target_el) ||
+        arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
+        /*
+         * LPAE format fault status register : bottom 6 bits are
+         * status code in the same form as needed for syndrome
+         */
+        fsr =3D arm_fi_to_lfsc(fi);
+        fsc =3D extract32(fsr, 0, 6);
+    } else {
+        fsr =3D arm_fi_to_sfsc(fi);
+        /*
+         * Short format FSR : this fault will never actually be reported
+         * to an EL that uses a syndrome register. Use a (currently)
+         * reserved FSR code in case the constructed syndrome does leak
+         * into the guest somehow.
+         */
+        fsc =3D 0x3f;
+    }
+
+    if (access_type =3D=3D MMU_INST_FETCH) {
+        syn =3D syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
+        exc =3D EXCP_PREFETCH_ABORT;
+    } else {
+        syn =3D merge_syn_data_abort(env->exception.syndrome, target_el,
+                                   same_el, fi->ea, fi->s1ptw,
+                                   access_type =3D=3D MMU_DATA_STORE,
+                                   fsc);
+        if (access_type =3D=3D MMU_DATA_STORE
+            && arm_feature(env, ARM_FEATURE_V6)) {
+            fsr |=3D (1 << 11);
+        }
+        exc =3D EXCP_DATA_ABORT;
+    }
+
+    env->exception.vaddress =3D addr;
+    env->exception.fsr =3D fsr;
+    raise_exception(env, exc, syn, target_el);
+}
+
+/* Raise a data fault alignment exception for the specified virtual addr=
ess */
+void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    ARMMMUFaultInfo fi =3D {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.type =3D ARMFault_Alignment;
+    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
+}
+
+/*
+ * arm_cpu_do_transaction_failed: handle a memory system error response
+ * (eg "no device/memory present at address") by raising an external abo=
rt
+ * exception
+ */
+void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr addr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retad=
dr)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    ARMMMUFaultInfo fi =3D {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.ea =3D arm_extabort_type(response);
+    fi.type =3D ARMFault_SyncExternal;
+    arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
+}
+
+#endif /* !defined(CONFIG_USER_ONLY) */
+
+bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+#ifdef CONFIG_USER_ONLY
+    cpu->env.exception.vaddress =3D address;
+    if (access_type =3D=3D MMU_INST_FETCH) {
+        cs->exception_index =3D EXCP_PREFETCH_ABORT;
+    } else {
+        cs->exception_index =3D EXCP_DATA_ABORT;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    hwaddr phys_addr;
+    target_ulong page_size;
+    int prot, ret;
+    MemTxAttrs attrs =3D {};
+    ARMMMUFaultInfo fi =3D {};
+
+    /*
+     * Walk the page table and (if the mapping exists) add the page
+     * to the TLB.  On success, return true.  Otherwise, if probing,
+     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
+     * register format, and signal the fault.
+     */
+    ret =3D get_phys_addr(&cpu->env, address, access_type,
+                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
+                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL=
);
+    if (likely(!ret)) {
+        /*
+         * Map a single [sub]page. Regions smaller than our declared
+         * target page size are handled specially, so for those we
+         * pass in the exact addresses.
+         */
+        if (page_size >=3D TARGET_PAGE_SIZE) {
+            phys_addr &=3D TARGET_PAGE_MASK;
+            address &=3D TARGET_PAGE_MASK;
+        }
+        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
+                                prot, mmu_idx, page_size);
+        return true;
+    } else if (probe) {
+        return false;
+    } else {
+        /* now we have a real cpu fault */
+        cpu_restore_state(cs, retaddr, true);
+        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
+    }
+#endif
+}
--=20
2.20.1


