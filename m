Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E04C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CB82081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFzDa4h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CB82081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlRq-00059L-B7
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl5M-0004mJ-5o
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:55:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl5K-00024e-7t
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wz4LYmJYkwD0FRusftg9gxDl1X3bD+K8dONSs5X0hnA=;
 b=jFzDa4h44CmSMJlaEX1daVQPaI2ZSsFwrKYS4kptmvFvVil5pG1M4mcu20phZIitnVcQwH
 5rSZIWBQ53fGeBh0Nff3+x7Gf7EnXmCUEvJny4JuAXT1f+aX/nIrN2Sw8rGBoV1q/O/lj4
 OvY/KVxzrdvd1booNpF1l4rP5ALd7tg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-gSN03lqiOw-5IBA1fUHXyg-1; Fri, 12 Jun 2020 10:51:36 -0400
X-MC-Unique: gSN03lqiOw-5IBA1fUHXyg-1
Received: by mail-wr1-f69.google.com with SMTP id t5so3974008wro.20
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wz4LYmJYkwD0FRusftg9gxDl1X3bD+K8dONSs5X0hnA=;
 b=aaPAOvQarcSlAcz+Sk59rjMSK1db6L+QJuD3HZw0m4aopWvhRpH1PkQ+QrszsFh0C0
 F0BJ6k4VsZjnSzmKgnMVSmEdtP3015ica8uPirgO6PSkmRlu62RW56q+tJYlBEuSyIzV
 SNBBNjiO5Pz68U73qCJYsAwBSive8mQRKXkU5MS4GURcrbP/iogg3VJOdYx5Xj0696u0
 ai1b2iy8eFg9YLV1nnM/CIvd8uvCdZAyts5y3psRgENNjBZK/w873Nq7OTlHrDc/DqOe
 b5EtfVKPv1gMsMKrk7wpdUw34pALOxGqAKJc5ZlsMnhvJsfXPshO2MPRRipTqPa3PA/y
 OCVw==
X-Gm-Message-State: AOAM532rkCJPUCMZcKzNdU6xVkgupoMnXz6AYHHWTO2cqVfd2gJgOOor
 3CiouJe+RKMB6TJ+IPoG4QJ5zKe/O2JHLWAb27yiHsFLYxMqzkVcze44tsfOCBlOgdM1SvCWJZ1
 iWKd3ak6KFnsOMFg=
X-Received: by 2002:adf:dec5:: with SMTP id i5mr16213545wrn.16.1591973495028; 
 Fri, 12 Jun 2020 07:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrq48yz7GKmE8biEtjLjKte04AD/V185NMosqi+HXXu1HIpVy8uQ1w6+MVMJsd+zzNXqKLTA==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr16213512wrn.16.1591973494718; 
 Fri, 12 Jun 2020 07:51:34 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id s72sm8916007wme.35.2020.06.12.07.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:34 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 14/58] acpi: Convert build_tpm2() to build_append* API
Message-ID: <20200612141917.9446-15-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


