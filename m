Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666DBC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA50520773
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 03:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZZmtF63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA50520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKv53-0004g0-Or
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 23:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKv33-0003K7-2S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:02:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKv2z-0004Lm-AG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 23:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600830139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HlsEJnjIQLIDnrwAQVkjaZ63PU3qMVIZMT/+6T3sxyg=;
 b=XZZmtF63loUXr2dNbBZ9crqNw1fa4XH7IN5ZTN88+DOb1/5ifSP82o23JeQ0stw5xWOjRH
 ZD53XOuQhTmyPvm86fWXkS14gl8GLamRGEDaySv1q/SFd1LaKaY7CVQlOKvgYH0Es2Rmfo
 EMJ9ENo7YYWKWcM3cut0YaG2NUD2+eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-xkryFTNIMmu8UVr_HxTZZA-1; Tue, 22 Sep 2020 23:02:17 -0400
X-MC-Unique: xkryFTNIMmu8UVr_HxTZZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D052864141
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F0555D9CC;
 Wed, 23 Sep 2020 03:02:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: kvm: require KVM_CAP_IRQ_ROUTING
Date: Tue, 22 Sep 2020 23:02:15 -0400
Message-Id: <20200923030216.1527921-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_CAP_IRQ_ROUTING has been available for x86 since Linux 2.6.33.
We can make it a requirement since that was more than ten years ago.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c       |  2 +-
 hw/i386/kvm/apic.c     |  4 +---
 hw/i386/microvm.c      |  2 +-
 hw/i386/pc.c           |  2 +-
 target/i386/kvm-stub.c |  5 -----
 target/i386/kvm.c      | 14 ++++----------
 target/i386/kvm_i386.h |  1 -
 7 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 33441ad484..e92e17fa07 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -123,7 +123,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
 #endif
-    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, true);
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                      &e820_reserve, sizeof(e820_reserve));
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 4eb2d77b87..284c0da6cd 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -225,9 +225,7 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io_memory, OBJECT(s), &kvm_apic_io_ops, s,
                           "kvm-apic-msi", APIC_SPACE_SIZE);
 
-    if (kvm_has_gsi_routing()) {
-        msi_nonbroken = true;
-    }
+    msi_nonbroken = true;
 }
 
 static void kvm_apic_unrealize(DeviceState *dev)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index aedcae3426..d4bcc28471 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -225,7 +225,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, true);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                      &e820_reserve, sizeof(e820_reserve));
     fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index da2ebc3fa0..9759d8acae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -825,7 +825,7 @@ void pc_guest_info_init(PCMachineState *pcms)
     MachineState *ms = MACHINE(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    x86ms->apic_xrupt_override = kvm_allows_irq0_override();
+    x86ms->apic_xrupt_override = true;
     pcms->numa_nodes = ms->numa_state->num_nodes;
     pcms->node_mem = g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index 872ef7df4c..92f49121b8 100644
--- a/target/i386/kvm-stub.c
+++ b/target/i386/kvm-stub.c
@@ -13,11 +13,6 @@
 #include "cpu.h"
 #include "kvm_i386.h"
 
-bool kvm_allows_irq0_override(void)
-{
-    return 1;
-}
-
 #ifndef __OPTIMIZE__
 bool kvm_has_smm(void)
 {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 595e822161..3996cf9764 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -153,11 +153,6 @@ bool kvm_has_exception_payload(void)
     return has_exception_payload;
 }
 
-bool kvm_allows_irq0_override(void)
-{
-    return !kvm_irqchip_in_kernel() || kvm_has_gsi_routing();
-}
-
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -4569,12 +4564,11 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 void kvm_arch_init_irq_routing(KVMState *s)
 {
     if (!kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
-        /* If kernel can't do irq routing, interrupt source
-         * override 0->2 cannot be set up as required by HPET.
-         * So we have to disable it.
-         */
-        no_hpet = 1;
+        error_report("Your kernel is too old.  This version of QEMU requires "
+		     "KVM_CAP_IRQ_ROUTING support.");
+        exit(1);
     }
+
     /* We know at this point that we're using the in-kernel
      * irqchip, so we can use irqfds, and on x86 we know
      * we can use msi via irqfd and GSI routing.
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 0fce4e51d2..a4a619cebb 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -32,7 +32,6 @@
 
 #endif  /* CONFIG_KVM */
 
-bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
 bool kvm_has_adjust_clock(void);
 bool kvm_has_adjust_clock_stable(void);
-- 
2.26.2


