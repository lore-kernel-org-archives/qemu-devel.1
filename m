Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC381206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxTddLnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC381206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEei-0002s4-3E
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUF-0000yR-IT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUD-0001iK-IG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrIw3oNFPuimxxA3bj46vEVZmWwWe/K09lvhh8ororc=;
 b=BxTddLnKN2nXyrvhpzWtmgHz05Js+pk34mnVH3Zp2B6DEkjxPizedNQjWHo6fXwhQN2Drq
 jyldFrDI+49PdFdtDtgJrh+Rjl+aHycTBckwWrs8FpETNaWURFF4CwHBMz3FGVqH1jiQLd
 Y8i/iXVBA5TSP51KR3gpIlxuMDSUEaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-wQbgNtHlN-izSKfsT1xwLQ-1; Wed, 24 Jun 2020 19:07:16 -0400
X-MC-Unique: wQbgNtHlN-izSKfsT1xwLQ-1
Received: by mail-wr1-f69.google.com with SMTP id a6so4735195wrq.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GrIw3oNFPuimxxA3bj46vEVZmWwWe/K09lvhh8ororc=;
 b=sZ0OEuwE+DDfthXoGjljlGHCDwjymM1rSYgGnpAOrfapw8y1kcF496FjJrOCwZfIx6
 5Q2/GsVWdngngA966WFeACyato/JQ18hAKi1RH77B8urT7Mt3sTIH+ImcQ6c1WTeLU1I
 GN9HVe2RBBieadkyuB9gwjE/Fc2uVl44rIxhjFwx3yjLpYfHk4ulautecfjKa/CU0hTt
 TDzdvaj+oi5EJz3G0pF0LUSjpAMVNckskDGEkmU2P79LaHsF/nK3572G/krkJycYOb0z
 oETW3Nap8Kms3FVmQN2sF1Rw3sAbfOK5fAvl/u4ZzAeRr78IAYADhMALobFLUIQ2IUe9
 +SPQ==
X-Gm-Message-State: AOAM532WiO4PcY0cqIhYafzfhtzi2S2Ad/5/Twx09vduy1VS/sM2Ivne
 /pAw4sK4BGM9nDLJvwB0oJkEOICYcZPAKbKATCozaTIjK5t9T4uJi9lv3O8KfUKCKn+LPrQ+mwP
 JUChV2AjI3Ox9BIg=
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr33964045wrq.156.1593040035403; 
 Wed, 24 Jun 2020 16:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfnNWE/9sqXv8jL47+sOvwuQDOYi+8r96QzAn/CWjvk58AmKZl9o3x0PxqfVESffrUI5+H4Q==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr33964028wrq.156.1593040035222; 
 Wed, 24 Jun 2020 16:07:15 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z1sm15419081wrh.14.2020.06.24.16.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:07:14 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:07:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
Message-ID: <20200624230609.703104-18-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <ani.sinha@nutanix.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani.sinha@nutanix.com>

Currently, the option use_acpi_pci_hotplug is being used to control device
hotplug capability using ACPI for slots of cold plugged bridges. Hence, we
are renaming this option to better reflect what it actually does.

Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
Message-Id: <1592310699-58916-1-git-send-email-ani.sinha@nutanix.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/piix4.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1262abc77a..630ca6ec87 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -77,7 +77,7 @@ typedef struct PIIX4PMState {
     Notifier powerdown_notifier;
 
     AcpiPciHpState acpi_pci_hotplug;
-    bool use_acpi_pci_hotplug;
+    bool use_acpi_hotplug_bridge;
 
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -204,16 +204,17 @@ static const VMStateDescription vmstate_pci_status = {
     }
 };
 
-static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int version_id)
+static bool vmstate_test_use_acpi_hotplug_bridge(void *opaque, int version_id)
 {
     PIIX4PMState *s = opaque;
-    return s->use_acpi_pci_hotplug;
+    return s->use_acpi_hotplug_bridge;
 }
 
-static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int version_id)
+static bool vmstate_test_no_use_acpi_hotplug_bridge(void *opaque,
+                                                    int version_id)
 {
     PIIX4PMState *s = opaque;
-    return !s->use_acpi_pci_hotplug;
+    return !s->use_acpi_hotplug_bridge;
 }
 
 static bool vmstate_test_use_memhp(void *opaque)
@@ -290,11 +291,11 @@ static const VMStateDescription vmstate_acpi = {
         VMSTATE_STRUCT_TEST(
             acpi_pci_hotplug.acpi_pcihp_pci_status[ACPI_PCIHP_BSEL_DEFAULT],
             PIIX4PMState,
-            vmstate_test_no_use_acpi_pci_hotplug,
+            vmstate_test_no_use_acpi_hotplug_bridge,
             2, vmstate_pci_status,
             struct AcpiPciHpPciStatus),
         VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug, PIIX4PMState,
-                            vmstate_test_use_acpi_pci_hotplug),
+                            vmstate_test_use_acpi_hotplug_bridge),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
@@ -530,7 +531,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
     s->smi_irq = smi_irq;
     s->smm_enabled = smm_enabled;
     if (xen_enabled()) {
-        s->use_acpi_pci_hotplug = false;
+        s->use_acpi_hotplug_bridge = false;
     }
 
     pci_realize_and_unref(pci_dev, bus, &error_fatal);
@@ -595,7 +596,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
 
     acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
-                    s->use_acpi_pci_hotplug);
+                    s->use_acpi_hotplug_bridge);
 
     s->cpu_hotplug_legacy = true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
@@ -633,7 +634,7 @@ static Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4, 0),
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
-                     use_acpi_pci_hotplug, true),
+                     use_acpi_hotplug_bridge, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
-- 
MST


