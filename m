Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0AC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2CF214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="IVi0Dfxo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJt0JVfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2CF214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifxUk-0008WH-Ap
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 21:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1ifxQ6-0004Ti-5D
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1ifxQ4-0001Bo-Mi
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:37 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1ifxQ0-000102-A5; Fri, 13 Dec 2019 21:44:32 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 831142244E;
 Fri, 13 Dec 2019 21:44:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 13 Dec 2019 21:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=kUtIe6kqnG2Fw
 dUxin7eUzLqjVTtszz1wUf2bM5zKlw=; b=IVi0DfxoEiA4oMjBgdafS+GpKn01a
 pmRKtf3FLwliDIvpJbhmHVAMv0N8sfhHOOOFffarxyZSGWT+BZM1i53ZmGOWpXJW
 dLonJMGCZEeDyHT1NZdk5YzNFGmQp7jySBWI5raMXFQxrsskp1bZ168akxhWDXw/
 KgF8lC/htqEoSPNKJQm+fHuX7Cu3glA9b10gPM8Et3N4jIfNDIQbbrxFaQRFTffs
 vrc0ALX7Ao70lLQKbWy+UVcZmMesMIxBZ7isx2S3wZKO/PqYWyrU23WjJaTttsJk
 WusJX3kNFtxbxPvccidWZc4kkoSbcT5MBc9PGYpUKhV7hTCv/98hmxrvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=kUtIe6kqnG2FwdUxin7eUzLqjVTtszz1wUf2bM5zKlw=; b=WJt0JVfA
 odkbL40NFx8fkbar6h2WemXVyQ0G4jgCuxA225kzNDnQukym4H/VbHs7VVlf3gbX
 zX0NRHGsE9SvqcUi51bjWdY180dy+nUEIE7I2qy7TY73LN64oVdbDKL56h2Qtcur
 /Kh/azSj5sLfPyoPRxt79BenJRD6USdPu8z69lFnj5bA0gVv3sMMGbiah37jZV5Y
 pz5Y9wnmdTq0Jdd+msmZpZfig6lDKbR07qtrG+lOBOEeIjY1KeKBubYdrPle+OMm
 2Hr/tHJ1xSrlXQNa5b29nVH5F1YcaM1qQfaRePQI6dECChFGJvlCXm0kgXM9WbUi
 G7rNonqJFwt8HA==
X-ME-Sender: <xms:j0z0XRskb99kEjkqxXZZRJ6M1x8dnIryifSO4a-8B5HzWqIPA-zrwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddttddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:j0z0Xfc-zPV1C4kyOkl-S_U4lrKAccwo7GFZq74K2jy9sYCkbXkkXA>
 <xmx:j0z0XVqAqYHvo7Vj8WE-1tO5eRDYgdyX7Spsfz09-xO4wIy-x6MJqA>
 <xmx:j0z0Xd_FMrIYmgSPsxlQ6G-gkPL2DlFyN2ub0K9K7HFUjk7sH07HPA>
 <xmx:j0z0XbtXPxpc6xoe_IUTZBCHMskyTSzSeAQsc6x9B7KpeeQ_6bfI5g>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id A85518005A;
 Fri, 13 Dec 2019 21:44:30 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v6 4/4] hw/arm: Add the Netduino Plus 2
Date: Fri, 13 Dec 2019 18:44:29 -0800
Message-Id: <40f97ae32a6f21d8184c1cc46fad2defb302238d.1576227325.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1576227325.git.alistair@alistair23.me>
References: <cover.1576227325.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.29
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
Cc: alistair23@gmail.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS            |  6 +++++
 hw/arm/Kconfig         |  3 +++
 hw/arm/Makefile.objs   |  1 +
 hw/arm/netduinoplus2.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10230b3212..b9dd2a11bc 100644
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
index 7bfdc3a7ac..881e7f56e7 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -105,6 +105,9 @@ config NETDUINOPLUS2
     bool
     select STM32F405_SOC
 
+config NETDUINOPLUS2
+    bool
+
 config NSERIES
     bool
     select OMAP
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index d9d54da7cf..336f6dd374 100644
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
index 0000000000..e5e247edbe
--- /dev/null
+++ b/hw/arm/netduinoplus2.c
@@ -0,0 +1,52 @@
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
+#include "hw/qdev-properties.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/arm/boot.h"
+
+static void netduinoplus2_init(MachineState *machine)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       FLASH_SIZE);
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
2.24.0


