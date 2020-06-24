Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5CDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCFF206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJWQHqRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCFF206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEYn-0000s2-Gk
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUC-0000p1-62
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEU6-0001fL-G2
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBtOThswta21xs6hvx04p8u9gjPXfF6q3aEihEmOyno=;
 b=TJWQHqRAcZD/nXYbKHUz2dSRJMCJ2Wf+Ox3PXlo/AX7KT3Eu9FdS/PjNWz4/s/XqRszppa
 y+5RPQ6Msdbx0BWTz1q28bpOZkj7GbFZNNgQwZp2U2YWb+T1GAjHrRnCYEfd2RHIoYGsaq
 jIXoEfSxyxDoud72YKuxp4JtY5t763Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-pmeJit2_P8GhBFblmooV-g-1; Wed, 24 Jun 2020 19:07:06 -0400
X-MC-Unique: pmeJit2_P8GhBFblmooV-g-1
Received: by mail-wm1-f71.google.com with SMTP id h6so4608448wmb.7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nBtOThswta21xs6hvx04p8u9gjPXfF6q3aEihEmOyno=;
 b=az0dgssZBxClXa7+LL4lOPVlLw0aDG7Qd84npUafyw7s3kmcSjiIQS6C10S21qIr0h
 IjprzhLgu1n6CSQU9wjMJuMjPZRzi5n/yqzaaYlXx2TjfbMsbGAPbL4HGOU6lgxAFvx1
 ib7inb2BLcQQxea66fr8CHSJWI0gRQ7wdQhuxgCt2RJXbq+b3mcTYNs91dJB1dS2R+H4
 VHAIn6V5Nu84JCNQOI2lTCfcVmb/MoW6r91iNHuZBMXDLgZBdvFi5nLBG3HG9MbViIwW
 zfvlugu89JmDTylq2RVYN8bmDn3+6dKW2cnrdNxPLSeRgUkAcLrIExK6tEXPthT+Ifhl
 2FNQ==
X-Gm-Message-State: AOAM530GJRapWChgKkfNit94/Mzb/nZeTgFeaTZaHqCAhPqrAjz0WwJ1
 0XHZX+/OcknisrrvQ9K7UeJEYOS8vIaGSgBwUTPJNh218w9aGYxPJOOevCGiRhjs+r6lDclk20U
 vB+4tkDvIKCmNpik=
X-Received: by 2002:a5d:4307:: with SMTP id h7mr1349443wrq.241.1593040025282; 
 Wed, 24 Jun 2020 16:07:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG6ebJEAgXsxgsMH0TbzwT43ebkw69AyLPa1sgA7pFhH2COyMru6Qjom4mpTv3stnV0QgVCQ==
X-Received: by 2002:a5d:4307:: with SMTP id h7mr1349433wrq.241.1593040025070; 
 Wed, 24 Jun 2020 16:07:05 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 v20sm29602988wrb.51.2020.06.24.16.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:07:04 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:07:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] acpi: Some build_tpm2() code reshape
Message-ID: <20200624230609.703104-14-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Remove any reference to Acpi20TPM2 and adopt an implementation
similar to build_ghes_v2().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Message-Id: <20200622140620.17229-2-eric.auger@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 18 -------------
 hw/acpi/aml-build.c         | 51 +++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 3be9ab5049..38a42f409a 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -465,24 +465,6 @@ struct Acpi20Tcpa {
 } QEMU_PACKED;
 typedef struct Acpi20Tcpa Acpi20Tcpa;
 
-/*
- * TPM2
- *
- * Following Version 1.2, Revision 8 of specs:
- * https://trustedcomputinggroup.org/tcg-acpi-specification/
- */
-struct Acpi20TPM2 {
-    ACPI_TABLE_HEADER_DEF
-    uint16_t platform_class;
-    uint16_t reserved;
-    uint64_t control_area_address;
-    uint32_t start_method;
-    uint8_t start_method_params[12];
-    uint32_t log_area_minimum_length;
-    uint64_t log_area_start_address;
-} QEMU_PACKED;
-typedef struct Acpi20TPM2 Acpi20TPM2;
-
 /* DMAR - DMA Remapping table r2.2 */
 struct AcpiTableDmar {
     ACPI_TABLE_HEADER_DEF
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2cb7b991ef..f6fbc9b95d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1878,48 +1878,61 @@ build_hdr:
                  "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
 }
 
+/*
+ * build_tpm2 - Build the TPM2 table as specified in
+ * table 7: TCG Hardware Interface Description Table Format for TPM 2.0
+ * of TCG ACPI Specification, Family “1.2” and “2.0”, Version 1.2, Rev 8
+ */
 void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 {
-    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
-    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
-    unsigned log_addr_offset =
-        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
     uint8_t start_method_params[12] = {};
+    unsigned log_addr_offset, tpm2_start;
+    uint64_t control_area_start_address;
     TPMIf *tpmif = tpm_find();
+    uint32_t start_method;
+    void *tpm2_ptr;
 
-    /* platform class */
+    tpm2_start = table_data->len;
+    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
+
+    /* Platform Class */
     build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
-    /* reserved */
+    /* Reserved */
     build_append_int_noprefix(table_data, 0, 2);
     if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
-        /* address of control area */
-        build_append_int_noprefix(table_data, 0, 8);
-        /* start method */
-        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
+        control_area_start_address = 0;
+        start_method = TPM2_START_METHOD_MMIO;
     } else if (TPM_IS_CRB(tpmif)) {
-        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
-        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
+        control_area_start_address = TPM_CRB_ADDR_CTRL;
+        start_method = TPM2_START_METHOD_CRB;
     } else {
-        g_warn_if_reached();
+        g_assert_not_reached();
     }
+    /* Address of Control Area */
+    build_append_int_noprefix(table_data, control_area_start_address, 8);
+    /* Start Method */
+    build_append_int_noprefix(table_data, start_method, 4);
 
-    /* platform specific parameters */
-    g_array_append_vals(table_data, &start_method_params, 12);
+    /* Platform Specific Parameters */
+    g_array_append_vals(table_data, &start_method_params,
+                        ARRAY_SIZE(start_method_params));
 
-    /* log area minimum length */
+    /* Log Area Minimum Length */
     build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
 
     acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
     bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
                              false);
 
-    /* log area start address to be filled by Guest linker */
+    log_addr_offset = table_data->len;
+
+    /* Log Area Start Address to be filled by Guest linker */
     build_append_int_noprefix(table_data, 0, 8);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-                                   log_addr_offset, log_addr_size,
+                                   log_addr_offset, 8,
                                    ACPI_BUILD_TPMLOG_FILE, 0);
     build_header(linker, table_data,
-                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
+                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
 }
 
 /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
-- 
MST


