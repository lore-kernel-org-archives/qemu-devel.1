Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590DDC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 20:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5B22080C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1Cl5Q6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5B22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUytC-0003bS-8F
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 16:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jUyro-0002Ds-QG
 for qemu-devel@nongnu.org; Sat, 02 May 2020 16:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jUyro-0003Wl-92
 for qemu-devel@nongnu.org; Sat, 02 May 2020 16:36:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jUyrn-0003VV-RU
 for qemu-devel@nongnu.org; Sat, 02 May 2020 16:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588451767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08iwP7LqFIqqeGyoG9u6SDwyyi8beRnRJa3nu+7iKrY=;
 b=H1Cl5Q6PpvSEp+JKXXT9iOoH+FNVWl2l+HxjVNC+xb0fAONgyADdm2J7kSpeFlPGw6NprP
 DszvQDnmgfPHBcAeVWHM5Jx2C7i1NVo/Kl8iezndQp7qbZBp+Kph/YjJxyumpwhajUe214
 MF0WOlw//mPi7yRhQEbvYf2G9701nkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-8UIoZFC9PayXxV2_-_UUZQ-1; Sat, 02 May 2020 16:36:03 -0400
X-MC-Unique: 8UIoZFC9PayXxV2_-_UUZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0897C80183C;
 Sat,  2 May 2020 20:36:02 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B5D810002AA;
 Sat,  2 May 2020 20:35:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com
Subject: [PATCH 1/2] arm/acpi: TPM2 ACPI table support
Date: Sat,  2 May 2020 22:35:35 +0200
Message-Id: <20200502203536.15011-2-eric.auger@redhat.com>
In-Reply-To: <20200502203536.15011-1-eric.auger@redhat.com>
References: <20200502203536.15011-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 16:36:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, gshan@redhat.com,
 lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a TPM2 ACPI table if a TPM2.0 sysbus device has been
dynamically instantiated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/sysemu/tpm.h     |  2 ++
 hw/arm/virt-acpi-build.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index f37851b1aa..03fb25941c 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -50,6 +50,8 @@ typedef struct TPMIfClass {
=20
 #define TPM_IS_TIS_ISA(chr)                         \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
+#define TPM_IS_TIS_SYSBUS(chr)                      \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
 #define TPM_IS_CRB(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
 #define TPM_IS_SPAPR(chr)                           \
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 81d41a3990..cc5863eaf2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -41,11 +41,13 @@
 #include "hw/acpi/pci.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/acpi/tpm.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
+#include "sysemu/tpm.h"
 #include "kvm_arm.h"
 #include "migration/vmstate.h"
=20
@@ -704,6 +706,35 @@ static void build_fadt_rev5(GArray *table_data, BIOSLi=
nker *linker,
     build_fadt(table_data, linker, &fadt, NULL, NULL);
 }
=20
+static void
+build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
+{
+    Acpi20TPM2 *tpm2_ptr =3D acpi_data_push(table_data, sizeof *tpm2_ptr);
+    unsigned log_addr_size =3D sizeof(tpm2_ptr->log_area_start_address);
+    unsigned log_addr_offset =3D
+        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
+
+    tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
+    if (TPM_IS_TIS_SYSBUS(tpm_find())) {
+        tpm2_ptr->control_area_address =3D cpu_to_le64(0);
+        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
+    } else {
+        g_warn_if_reached();
+    }
+
+    tpm2_ptr->log_area_minimum_length =3D cpu_to_le32(TPM_LOG_AREA_MINIMUM=
_SIZE);
+    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length)=
);
+
+    /* log area start address to be filled by Guest linker */
+    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE,
+                             tcpalog, 1, false);
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+                                   log_addr_offset, log_addr_size,
+                                   ACPI_BUILD_TPMLOG_FILE, 0);
+    build_header(linker, table_data,
+                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NUL=
L);
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -831,6 +862,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildT=
ables *tables)
         build_iort(tables_blob, tables->linker, vms);
     }
=20
+    if (tpm_get_version(tpm_find()) =3D=3D TPM_VERSION_2_0) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_tpm2(tables_blob, tables->linker, tables->tcpalog);
+    }
+
     /* XSDT is pointed to by RSDP */
     xsdt =3D tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
--=20
2.20.1


