Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A523DC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AF620673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AF620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnlw-0003Ex-5S
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iHnk9-0001pw-Op
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iHnk8-0001Ti-LD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:33:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iHnk8-0001TD-6S; Tue, 08 Oct 2019 07:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62C4B793EC;
 Tue,  8 Oct 2019 11:33:27 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99A1E60BE0;
 Tue,  8 Oct 2019 11:33:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] sparc64: use memory_region_allocate_system_memory() only
 for '-m' specified RAM
Date: Tue,  8 Oct 2019 07:33:16 -0400
Message-Id: <20191008113318.7012-2-imammedo@redhat.com>
In-Reply-To: <20191008113318.7012-1-imammedo@redhat.com>
References: <20191008113318.7012-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 08 Oct 2019 11:33:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, hpoussin@reactos.org,
 qemu-ppc@nongnu.org, rth@twiddle.net, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() was designed to be called for
allocating inital RAM. Using it mutiple times within one board is not
supported and could fail if -mem-path with non hugepage path is used.

Keep using memory_region_allocate_system_memory() only for initial
RAM and use memory_region_init_ram() for the rest fixed size regions.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/sparc64/niagara.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 167143bffe..5987693659 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -36,6 +36,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
+#include "qapi/error.h"
 
 typedef struct NiagaraBoardState {
     MemoryRegion hv_ram;
@@ -106,8 +107,8 @@ static void niagara_init(MachineState *machine)
     /* init CPUs */
     sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
     /* set up devices */
-    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
-                                         NIAGARA_HV_RAM_SIZE);
+    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
+                           NIAGARA_HV_RAM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
 
     memory_region_allocate_system_memory(&s->partition_ram, NULL,
@@ -116,17 +117,17 @@ static void niagara_init(MachineState *machine)
     memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
                                 &s->partition_ram);
 
-    memory_region_allocate_system_memory(&s->nvram, NULL,
-                                         "sun4v.nvram", NIAGARA_NVRAM_SIZE);
+    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_SIZE,
+                           &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
-    memory_region_allocate_system_memory(&s->md_rom, NULL,
-                                         "sun4v-md.rom", NIAGARA_MD_ROM_SIZE);
+    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
+                           NIAGARA_MD_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
-    memory_region_allocate_system_memory(&s->hv_rom, NULL,
-                                         "sun4v-hv.rom", NIAGARA_HV_ROM_SIZE);
+    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
+                           NIAGARA_HV_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
-    memory_region_allocate_system_memory(&s->prom, NULL,
-                                         "sun4v.prom", PROM_SIZE_MAX);
+    memory_region_init_ram(&s->prom, NULL, "sun4v.prom", PROM_SIZE_MAX,
+                           &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
 
     add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
@@ -143,8 +144,8 @@ static void niagara_init(MachineState *machine)
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
         int size = blk_getlength(blk);
         if (size > 0) {
-            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
-                                                 "sun4v_vdisk.ram", size);
+            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
+                                   &error_fatal);
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram);
             dinfo->is_default = 1;
-- 
2.18.1


