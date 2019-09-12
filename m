Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D6C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3764206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3764206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8S3K-0007xF-CG
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i8S0g-0005p6-Bn
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i8S0e-0006Jy-SE
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37119 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i8S0e-00061u-H0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B1E781A218D;
 Thu, 12 Sep 2019 18:30:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 866081A1E75;
 Thu, 12 Sep 2019 18:30:46 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 18:30:38 +0200
Message-Id: <1568305840-12550-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 2/4] target/mips: Switch to
 do_transaction_failed() hook
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Switch the MIPS target from the old unassigned_access hook to the new
do_transaction_failed hook.

Unlike the old hook, do_transaction_failed is only ever called from
the TCG memory access paths, so there is no need for the "ignore this
if we're using KVM" hack that we were previously using to work around
the way unassigned_access was called for all kinds of memory accesses
to unassigned physical addresses.

The MIPS target does not ever do direct memory reads by physical
address (via either ldl_phys etc or address_space_ldl etc), so the
only memory accesses this affects are the 'normal' guest loads and
stores, which will be handled by the new hook; their behaviour is
unchanged.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20190802160458.25681-3-peter.maydell@linaro.org>
---
 target/mips/cpu.c       |  2 +-
 target/mips/internal.h  |  8 +++++---
 target/mips/op_helper.c | 24 ++++++++----------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 3ffa342..bbcf7ca 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -202,7 +202,7 @@ static void mips_cpu_class_init(ObjectClass *c, void =
*data)
     cc->gdb_read_register =3D mips_cpu_gdb_read_register;
     cc->gdb_write_register =3D mips_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
-    cc->do_unassigned_access =3D mips_cpu_unassigned_access;
+    cc->do_transaction_failed =3D mips_cpu_do_transaction_failed;
     cc->do_unaligned_access =3D mips_cpu_do_unaligned_access;
     cc->get_phys_page_debug =3D mips_cpu_get_phys_page_debug;
     cc->vmsd =3D &vmstate_mips_cpu;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index ae29b57..685e8d6 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -139,9 +139,11 @@ void r4k_helper_tlbinv(CPUMIPSState *env);
 void r4k_helper_tlbinvf(CPUMIPSState *env);
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
=20
-void mips_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                bool is_write, bool is_exec, int unused,
-                                unsigned size);
+void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                    vaddr addr, unsigned size,
+                                    MMUAccessType access_type,
+                                    int mmu_idx, MemTxAttrs attrs,
+                                    MemTxResult response, uintptr_t reta=
ddr);
 hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong addres=
s,
                                   int rw);
 #endif
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 01b9e78..4de6465 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2668,27 +2668,19 @@ void mips_cpu_do_unaligned_access(CPUState *cs, v=
addr addr,
     do_raise_exception_err(env, excp, error_code, retaddr);
 }
=20
-void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                bool is_write, bool is_exec, int unused,
-                                unsigned size)
+void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                    vaddr addr, unsigned size,
+                                    MMUAccessType access_type,
+                                    int mmu_idx, MemTxAttrs attrs,
+                                    MemTxResult response, uintptr_t reta=
ddr)
 {
     MIPSCPU *cpu =3D MIPS_CPU(cs);
     CPUMIPSState *env =3D &cpu->env;
=20
-    /*
-     * Raising an exception with KVM enabled will crash because it won't=
 be from
-     * the main execution loop so the longjmp won't have a matching setj=
mp.
-     * Until we can trigger a bus error exception through KVM lets just =
ignore
-     * the access.
-     */
-    if (kvm_enabled()) {
-        return;
-    }
-
-    if (is_exec) {
-        raise_exception(env, EXCP_IBE);
+    if (access_type =3D=3D MMU_INST_FETCH) {
+        do_raise_exception(env, EXCP_IBE, retaddr);
     } else {
-        raise_exception(env, EXCP_DBE);
+        do_raise_exception(env, EXCP_DBE, retaddr);
     }
 }
 #endif /* !CONFIG_USER_ONLY */
--=20
2.7.4


