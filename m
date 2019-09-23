Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC9C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B1C2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B1C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJwE-00032k-Tg
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iCJun-0001bW-2t
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iCJul-0005s7-HF
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:41:48 -0400
Received: from ozlabs.ru ([107.173.13.209]:44440)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iCJul-0005ll-Bn; Mon, 23 Sep 2019 04:41:47 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id B73ACAE80017;
 Mon, 23 Sep 2019 04:40:39 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] ppc/kvm: Skip writing DPDES back when in run time state
Date: Mon, 23 Sep 2019 18:41:10 +1000
Message-Id: <20190923084110.34643-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On POWER8 systems the Directed Privileged Door-bell Exception State
register (DPDES) stores doorbell pending status, one bit per a thread
of a core, set by "msgsndp" instruction. The register is shared among
threads of the same core and KVM on POWER9 emulates it in a similar way
(POWER9 does not have DPDES).

DPDES is shared but QEMU assumes all SPRs are per thread so the only safe
way to write DPDES back to VCPU before running a guest is doing so
while all threads are pulled out of the guest so DPDES cannot change.
There is only one situation when this condition is met: incoming migration
when all threads are stopped. Otherwise any QEMU HMP/QMP command causing
kvm_arch_put_registers() (for example printing registers or dumping memory)
can clobber DPDES in a race with other vcpu threads.

This changes DPDES handling so it is not written to KVM at runtime.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/kvm.c                | 5 +++++
 target/ppc/translate_init.inc.c | 9 ++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8c5b1f25cc95..820724cc7d15 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -993,6 +993,10 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
 
         kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &env->tb_env->tb_offset);
+
+        if (level > KVM_PUT_RUNTIME_STATE) {
+            kvm_put_one_spr(cs, KVM_REG_PPC_DPDES, SPR_DPDES);
+        }
 #endif /* TARGET_PPC64 */
     }
 
@@ -1297,6 +1301,7 @@ int kvm_arch_get_registers(CPUState *cs)
         }
 
         kvm_get_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &env->tb_env->tb_offset);
+        kvm_get_one_spr(cs, KVM_REG_PPC_DPDES, SPR_DPDES);
 #endif
     }
 
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0fb11c7ac6da..ba726dec4d00 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8200,11 +8200,10 @@ static void gen_spr_power8_dpdes(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* Directed Privileged Door-bell Exception State, used for IPI */
-    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
-                        SPR_NOACCESS, SPR_NOACCESS,
-                        &spr_read_generic, SPR_NOACCESS,
-                        &spr_read_generic, &spr_write_generic,
-                        KVM_REG_PPC_DPDES, 0x00000000);
+    spr_register(env, SPR_DPDES, "DPDES",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
+                 0x00000000);
 #endif
 }
 
-- 
2.17.1


