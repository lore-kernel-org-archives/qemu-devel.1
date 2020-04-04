Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BD9C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475F2206F5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W54ReRyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475F2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKeFq-0003NZ-Dh
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKeBF-0005ts-1h
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKeBD-0001zz-M8
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKeBD-0001zD-G6
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id w15so4997693wrv.10
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yrfrmdPGmGItN4XLD5ZGlQ5Yc/DzcjcAfVJzfsmvkBc=;
 b=W54ReRyZ0VjCw7pMoJzT4Mdo9VV1lHlUFZc0TLBLOJ69/44cTnQsrg1bqj+DKye9Iz
 ltOcCKH457U0K3Ung8SXvPaLrCTqSlHJWrQnR/Qqf/6kRJ5jY+uMX3pEGav4U0y3P/xW
 7Lb7kMB/1MMVEgpBdmpEXPEIP+wZLyalmJg62uAZvIXT5ZLX9pa3U7B6ti4S/0SnyXkJ
 BmDoxdSJDhBDlSFI6uVSiEzWanLUzsEMSXQnoJRF/70xFn7ufRxsFERt+AfZLKTaGHBw
 dBzXieET0B+l+yNVxV+AQPdafs/rZgRoQO1zU2d/VpEL2zgKM4BJ/lbZkjO67RqMDxco
 zhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yrfrmdPGmGItN4XLD5ZGlQ5Yc/DzcjcAfVJzfsmvkBc=;
 b=QG7mbi4aVTVbil7mTMyY+yr40It2rxh3Gx3ylOurn218+ogwkKv166tD/PsSobrllh
 FcapsxCdldBNkyfZ6VDlkrPVMTkf6cfzx8wwUqLO1vGcEAg+q/kNuQbWZcBHzIcCKbCE
 T+4SlbYbCBwTOjRYtOa8xQ3xC0pV+u7zMltbsaXALDHSLRyOv8L5nXbl5+IAfLxTtXG9
 CKnLjk/z5ehcpES0weeyit11SXanH4fvZ5dmwhNqdr2ogo5pvntN9UZ04o4w4NJGVnfq
 CDBZwU75dIoGenzUHF4WVvTWkEJRJhoqyiIkclfpptUy6r4j126tyT8HSSR2lEfDhXqk
 M/FA==
X-Gm-Message-State: AGi0PuaPoml4EdXvxnjVOqacl4Qy1jwwV8raeiYo3cL4r+RNr03y4LI2
 cvwYSibGoVtB6vLLJfPs8VY85RhiM81uYw==
X-Google-Smtp-Source: APiQypL8JEc+yJ+9G/dIQqe2G6hDUNljqteCPamxvRvLF3yI3dDw08oDv9mFR+vgdM4JNiI65630Jg==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr6351749wrt.326.1585988966367; 
 Sat, 04 Apr 2020 01:29:26 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-40.inter.net.il. [84.229.155.40])
 by smtp.gmail.com with ESMTPSA id
 a10sm15884778wrm.87.2020.04.04.01.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 01:29:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] i386: Hyper-V VMBus ACPI DSDT entry
Date: Sat,  4 Apr 2020 11:28:59 +0300
Message-Id: <20200404082900.33711-7-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404082900.33711-1-arilou@gmail.com>
References: <20200404082900.33711-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 pbonzini@redhat.com, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Guest OS uses ACPI to discover VMBus presence.  Add a corresponding
entry to DSDT in case VMBus has been enabled.

Experimentally Windows guests were found to require this entry to
include two IRQ resources. They seem to never be used but they still
have to be there.

Make IRQ numbers user-configurable via corresponding properties; use 7
and 13 by default.

Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/vmbus.c                |  7 ++++++
 hw/i386/acpi-build.c             | 43 ++++++++++++++++++++++++++++++++
 include/hw/hyperv/vmbus-bridge.h |  3 +++
 3 files changed, 53 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 4baf1d1266..46c6f5eebb 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2641,6 +2641,12 @@ static const VMStateDescription vmstate_vmbus_bridge = {
     },
 };
 
+static Property vmbus_bridge_props[] = {
+    DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
+    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -2651,6 +2657,7 @@ static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
     sk->explicit_ofw_unit_address = vmbus_bridge_ofw_unit_address;
     set_bit(DEVICE_CATEGORY_BRIDGE, k->categories);
     k->vmsd = &vmstate_vmbus_bridge;
+    device_class_set_props(k, vmbus_bridge_props);
     /* override SysBusDevice's default */
     k->user_creatable = true;
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2a7e55bae7..d235074fb8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -50,6 +50,7 @@
 #include "hw/mem/nvdimm.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
+#include "hw/hyperv/vmbus-bridge.h"
 
 /* Supported chipsets: */
 #include "hw/southbridge/piix.h"
@@ -1270,9 +1271,47 @@ static Aml *build_com_device_aml(uint8_t uid)
     return dev;
 }
 
+static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
+{
+    Aml *dev;
+    Aml *method;
+    Aml *crs;
+
+    dev = aml_device("VMBS");
+    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
+    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
+
+    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
+                                     aml_name("STA")));
+    aml_append(dev, method);
+
+    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
+                                     aml_name("STA")));
+    aml_append(dev, method);
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_name("STA")));
+    aml_append(dev, method);
+
+    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
+    /* FIXME: newer HyperV gets by with only one IRQ */
+    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    return dev;
+}
+
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
+    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     bool ambiguous;
 
     Aml *scope = aml_scope("_SB.PCI0.ISA");
@@ -1296,6 +1335,10 @@ static void build_isa_devices_aml(Aml *table)
         build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     }
 
+    if (vmbus_bridge) {
+        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
+    }
+
     aml_append(table, scope);
 }
 
diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
index 9cc8f780de..c0a06d832c 100644
--- a/include/hw/hyperv/vmbus-bridge.h
+++ b/include/hw/hyperv/vmbus-bridge.h
@@ -19,6 +19,9 @@ typedef struct VMBus VMBus;
 typedef struct VMBusBridge {
     SysBusDevice parent_obj;
 
+    uint8_t irq0;
+    uint8_t irq1;
+
     VMBus *bus;
 } VMBusBridge;
 
-- 
2.24.1


