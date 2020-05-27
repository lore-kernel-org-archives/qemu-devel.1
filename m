Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F714C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD78B2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qtyKy4qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD78B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzSX-0008Ct-Vl
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOb-00027X-Tb; Wed, 27 May 2020 12:59:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOa-0002Kx-QW; Wed, 27 May 2020 12:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598752; x=1622134752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bypzf+ohyagefd+Z4V1gwnh1J59KBZ957z2nBB6h39I=;
 b=qtyKy4qmw/xAO6rfoDy7BOf9BUT8wYs+A1Zh+x2tyogRTDWbD06wTYq/
 hEZtT/r3gRUaB/RhL+PAWz9wOoMOFYBzYdvacur7FMvlfGmfDzIaB39Bb
 mm54+xMfmxNI+6PT1Uo0Bvr0ifzC+Oe2jCuGNMEX6NFNHNubu0S4xQznz
 bklYsmrBD7xO+wIhGPHtB8jOsgX3P2fF4kba4aTKAAgSVqzGEKkEnrv2l
 7AyK8J1vTiTKw/C5HwZE8msASRUIKRUgn96neMwvApKyjWYJd+ZhRh1gv
 9vFC3HpiwBTAi7iXHwpv5929YuYV3HdVOImiRcgAbHlb34P1KVRXlslyp Q==;
IronPort-SDR: msH1nyecXP5I4+I/YmuaZ5DFUnccnvW1ymu4ct9kLrkuUtjhooFFnJ9kN+VizyiRdCRiTaVlD0
 FZbcRiwgTlHPmk9KEySdTY3eBkUjBOAC1kVQwfATfCwWb0NKKaMOs62cVltSgS4Bz1qu4YhXmT
 FrJTIuyyq7xcpikeSAtLS4A+7o+l3GlpKt5vjkBKfb+Jg/ZQ65sB35ACpT5C9o5Pa/Vi2ILKiE
 6nlzPsibUZnsuPoSTJ/Dtkw/GU6YLGy3r0nn62nKat3boVE9QrH6FLIYHxTU5uDnUHi/HZK/pV
 BqM=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="138633231"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:59:11 +0800
IronPort-SDR: kX6sxtq0P4554Zos3d4Qt3ICvPXm57McWIlKpF55fT4sJv9clyycyKTFs/F8HLHEJyAsHe8PWW
 pd5xbEPEbIQhoBkOTZYlr4HnjiSaTgYQI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:49:01 -0700
IronPort-SDR: aRkSmyu5HNLPGnKBAsMPbVi/hIUVLc7PEPFJHs3z9VDSUav1Vc3kMxVq1I/jsJjjLKEenQdr3F
 rJE2uc2nYOMQ==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 May 2020 09:59:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 08/10] riscv/opentitan: Connect the PLIC device
Date: Wed, 27 May 2020 09:50:37 -0700
Message-Id: <a699a63fee27d52496076ef0bb4b3e96a7b1d4e1.1590598125.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590598125.git.alistair.francis@wdc.com>
References: <cover.1590598125.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/opentitan.h |  3 +++
 hw/riscv/opentitan.c         | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 15a3d87ed0..8d6a09b696 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -20,6 +20,7 @@
 #define HW_OPENTITAN_H
 
 #include "hw/riscv/riscv_hart.h"
+#include "hw/intc/ibex_plic.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 #define RISCV_IBEX_SOC(obj) \
@@ -31,6 +32,8 @@ typedef struct LowRISCIbexSoCState {
 
     /*< public >*/
     RISCVHartArrayState cpus;
+    IbexPlicState plic;
+
     MemoryRegion flash_mem;
     MemoryRegion rom;
 } LowRISCIbexSoCState;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index c00f0720ab..3926321d8c 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -25,6 +25,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
 
 static const struct MemmapEntry {
     hwaddr base;
@@ -92,6 +93,9 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
                             &error_abort, NULL);
+
+    sysbus_init_child_obj(obj, "plic", &s->plic,
+                          sizeof(s->plic), TYPE_IBEX_PLIC);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -100,6 +104,9 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
     MemoryRegion *sys_mem = get_system_memory();
+    DeviceState *dev;
+    SysBusDevice *busdev;
+    Error *err = NULL;
 
     object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
@@ -120,6 +127,16 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(sys_mem, memmap[IBEX_FLASH].base,
                                 &s->flash_mem);
 
+    /* PLIC */
+    dev = DEVICE(&s->plic);
+    object_property_set_bool(OBJECT(&s->plic), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, memmap[IBEX_PLIC].base);
+
     create_unimplemented_device("riscv.lowrisc.ibex.uart",
         memmap[IBEX_UART].base, memmap[IBEX_UART].size);
     create_unimplemented_device("riscv.lowrisc.ibex.gpio",
@@ -134,8 +151,6 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_AES].base, memmap[IBEX_AES].size);
     create_unimplemented_device("riscv.lowrisc.ibex.hmac",
         memmap[IBEX_HMAC].base, memmap[IBEX_HMAC].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.plic",
-        memmap[IBEX_PLIC].base, memmap[IBEX_PLIC].size);
     create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
         memmap[IBEX_PINMUX].base, memmap[IBEX_PINMUX].size);
     create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
-- 
2.26.2


