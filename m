Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034EDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3674821D40
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="b/GFoVvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3674821D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnb7-0004Fx-84
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTh-0003TU-Do
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:53 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTf-0005yv-Oo
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:53 -0400
Received: by mail-pj1-x1041.google.com with SMTP id fa1so2095091pjb.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2bDn5lP82DTof33HcPkKGbpUXGX2/dBL7v5dVOpxZK0=;
 b=b/GFoVvOlaY4Oy7QM61ZqHQqHdQkZlnCKibwTYv0i+Fouk6lhrVPZFVkWNnC861hy6
 vY7DckkrsfCkP1+duurcDlOr/sYkoEdjd61Kd7d4YwZFftuAiaPaxuBmAp+5GPmKyDiI
 gBb+KPU1RTjpgt0Z9JO3xDE50fdniIfcq1K+NPB/vY7qC+dKD3w2g6CdziEtqpl1isFU
 jTHdjdGKfUNRzLKCe4hKUBCOE9IOQxxwN2ZQhSz7lOhasfjENgbzesQ7Hj+RjonhPLsQ
 Kd1irTbLRjdLE2ee9kVtriovxtshIjJn5C9h7IvlZoZrr2Q7CTWdvck9VpAZVR5fH9lE
 wAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2bDn5lP82DTof33HcPkKGbpUXGX2/dBL7v5dVOpxZK0=;
 b=Ai1jqQCgEVuE13JKi1pQlXshkFnO4xlzlilwypnpn+CcAaKJFx5STHuHPxfwN87wEY
 coLZfcP8o/wprMEFfSnOfK/c24xEkF+NIDUvXaTHULlCo9ZOXSCjsEzmTXo3VcHjFhjz
 BDIUeadNBmRjpbTWcIk7km8Wf2YZQr5fqUTmn+iMTM3kB1rL6SQIEI+4KvMkNRCEGO12
 Wh+hmAT9TaG3zZhYYqacWOYeVcMStPU+ffcMdufi8yh2XYGRx8KDIFiKCVjDEFNlq3nF
 frHkuxiTbCtKe6g7dvjx5ChHchCkeV4bMDt9iEhQZREckq33eYJ/f7vWF43SltFkII9r
 xblQ==
X-Gm-Message-State: AOAM5302e+jtXZ0PLyWNjb4sZRbgHFTIhEdj03ug0LUcPoDx2OVYhTuX
 VLC+VEQieQzH9a9D84qPK1ZOxwI3DleDdBho
X-Google-Smtp-Source: ABdhPJwKUulMOxjoSEaVpBxZ+IGq7azvXY1K9ctlV2klYo1URWjWqnF7wIEeYNbyiOQ7IQ5aXo9keQ==
X-Received: by 2002:a17:90b:ecc:: with SMTP id
 gz12mr3242695pjb.123.1599847729972; 
 Fri, 11 Sep 2020 11:08:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.201])
 by smtp.googlemail.com with ESMTPSA id n9sm2929135pfu.163.2020.09.11.11.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 11:08:49 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] piix4: don't reserve hw resources when hotplug is off
 globally
Date: Fri, 11 Sep 2020 23:37:55 +0530
Message-Id: <20200911180755.28409-9-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911180755.28409-1-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When acpi hotplug is turned off for both root pci bus as well as for pci
bridges, we should not generate the related amls for DSDT table or initialize
related hw ports or reserve hw resources. This change makes sure all those
operations are turned off in the case acpi pci hotplug is off globally.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/piix4.c      |  6 ++++--
 hw/i386/acpi-build.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e6163bb6ce..b70b1f98af 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                           "acpi-gpe0", GPE_LEN);
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
-    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_hotplug_bridge);
+    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+                        s->use_acpi_hotplug_bridge);
+    }
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e079b686f5..7e3cf3b57b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool pcihp_root_en;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_bridge_en =
         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
                                  NULL);
+    pm->pcihp_root_en =
+        object_property_get_bool(obj, "acpi-root-pci-hotplug",
+                                 NULL);
 }
 
 static void acpi_get_misc_info(AcpiMiscInfo *info)
@@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_hpet_aml(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
-        build_piix4_pci_hotplug(dsdt);
+        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
+            build_piix4_pci_hotplug(dsdt);
+        }
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
@@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     crs_range_set_free(&crs_range_set);
 
     /* reserve PCIHP resources */
-    if (pm->pcihp_io_len) {
+    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
         dev = aml_device("PHPR");
         aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(dev,
-- 
2.17.1


