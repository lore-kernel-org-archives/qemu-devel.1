Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32130C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF93D20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0hwy3f9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF93D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytBk-0008GU-LZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jytBA-0007kA-DA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:35:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jytB8-0007Nb-HS
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595579741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=InBwq/6ekQfs5RfXLsv/seuvSyx3UpGVDS5FZpmQ+jQ=;
 b=T0hwy3f97+csCynetWtMIcmyWU7p1tivgopFVvLfJU8Rmrk3F7xnrMZ9TXGRh/9YQDeOFF
 PJt4nB1nBfvWD38/Xyzb4UlD8yM9rKNPfTzr5rHz4vCOKKIa0r+9d1X3VAdRrPxsWZLBxr
 GOqd0tZDrGvFjGxQ7FsA52HHGOUUq/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-fQzOSTIOOkiInjhslgAVeA-1; Fri, 24 Jul 2020 04:35:37 -0400
X-MC-Unique: fQzOSTIOOkiInjhslgAVeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8644D80183C;
 Fri, 24 Jul 2020 08:35:36 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9162DE73;
 Fri, 24 Jul 2020 08:35:34 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pseries: fix kvmppc_set_fwnmi()
Date: Fri, 24 Jul 2020 10:35:33 +0200
Message-Id: <20200724083533.281700-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org, npiggin@gmail.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/ppc/spapr_rtas.c  | 2 +-
 target/ppc/kvm.c     | 3 +--
 target/ppc/kvm_ppc.h | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index bcac0d00e7b6..513c7a84351b 100644
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
index 2692f76130aa..d85ba8ffe00b 100644
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
index 701c0c262be2..72e05f1cd2fc 100644
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


