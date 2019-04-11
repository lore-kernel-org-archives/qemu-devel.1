Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD92C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2872077C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2872077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEaCz-0002GW-Ur
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 09:57:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBb-0001Ga-Nd
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEaBZ-0005lB-Pd
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:56:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hEaBR-0005fa-S8; Thu, 11 Apr 2019 09:56:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 577053084294;
	Thu, 11 Apr 2019 13:56:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B25C018A51;
	Thu, 11 Apr 2019 13:56:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 46FDD1132BB6; Thu, 11 Apr 2019 15:56:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 15:56:01 +0200
Message-Id: <20190411135602.21725-2-armbru@redhat.com>
In-Reply-To: <20190411135602.21725-1-armbru@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 11 Apr 2019 13:56:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	mreitz@redhat.com, qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411135601.3Kc5rYpjL702xHnTVBTq0BV_J-IPbxJZrgtMuCTGJhc@z>

Factored out of pc_system_firmware_init() so the next commit can reuse
it in hw/arm/virt.c.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c  | 30 ++++++++++++++++++++++++++++++
 hw/i386/pc_sysfw.c       | 19 ++-----------------
 include/hw/block/flash.h |  1 +
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 16dfae14b8..eba01b1447 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -44,9 +44,12 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/option.h"
 #include "hw/sysbus.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -968,6 +971,33 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
     return &fl->mem;
 }
 
+/*
+ * Handle -drive if=pflash for machines that use machine properties.
+ * Map unit#i (0 < i <= @ndev) to @dev[i]'s property "drive".
+ */
+void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev)
+{
+    int i;
+    DriveInfo *dinfo;
+    Location loc;
+
+    for (i = 0; i < ndev; i++) {
+        dinfo = drive_get(IF_PFLASH, 0, i);
+        if (!dinfo) {
+            continue;
+        }
+        loc_push_none(&loc);
+        qemu_opts_loc_restore(dinfo->opts);
+        if (dev[i]->blk) {
+            error_report("clashes with -machine");
+            exit(1);
+        }
+        qdev_prop_set_drive(DEVICE(dev[i]), "drive",
+                            blk_by_legacy_dinfo(dinfo), &error_fatal);
+        loc_pop(&loc);
+    }
+}
+
 static void postload_update_cb(void *opaque, int running, RunState state)
 {
     PFlashCFI01 *pfl = opaque;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c628540774..d58e47184c 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -269,32 +269,17 @@ void pc_system_firmware_init(PCMachineState *pcms,
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     int i;
-    DriveInfo *pflash_drv;
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
-    Location loc;
 
     if (!pcmc->pci_enabled) {
         old_pc_system_rom_init(rom_memory, true);
         return;
     }
 
-    /* Map legacy -drive if=pflash to machine properties */
+    pflash_cfi01_legacy_drive(pcms->flash, ARRAY_SIZE(pcms->flash));
+
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
-        pflash_drv = drive_get(IF_PFLASH, 0, i);
-        if (!pflash_drv) {
-            continue;
-        }
-        loc_push_none(&loc);
-        qemu_opts_loc_restore(pflash_drv->opts);
-        if (pflash_blk[i]) {
-            error_report("clashes with -machine");
-            exit(1);
-        }
-        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
-        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
-                            "drive", pflash_blk[i], &error_fatal);
-        loc_pop(&loc);
     }
 
     /* Reject gaps */
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index a0f488732a..f6a68c2a4c 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -24,6 +24,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    int be);
 BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
+void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev);
 
 /* pflash_cfi02.c */
 
-- 
2.17.2


