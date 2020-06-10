Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D79DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F99D2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaM8Q0z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F99D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jislN-0005mu-CJ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOI-0004h1-Cw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOH-0000gl-3I
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpMbTsm6mehy6ISo1LlFq8k67fPnsrK8nRjA546c8Mw=;
 b=RaM8Q0z1FpESSejNi0stSvUcMsp1mQrGtDQB6zT6R+kGRjqVKP3PyVYAXix47Jw+LUjPut
 8RIkHBuWAtCDV4VbYU3lFpE5ET2DfkJvKWSqyHCZ2UWp9q67ybobtk2BpWGb4W62PLYXKL
 qoLS51gdDgi9rOWbo29m3R/risSDATo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-0CexiNW0PuuGbPkb_RlSNA-1; Wed, 10 Jun 2020 00:28:36 -0400
X-MC-Unique: 0CexiNW0PuuGbPkb_RlSNA-1
Received: by mail-wr1-f71.google.com with SMTP id n6so513136wrv.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mpMbTsm6mehy6ISo1LlFq8k67fPnsrK8nRjA546c8Mw=;
 b=oSX6+INU80mKeajPWc4s+19yE9uF6UBO1Nbc3Om2Qq6D40g1o7696xvb3dv4QH0xzl
 rwnDSJ1ulmW6hbsq3NbdLH2pXNTXuojRqV1Wpfyhc8yzuZl0yIO+6wgzF4sO7idcNf/l
 tUqorX+or6Hbw9VPfD3PLQlYhnPXk8acU4dtecD7ju5LT0de+fGx5sDNkz7PZaCnbwnX
 u95EUxd8xCkY6fPU48K7kJSsPpJ7g3PNV0vkgMi++y21PU2YS8d1NYpXtQkX88P/6zlI
 tFT/3ETHXRuEpkUbB9zJgverpCbM/hg9dZYrRqD6byJIxcK88bd30c77uMrAQbFduusg
 RJyQ==
X-Gm-Message-State: AOAM531yiwsJgyz1yw3G+/+H1QU3XbPbTS8g2tFKCmjLNDHyF8jzaOQ3
 fmFUgDYExErxo4wGD31Aj6NKGCcI9TBGNdCdrsNVYUnN7yanCzHtrBSl+2WdT9oXq8by1It4dS5
 IbWD86dHnrcoChD0=
X-Received: by 2002:adf:a15c:: with SMTP id r28mr1236556wrr.337.1591763314759; 
 Tue, 09 Jun 2020 21:28:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydDYMB2bzOQ/aVCRVO6cOR7dg0Yx8FsEun+ZgY7V6amxQuoP4SOmbMpz7kSIn5UfJts3w3bQ==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr1236537wrr.337.1591763314559; 
 Tue, 09 Jun 2020 21:28:34 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u74sm5371491wmu.31.2020.06.09.21.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:34 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/56] acpi: madt: skip pci override on pci-less systems.
Message-ID: <20200610042613.1459309-54-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
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

Needed for microvm.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200520132003.9492-8-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-common.h |  3 ++-
 hw/i386/acpi-build.c  |  2 +-
 hw/i386/acpi-common.c | 26 +++++++++++++++-----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index c30e461f18..9cac18dddf 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -9,6 +9,7 @@
 #define ACPI_BUILD_IOAPIC_ID 0x0
 
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev);
+                     X86MachineState *x86ms, AcpiDeviceIf *adev,
+                     bool has_pci);
 
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 26c0c8aefa..473cbdfffd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2588,7 +2588,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
-                    ACPI_DEVICE_IF(pcms->acpi_dev));
+                    ACPI_DEVICE_IF(pcms->acpi_dev), true);
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 5caca16a0b..ab9b00581a 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -72,7 +72,8 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 }
 
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev)
+                     X86MachineState *x86ms, AcpiDeviceIf *adev,
+                     bool has_pci)
 {
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
@@ -111,18 +112,21 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
         intsrcovr->gsi    = cpu_to_le32(2);
         intsrcovr->flags  = cpu_to_le16(0); /* conforms to bus specifications */
     }
-    for (i = 1; i < 16; i++) {
+
+    if (has_pci) {
+        for (i = 1; i < 16; i++) {
 #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
-        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
-            /* No need for a INT source override structure. */
-            continue;
+            if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
+                /* No need for a INT source override structure. */
+                continue;
+            }
+            intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
+            intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
+            intsrcovr->length = sizeof(*intsrcovr);
+            intsrcovr->source = i;
+            intsrcovr->gsi    = cpu_to_le32(i);
+            intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
         }
-        intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
-        intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
-        intsrcovr->length = sizeof(*intsrcovr);
-        intsrcovr->source = i;
-        intsrcovr->gsi    = cpu_to_le32(i);
-        intsrcovr->flags  = cpu_to_le16(0xd); /* active high, level triggered */
     }
 
     if (x2apic_mode) {
-- 
MST


