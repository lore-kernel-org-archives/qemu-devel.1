Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B6AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40B9207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4QWTtkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40B9207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisuw-0004Du-4Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOH-0004gQ-EZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOF-0000gW-6V
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SkTpw3tlfOMxd2u5FlY1lVrn4tytemDjVdlXjNxP9Y=;
 b=O4QWTtkTO2wWbriYBJu0MUWACn2iCEcgiPq7KMx85RdscqLyql5Jk9LL0Ocr/oy5AZzkTS
 7I0mkn/fENVFpdmd2b6qL5RSlcWcFLtwaFcmdh76qXXP3+dasiidvZGaZhcr7c5MmiNwId
 JtMqgcqSwDuDrbMZukvh2stgOCo43Ck=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-EpgAQpmOMjuxVJy7jGXBnA-1; Wed, 10 Jun 2020 00:28:34 -0400
X-MC-Unique: EpgAQpmOMjuxVJy7jGXBnA-1
Received: by mail-wr1-f69.google.com with SMTP id e7so506333wrp.14
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4SkTpw3tlfOMxd2u5FlY1lVrn4tytemDjVdlXjNxP9Y=;
 b=rR9VAZ0c2P0q8CnE5MCWy8dcK99EUEvvoxxgzT248DLyQizi1wMXen8w4DCiLDP6Yu
 6+6VUhKHyzcp5wLqQuThAcCSKfEgOcQgdy7DMOv2k7O2i38bjaa+RjtwVkqckNRvPG49
 iFs1vJBarhwz37VYFUnewbpqWhu0Tt5maLBDzH25ACqRWJ35z2Um/xTDxLvDTJud7MNn
 XPtH+J2GriFrwrtD81/MWSoDLc3ZPpBTZ9EZmosTVUFPlstRaFczZzu4YR6CksOhqPvY
 10XOb5u0liemkF2YCg0w9t5vHhBpq6KpQfSPLBhfyNAsQcY2d/b2wr/29wnKFFvn0f7B
 wk7A==
X-Gm-Message-State: AOAM532ssoeLEU8bwNoT4Az/9OZ6oY6aIdDNhjdeLOQ7sSdDFs9paM9K
 GpuT/+rcoC62y+KC9VHNtJegYBka3BS+QWUKc9d9AVSdG/8KhdphOeGiZ8xekBo+1DN3f01DK6+
 FyUviJ2C5bo6jH60=
X-Received: by 2002:a1c:6606:: with SMTP id a6mr1112622wmc.37.1591763312515;
 Tue, 09 Jun 2020 21:28:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEi65OSmdy5x+pv5tsfV+BPafx19c2ru710FTsEufaqgufAOcKfulzcA2+kSgY6r8BGMGjxg==
X-Received: by 2002:a1c:6606:: with SMTP id a6mr1112592wmc.37.1591763312052;
 Tue, 09 Jun 2020 21:28:32 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id q11sm6124419wrv.67.2020.06.09.21.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:31 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/56] acpi: create acpi-common.c and move madt code
Message-ID: <20200610042613.1459309-53-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

We'll need madt support for microvm.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200520132003.9492-7-kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-common.h |  14 ++++
 hw/i386/acpi-build.c  | 126 +---------------------------------
 hw/i386/acpi-common.c | 152 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/Makefile.objs |   1 +
 4 files changed, 170 insertions(+), 123 deletions(-)
 create mode 100644 hw/i386/acpi-common.h
 create mode 100644 hw/i386/acpi-common.c

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
new file mode 100644
index 0000000000..c30e461f18
--- /dev/null
+++ b/hw/i386/acpi-common.h
@@ -0,0 +1,14 @@
+#ifndef HW_I386_ACPI_COMMON_H
+#define HW_I386_ACPI_COMMON_H
+#include "include/hw/acpi/acpi_dev_interface.h"
+
+#include "include/hw/acpi/bios-linker-loader.h"
+#include "include/hw/i386/x86.h"
+
+/* Default IOAPIC ID */
+#define ACPI_BUILD_IOAPIC_ID 0x0
+
+void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
+                     X86MachineState *x86ms, AcpiDeviceIf *adev);
+
+#endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d217fc1fe6..26c0c8aefa 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qnum.h"
 #include "acpi-build.h"
+#include "acpi-common.h"
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
@@ -89,9 +90,6 @@
 #define ACPI_BUILD_DPRINTF(fmt, ...)
 #endif
 
-/* Default IOAPIC ID */
-#define ACPI_BUILD_IOAPIC_ID 0x0
-
 typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
@@ -327,124 +325,6 @@ build_facs(GArray *table_data)
     facs->length = cpu_to_le32(sizeof(*facs));
 }
 
