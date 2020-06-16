Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBEBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299BD2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299BD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC4X-0007i6-8O
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1n-00022d-Go; Tue, 16 Jun 2020 09:53:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:36214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1l-0002Pu-Ki; Tue, 16 Jun 2020 09:53:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 59D29748DE2;
 Tue, 16 Jun 2020 15:53:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CCC00748DD0; Tue, 16 Jun 2020 15:53:17 +0200 (CEST)
Message-Id: <0dd50184cd4b0848808c8a1faddaf84bd2cf0fcd.1592315226.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592315226.git.balaton@eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 08/11] mac_oldworld: Add machine ID register
Date: Tue, 16 Jun 2020 15:47:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 09:53:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The G3 beige machine has a machine ID register that is accessed by the
firmware to deternine the board config. Add basic emulation of it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v4: Move MermoryRegion to MachineState, use constants

 hw/ppc/mac.h          |  1 +
 hw/ppc/mac_oldworld.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 79ccf8775d..32b7928a96 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -64,6 +64,7 @@ typedef struct HeathrowMachineState {
     /*< private >*/
     MachineState parent;
 
+    MemoryRegion machine_id;
     PCIDevice *macio;
 } HeathrowMachineState;
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 13562e26e6..14a191ff88 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -52,6 +52,9 @@
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
+#define MACHINE_ID_ADDR 0xff000004
+#define MACHINE_ID_VAL 0x3d8c
+
 #define TBFREQ 16600000UL
 #define CLOCKFREQ 266000000UL
 #define BUSFREQ 66000000UL
@@ -89,6 +92,22 @@ static void ppc_heathrow_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+static uint64_t machine_id_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return (addr == 0 && size == 2 ? MACHINE_ID_VAL : 0);
+}
+
+static void machine_id_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    return;
+}
+
+const MemoryRegionOps machine_id_reg_ops = {
+    .read = machine_id_read,
+    .write = machine_id_write,
+};
+
 static void ppc_heathrow_init(MachineState *machine)
 {
     HeathrowMachineState *hm = HEATHROW_MACHINE(machine);
@@ -239,6 +258,11 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }
 
+    memory_region_init_io(&hm->machine_id, OBJECT(machine),
+                          &machine_id_reg_ops, NULL, "machine_id", 2);
+    memory_region_add_subregion(get_system_memory(), MACHINE_ID_ADDR,
+                                &hm->machine_id);
+
     /* XXX: we register only 1 output pin for heathrow PIC */
     pic_dev = qdev_new(TYPE_HEATHROW);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(pic_dev), &error_fatal);
-- 
2.21.3


