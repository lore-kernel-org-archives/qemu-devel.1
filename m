Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10242C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E4821473
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E4821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcBCy-0007K9-66
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 12:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAr8-00045p-01
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAr6-00014R-1n
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAr0-0000jz-Cw; Sat, 15 Jun 2019 11:44:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06BEF85539;
 Sat, 15 Jun 2019 15:44:29 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A91F1001B05;
 Sat, 15 Jun 2019 15:44:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:44 +0200
Message-Id: <20190615154352.26824-16-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Sat, 15 Jun 2019 15:44:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 15/23] target/arm: Make ARM TLB filling
 routine static
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Ortiz <sameo@linux.intel.com>

It's only used in op_helper.c, it does not need to be exported and
moreover it should only be build when TCG is enabled.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c    | 53 ---------------------------------------
 target/arm/internals.h |  2 ++
 target/arm/op_helper.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 673ada1e86..a4af02c984 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10621,59 +10621,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUStat=
e *cs, vaddr addr,
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
index fe9e4665e2..37ca493635 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -761,9 +761,11 @@ static inline bool arm_extabort_type(MemTxResult res=
ult)
     return result !=3D MEMTX_DECODE_ERROR;
 }
=20
+#ifdef CONFIG_TCG
 bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
+#endif
=20
 void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
                        int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 29b56039e5..e43c99ebf0 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -179,6 +179,62 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUA=
ccessType access_type,
     env->exception.fsr =3D fsr;
     raise_exception(env, exc, syn, target_el);
 }
+#endif
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
+
+#if !defined(CONFIG_USER_ONLY)
=20
 /* Raise a data fault alignment exception for the specified virtual addr=
ess */
 void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
--=20
2.20.1


