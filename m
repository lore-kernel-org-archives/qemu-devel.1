Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D941C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245922080C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoPrznLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245922080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgws-0003so-91
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtx-0007Ho-P8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtw-0004GZ-5D
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599584123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mfcLUk8WHP0NVHkcizMVA7sBj5Ca5AZ2tn+WQE8aUs=;
 b=AoPrznLE0qKIadz8rKB9Fm1PXr+kdkF5y5WCafp/Uk1OMPNADa36Z90Z87nL9BIrIg8kPA
 Is4P1gjAwWwamkrFEtElliRrmeoI734T+T2+wfqqqGv7Mf2uQcq9J1WDSqyBybL1S35YGl
 FuKBxaP9zp80gEWIeMAr+BZWHBIvZT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-R5EAJ874MqeunE8EogHBTg-1; Tue, 08 Sep 2020 12:55:19 -0400
X-MC-Unique: R5EAJ874MqeunE8EogHBTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9415B192C8AE;
 Tue,  8 Sep 2020 16:55:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 560A060CD1;
 Tue,  8 Sep 2020 16:55:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/i386: expose a "smbios_ep" PC machine property
Date: Tue,  8 Sep 2020 17:54:38 +0100
Message-Id: <20200908165438.1008942-6-berrange@redhat.com>
In-Reply-To: <20200908165438.1008942-1-berrange@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i440fx and Q35 machine types are both hardcoded to use the legacy
SMBIOS 2.1 entry point. This is a sensible conservative choice because
SeaBIOS only supports SMBIOS 2.1

EDK2, however, can also support SMBIOS 3.0 and QEMU already uses this on
the ARM virt machine type.

This adds a property to allow the choice of SMBIOS entry point versions
For example to opt in to version 3.0

   $QEMU -machine q35,smbios_ep=3_0

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc.c         | 26 ++++++++++++++++++++++++++
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  2 +-
 include/hw/i386/pc.h |  3 +++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d11daacc23..cfce279eed 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,7 @@
 #include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "hw/core/cpu.h"
 #include "hw/usb.h"
@@ -1834,6 +1835,23 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
     pcms->pit_enabled = value;
 }
 
+static void pc_machine_get_smbios_ep(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+    SmbiosEntryPointType smbios_ep = pcms->smbios_ep;
+
+    visit_type_SmbiosEntryPointType(v, name, &smbios_ep, errp);
+}
+
+static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_ep, errp);
+}
+
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
@@ -1879,6 +1897,8 @@ static void pc_machine_initfn(Object *obj)
     pcms->vmport = ON_OFF_AUTO_OFF;
 #endif /* CONFIG_VMPORT */
     pcms->max_ram_below_4g = 0; /* use default */
+    pcms->smbios_ep = SMBIOS_ENTRY_POINT_TYPE_2_1;
+
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus_enabled = true;
@@ -2004,6 +2024,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
         pc_machine_get_pit, pc_machine_set_pit);
+
+    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str",
+        pc_machine_get_smbios_ep, pc_machine_set_smbios_ep,
+        NULL, NULL);
+    object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
+        "SMBIOS Entry Point version [v2_1, v3_0]");
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1c5bc6ae6e..3626e5425f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -179,7 +179,7 @@ static void pc_init1(MachineState *machine,
         smbios_set_defaults("QEMU", "Standard PC (i440FX + PIIX, 1996)",
                             mc->name, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
-                            SMBIOS_ENTRY_POINT_TYPE_2_1);
+                            pcms->smbios_ep);
     }
 
     /* allocate ram and load rom/bios */
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cc202407c7..7cf08fa364 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -204,7 +204,7 @@ static void pc_q35_init(MachineState *machine)
         smbios_set_defaults("QEMU", "Standard PC (Q35 + ICH9, 2009)",
                             mc->name, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
-                            SMBIOS_ENTRY_POINT_TYPE_2_1);
+                            pcms->smbios_ep);
     }
 
     /* allocate ram and load rom/bios */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fe52e165b2..f5d2ebcb49 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -10,6 +10,7 @@
 
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/hotplug.h"
+#include "hw/firmware/smbios.h"
 
 #define HPET_INTCAP "hpet-intcap"
 
@@ -38,6 +39,7 @@ struct PCMachineState {
     /* Configuration options: */
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
+    SmbiosEntryPointType smbios_ep;
 
     bool acpi_build_enabled;
     bool smbus_enabled;
@@ -59,6 +61,7 @@ struct PCMachineState {
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
+#define PC_MACHINE_SMBIOS_EP        "smbios-ep"
 
 /**
  * PCMachineClass:
-- 
2.26.2


