Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B463FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECE520691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3FRfJJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECE520691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlBY-0006Tv-Bs
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1z-0006AH-CP
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1x-0001PK-Iy
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ulyJw62AwRxsch849W7FmGdBygZ/68I8k1w2QUFSjE=;
 b=M3FRfJJ5qvJWEJ3jcmLHRX0wwUKF4NArovtrZJonKBm4RQ57iBeh0J1g5RPrIUTwa7Bu8Z
 Qa0ooKYKfXXO9oohle3UUgc4RqQi8eSpU4acvNROeqG9q2ZrkreIeGQP3rg7HnEGfQ4Vgp
 SYBjECFfg4qJ3A24S+SYFr0VdJuSs4I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-P2qesqbcMXiDGN_hLhMHqQ-1; Fri, 12 Jun 2020 10:51:38 -0400
X-MC-Unique: P2qesqbcMXiDGN_hLhMHqQ-1
Received: by mail-wm1-f71.google.com with SMTP id k185so2032801wme.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0ulyJw62AwRxsch849W7FmGdBygZ/68I8k1w2QUFSjE=;
 b=nZeIEV7Q6x9cMPoqYe3utRxmaUO9OH9iso9HNFJQJD8E/vEQ7DKKiHARZPhCRUtiTr
 Zw/MWFkTbQrxxMBLdHnBFnA1hcOMSct8oyiLBkTWKV+KD9D07tS6gekDvN4UO8t2Xv50
 vsuYtRxaP7RtB8brzd1K/DHtHZLq05fzANyaEX6ZjAThywJbDby3qk/oIcdgaSHiw7vK
 6+/Ejd+gYoSzRIkXljIUJg/UpR8/444TFTfvlvVPlB+/bCNwAzJglvZiZXG2GgcRahko
 HCsdoATunGLaCeq1w+9ecz9mVADdByxmDvUWTb5yYLRaSuOPiolxNxxYb13VWS5eb6Je
 cFsg==
X-Gm-Message-State: AOAM532QWWragMqz3PeI+ss19hR+dlrA+q/2brH75T4nJGtXQO7pprpX
 +DMUDzW5+pA+Rlj7EW2+ZOXUJXRgErV/dhjde+fd87aVIzCjhW6Nf0DN8R48vKsddjxOIP0+8T2
 Etnw6p2GfljKykRA=
X-Received: by 2002:a7b:c249:: with SMTP id b9mr12879258wmj.143.1591973497171; 
 Fri, 12 Jun 2020 07:51:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4wVUFmwddd7D6Rd3u1AM2TgAl6djaNmKqlO3avddnj0DCrRcehX2zUu1BN6Sn+fV2qYfJOg==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr12879242wmj.143.1591973496975; 
 Fri, 12 Jun 2020 07:51:36 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id j5sm10806252wrm.57.2020.06.12.07.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:36 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/58] acpi: Move build_tpm2() in the generic part
Message-ID: <20200612141917.9446-16-mst@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

We plan to build the TPM2 table on ARM too. In order to reuse the
generation code, let's move build_tpm2() to aml-build.c.

No change in the implementation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200601095737.32671-3-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h |  2 ++
 hw/acpi/aml-build.c         | 44 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 44 -------------------------------------
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index ed7c89309e..d27da03d64 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -437,4 +437,6 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
+
+void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog);
 #endif
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 3681ec6e3d..b37052c1b4 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -26,6 +26,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
 #include "hw/boards.h"
+#include "hw/acpi/tpm.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -1877,6 +1878,49 @@ build_hdr:
                  "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
 }
 
+void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
+{
+    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
+    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
+    unsigned log_addr_offset =
+        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
+    uint8_t start_method_params[12] = {};
+
+    /* platform class */
+    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
+    /* reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    if (TPM_IS_TIS_ISA(tpm_find())) {
+        /* address of control area */
+        build_append_int_noprefix(table_data, 0, 8);
+        /* start method */
+        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
+    } else if (TPM_IS_CRB(tpm_find())) {
+        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
+        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
+    } else {
+        g_warn_if_reached();
+    }
+
+    /* platform specific parameters */
+    g_array_append_vals(table_data, &start_method_params, 12);
+
+    /* log area minimum length */
+    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
+
+    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
+    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
+                             false);
+
+    /* log area start address to be filled by Guest linker */
+    build_append_int_noprefix(table_data, 0, 8);
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+                                   log_addr_offset, log_addr_size,
+                                   ACPI_BUILD_TPMLOG_FILE, 0);
+    build_header(linker, table_data,
+                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
+}
+
 /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
 static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags,
                                   uint16_t type_flags,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8d93a2d339..1ecb68f45f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2194,50 +2194,6 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
                  (void *)tcpa, "TCPA", sizeof(*tcpa), 2, NULL, NULL);
 }
 
-static void
-build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
-{
-    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
-    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
-    unsigned log_addr_offset =
-        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
-    uint8_t start_method_params[12] = {};
-
-    /* platform class */
-    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
-    /* reserved */
-    build_append_int_noprefix(table_data, 0, 2);
-    if (TPM_IS_TIS_ISA(tpm_find())) {
-        /* address of control area */
-        build_append_int_noprefix(table_data, 0, 8);
-        /* start method */
-        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
-    } else if (TPM_IS_CRB(tpm_find())) {
-        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
-        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
-    } else {
-        g_warn_if_reached();
-    }
-
-    /* platform specific parameters */
-    g_array_append_vals(table_data, &start_method_params, 12);
-
-    /* log area minimum length */
-    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
-
-    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
-    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
-                             false);
-
-    /* log area start address to be filled by Guest linker */
-    build_append_int_noprefix(table_data, 0, 8);
-    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
-                                   log_addr_offset, log_addr_size,
-                                   ACPI_BUILD_TPMLOG_FILE, 0);
-    build_header(linker, table_data,
-                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
-}
-
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
-- 
MST


