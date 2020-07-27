Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF919C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 06:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AE120714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 06:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YpHoLVe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AE120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzwe0-0000hp-3J
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 02:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jzwcd-0007fO-Nj; Mon, 27 Jul 2020 02:28:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jzwca-00042Z-Sd; Mon, 27 Jul 2020 02:28:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BFVHQ5jlBz9sPB; Mon, 27 Jul 2020 16:28:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595831298;
 bh=SF4UJUT4rhnCiCoRCeeFADiKD0zcMDoggaOqiwG6Jsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YpHoLVe4MSv/ZfNZGR/p0kUbIDlFtaeZZAgpCCkHicRjF0DfSw1ePRiH3J7UQOgfQ
 J0TpWOJcyNAS+amu2wvJkxG7MdTfx/YsYbuiFIC3Ftb0N7ECueVlCm01JOfB6xAmFJ
 OVZ5bthP0omxryRG1jEj4eJBKwsgqaJNkM42uECg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 1/1] pseries: fix kvmppc_set_fwnmi()
Date: Mon, 27 Jul 2020 16:28:14 +1000
Message-Id: <20200727062814.179163-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727062814.179163-1-david@gibson.dropbear.id.au>
References: <20200727062814.179163-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, npiggin@gmail.com,
 groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

QEMU issues the ioctl(KVM_CAP_PPC_FWNMI) on the first vCPU.

If the first vCPU is currently running, the vCPU mutex is held
and the ioctl() cannot be done and waits until the mutex is released.
This never happens and the VM is stuck.

To avoid this deadlock, issue the ioctl on the same vCPU doing the
RTAS call.

The problem can be reproduced by booting a guest with several vCPUs
(the probability to have the problem is (n - 1) / n,  n = # of CPUs),
and then by triggering a kernel crash with "echo c >/proc/sysrq-trigger".

On the reboot, the kernel hangs after:

...
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x0
[    0.000000] phys_mem_size     = 0x48000000
[    0.000000] dcache_bsize      = 0x80
[    0.000000] icache_bsize      = 0x80
[    0.000000] cpu_features      = 0x0001c06f8f4f91a7
[    0.000000]   possible        = 0x0003fbffcf5fb1a7
[    0.000000]   always          = 0x00000003800081a1
[    0.000000] cpu_user_features = 0xdc0065c2 0xaee00000
[    0.000000] mmu_features      = 0x3c006041
[    0.000000] firmware_features = 0x00000085455a445f
[    0.000000] physical_start    = 0x8000000
[    0.000000] -----------------------------------------------------
[    0.000000] numa:   NODE_DATA [mem 0x47f33c80-0x47f3ffff]

Fixes: ec010c00665b ("ppc/spapr: KVM FWNMI should not be enabled until guest requests it")
Cc: npiggin@gmail.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200724083533.281700-1-lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c  | 2 +-
 target/ppc/kvm.c     | 3 +--
 target/ppc/kvm_ppc.h | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index bcac0d00e7..513c7a8435 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -438,7 +438,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
     }
 
     if (kvm_enabled()) {
-        if (kvmppc_set_fwnmi() < 0) {
+        if (kvmppc_set_fwnmi(cpu) < 0) {
             rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
             return;
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2692f76130..d85ba8ffe0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2071,9 +2071,8 @@ bool kvmppc_get_fwnmi(void)
     return cap_fwnmi;
 }
 
-int kvmppc_set_fwnmi(void)
+int kvmppc_set_fwnmi(PowerPCCPU *cpu)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
     CPUState *cs = CPU(cpu);
 
     return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 701c0c262b..72e05f1cd2 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
 bool kvmppc_get_fwnmi(void);
-int kvmppc_set_fwnmi(void);
+int kvmppc_set_fwnmi(PowerPCCPU *cpu);
 int kvmppc_smt_threads(void);
 void kvmppc_error_append_smt_possible_hint(Error *const *errp);
 int kvmppc_set_smt_threads(int smt);
@@ -169,7 +169,7 @@ static inline bool kvmppc_get_fwnmi(void)
     return false;
 }
 
-static inline int kvmppc_set_fwnmi(void)
+static inline int kvmppc_set_fwnmi(PowerPCCPU *cpu)
 {
     return -1;
 }
-- 
2.26.2


