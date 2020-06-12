Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312E620691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVrGgP9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312E620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl6r-0007Zo-Fz
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl22-0006Er-Ar
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1z-0001PX-Ga
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zGOoHYc7BnEUE5/Tw0vbz2Gw05a97G6XRUJWvEWyGjA=;
 b=BVrGgP9KPFaPBV/tSHHr+jE7nLX1k3ymHzRriBrIjR2ETM5ICJQGXQKO5aYjEQQfgaPl0K
 +PZZEfRBr1eXUpHMdoD1iu+Jc1vOevp2Zi9D7zlgM2z0z6EmApCeOnZe8/INRtYZF6ni+p
 Vx8+6Z1oCyd1Be4f3DBmko/Avb1zljQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-hm62ABFKNDOEeEtNpnHoOA-1; Fri, 12 Jun 2020 10:51:40 -0400
X-MC-Unique: hm62ABFKNDOEeEtNpnHoOA-1
Received: by mail-wr1-f71.google.com with SMTP id r5so4002236wrt.9
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zGOoHYc7BnEUE5/Tw0vbz2Gw05a97G6XRUJWvEWyGjA=;
 b=qZKvsNleKPXXC4D1dAziC+h56+Onq5O2pv51KQxi+mw6z03nnMjrNWoNVsBVYxKb0r
 HoW1pnE0g5v5tEYvNNfEvpTTD01JsUI7zi1lBGUyim/QM5nmI6kT+Wyrdxo32I0Yx6Wr
 65WuKZqCjGeab6Y7JpaGe20Z/bLNMnNv9x3ujR20Pjg0sytGw3LyLa0gyCKJVFrnfBdE
 OL+liJ0IP9dDQLkKhdVYkxdVpHwrcXSNfrzPaSWSnC6jsshOgHTffwb28F1G8CIAw8s1
 l/DonX7rbg4QMzB/aCS8NxRNGgEuEGK2aOTdmmv8eRO0wo/TZidHXBJTZthyhYpP2HUJ
 +Ejg==
X-Gm-Message-State: AOAM531Cem4kVZImjtiTD4AyUgXGnIhJ6Ifbk797yFWvKbfTBhKZyORb
 NC7/HgiedXfzJITDUlTNHSTpWW3nAb3hjBHhpIPxrB1/A68jWs74UhQ/Wo8aPFx45DW3WokAwwG
 QGu3+dAeTbPhPdVs=
X-Received: by 2002:a1c:7903:: with SMTP id l3mr13483925wme.50.1591973499328; 
 Fri, 12 Jun 2020 07:51:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR4D2VtuT67U58RnzCGHC3lbDYP+TWdHWYomPasF6q6FgznRdyNmRy7Qs1NVFk1eh3mF6kBQ==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr13483903wme.50.1591973499160; 
 Fri, 12 Jun 2020 07:51:39 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id y37sm11339873wrd.55.2020.06.12.07.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:38 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/58] arm/acpi: TPM2 ACPI table support
Message-ID: <20200612141917.9446-17-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Eric Auger <eric.auger@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Add a TPM2 ACPI table if a TPM2.0 sysbus device has been
dynamically instantiated.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20200601095737.32671-4-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index b37052c1b4..d24e9e6c3a 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1885,17 +1885,18 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     unsigned log_addr_offset =
         (char *)&tpm2_ptr->log_area_start_address - table_data->data;
     uint8_t start_method_params[12] = {};
+    TPMIf *tpmif = tpm_find();
 
     /* platform class */
     build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
     /* reserved */
     build_append_int_noprefix(table_data, 0, 2);
-    if (TPM_IS_TIS_ISA(tpm_find())) {
+    if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
         /* address of control area */
         build_append_int_noprefix(table_data, 0, 8);
         /* start method */
         build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
-    } else if (TPM_IS_CRB(tpm_find())) {
+    } else if (TPM_IS_CRB(tpmif)) {
         build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
         build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
     } else {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2cbccd5fe2..ca31f70f7f 100644
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
@@ -848,6 +850,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
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
MST


