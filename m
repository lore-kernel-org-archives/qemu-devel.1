Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99329C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E8420700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAVtVSvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E8420700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxZc-00063V-9S
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXy-0003hn-Ht
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXx-0003zH-Cy
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jRxXw-0003uw-T7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id i10so10585164wrv.10
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ErYhhtGatTVVSppf6eN8KOXRLomnBrdur/FAKDAYlG4=;
 b=nAVtVSvX7R8tpzoNNeMDdSsBtyreGPIqjo4FK0+uKDVBugZKJSMsBf+mi9laxSiC2n
 X8x0RZwhEQlXdCexLRKqOwLaOb8EOnyG0FJXQW8gAcQpItoO3YUBGo5qsMSt95OgYd6V
 nqJl7kJ+/daMD9z6sVIe8vvbkuuBn1k/OsrBZFnsMsiV+HOJhvz8zx0gLAM8kaK+8Iv4
 2L9dfhB5isHjHg2maxPfdEJR4NmGYO7WeRR6HDwQQPOq4afUqvlMhIfBwR/XCHQPw4Ar
 2xbb0eYQ1cRfK3DNOqsnXCyYyuYda74whHOLEeh5ytMocgUNMcs398uHtHMZP4PetLnk
 usuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ErYhhtGatTVVSppf6eN8KOXRLomnBrdur/FAKDAYlG4=;
 b=JEAX4afk6cALP6olq91HJid6emlV/Wqc7PzfTH2eh868vqolI+nt0hAh7i1AKnfJ+C
 j1HryQ7A2XSpD/r87dKb4WQS9efs1WxZKJmBLvEB2c2x703jfImR7m5Ivgr+uoYIJoNc
 2MnmKMjwAeMHNh/iqYL31tXqX2ry27voQSnH4iXw6ZbisVyajaL0VgTj5JPbeslCnMIT
 1jbFnoPrfqrYhiqGm9f9WJs+fEznWQWrN0kjaj3iCEjsI4wKRWw5jNtVB5oUMAg754cu
 7e+rZWXYqI+K3wcG6MqNImCsRsft7Bm/Xh1ipqe03LPudtrhBe3NzctdvxOz204dnu9F
 nNag==
X-Gm-Message-State: AGi0PuaeIs8Pfn+KmmcHHI3jsnHjJEzWCp3tkfWb0XE5n6BJfoNfO0im
 UDnS1ZYyDqqGD1AJs2pAlRlw0TthsZVNfA==
X-Google-Smtp-Source: APiQypICdiXRsZZsiYBGuL7igP3ZGuICITI9FTzxfFaXmqGim04UliazAWQ8vRXjfd1XW/jQx7rFkQ==
X-Received: by 2002:a05:6000:8f:: with SMTP id
 m15mr10898209wrx.19.1587731707288; 
 Fri, 24 Apr 2020 05:35:07 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 91sm8462859wra.37.2020.04.24.05.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 05:35:06 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Date: Fri, 24 Apr 2020 15:34:43 +0300
Message-Id: <20200424123444.3481728-6-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424123444.3481728-1-arilou@gmail.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
index 1f5873ab60..0df7afe0ca 100644
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


