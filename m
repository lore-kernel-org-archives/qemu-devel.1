Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4539C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA1522249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFvROMWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA1522249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFVR-0004SP-QA
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVFQY-0006fK-Cn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVFQU-0006n8-NO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603291758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BY3LCRYb+EOeeGmcGqTicT4dxtI6Osvx8JYjEYugM00=;
 b=cFvROMWWGSq8fILxHtvMYNK6sp2+hkRvgBKhcw4lYF9LhobRAKl0+sOd4Rkm9Ld0k2f1HK
 MzEufVsUwNRwywqd7Ol1ZeJCoIVUhJApdtYBSlkNv7AaWQWaxHC4sXnG6MZ/Zb33OY4jng
 OkCU9VbiDVpav0QUa6bqmIrmwkHXSDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-cNzHLtwIN9qRjAK5j5F3Dw-1; Wed, 21 Oct 2020 10:49:15 -0400
X-MC-Unique: cNzHLtwIN9qRjAK5j5F3Dw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08B241888A37;
 Wed, 21 Oct 2020 14:48:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CDA25B4BE;
 Wed, 21 Oct 2020 14:48:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4EE5B9D10; Wed, 21 Oct 2020 16:48:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/17] apci: drop has_pci arg for acpi_build_madt
Date: Wed, 21 Oct 2020 16:48:40 +0200
Message-Id: <20201021144852.16665-6-kraxel@redhat.com>
In-Reply-To: <20201021144852.16665-1-kraxel@redhat.com>
References: <20201021144852.16665-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting x86ms->pci_irq_mask to zero has the same effect,
so we don't need the has_pci argument any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20201016113835.17465-6-kraxel@redhat.com
---
 hw/i386/acpi-common.h  |  3 +--
 hw/i386/acpi-build.c   |  2 +-
 hw/i386/acpi-common.c  | 25 +++++++++++--------------
 hw/i386/acpi-microvm.c |  2 +-
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index 9cac18dddf5b..c30e461f1854 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -9,7 +9,6 @@
 #define ACPI_BUILD_IOAPIC_ID 0x0
 
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev,
-                     bool has_pci);
+                     X86MachineState *x86ms, AcpiDeviceIf *adev);
 
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 45ad2f953341..e3a4bc206c4e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2477,7 +2477,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
-                    ACPI_DEVICE_IF(x86ms->acpi_dev), true);
+                    ACPI_DEVICE_IF(x86ms->acpi_dev));
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 1584abb3e6b0..8a769654060e 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -72,8 +72,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 }
 
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev,
-                     bool has_pci)
+                     X86MachineState *x86ms, AcpiDeviceIf *adev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
@@ -113,19 +112,17 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
         intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
     }
 
-    if (has_pci) {
-        for (i = 1; i < 16; i++) {
-            if (!(x86ms->pci_irq_mask & (1 << i))) {
-                /* No need for a INT source override structure. */
-                continue;
-            }
-            intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
-            intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
-            intsrcovr->length = sizeof(*intsrcovr);
-            intsrcovr->source = i;
-            intsrcovr->gsi    = cpu_to_le32(i);
-            intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
+    for (i = 1; i < 16; i++) {
+        if (!(x86ms->pci_irq_mask & (1 << i))) {
+            /* No need for a INT source override structure. */
+            continue;
         }
+        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
+        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
+        intsrcovr->length = sizeof(*intsrcovr);
+        intsrcovr->source = i;
+        intsrcovr->gsi    = cpu_to_le32(i);
+        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
     }
 
     if (x2apic_mode) {
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 8e2d2b7cff83..5efa89c32709 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -196,7 +196,7 @@ static void acpi_build_microvm(AcpiBuildTables *tables,
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
-                    ACPI_DEVICE_IF(x86ms->acpi_dev), x86ms->pci_irq_mask != 0);
+                    ACPI_DEVICE_IF(x86ms->acpi_dev));
 
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
-- 
2.27.0


