Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7ACC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49042074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTKqsfe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49042074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisLX-0000pO-SC
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKW-0007Qy-3N
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKV-0008Ex-4T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wz4LYmJYkwD0FRusftg9gxDl1X3bD+K8dONSs5X0hnA=;
 b=FTKqsfe2bTn3sjyIzxMW5lr3ztpjDER2Wae/ri3XD9s7FNRFgQOznuGzQUdEqFHuVPB2vt
 bxtgBQirr5Yak/IOnEbvBOdK5TX8w5zOE6+3nXOP4WHVObVzpxpMuAiTLJbhS5sJVS8IJl
 80Xd/Qa8DApz1zBXVS2bixMEEp9G9Uk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-FotIdlCnNwSthXi48vt_Ig-1; Wed, 10 Jun 2020 00:27:07 -0400
X-MC-Unique: FotIdlCnNwSthXi48vt_Ig-1
Received: by mail-wr1-f69.google.com with SMTP id s17so509214wrt.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wz4LYmJYkwD0FRusftg9gxDl1X3bD+K8dONSs5X0hnA=;
 b=Yr6LBU4u/8aMVgEmLsleroTjX6wN7TjGEGYycXifWXa6IH8+zB8/6OFLz0VzLYQRY0
 7LWyghFTVZYEFgLuRI3w7z5WrnAw4+Y7xXLC9eQPjKJ9aZ+mrcS8eUe5etc2RRt/mdme
 ohsYkvTsyIrz2Or8qlV5fmULHeiUbY+JQEcpTQcPwAcD/hJu4uTbcXLWn3pBfTO/kLrF
 7dTFoKxiu0KSP7jqsrFXAnFbJylT9J80csWppAvVeNTsM/rmAhDMC2JmLqN3/TOpcJIN
 PP9AisoFkioM91tFw6XI+OSwnP672aYcG4hsKKfcXV4k0iqUWM7PkqNT3WTm8hT6KtUX
 rOXw==
X-Gm-Message-State: AOAM533OsXoIO02lO6Zgq1PXf3ykLf65Prg+TI2O4wmsS16iHCnxNzs9
 BXjVuBPKpdl7E3smsxZMOpCSeI/6bADy/5f9lTCYUikxI8YAg3aC8xoG8/HHQ4tcQGh8bXtcA4n
 Ez9quClonY51QtV8=
X-Received: by 2002:a7b:c145:: with SMTP id z5mr1223685wmi.6.1591763226321;
 Tue, 09 Jun 2020 21:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3xnirnlqeMs0iB75rAPaM7hktq59XDZB9sVvXkJ1k8wS/zJqr3lAV9rREcI8rL62RffkSZw==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr1223673wmi.6.1591763226076;
 Tue, 09 Jun 2020 21:27:06 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id c6sm6135976wro.92.2020.06.09.21.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:05 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/56] acpi: Convert build_tpm2() to build_append* API
Message-ID: <20200610042613.1459309-15-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
 Eduardo Habkost <ehabkost@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

In preparation of its move to the generic acpi code,
let's convert build_tpm2() to use build_append API. This
latter now is prefered in place of direct ACPI struct field
settings with manual endianness conversion.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200601095737.32671-2-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d05d010f77..8d93a2d339 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2197,30 +2197,40 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 static void
 build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 {
-    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
+    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
     unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
     unsigned log_addr_offset =
         (char *)&tpm2_ptr->log_area_start_address - table_data->data;
+    uint8_t start_method_params[12] = {};
 
-    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
+    /* platform class */
+    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
+    /* reserved */
+    build_append_int_noprefix(table_data, 0, 2);
     if (TPM_IS_TIS_ISA(tpm_find())) {
-        tpm2_ptr->control_area_address = cpu_to_le64(0);
-        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
+        /* address of control area */
+        build_append_int_noprefix(table_data, 0, 8);
+        /* start method */
+        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
     } else if (TPM_IS_CRB(tpm_find())) {
-        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
-        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
+        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
+        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
     } else {
         g_warn_if_reached();
     }
 
-    tpm2_ptr->log_area_minimum_length =
-        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
+    /* platform specific parameters */
+    g_array_append_vals(table_data, &start_method_params, 12);
 
-    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
+    /* log area minimum length */
+    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
+
+    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
     bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
                              false);
 
     /* log area start address to be filled by Guest linker */
+    build_append_int_noprefix(table_data, 0, 8);
     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                    log_addr_offset, log_addr_size,
                                    ACPI_BUILD_TPMLOG_FILE, 0);
-- 
MST


