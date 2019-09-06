Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F337C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3682D2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="TuIPp8Uf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hCImHbbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3682D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67b3-00011z-CJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i67Sr-0002hf-2v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i67Sp-0003tQ-PE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i67Sp-0003tK-Lc
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:19 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 2907620CB1;
 Fri,  6 Sep 2019 02:11:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 06 Sep 2019 02:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=rH9HN90l0DkIZ
 8oRDIrruzZS+xV4QJi52UZ0IPBbxzA=; b=TuIPp8Uf8NnlQ4GEm76E8Tz811J5E
 Gb6BxGgmIT33XMyN3PKS5tffUBqaNZ/bRGMjm+BSilW8FHwJ2jLN8ZCWB0GFhqgW
 eLD3V6qDHZ5QVL2LYf3KBO7mOl/YUgsrlXne/+oEWhQg9W6yev4ig6MQEzThA5HQ
 ensIeM+XC/FlKx+VnnzeFy2BBdSvX6PtrFnwkyNS4tqObcXX5XcOnGtLz8rIMDHL
 0eg0bKnbCc0TpAlWZrLSVJtMb9Y0hP9o7tbwyL5LGYCHRlxMjjQ4F8xJVHF6cZ6X
 AV9PoQ+Ow5+0i3Wgubc6lSjS+ppteswlXsYxVUjDk2Up59nkNhuWZPNDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=rH9HN90l0DkIZ8oRDIrruzZS+xV4QJi52UZ0IPBbxzA=; b=hCImHbbY
 rEOm6CEZY67C8JZX8K9z9uWQDxDfkgmgjT1ZoS1NZ7QVZkm53KAOpQS89lvg7uIs
 q5IqChNuAMeFFdjVC+Uz3Swwf4iFuVDU/NuJ3FRQXm8MsBlRaNOzsHqO1HfyjJUd
 Y6edqDblw8wx2WP+XuloYTRG5ncUhxZFBfDzH392ZzmC8ErlFhtJ/efSk4uxqeU5
 VLYKpVtQjMSl3KxWa6zlQjKqHi9uUOd9azaADUgKiEZouvi9rby5aVcB9lwp6oKn
 4JYzMI3IWfnZbGuklJMC21o2YxzxWDdvCYB8lYt7AQgsNoT1OABj1Jma3r33kLrO
 99Vmd2Op9U0+1g==
X-ME-Sender: <xms:hvhxXfZXpFivldLXefAsn2bHdZfRK42o97hZbQC9NJa2VecxfJfudQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hvhxXSNMfRc5r8ZtgeP8rS-eVSvKw8AvXKGJH-zRsCLKd0SZ6lV_OA>
 <xmx:hvhxXbA8Um9CzD8PdCfiVemTxQE2GOHbC_E4PhSlA71CgbEJGE6y1Q>
 <xmx:hvhxXZJSpE6Pfl7XNRARfnAT_DdUhnp-jbbjloS2GSVba3b_L51RtQ>
 <xmx:h_hxXWW9qyOESaynEESKwJmt7Wq973a0Hb4VQubVx4sgZtCkPx_h4Q>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 65509D6005D;
 Fri,  6 Sep 2019 02:11:18 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu,  5 Sep 2019 23:11:17 -0700
Message-Id: <29bce768ca12da6bab0b35865917f4094380cf50.1567750222.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
References: <cover.1567750222.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: [Qemu-devel] [PATCH v4 6/6] hw/arm: Add the Netduino Plus 2
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS            |  6 +++++
 hw/arm/Kconfig         |  3 +++
 hw/arm/Makefile.objs   |  1 +
 hw/arm/netduinoplus2.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4aea8cb3fa..5f23865ce3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -828,6 +828,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/netduino2.c
 
+Netduino Plus 2
+M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: hw/arm/netduinoplus2.c
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 46a4f052e9..c153ac0975 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -101,6 +101,9 @@ config NETDUINOPLUS2
     bool
     select STM32F405_SOC
 
+config NETDUINOPLUS2
+    bool
+
 config NSERIES
     bool
     select OMAP
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 0191c22c4f..4267805dc9 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -11,6 +11,7 @@ obj-$(CONFIG_MAINSTONE) += mainstone.o
 obj-$(CONFIG_MICROBIT) += microbit.o
 obj-$(CONFIG_MUSICPAL) += musicpal.o
 obj-$(CONFIG_NETDUINO2) += netduino2.o
+obj-$(CONFIG_NETDUINOPLUS2) += netduinoplus2.o
 obj-$(CONFIG_NSERIES) += nseries.o
 obj-$(CONFIG_SX1) += omap_sx1.o
 obj-$(CONFIG_CHEETAH) += palm.o
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
new file mode 100644
index 0000000000..4a75da8543
--- /dev/null
+++ b/hw/arm/netduinoplus2.c
@@ -0,0 +1,58 @@
+/*
+ * Netduino Plus 2 Machine Model
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/arm/boot.h"
+
+static void netduinoplus2_init(MachineState *machine)
+{
+    DeviceState *dev;
+    uint32_t kernel_entry;
+
+    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+
+    kernel_entry = armv7m_load_kernel(ARM_CPU(first_cpu),
+                                      machine->kernel_filename,
+                                      FLASH_SIZE);
+
+    object_property_set_int(OBJECT(first_cpu), kernel_entry,
+                            "init-entry", &error_fatal);
+    object_property_set_int(OBJECT(first_cpu),
+                            SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3,
+                            "init-sp", &error_fatal);
+}
+
+static void netduinoplus2_machine_init(MachineClass *mc)
+{
+    mc->desc = "Netduino Plus 2 Machine";
+    mc->init = netduinoplus2_init;
+}
+
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
-- 
2.22.0


