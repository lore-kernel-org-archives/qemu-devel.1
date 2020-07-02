Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031CC433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B70720672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBC1cvxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B70720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr6An-0007QS-Kz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 16:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr693-0004Ca-2J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:49:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr690-0003X7-7Y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593722957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=iZ8q6BNQD71G/ReGAtp/ZouIvCh6XyxiS1/Hett2Vw4=;
 b=dBC1cvxucaRCOutwDPUTpQSysJt58hYiPPjk+zVNV/sOqvEv3iZxeidqMxyihnooZ3+YAC
 HTui2NS5khdlSzSJLm+lAWyq5XHfnx5WiU9E1UeE4JXN4vFOrBATH2hb/yGgwMajjqMo+0
 ExSahQnL4Osvn1G90nZF4yvhq7DkMq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-t2U6IrGlPBGVrhw3hxrHkg-1; Thu, 02 Jul 2020 16:49:14 -0400
X-MC-Unique: t2U6IrGlPBGVrhw3hxrHkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAE2080183C;
 Thu,  2 Jul 2020 20:49:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BB685C1C5;
 Thu,  2 Jul 2020 20:49:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E7BEA31E62; Thu,  2 Jul 2020 22:48:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/21] acpi: ged: add control regs
Date: Thu,  2 Jul 2020 22:48:42 +0200
Message-Id: <20200702204859.9876-5-kraxel@redhat.com>
In-Reply-To: <20200702204859.9876-1-kraxel@redhat.com>
References: <20200702204859.9876-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add control regs (sleep, reset) for hw-reduced acpi.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/acpi/generic_event_device.h |  7 ++++
 hw/acpi/generic_event_device.c         | 44 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 90a9180db572..474c92198080 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -72,6 +72,12 @@
 #define ACPI_GED_EVT_SEL_OFFSET    0x0
 #define ACPI_GED_EVT_SEL_LEN       0x4
 
+#define ACPI_GED_REG_SLEEP_CTL     0x00
+#define ACPI_GED_REG_SLEEP_STS     0x01
+#define ACPI_GED_REG_RESET         0x02
+#define   ACPI_GED_RESET_VALUE     0x42
+#define ACPI_GED_REG_COUNT         0x03
+
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
 #define AML_GED_EVT_SEL "ESEL"
@@ -87,6 +93,7 @@
 
 typedef struct GEDState {
     MemoryRegion evt;
+    MemoryRegion regs;
     uint32_t     sel;
 } GEDState;
 
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index b8abdefa1c77..491df80a5cc7 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
+#include "sysemu/runstate.h"
 
 static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
@@ -176,6 +177,45 @@ static const MemoryRegionOps ged_evt_ops = {
     },
 };
 
+static uint64_t ged_regs_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
+                           unsigned int size)
+{
+    bool slp_en;
+    int slp_typ;
+
+    switch (addr) {
+    case ACPI_GED_REG_SLEEP_CTL:
+        slp_typ = (data >> 2) & 0x07;
+        slp_en  = (data >> 5) & 0x01;
+        if (slp_en && slp_typ == 5) {
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        }
+        return;
+    case ACPI_GED_REG_SLEEP_STS:
+        return;
+    case ACPI_GED_REG_RESET:
+        if (data == ACPI_GED_RESET_VALUE) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        }
+        return;
+    }
+}
+
+static const MemoryRegionOps ged_regs_ops = {
+    .read = ged_regs_read,
+    .write = ged_regs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
 static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
@@ -332,6 +372,10 @@ static void acpi_ged_initfn(Object *obj)
      sysbus_init_mmio(sbd, &s->container_memhp);
      acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
                               &s->memhp_state, 0);
+
+    memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
+                          TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
+    sysbus_init_mmio(sbd, &ged_st->regs);
 }
 
 static void acpi_ged_class_init(ObjectClass *class, void *data)
-- 
2.18.4


