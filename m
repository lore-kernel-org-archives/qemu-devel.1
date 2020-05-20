Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4E32070A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grEMs9Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4E32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOi3-0001xS-LH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOeC-0002BI-Fb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOe9-0000I9-Vh
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589980833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=y4l/wLNM+Ws5zx05lfTKUy0HcJz6AmubwM0kMg2Czgk=;
 b=grEMs9WzUeLWzbYwL/KOqkHtSCDSRKUp6NxHeQmiQXNtC+nJot88ri6pbXMG9wnms6W6nh
 TOezBfGFyZu36XLaihrRgaFLkhuZ8xTuzxXH0kT3v59wpIQAyvumrVAi3mvnihAddvbJrR
 uql2ED9i9W+LAQI9SYxpy65DR5QgCFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-xEFuaHAUMYKws5UVsgIEeQ-1; Wed, 20 May 2020 09:20:31 -0400
X-MC-Unique: xEFuaHAUMYKws5UVsgIEeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE9E31005510;
 Wed, 20 May 2020 13:20:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF3065D9CA;
 Wed, 20 May 2020 13:20:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 060249D59; Wed, 20 May 2020 15:20:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/22] acpi: ged: add control regs
Date: Wed, 20 May 2020 15:19:51 +0200
Message-Id: <20200520132003.9492-11-kraxel@redhat.com>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
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
index 1cb34111e59a..3072fb4ab32b 100644
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
@@ -305,6 +345,10 @@ static void acpi_ged_initfn(Object *obj)
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


