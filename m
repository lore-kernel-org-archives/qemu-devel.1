Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0487E2168B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVzlRx/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0487E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3dy-0004ex-33
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W9-00044m-Rn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W6-0007yh-Lu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r3li5OQv5njVdQAQl/B/nGvaueuiWERo40ET4aTjiwQ=;
 b=DVzlRx/bHiaEBGQCe7iUfc+XXm5aMy5jfFXDMNmE9MZHAK68nzMqHFhaLidd57hB8FqiWY
 tr7ROFYLiuItkE6Cqoh6crUygq+0j8MIh4HxDgBN5TIRpZCY0EBaPXkc/I6RL04gqh8rLs
 lYMJL6b8p3xObckIh/dFMb5bJi/TFy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-MnmpeqPjPfytuj5mBIh7Tg-1; Mon, 26 Oct 2020 10:30:31 -0400
X-MC-Unique: MnmpeqPjPfytuj5mBIh7Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C22591016CE6;
 Mon, 26 Oct 2020 14:30:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 702C010021AA;
 Mon, 26 Oct 2020 14:30:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/15] arm: remove bios_name
Date: Mon, 26 Oct 2020 10:30:16 -0400
Message-Id: <20201026143028.3034018-4-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get the firmware name from the MachineState object.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/cubieboard.c     | 2 +-
 hw/arm/highbank.c       | 8 ++++----
 hw/arm/npcm7xx_boards.c | 5 +----
 hw/arm/orangepi.c       | 2 +-
 hw/arm/sbsa-ref.c       | 2 ++
 hw/arm/vexpress.c       | 8 ++++----
 hw/arm/virt.c           | 2 ++
 7 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 1c6c792eb6..9d0d728180 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -40,7 +40,7 @@ static void cubieboard_init(MachineState *machine)
     DeviceState *carddev;
 
     /* BIOS is not supported by this board */
-    if (bios_name) {
+    if (machine->firmware) {
         error_report("BIOS not supported for this machine");
         exit(1);
     }
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index da0510d7ce..8c18971790 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -295,16 +295,16 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0xfff88000, sysram);
-    if (bios_name != NULL) {
-        sysboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (machine->firmware != NULL) {
+        sysboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
         if (sysboot_filename != NULL) {
             if (load_image_targphys(sysboot_filename, 0xfff88000, 0x8000) < 0) {
-                error_report("Unable to load %s", bios_name);
+                error_report("Unable to load %s", machine->firmware);
                 exit(1);
             }
             g_free(sysboot_filename);
         } else {
-            error_report("Unable to find %s", bios_name);
+            error_report("Unable to find %s", machine->firmware);
             exit(1);
         }
     }
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 79e2e2744c..9821013bc6 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -33,13 +33,10 @@ static const char npcm7xx_default_bootrom[] = "npcm7xx_bootrom.bin";
 
 static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
 {
+    const char *bios_name = machine->firmware ?: npcm7xx_default_bootrom;
     g_autofree char *filename = NULL;
     int ret;
 
-    if (!bios_name) {
-        bios_name = npcm7xx_default_bootrom;
-    }
-
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (!filename) {
         error_report("Could not find ROM image '%s'", bios_name);
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 17a568a2b4..d6306dfdda 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -41,7 +41,7 @@ static void orangepi_init(MachineState *machine)
     DeviceState *carddev;
 
     /* BIOS is not supported by this board */
-    if (bios_name) {
+    if (machine->firmware) {
         error_report("BIOS not supported for this machine");
         exit(1);
     }
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 01863510d0..8372ed901d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -294,6 +294,7 @@ static bool sbsa_firmware_init(SBSAMachineState *sms,
                                MemoryRegion *sysmem,
                                MemoryRegion *secure_sysmem)
 {
+    const char *bios_name;
     int i;
     BlockBackend *pflash_blk0;
 
@@ -307,6 +308,7 @@ static bool sbsa_firmware_init(SBSAMachineState *sms,
 
     pflash_blk0 = pflash_cfi01_get_blk(sms->flash[0]);
 
+    bios_name = MACHINE(sms)->firmware;
     if (bios_name) {
         char *fname;
         MemoryRegion *mr;
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 531f3a122a..1adb663d77 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -560,7 +560,7 @@ static void vexpress_common_init(MachineState *machine)
     /*
      * If a bios file was provided, attempt to map it into memory
      */
-    if (bios_name) {
+    if (machine->firmware) {
         char *fn;
         int image_size;
 
@@ -570,16 +570,16 @@ static void vexpress_common_init(MachineState *machine)
                          "but you cannot use both options at once");
             exit(1);
         }
-        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
         if (!fn) {
-            error_report("Could not find ROM image '%s'", bios_name);
+            error_report("Could not find ROM image '%s'", machine->firmware);
             exit(1);
         }
         image_size = load_image_targphys(fn, map[VE_NORFLASH0],
                                          VEXPRESS_FLASH_SIZE);
         g_free(fn);
         if (image_size < 0) {
-            error_report("Could not load ROM image '%s'", bios_name);
+            error_report("Could not load ROM image '%s'", machine->firmware);
             exit(1);
         }
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d6..5c7e3d18db 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1047,6 +1047,7 @@ static bool virt_firmware_init(VirtMachineState *vms,
                                MemoryRegion *secure_sysmem)
 {
     int i;
+    const char *bios_name;
     BlockBackend *pflash_blk0;
 
     /* Map legacy -drive if=pflash to machine properties */
@@ -1059,6 +1060,7 @@ static bool virt_firmware_init(VirtMachineState *vms,
 
     pflash_blk0 = pflash_cfi01_get_blk(vms->flash[0]);
 
+    bios_name = MACHINE(vms)->firmware;
     if (bios_name) {
         char *fname;
         MemoryRegion *mr;
-- 
2.26.2



