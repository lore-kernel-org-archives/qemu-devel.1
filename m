Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF31C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B3B222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="q6CLkcWN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NGzn1KMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B3B222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihoLp-00011a-9d
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 00:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1ihoHA-0004j3-9I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1ihoH7-0003Yd-VT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:23:04 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1ihoH5-0003CM-0z; Thu, 19 Dec 2019 00:22:59 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id CEF54489;
 Thu, 19 Dec 2019 00:22:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 19 Dec 2019 00:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=fqnBMewqCOATa
 fjXZmyB+vZHiX5owZHz7dR6tUsw22Y=; b=q6CLkcWNePuJvyfd4Z6BVPbGBJlvj
 zWP5YX9uV8JgTlCa2ukwFe0h0ymCkSiWmihJVUgocDBbKmWyG63seE6igj+Asebh
 f+gPWK2kaDW/7xJtVYgQ43wTYcZaLMKMEJLYYZ3QlJpE32Kro+4O0H9eweJNS8e/
 9S9QTX6yMuIkGC5fQ/3j1joYS0y0MRprFPgQohp4p0e/Vv0B8ELiQvNtxnf+W8EE
 2tXEgcgjW6EC3hlS64V87ivUQqmPGrl02sB+++dd+kZrx1ba3CYgWmkPfPGvbQSp
 dihSfv0cXzTyP0F3WAUmu2zr9Zi4nfkDp4pYHoj+6XupnBW75ytegJ46g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=fqnBMewqCOATafjXZmyB+vZHiX5owZHz7dR6tUsw22Y=; b=NGzn1KMs
 eq2d6UNtlWCMmQbpMYnO5qiFOtnFmBn0nHFV5jW7A90ki6368mJjTKEPkFvjUCbs
 oSKWtU+yhj9J6WPXjTMns+m5dBpflkO9lsNgP/Z4739Wl2Fz+79svPWxlRGMHi7L
 og3KqGnok4ALHZ6+Eawy8gLma5DmcdgqokJO2Au2Zu+Ir+FIDgSvTOFD9lDnahR1
 HN/Qw0lI/fxEKMlIY7L8ZIyavow8GN2Qwz5NXBbmxpe2ewC1oD31NpeK6KN2taMM
 vO0h/Flzj/Rqjhuga+baMt67hA4vVXwyF88qrdsWTy6n1VZerJ564asAyxlgEOq8
 hcwYRQXi5Ny9rw==
X-ME-Sender: <xms:MQn7XaRncktuIFwIygiYGnIe3_w8_KWdzCK-EH5OzJWDUv70KTjwrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddutddgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:MQn7XdmGI4VwGuNUOtniK09tG66jxoIJcvAgvxaw_5nn_ueYK0vUAw>
 <xmx:MQn7XSSWlMZH-t0pjfVtwPuThH_HJdcpyFkivGC1e9PIi1tu5OwP6w>
 <xmx:MQn7XTOT7vvK9N-Zo7oi1P4uMuOuo5uYI1465VwuW9xYDfpiDg7yPQ>
 <xmx:MQn7XeclT1D6iCTRI0oX-2cJYovGl7MA10QFUImohXMbKmhjTQ99Mw>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9632080059;
 Thu, 19 Dec 2019 00:22:56 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 philmd@redhat.com
Subject: [PATCH v7 4/4] hw/arm: Add the Netduino Plus 2
Date: Wed, 18 Dec 2019 21:22:55 -0800
Message-Id: <dad8d8d47f7625913e35e27a1c00f603a6b08f9a.1576658572.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1576658572.git.alistair@alistair23.me>
References: <cover.1576658572.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.20
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS            |  6 +++++
 hw/arm/Makefile.objs   |  1 +
 hw/arm/netduinoplus2.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bda53628a5..203ced66e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -829,6 +829,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
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


