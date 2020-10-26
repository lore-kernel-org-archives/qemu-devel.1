Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE1BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A83C22263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8mgRh5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A83C22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3e2-0004qI-5A
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WG-0004M5-HC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W9-0007zb-IT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GFpxH70jBdUc9bnsAYgZkItYUzh5HlSFFPFmot9nlE=;
 b=D8mgRh5psFW+bBRr+pTNtqdLZrJYLffeHqPSpMbL1SFPtNzgaCa5EoL7svH07k6k4RjmGp
 hOOaxy5q4vjE3bLc/6a307YMGRDeLYAB/YBHFPQpq+RXclbqFRPiAXeOFZODTJbisQ6U92
 ZU89O33+GqUE3uhC2gfXjNz8KYop5Gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-hQTKFSSIM9mjq3WhRnYaBg-1; Mon, 26 Oct 2020 10:30:33 -0400
X-MC-Unique: hQTKFSSIM9mjq3WhRnYaBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBE55804325
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:30:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA81F1002C00;
 Mon, 26 Oct 2020 14:30:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] mips: remove bios_name
Date: Mon, 26 Oct 2020 10:30:21 -0400
Message-Id: <20201026143028.3034018-9-pbonzini@redhat.com>
In-Reply-To: <20201026143028.3034018-1-pbonzini@redhat.com>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/fuloong2e.c | 6 +++---
 hw/mips/jazz.c      | 6 +++---
 hw/mips/malta.c     | 6 +++---
 hw/mips/mipssim.c   | 6 +++---
 hw/mips/r4k.c       | 4 +---
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index a9e0c2f8d3..25b679011f 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -338,7 +338,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                                  bios_name ?: FULOONG_BIOSNAME);
+                                  machine->firmware ?: FULOONG_BIOSNAME);
         if (filename) {
             bios_size = load_image_targphys(filename, 0x1fc00000LL,
                                             BIOS_SIZE);
@@ -348,8 +348,8 @@ static void mips_fuloong2e_init(MachineState *machine)
         }
 
         if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-            bios_name && !qtest_enabled()) {
-            error_report("Could not load MIPS bios '%s'", bios_name);
+            machine->firmware && !qtest_enabled()) {
+            error_report("Could not load MIPS bios '%s'", machine->firmware);
             exit(1);
         }
     }
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 71448f72ac..aa95c6a3d3 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -218,7 +218,7 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
 
     /* load the BIOS image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
     if (filename) {
         bios_size = load_image_targphys(filename, 0xfff00000LL,
                                         MAGNUM_BIOS_SIZE);
@@ -227,8 +227,8 @@ static void mips_jazz_init(MachineState *machine,
         bios_size = -1;
     }
     if ((bios_size < 0 || bios_size > MAGNUM_BIOS_SIZE)
-        && bios_name && !qtest_enabled()) {
-        error_report("Could not load MIPS bios '%s'", bios_name);
+        && machine->firmware && !qtest_enabled()) {
+        error_report("Could not load MIPS bios '%s'", machine->firmware);
         exit(1);
     }
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 9d1a3b50b7..ef369945d1 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1333,7 +1333,7 @@ void mips_malta_init(MachineState *machine)
         if (!dinfo) {
             /* Load a BIOS image. */
             filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                                      bios_name ?: BIOS_FILENAME);
+                                      machine->firmware ?: BIOS_FILENAME);
             if (filename) {
                 bios_size = load_image_targphys(filename, FLASH_ADDRESS,
                                                 BIOS_SIZE);
@@ -1342,8 +1342,8 @@ void mips_malta_init(MachineState *machine)
                 bios_size = -1;
             }
             if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-                bios_name && !qtest_enabled()) {
-                error_report("Could not load MIPS bios '%s'", bios_name);
+                machine->firmware && !qtest_enabled()) {
+                error_report("Could not load MIPS bios '%s'", machine->firmware);
                 exit(1);
             }
         }
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index aaa62a0f4b..cc9b0934b3 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -177,7 +177,7 @@ mips_mipssim_init(MachineState *machine)
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
     /* Load a BIOS / boot exception handler image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
     if (filename) {
         bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
         g_free(filename);
@@ -185,9 +185,9 @@ mips_mipssim_init(MachineState *machine)
         bios_size = -1;
     }
     if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
-        bios_name && !qtest_enabled()) {
+        machine->firmware && !qtest_enabled()) {
         /* Bail out if we have neither a kernel image nor boot vector code. */
-        error_report("Could not load MIPS bios '%s'", bios_name);
+        error_report("Could not load MIPS bios '%s'", machine->firmware);
         exit(1);
     } else {
         /* We have a boot vector start address. */
diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 3830854342..b27be138a4 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -168,6 +168,7 @@ static const int sector_len = 32 * KiB;
 static
 void mips_r4k_init(MachineState *machine)
 {
+    const char *bios_name = machine->firmware ?: BIOS_FILENAME;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -221,9 +222,6 @@ void mips_r4k_init(MachineState *machine)
      * run.
      */
 
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename);
-- 
2.26.2



