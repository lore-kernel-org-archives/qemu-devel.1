Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E5C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39602077C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39602077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1fG-0005oT-QR
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:28:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dm-0004eJ-Pw
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dk-00052s-T0
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hG1dj-00051g-09; Mon, 15 Apr 2019 09:27:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB7DE3092645;
	Mon, 15 Apr 2019 13:27:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC53E1001E6D;
	Mon, 15 Apr 2019 13:27:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 15:27:18 +0200
Message-Id: <1555334842-195718-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 15 Apr 2019 13:27:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 1/5] sparc64: use
 memory_region_allocate_system_memory() only for '-m' specified RAM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415132718.oE9dYgs9naYV1yp1HAt6bQ9zcx0tcVWh0OPd-svBPeU@z>

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
index f8a856f..39a4522 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -37,6 +37,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
+#include "qapi/error.h"
 
 
 typedef struct NiagaraBoardState {
@@ -108,8 +109,8 @@ static void niagara_init(MachineState *machine)
     /* init CPUs */
     sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
     /* set up devices */
-    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
-                                         NIAGARA_HV_RAM_SIZE);
+    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
+                           NIAGARA_HV_RAM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
 
     memory_region_allocate_system_memory(&s->partition_ram, NULL,
@@ -118,17 +119,17 @@ static void niagara_init(MachineState *machine)
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
@@ -145,8 +146,8 @@ static void niagara_init(MachineState *machine)
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
2.7.4


