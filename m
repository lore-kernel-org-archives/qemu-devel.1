Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A6FC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8982168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8982168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2RTm-0002vI-7E
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 22:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j2RTC-0002FD-Om
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j2RTB-0006fU-Ep
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:16:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2781 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j2RTA-0006Dv-55; Thu, 13 Feb 2020 22:16:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7687B83B56F6FCCF9B6E;
 Fri, 14 Feb 2020 11:16:34 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 11:16:24 +0800
From: <pannengyuan@huawei.com>
To: <david@gibson.dropbear.id.au>, <clg@kaod.org>
Subject: [PATCH] ppc: free 'fdt' after reset the machine
Date: Fri, 14 Feb 2020 11:32:06 +0800
Message-ID: <20200214033206.4395-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, euler.robot@huawei.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'fdt' forgot to clean both e500 and pnv when we call 'system_reset' on ppc,
this patch fix it. The leak stacks are as follow:

Direct leak of 4194304 byte(s) in 4 object(s) allocated from:
    #0 0x7fafe37dd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7fafe2e3149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x561876f7f80d in create_device_tree /mnt/sdb/qemu-new/qemu/device_tree.c:40
    #3 0x561876b7ac29 in ppce500_load_device_tree /mnt/sdb/qemu-new/qemu/hw/ppc/e500.c:364
    #4 0x561876b7f437 in ppce500_reset_device_tree /mnt/sdb/qemu-new/qemu/hw/ppc/e500.c:617
    #5 0x56187718b1ae in qemu_devices_reset /mnt/sdb/qemu-new/qemu/hw/core/reset.c:69
    #6 0x561876f6938d in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:1412
    #7 0x561876f6a25b in main_loop_should_exit /mnt/sdb/qemu-new/qemu/vl.c:1645
    #8 0x561876f6a398 in main_loop /mnt/sdb/qemu-new/qemu/vl.c:1679
    #9 0x561876f7da8e in main /mnt/sdb/qemu-new/qemu/vl.c:4438
    #10 0x7fafde16b812 in __libc_start_main ../csu/libc-start.c:308
    #11 0x5618765c055d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-softmmu/qemu-system-ppc64+0x2b1555d)

Direct leak of 1048576 byte(s) in 1 object(s) allocated from:
    #0 0x7fc0a6f1b970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7fc0a656f49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55eb05acd2ca in pnv_dt_create /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.c:507
    #3 0x55eb05ace5bf in pnv_reset /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.c:578
    #4 0x55eb05f2f395 in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:1410
    #5 0x55eb05f43850 in main /mnt/sdb/qemu-new/qemu/vl.c:4403
    #6 0x7fc0a18a9812 in __libc_start_main ../csu/libc-start.c:308
    #7 0x55eb0558655d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-softmmu/qemu-system-ppc64+0x2b1555d)

Reported-by: Euler Robot <pannengyuan@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/ppc/e500.c | 1 +
 hw/ppc/pnv.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 886442e54f..af537bba2b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -594,6 +594,7 @@ done:
         cpu_physical_memory_write(addr, fdt, fdt_size);
     }
     ret = fdt_size;
+    g_free(fdt);
 
 out:
     g_free(pci_map);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 139c857b1e..e98038b809 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -582,6 +582,8 @@ static void pnv_reset(MachineState *machine)
 
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
+
+    g_free(fdt);
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
-- 
2.18.2


