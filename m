Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21099C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D66620780
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnuWwYpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D66620780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3bZ-00017z-Gb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W9-000448-B6
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W7-0007yz-8R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGz4sZRZl+4wxAmY2w5b8flBmG5J6M3AZqNYoVUladM=;
 b=hnuWwYpauXiVeHcFgykQWRdiKBETvYzMnBHyLMcB2qu6g/Xi/0kqS2q0rY5ZoOk08TexLH
 4kim+I7Zqj4Y6f+t9WWyO6KIM7JThwALnbdtZ4raTkJrf+NsoMdhLw+yc6ZYuGdOst/l9c
 FQ28b5ud2YiHhuU5HYWN1/MIui4PKp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-j_f8yrT7OJOvyd7xyx1zYA-1; Mon, 26 Oct 2020 10:30:32 -0400
X-MC-Unique: j_f8yrT7OJOvyd7xyx1zYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938741016CF0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:30:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 526341002391;
 Mon, 26 Oct 2020 14:30:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/15] i386: remove bios_name
Date: Mon, 26 Oct 2020 10:30:18 -0400
Message-Id: <20201026143028.3034018-6-pbonzini@redhat.com>
In-Reply-To: <20201026143028.3034018-1-pbonzini@redhat.com>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/microvm.c     |  7 +++----
 hw/i386/pc_sysfw.c    |  4 ++--
 hw/i386/x86.c         | 10 ++++------
 include/hw/i386/x86.h |  3 ++-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 5428448b70..6cda3014d6 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -154,6 +154,7 @@ static void create_gpex(MicrovmMachineState *mms)
 
 static void microvm_devices_init(MicrovmMachineState *mms)
 {
+    const char *default_firmware;
     X86MachineState *x86ms = X86_MACHINE(mms);
     ISABus *isa_bus;
     ISADevice *rtc_state;
@@ -259,12 +260,10 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         serial_hds_isa_init(isa_bus, 0, 1);
     }
 
-    if (bios_name == NULL) {
-        bios_name = x86_machine_is_acpi_enabled(x86ms)
+    default_firmware = x86_machine_is_acpi_enabled(x86ms)
             ? MICROVM_BIOS_FILENAME
             : MICROVM_QBOOT_FILENAME;
-    }
-    x86_bios_rom_init(get_system_memory(), true);
+    x86_bios_rom_init(MACHINE(mms), default_firmware, get_system_memory(), true);
 }
 
 static void microvm_memory_init(MicrovmMachineState *mms)
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b6c0822fe3..0187f0a934 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -222,7 +222,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(rom_memory, true);
+        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
         return;
     }
 
@@ -243,7 +243,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(rom_memory, false);
+        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 5944fc44ed..836d388248 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -54,8 +54,6 @@
 #include CONFIG_DEVICES
 #include "kvm_i386.h"
 
-#define BIOS_FILENAME "bios.bin"
-
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
@@ -1051,17 +1049,17 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
-void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
+void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
+    const char *bios_name;
     char *filename;
     MemoryRegion *bios, *isa_bios;
     int bios_size, isa_bios_size;
     int ret;
 
     /* BIOS load */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
+    bios_name = ms->firmware ?: default_firmware;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index bfa9cb2a25..e92ddeaed1 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -101,7 +101,8 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
-void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
+void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-- 
2.26.2



