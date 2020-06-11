Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F1EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3458206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtMhGgC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3458206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNmS-0004Di-UF
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjNkL-0002YB-IE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:59:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjNkK-0002Bi-1h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591883995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/tsqs0CV87SZ1ggKjgE+gFxoq7g2D7z8Ikszig2jYc=;
 b=BtMhGgC/SdQlBoSpOXzkhY73qRGaNihb11Cp7/wnn7yhuI9PoJsnkD1yo0JCnbXnq21Y3f
 OHuPnmkCEANr+pT+YzroJ3DbuH7hDJ8ga1QbaFYPdL0LGF69sX/LM5ojjuiOMX2/g4C7xy
 p0Ldq6rfEpu5Xd/cFguIC2RZ0wwI+Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-zQf7JofQNBSF6NrVhN50HQ-1; Thu, 11 Jun 2020 09:59:53 -0400
X-MC-Unique: zQf7JofQNBSF6NrVhN50HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8751D1005513;
 Thu, 11 Jun 2020 13:59:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5785D9DC;
 Thu, 11 Jun 2020 13:59:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
Subject: [PATCH v4 3/5] arm/acpi: TPM2 ACPI table support
Date: Thu, 11 Jun 2020 15:59:15 +0200
Message-Id: <20200611135917.18300-4-eric.auger@redhat.com>
In-Reply-To: <20200611135917.18300-1-eric.auger@redhat.com>
References: <20200611135917.18300-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a TPM2 ACPI table if a TPM2.0 sysbus device has been
dynamically instantiated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- do not to need to create the log area anymore

v1 -> v2:
- reuse generic build_tpm2() and alloc log area externally
- call tpm_find() once in build_tpm2()
---
 include/sysemu/tpm.h     | 2 ++
 hw/acpi/aml-build.c      | 5 +++--
 hw/arm/virt-acpi-build.c | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index f37851b1aa..03fb25941c 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -50,6 +50,8 @@ typedef struct TPMIfClass {
 
 #define TPM_IS_TIS_ISA(chr)                         \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
+#define TPM_IS_TIS_SYSBUS(chr)                      \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
 #define TPM_IS_CRB(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
 #define TPM_IS_SPAPR(chr)                           \
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2a1d9fc839..a0c4d71fe9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1883,6 +1883,7 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     uint8_t start_method_params[12] = {};
     unsigned log_addr_offset, tpm2_start;
     uint64_t control_area_start_address;
+    TPMIf *tpmif = tpm_find();
     uint32_t start_method;
     void *tpm2_ptr;
 
@@ -1893,10 +1894,10 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
     /* Reserved */
     build_append_int_noprefix(table_data, 0, 2);
-    if (TPM_IS_TIS_ISA(tpm_find())) {
+    if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
         control_area_start_address = 0;
         start_method = TPM2_START_METHOD_MMIO;
-    } else if (TPM_IS_CRB(tpm_find())) {
+    } else if (TPM_IS_CRB(tpmif)) {
         control_area_start_address = TPM_CRB_ADDR_CTRL;
         start_method = TPM2_START_METHOD_CRB;
     } else {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1b0a584c7b..6d152ab481 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -41,12 +41,14 @@
 #include "hw/acpi/pci.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/acpi/tpm.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
 #include "hw/mem/nvdimm.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
+#include "sysemu/tpm.h"
 #include "kvm_arm.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
@@ -844,6 +846,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         build_iort(tables_blob, tables->linker, vms);
     }
 
+    if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_tpm2(tables_blob, tables->linker, tables->tcpalog);
+    }
+
     /* XSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
-- 
2.20.1


