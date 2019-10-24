Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC5320679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRtHYnQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC5320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTB0-00066x-Ji
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 22:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNT94-0002wE-C8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNT93-0005g2-75
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNT93-0005fh-3B
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571885196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFN3G4vy9TZ4XjODrTT4WxsNQU09kGyHD2ISBmvwuXk=;
 b=LRtHYnQWLrU3w9EUbv/WF8hxHfDq3AJmT5qhvKT/1Rmhc2dJbp5eqZ0VDSZQwresupUpV2
 RQAq7kC8EErgYs+cge3T8aS7UVao6Z1zKSH/rpZbVs0TEEr2OdzHHJg73lRoshScK/+iGK
 05bxG9hFCMrFElSCe5Mkn/SO9HFScss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-XScY6BQVM9yqtB8h_F1azQ-1; Wed, 23 Oct 2019 22:46:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0743E1005500;
 Thu, 24 Oct 2019 02:46:32 +0000 (UTC)
Received: from localhost (ovpn-116-56.gru2.redhat.com [10.97.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 474501001B3F;
 Thu, 24 Oct 2019 02:46:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 2/4] sparc64: use memory_region_allocate_system_memory() only
 for '-m' specified RAM
Date: Wed, 23 Oct 2019 23:46:21 -0300
Message-Id: <20191024024623.18848-3-ehabkost@redhat.com>
In-Reply-To: <20191024024623.18848-1-ehabkost@redhat.com>
References: <20191024024623.18848-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XScY6BQVM9yqtB8h_F1azQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() was designed to be called for
allocating inital RAM. Using it mutiple times within one board is not
supported and could fail if -mem-path with non hugepage path is used.

Keep using memory_region_allocate_system_memory() only for initial
RAM and use memory_region_init_ram() for the rest fixed size regions.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20191008113318.7012-2-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
=20
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
=20
     memory_region_allocate_system_memory(&s->partition_ram, NULL,
@@ -116,17 +117,17 @@ static void niagara_init(MachineState *machine)
     memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
                                 &s->partition_ram);
=20
-    memory_region_allocate_system_memory(&s->nvram, NULL,
-                                         "sun4v.nvram", NIAGARA_NVRAM_SIZE=
);
+    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_S=
IZE,
+                           &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
-    memory_region_allocate_system_memory(&s->md_rom, NULL,
-                                         "sun4v-md.rom", NIAGARA_MD_ROM_SI=
ZE);
+    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
+                           NIAGARA_MD_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
-    memory_region_allocate_system_memory(&s->hv_rom, NULL,
-                                         "sun4v-hv.rom", NIAGARA_HV_ROM_SI=
ZE);
+    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
+                           NIAGARA_HV_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
-    memory_region_allocate_system_memory(&s->prom, NULL,
-                                         "sun4v.prom", PROM_SIZE_MAX);
+    memory_region_init_ram(&s->prom, NULL, "sun4v.prom", PROM_SIZE_MAX,
+                           &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
=20
     add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
@@ -143,8 +144,8 @@ static void niagara_init(MachineState *machine)
         BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
         int size =3D blk_getlength(blk);
         if (size > 0) {
-            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
-                                                 "sun4v_vdisk.ram", size);
+            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram",=
 size,
+                                   &error_fatal);
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram)=
;
             dinfo->is_default =3D 1;
--=20
2.21.0


