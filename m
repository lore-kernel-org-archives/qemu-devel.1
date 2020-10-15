Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B458AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24797206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9AD/VU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24797206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6aQ-0001To-2p
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6Nc-0004Nm-LQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NR-0000XO-U7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGmqgei+Up8VgdSbIiXXnU58C7qtGxogY9pgtEwOVOA=;
 b=e9AD/VU1UtYGEgJbpb6CReO68MA0hNDQOgnU2XM2/bOdU/I9nXK95w5L1hCgkJ041gydT4
 rIy0dER6s9eJKxSg3GnDs88nRV9AHsZrMuzH85ydf3eNXzuRMofDZPTZ3r2FJWYfmSJhgQ
 bcxzmGkuC16W8l6LWj7uMlsTO9TwATQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-jdAFo9-hMkaHUpdIk_FZhg-1; Thu, 15 Oct 2020 12:45:12 -0400
X-MC-Unique: jdAFo9-hMkaHUpdIk_FZhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8991A1007470;
 Thu, 15 Oct 2020 16:45:11 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5705A5D9D5;
 Thu, 15 Oct 2020 16:45:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 6/9] i386/kvm: Delete kvm_allows_irq0_override()
Date: Thu, 15 Oct 2020 12:44:58 -0400
Message-Id: <20201015164501.462775-7-ehabkost@redhat.com>
In-Reply-To: <20201015164501.462775-1-ehabkost@redhat.com>
References: <20201015164501.462775-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As IRQ routing is always available on x86,
kvm_allows_irq0_override() will always return true, so we don't
need the function anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200922201922.2153598-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm_i386.h | 1 -
 hw/i386/fw_cfg.c       | 2 +-
 hw/i386/microvm.c      | 2 +-
 hw/i386/pc.c           | 2 +-
 target/i386/kvm-stub.c | 5 -----
 target/i386/kvm.c      | 5 -----
 6 files changed, 3 insertions(+), 14 deletions(-)

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
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 33441ad484..e06579490c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -123,7 +123,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
 #endif
-    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                      &e820_reserve, sizeof(e820_reserve));
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 73a7a142b4..68a7f424ac 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -290,7 +290,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                      &e820_reserve, sizeof(e820_reserve));
     fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e87be5d29a..4e323755d0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -827,7 +827,7 @@ void pc_guest_info_init(PCMachineState *pcms)
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
index 588d893a63..cf46259534 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -154,11 +154,6 @@ bool kvm_has_exception_payload(void)
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
-- 
2.28.0


