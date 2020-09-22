Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13642220D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ih5Y9jS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13642220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKop5-0005y5-M7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 16:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKolT-0002GJ-AU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKolR-000852-HI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600805988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiMyrJEnAYgkkVWygOH1TIFk/RLS8Nq9gl/xrF7Oldk=;
 b=ih5Y9jS+2imi9EmR0vnj9XG8lToA1rzahkOyQFgyvkLQYrdxMn3VvqgrIUlpo8PHQ1EkX3
 oqjlWxLnlh5XIbiFvwqQ7QQXZmI2RpzcxP/XcWsjh4JRRvmhpSBOUKIbfdO3vpr6VplElN
 ixioHXBize3kKdGEkeuFzHkE3himPTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-NJpeCggvNqm9K1aDoFmkpg-1; Tue, 22 Sep 2020 16:19:46 -0400
X-MC-Unique: NJpeCggvNqm9K1aDoFmkpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1905E8B1242;
 Tue, 22 Sep 2020 20:19:45 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 085B473689;
 Tue, 22 Sep 2020 20:19:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] i386/kvm: Delete kvm_allows_irq0_override()
Date: Tue, 22 Sep 2020 16:19:22 -0400
Message-Id: <20200922201922.2153598-4-ehabkost@redhat.com>
In-Reply-To: <20200922201922.2153598-1-ehabkost@redhat.com>
References: <20200922201922.2153598-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Sergio Lopez <slp@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As IRQ routing is always available on x86,
kvm_allows_irq0_override() will always return true, so we don't
need the function anymore.

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
index 064b8798a26..b11704cc772 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -32,7 +32,6 @@
 
 #endif  /* CONFIG_KVM */
 
-bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 33441ad4840..e06579490c4 100644
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
index 60d32722301..05fb0536dcc 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -225,7 +225,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                      &e820_reserve, sizeof(e820_reserve));
     fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b55369357e5..0bc569d4c6b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -859,7 +859,7 @@ void pc_guest_info_init(PCMachineState *pcms)
     MachineState *ms = MACHINE(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    x86ms->apic_xrupt_override = kvm_allows_irq0_override();
+    x86ms->apic_xrupt_override = true;
     pcms->numa_nodes = ms->numa_state->num_nodes;
     pcms->node_mem = g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index 872ef7df4c8..92f49121b8f 100644
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
index cf6dc90f7c5..c419c52ec58 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -148,11 +148,6 @@ bool kvm_has_exception_payload(void)
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
2.26.2