-void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
-                       const CPUArchIdList *apic_ids, GArray *entry)
-{
-    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
-
-    /* ACPI spec says that LAPIC entry for non present
-     * CPU may be omitted from MADT or it must be marked
-     * as disabled. However omitting non present CPU from
-     * MADT breaks hotplug on linux. So possible CPUs
-     * should be put in MADT but kept disabled.
-     */
-    if (apic_id < 255) {
-        AcpiMadtProcessorApic *apic = acpi_data_push(entry, sizeof *apic);
-
-        apic->type = ACPI_APIC_PROCESSOR;
-        apic->length = sizeof(*apic);
-        apic->processor_id = uid;
-        apic->local_apic_id = apic_id;
-        if (apic_ids->cpus[uid].cpu != NULL) {
-            apic->flags = cpu_to_le32(1);
-        } else {
-            apic->flags = cpu_to_le32(0);
-        }
-    } else {
-        AcpiMadtProcessorX2Apic *apic = acpi_data_push(entry, sizeof *apic);
-
-        apic->type = ACPI_APIC_LOCAL_X2APIC;
-        apic->length = sizeof(*apic);
-        apic->uid = cpu_to_le32(uid);
-        apic->x2apic_id = cpu_to_le32(apic_id);
-        if (apic_ids->cpus[uid].cpu != NULL) {
-            apic->flags = cpu_to_le32(1);
-        } else {
-            apic->flags = cpu_to_le32(0);
-        }
-    }
-}
-
-static void
-build_madt(GArray *table_data, BIOSLinker *linker,
-           X86MachineState *x86ms, AcpiDeviceIf *adev)
-{
-    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
-    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
-    int madt_start = table_data->len;
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
-    bool x2apic_mode = false;
-
-    AcpiMultipleApicTable *madt;
-    AcpiMadtIoApic *io_apic;
-    AcpiMadtIntsrcovr *intsrcovr;
-    int i;
-
-    madt = acpi_data_push(table_data, sizeof *madt);
-    madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
-    madt->flags = cpu_to_le32(1);
-
-    for (i = 0; i < apic_ids->len; i++) {
-        adevc->madt_cpu(adev, i, apic_ids, table_data);
-        if (apic_ids->cpus[i].arch_id > 254) {
-            x2apic_mode = true;
-        }
-    }
-
-    io_apic = acpi_data_push(table_data, sizeof *io_apic);
-    io_apic->type = ACPI_APIC_IO;
-    io_apic->length = sizeof(*io_apic);
-    io_apic->io_apic_id = ACPI_BUILD_IOAPIC_ID;
-    io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
-    io_apic->interrupt = cpu_to_le32(0);
-
-    if (x86ms->apic_xrupt_override) {
-        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
-        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
-        intsrcovr->length = sizeof(*intsrcovr);
-        intsrcovr->source = 0;
-        intsrcovr->gsi    = cpu_to_le32(2);
-        intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
-    }
-    for (i = 1; i < 16; i++) {
-#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
-        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
-            /* No need for a INT source override structure. */
-            continue;
-        }
-        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
-        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
-        intsrcovr->length = sizeof(*intsrcovr);
-        intsrcovr->source = i;
-        intsrcovr->gsi    = cpu_to_le32(i);
-        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
-    }
-
-    if (x2apic_mode) {
-        AcpiMadtLocalX2ApicNmi *local_nmi;
-
-        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
-        local_nmi->type   = ACPI_APIC_LOCAL_X2APIC_NMI;
-        local_nmi->length = sizeof(*local_nmi);
-        local_nmi->uid    = 0xFFFFFFFF; /* all processors */
-        local_nmi->flags  = cpu_to_le16(0);
-        local_nmi->lint   = 1; /* ACPI_LINT1 */
-    } else {
-        AcpiMadtLocalNmi *local_nmi;
-
-        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
-        local_nmi->type         = ACPI_APIC_LOCAL_NMI;
-        local_nmi->length       = sizeof(*local_nmi);
-        local_nmi->processor_id = 0xff; /* all processors */
-        local_nmi->flags        = cpu_to_le16(0);
-        local_nmi->lint         = 1; /* ACPI_LINT1 */
-    }
-
-    build_header(linker, table_data,
-                 (void *)(table_data->data + madt_start), "APIC",
-                 table_data->len - madt_start, 1, NULL, NULL);
-}
-
 static void build_append_pcihp_notify_entry(Aml *method, int slot)
 {
     Aml *if_ctx;
@@ -2707,8 +2587,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, x86ms,
-               ACPI_DEVICE_IF(pcms->acpi_dev));
+    acpi_build_madt(tables_blob, tables->linker, x86ms,
+                    ACPI_DEVICE_IF(pcms->acpi_dev));
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
new file mode 100644
index 0000000000..5caca16a0b
--- /dev/null
+++ b/hw/i386/acpi-common.c
@@ -0,0 +1,152 @@
+/* Support for generating ACPI tables and passing them to Guests
+ *
+ * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
+ * Copyright (C) 2006 Fabrice Bellard
+ * Copyright (C) 2013 Red Hat Inc
+ *
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+
+#include "exec/memory.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
+#include "hw/i386/pc.h"
+#include "target/i386/cpu.h"
+
+#include "acpi-build.h"
+#include "acpi-common.h"
+
+void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
+                       const CPUArchIdList *apic_ids, GArray *entry)
+{
+    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
+
+    /* ACPI spec says that LAPIC entry for non present
+     * CPU may be omitted from MADT or it must be marked
+     * as disabled. However omitting non present CPU from
+     * MADT breaks hotplug on linux. So possible CPUs
+     * should be put in MADT but kept disabled.
+     */
+    if (apic_id < 255) {
+        AcpiMadtProcessorApic *apic = acpi_data_push(entry, sizeof *apic);
+
+        apic->type = ACPI_APIC_PROCESSOR;
+        apic->length = sizeof(*apic);
+        apic->processor_id = uid;
+        apic->local_apic_id = apic_id;
+        if (apic_ids->cpus[uid].cpu != NULL) {
+            apic->flags = cpu_to_le32(1);
+        } else {
+            apic->flags = cpu_to_le32(0);
+        }
+    } else {
+        AcpiMadtProcessorX2Apic *apic = acpi_data_push(entry, sizeof *apic);
+
+        apic->type = ACPI_APIC_LOCAL_X2APIC;
+        apic->length = sizeof(*apic);
+        apic->uid = cpu_to_le32(uid);
+        apic->x2apic_id = cpu_to_le32(apic_id);
+        if (apic_ids->cpus[uid].cpu != NULL) {
+            apic->flags = cpu_to_le32(1);
+        } else {
+            apic->flags = cpu_to_le32(0);
+        }
+    }
+}
+
+void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
+                     X86MachineState *x86ms, AcpiDeviceIf *adev)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
+    int madt_start = table_data->len;
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
+    bool x2apic_mode = false;
+
+    AcpiMultipleApicTable *madt;
+    AcpiMadtIoApic *io_apic;
+    AcpiMadtIntsrcovr *intsrcovr;
+    int i;
+
+    madt = acpi_data_push(table_data, sizeof *madt);
+    madt->local_apic_address = cpu_to_le32(APIC_DEFAULT_ADDRESS);
+    madt->flags = cpu_to_le32(1);
+
+    for (i = 0; i < apic_ids->len; i++) {
+        adevc->madt_cpu(adev, i, apic_ids, table_data);
+        if (apic_ids->cpus[i].arch_id > 254) {
+            x2apic_mode = true;
+        }
+    }
+
+    io_apic = acpi_data_push(table_data, sizeof *io_apic);
+    io_apic->type = ACPI_APIC_IO;
+    io_apic->length = sizeof(*io_apic);
+    io_apic->io_apic_id = ACPI_BUILD_IOAPIC_ID;
+    io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
+    io_apic->interrupt = cpu_to_le32(0);
+
+    if (x86ms->apic_xrupt_override) {
+        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
+        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
+        intsrcovr->length = sizeof(*intsrcovr);
+        intsrcovr->source = 0;
+        intsrcovr->gsi    = cpu_to_le32(2);
+        intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
+    }
+    for (i = 1; i < 16; i++) {
+#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
+        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
+            /* No need for a INT source override structure. */
+            continue;
+        }
+        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
+        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
+        intsrcovr->length = sizeof(*intsrcovr);
+        intsrcovr->source = i;
+        intsrcovr->gsi    = cpu_to_le32(i);
+        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
+    }
+
+    if (x2apic_mode) {
+        AcpiMadtLocalX2ApicNmi *local_nmi;
+
+        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
+        local_nmi->type   = ACPI_APIC_LOCAL_X2APIC_NMI;
+        local_nmi->length = sizeof(*local_nmi);
+        local_nmi->uid    = 0xFFFFFFFF; /* all processors */
+        local_nmi->flags  = cpu_to_le16(0);
+        local_nmi->lint   = 1; /* ACPI_LINT1 */
+    } else {
+        AcpiMadtLocalNmi *local_nmi;
+
+        local_nmi = acpi_data_push(table_data, sizeof *local_nmi);
+        local_nmi->type         = ACPI_APIC_LOCAL_NMI;
+        local_nmi->length       = sizeof(*local_nmi);
+        local_nmi->processor_id = 0xff; /* all processors */
+        local_nmi->flags        = cpu_to_le16(0);
+        local_nmi->lint         = 1; /* ACPI_LINT1 */
+    }
+
+    build_header(linker, table_data,
+                 (void *)(table_data->data + madt_start), "APIC",
+                 table_data->len - madt_start, 1, NULL, NULL);
+}
+
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 8ce1b26533..6abc74551a 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -16,4 +16,5 @@ obj-$(CONFIG_VMMOUSE) += vmmouse.o
 obj-$(CONFIG_PC) += port92.o
 
 obj-y += kvmvapic.o
+obj-$(CONFIG_ACPI) += acpi-common.o
 obj-$(CONFIG_PC) += acpi-build.o
-- 
MST


