Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77D620780
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQgZb3xM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77D620780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3Z9-00068n-Uj
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WA-00047B-W1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W9-0007zQ-0Y
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yelqOBS9IRH94Dyy5XS7fbg8WkiycDDMHuq9uuOUtFg=;
 b=OQgZb3xMTqCLXl8dV/tSLhoLaHCRdx7qy6zDMNREeaom+KeIqGqsf1GRskiSxPvn9mJ7gd
 JQ4b6Xq4LIyy5/uNlu47LREL1Fh9Qz8mEbc87AeqjDwxTDR+67ygRKPQ6K9mKmPSBvuVRl
 N2fHxB60rNOsn1+dmsZse/iiboN4Beo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-AebGZhB2NnWxLttrW-udOg-1; Mon, 26 Oct 2020 10:30:33 -0400
X-MC-Unique: AebGZhB2NnWxLttrW-udOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 905D7809DC8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:30:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE2710002A6;
 Mon, 26 Oct 2020 14:30:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/15] m68k: remove bios_name
Date: Mon, 26 Oct 2020 10:30:20 -0400
Message-Id: <20201026143028.3034018-8-pbonzini@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/m68k/mcf5208.c   | 10 +++++-----
 hw/m68k/next-cube.c |  4 +---
 hw/m68k/q800.c      |  4 +---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index d310a98e7b..7c8ca5ddf6 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -301,17 +301,17 @@ static void mcf5208evb_init(MachineState *machine)
     /* 0xfc0a8000 SDRAM controller.  */
 
     /* Load firmware */
-    if (bios_name) {
+    if (machine->firmware) {
         char *fn;
         uint8_t *ptr;
 
-        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
         if (!fn) {
-            error_report("Could not find ROM image '%s'", bios_name);
+            error_report("Could not find ROM image '%s'", machine->firmware);
             exit(1);
         }
         if (load_image_targphys(fn, 0x0, ROM_SIZE) < 8) {
-            error_report("Could not load ROM image '%s'", bios_name);
+            error_report("Could not load ROM image '%s'", machine->firmware);
             exit(1);
         }
         g_free(fn);
@@ -323,7 +323,7 @@ static void mcf5208evb_init(MachineState *machine)
 
     /* Load kernel.  */
     if (!kernel_filename) {
-        if (qtest_enabled() || bios_name) {
+        if (qtest_enabled() || machine->firmware) {
             return;
         }
         error_report("Kernel image must be specified");
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e7045980b7..37bc35dfa4 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -868,6 +868,7 @@ static void next_cube_init(MachineState *machine)
     MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
     MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
     MemoryRegion *sysmem = get_system_memory();
+    const char *bios_name = machine->firmware ?: ROM_FILE;
     NeXTState *ns = NEXT_MACHINE(machine);
     DeviceState *dev;
 
@@ -924,9 +925,6 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0200e000);
 
     /* Load ROM here */
-    if (bios_name == NULL) {
-        bios_name = ROM_FILE;
-    }
     /* still not sure if the rom should also be mapped at 0x0*/
     memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
     memory_region_add_subregion(sysmem, 0x01000000, rom);
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ce4b47c3e3..6ebcddcfb2 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -167,6 +167,7 @@ static void q800_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
+    const char *bios_name = machine->firmware ?: MACROM_FILENAME;
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
@@ -400,9 +401,6 @@ static void q800_init(MachineState *machine)
         rom = g_malloc(sizeof(*rom));
         memory_region_init_rom(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
                                &error_abort);
-        if (bios_name == NULL) {
-            bios_name = MACROM_FILENAME;
-        }
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
 
-- 
2.26.2



