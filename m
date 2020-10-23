Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DEC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E143220857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="nm8SIOxj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="nm8SIOxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E143220857
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW4vn-0007nU-P6
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 17:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW4sH-0005HX-2J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:45:25 -0400
Received: from home.keithp.com ([63.227.221.253]:42420 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW4sA-0007G2-Aq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:45:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id DFE1E3F2DD11
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603489513; bh=DmcK7hvUL57Bb6vQP0V4uayY6PWIubyTh96C95EW67g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nm8SIOxjqBGO/QEB5rE5g7plREOiJ+nMj4YNUtXX3iLxhRUWWg81GNjLPz55uIT27
 ADb/6z3/mzrn7BRxW0kVw5wTwwiPMIxfuWp1PoG2SQpF/2GvcMMCcWSUa2yBWwgR6P
 uPlwEi1wJvQ8Z1ZocDqmz5hVIEUkIjHf6FTrTwLScJXl5suUdVHFxQSjB+2LHQiDbA
 EfLhysp2UKeIzZrl+Bl3/T5iMXFNeROj2zzabuVzj3gp73STS/bTAQhlLaAZDj9ldU
 FOhAmdSGjtyC9QmJ9jIkg64uEQREnf4pWALQd1VAy7IumlnjIlQQWgFyRp16N71Itk
 J32E1Op3Ia3Ew==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 9s8bwTYW_TUN; Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 3B4F73F2DD12;
 Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603489513; bh=DmcK7hvUL57Bb6vQP0V4uayY6PWIubyTh96C95EW67g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nm8SIOxjqBGO/QEB5rE5g7plREOiJ+nMj4YNUtXX3iLxhRUWWg81GNjLPz55uIT27
 ADb/6z3/mzrn7BRxW0kVw5wTwwiPMIxfuWp1PoG2SQpF/2GvcMMCcWSUa2yBWwgR6P
 uPlwEi1wJvQ8Z1ZocDqmz5hVIEUkIjHf6FTrTwLScJXl5suUdVHFxQSjB+2LHQiDbA
 EfLhysp2UKeIzZrl+Bl3/T5iMXFNeROj2zzabuVzj3gp73STS/bTAQhlLaAZDj9ldU
 FOhAmdSGjtyC9QmJ9jIkg64uEQREnf4pWALQd1VAy7IumlnjIlQQWgFyRp16N71Itk
 J32E1Op3Ia3Ew==
Received: by keithp.com (Postfix, from userid 1000)
 id 0E35415821A8; Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 2/2] riscv: Add sifive test device to sifive_u target
Date: Fri, 23 Oct 2020 14:45:06 -0700
Message-Id: <20201023214506.917601-3-keithp@keithp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023214506.917601-1-keithp@keithp.com>
References: <20201023214506.917601-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 17:45:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

The SiFive test device provides a mechanism for terminating the qemu
instance from the emulated system. This patch adds that device to the
sifive_u target, including constructing a suitable FDT node.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/riscv/sifive_u.c         | 15 +++++++++++++++
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6ad975d692..8d803fe7c0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -15,6 +15,7 @@
  * 5) OTP (One-Time Programmable) memory with stored serial number
  * 6) GEM (Gigabit Ethernet Controller) and management block
  * 7) DMA (Direct Memory Access Controller)
+ * 8) TEST (Test device)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -44,6 +45,7 @@
 #include "hw/char/serial.h"
 #include "hw/cpu/cluster.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/sifive_test.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
@@ -72,6 +74,7 @@ static const struct MemmapEntry {
 } sifive_u_memmap[] = {
     [SIFIVE_U_DEV_DEBUG] =    {        0x0,      0x100 },
     [SIFIVE_U_DEV_MROM] =     {     0x1000,     0xf000 },
+    [SIFIVE_U_DEV_TEST] =     {   0x100000,     0x1000 },
     [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
     [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
@@ -397,6 +400,16 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
+
+    nodename = g_strdup_printf("/soc/test@%lx",
+                               (long)memmap[SIFIVE_U_DEV_TEST].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+                           0x0, memmap[SIFIVE_U_DEV_TEST].base,
+                           0x0, memmap[SIFIVE_U_DEV_TEST].size);
+
+    g_free(nodename);
 }
 
 static void sifive_u_machine_reset(void *opaque, int n, int level)
@@ -780,6 +793,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
 
+    sifive_test_create(memmap[SIFIVE_U_DEV_TEST].base);
+
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_DEV_GEM_MGMT].base, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 22e7e6efa1..4b3ebc3fc6 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -72,6 +72,7 @@ typedef struct SiFiveUState {
 enum {
     SIFIVE_U_DEV_DEBUG,
     SIFIVE_U_DEV_MROM,
+    SIFIVE_U_DEV_TEST,
     SIFIVE_U_DEV_CLINT,
     SIFIVE_U_DEV_L2CC,
     SIFIVE_U_DEV_PDMA,
-- 
2.28.0


