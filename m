Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDAC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEAA20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgQukXrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEAA20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXcG-0004R4-Uc
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSP-0004CO-Vl
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSO-0005Pc-Ma
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSO-0005Ny-E4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id r16so15528502wrl.11
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9SctNReWxhEE3cMWEX6p+uUNHMIHY/fb8Bqmz63WdR4=;
 b=RgQukXrfhDk9U6VLTwaL94F0+GEQYpzHt9aH/mSzmEFJPF/o0QUHhM4HaJ0NkmedIB
 CMfKSe/9NMIfzdXJuc0C58UXQ1/tb1pWsA2Y3pPWCcQEFnMfw6qkwUU2Kq2enIetEs4M
 RqP6jQYjn9AaTGJPN5lg+quL6BZzS8qy2r4KasUVOpPRGQzoXtzPKHvoHgHfGcp2YImg
 8/4P7/myjbG/w9TJ/uq1qwkHlRYCumjKTAeSEkFO9OHWYdHFZrCO7/xzpyurmtf7fObp
 ZbnkoEs6/jR+oA5XE8HsIZiBtKIUjGHM611WTqv/Syu3KCAL4TKVq5IqViL9bATttOhl
 jVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9SctNReWxhEE3cMWEX6p+uUNHMIHY/fb8Bqmz63WdR4=;
 b=mie8JhfGhXgL/MIY8EEMpcPlGk8yCZX9vCnndpX789l70tZ91lUrbzG1+R7FpFYkDN
 Teix2GS55t8Dz6FBQ8lCCb+wWnCKkbpvyTAVAiUpf8ZLvWBWRcWpfr7+FSCn1Uz+E4CV
 NrI3d0g1Jt64LOvug3Fvvrb5AM6njTEwJKFfUZUqoqXnt9ipIiXB6Xx9UDE4vleKDVHl
 d+/P4eF84oBHQCTDlp8caprLQMvZu3JpEVybaZxlbSBh7Wv8E9yLINSiqhpvMekF5aU6
 PmwUOO9aZFmlb3I2X1+4n0ssbr+f36BUeXDF3jZ79wsGxJE7KqTReGl+tc9zOSsrRQtw
 vpTw==
X-Gm-Message-State: APjAAAU7J7racoWdtzwO2RjcF22VAkk9XnvkPLNvqekt4yPzsn2Ifw41
 A5aQoLYYwJGkkltZmlUbudN8n85/
X-Google-Smtp-Source: APXvYqw/+IZ/snn4T9+g/yNeUZATXLbOk5a0vVi69maJqE87fahpMwL6MmmCau8T32QC8LBlzyU6kw==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr26801694wrs.348.1561415339334; 
 Mon, 24 Jun 2019 15:28:59 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:44 +0200
Message-Id: <20190624222844.26584-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [RFC PATCH 10/10] hw/pci-host/gt64120: Clean the
 decoded address space
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SysAd bus is split in various address spaces.
Declare the different regions separately, this helps a lot
while tracing different access while debugging.

We also add the PCI1 ranges.

See 'GT-64120A System Controller' datasheet Rev, 1.1,
"Table 15: CPU and Device Decoder Default Address Mapping"

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
While this device is modelled toward the Malta board, it is generic.
---
 hw/mips/mips_malta.c  |  6 ------
 hw/pci-host/gt64120.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 97f8ffbf1b..d6e4a0dad9 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -53,7 +53,6 @@
 #include "sysemu/qtest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/misc/empty_slot.h"
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
@@ -1209,11 +1208,6 @@ void mips_malta_init(MachineState *machine)
     DeviceState *dev = qdev_create(NULL, TYPE_MIPS_MALTA);
     MaltaState *s = MIPS_MALTA(dev);
 
-    /* The whole address space decoded by the GT-64120A doesn't generate
-       exception when accessing invalid memory. Create an empty slot to
-       emulate this feature. */
-    empty_slot_init("gt64120-ad", 0x00000000, 0x20000000);
-
     qdev_init_nofail(dev);
 
     /* create CPU */
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 5209038ee5..6eaa571994 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -31,6 +31,8 @@
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
+#include "hw/misc/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "trace.h"
 
 #define GT_REGS                 (0x1000 >> 2)
@@ -1206,6 +1208,23 @@ PCIBus *gt64120_create(qemu_irq *pic, bool target_is_bigendian)
                           "isd-mem", 0x1000);
 
     pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
+
+    create_unimplemented_device("gt64120_i2o", 0x14000000, 256);
+
+    empty_slot_init("SCS0",     0x00000000, 8 * MiB);
+    empty_slot_init("SCS1",     0x00800000, 8 * MiB);
+    empty_slot_init("SCS2",     0x01000000, 8 * MiB);
+    empty_slot_init("SCS3",     0x01800000, 8 * MiB);
+    empty_slot_init("CS0",      0x1c000000, 8 * MiB);
+    empty_slot_init("CS1",      0x1c800000, 8 * MiB);
+    empty_slot_init("CS2",      0x1d000000, 32 * MiB);
+    empty_slot_init("CS3",      0x1f000000, 12 * MiB);
+    empty_slot_init("BootCS",   0x1fc00000, 4 * MiB);
+
+    create_unimplemented_device("pci1-io", 0x20000000, 32 * MiB);
+    empty_slot_init("pci1-mem0", 0x22000000, 32 * MiB);
+    empty_slot_init("pci1-mem1", 0x24000000, 32 * MiB);
+
     return phb->bus;
 }
 
-- 
2.19.1


