Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9918C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5408B22B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5Bp028b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5408B22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBICx-0000tG-AX
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8y-0001P9-6d
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8v-0006KN-KE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goMO8hb7iY4YjGLokxDYf+btfPCSDsgCnFQDuyULhx0=;
 b=W5Bp028bkTE6dj7sZ5S3oCp4tXR8G3lnW8PSPZ4dDAHCcFvH2Xy+H6zSv65pXnJldAQS/2
 2ElvcL56Dss1zgxfQopEgmQ972e4UpajZeLypxpqco4uyIEX3qiETaQwm1prIIuRSdoRLs
 FJYvHL+cAzA8iKzUYeHITnjMBDi22bA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-HgJGUKZsPXSb-mq4mf0amw-1; Thu, 27 Aug 2020 09:40:38 -0400
X-MC-Unique: HgJGUKZsPXSb-mq4mf0amw-1
Received: by mail-wm1-f72.google.com with SMTP id b73so2081055wmb.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=goMO8hb7iY4YjGLokxDYf+btfPCSDsgCnFQDuyULhx0=;
 b=K+bOf+ICgkaB/pwnNU4YFKJSiNoWIaxlE8frfUOuoVt9eCCKR7/ZVu5JJzNM6CXurH
 meLf9qpYIsZgwwzX50kJUmLHsif/349lX4iYwR94gA/HtuULklnyZZhFli4nxPShDZuz
 S6ypndIzEny54MLzttZ+X6aG7EDRqRpUn/saftBi+0p+sY/1TfKss3JgL52OoLgNNTrr
 ZrwU4G522nSngtaUdXWn4iVhela48JQoJIT52D4EH9TBbpwZw3oWqoyLEpkb4iFxc/Jp
 /9ZgAaiAiXu4zTZIHFNwd/8IGWZzQnjUCkcd7WeyzKLvKg7cga5n05JSq+dKMO0kzS88
 Lbjg==
X-Gm-Message-State: AOAM531M+G9xb0uTgFRRBcUUc6pmImMQoI5xmN1dOtOZzwak1XOlhddg
 /bDahlDV6XN/YJ6Eg4GscmoP750HdRUcU+piYhVx0/zixGx/USmp3FMalxY9d4eeT+ce9KARWD2
 1HotfAOzkkzZDhvA=
X-Received: by 2002:adf:c50d:: with SMTP id q13mr12622125wrf.175.1598535637108; 
 Thu, 27 Aug 2020 06:40:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydCjQonxJ7Xx7koQmhScRTLdx7rtcQiU85MMZWlCaU2cpHPsFJUpJbRD+nw9YmMBJnZPJ9aA==
X-Received: by 2002:adf:c50d:: with SMTP id q13mr12622098wrf.175.1598535636841; 
 Thu, 27 Aug 2020 06:40:36 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id s8sm4646372wmc.1.2020.08.27.06.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:36 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
Message-ID: <20200827133954.2118749-7-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
we can turn on or off PCI device hotplug on the root bus. This flag can be
used to prevent all PCI devices from getting hotplugged or unplugged from the
root PCI bus.
This feature is targetted mostly towards Windows VMs. It is useful in cases
where some hypervisor admins want to deploy guest VMs in a way so that the
users of the guest OSes are not able to hot-eject certain PCI devices from
the Windows system tray. Laine has explained the use case here in detail:
https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html

Julia has resolved this issue for PCIE buses with the following commit:
530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")

This commit attempts to introduce similar behavior for PCI root buses used in
i440fx machine types (although in this case, we do not have a per-slot
capability to turn hotplug on or off).

Usage:
   -global PIIX4_PM.acpi-root-pci-hotplug=off

By default, this option is enabled which means that hotplug is turned on for
the PCI root bus.

The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
bridges remain as is and can be used along with this new flag to control PCI
hotplug on PCI bridges.

This change has been tested using a Windows 2012R2 server guest image and also
with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
master qemu from upstream.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/pcihp.h |  2 +-
 hw/acpi/pcihp.c         | 23 ++++++++++++++++++++++-
 hw/acpi/piix4.c         |  5 ++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8bc4a4c01d..02f4665767 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                          Error **errp);
 
 /* Called on reset */
-void acpi_pcihp_reset(AcpiPciHpState *s);
+void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
 
 extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 9e31ab2da4..39b1f74442 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
     }
 }
 
+static void acpi_pcihp_disable_root_bus(void)
+{
+    static bool root_hp_disabled;
+    PCIBus *bus;
+
+    if (root_hp_disabled) {
+        return;
+    }
+
+    bus = find_i440fx();
+    if (bus) {
+        /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
+        qbus_set_hotplug_handler(BUS(bus), NULL);
+    }
+    root_hp_disabled = true;
+    return;
+}
+
 static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
 {
     AcpiPciHpFind *find = opaque;
@@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
     }
 }
 
-void acpi_pcihp_reset(AcpiPciHpState *s)
+void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
 {
+    if (acpihp_root_off) {
+        acpi_pcihp_disable_root_bus();
+    }
     acpi_set_pci_info();
     acpi_pcihp_update(s);
 }
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 26bac4f16c..e6163bb6ce 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
 
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_hotplug_bridge;
+    bool use_acpi_root_pci_hotplug;
 
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
         pci_conf[0x5B] = 0x02;
     }
     pm_io_space_update(s);
-    acpi_pcihp_reset(&s->acpi_pci_hotplug);
+    acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
 }
 
 static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
@@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
                      use_acpi_hotplug_bridge, true),
+    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
+                     use_acpi_root_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
-- 
MST


