Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A37C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EC4206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJRT//Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EC4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxuz-0006Rh-07
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr4-0000Nh-0q
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr1-0003T1-3q
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkzOmJ453aBGs+rRX72gsPbaw2iO6z3DgUXBGV9tl0M=;
 b=AJRT//PerhQCufEqzRbvx0hFvFjcptxOmlQCTeeqlXF9L+6lrw9I1vJLI5DNt1DGBOm7Mq
 KgA9k5OJ2nLiDtFPUkyQySfYi4vaA/uFVmJYdA0W0nWYi1hRYbv64famjzYbNZmhD+GrMU
 EvGLndBbFbvVAdYmN9GvQKA6tulaOdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-ORMOH5CuOTW8CFN82yLycg-1; Tue, 05 May 2020 09:43:18 -0400
X-MC-Unique: ORMOH5CuOTW8CFN82yLycg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68241461;
 Tue,  5 May 2020 13:43:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC9BA5D9D5;
 Tue,  5 May 2020 13:43:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D9FF317532; Tue,  5 May 2020 15:43:05 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/13] acpi: madt: skip pci override on pci-less systems
 (microvm)
Date: Tue,  5 May 2020 15:42:55 +0200
Message-Id: <20200505134305.22666-4-kraxel@redhat.com>
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-common.h |  3 ++-
 hw/i386/acpi-build.c  |  2 +-
 hw/i386/acpi-common.c | 26 +++++++++++++++-----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index c30e461f1854..9cac18dddf5b 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -9,6 +9,7 @@
 #define ACPI_BUILD_IOAPIC_ID 0x0
=20
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev);
+                     X86MachineState *x86ms, AcpiDeviceIf *adev,
+                     bool has_pci);
=20
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index eb530e5cd56d..4cce2192eeb0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2441,7 +2441,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
=20
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
-                    ACPI_DEVICE_IF(pcms->acpi_dev));
+                    ACPI_DEVICE_IF(pcms->acpi_dev), true);
=20
     vmgenid_dev =3D find_vmgenid_dev();
     if (vmgenid_dev) {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 5caca16a0b59..ab9b00581a15 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -72,7 +72,8 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 }
=20
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev)
+                     X86MachineState *x86ms, AcpiDeviceIf *adev,
+                     bool has_pci)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(x8=
6ms));
@@ -111,18 +112,21 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *=
linker,
         intsrcovr->gsi    =3D cpu_to_le32(2);
         intsrcovr->flags  =3D cpu_to_le16(0); /* conforms to bus specifica=
tions */
     }
-    for (i =3D 1; i < 16; i++) {
+
+    if (has_pci) {
+        for (i =3D 1; i < 16; i++) {
 #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
-        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
-            /* No need for a INT source override structure. */
-            continue;
+            if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
+                /* No need for a INT source override structure. */
+                continue;
+            }
+            intsrcovr =3D acpi_data_push(table_data, sizeof *intsrcovr);
+            intsrcovr->type   =3D ACPI_APIC_XRUPT_OVERRIDE;
+            intsrcovr->length =3D sizeof(*intsrcovr);
+            intsrcovr->source =3D i;
+            intsrcovr->gsi    =3D cpu_to_le32(i);
+            intsrcovr->flags  =3D cpu_to_le16(0xd); /* active high, level =
triggered */
         }
-        intsrcovr =3D acpi_data_push(table_data, sizeof *intsrcovr);
-        intsrcovr->type   =3D ACPI_APIC_XRUPT_OVERRIDE;
-        intsrcovr->length =3D sizeof(*intsrcovr);
-        intsrcovr->source =3D i;
-        intsrcovr->gsi    =3D cpu_to_le32(i);
-        intsrcovr->flags  =3D cpu_to_le16(0xd); /* active high, level trig=
gered */
     }
=20
     if (x2apic_mode) {
--=20
2.18.4


