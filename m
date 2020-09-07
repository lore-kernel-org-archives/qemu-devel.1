Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FC82065E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMGwARp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FC82065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFQn-00043C-01
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFFFo-0005Ve-NS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFFFm-0001PJ-Q8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A25icNiHaVw/f0aC3oKZnjbi4BsnTnr/X/xOX76lHNY=;
 b=YMGwARp4+jQpwJf2Ceku/YOUtcX2SM9akxpW506+adhccvqABVEUsJxHeynFfR7e5UhA4L
 KbBVPASsfgQLW4G1Lid5FyoeiMu5DJiai4JsuUNlSaYFcFhZ4sgSANVT6wTAiDV9DZy1TL
 vJ21LTT8VR/zGMUGpYjS39XM/8qyh5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Q1dXKgbuMn6jp-IBtRBeZg-1; Mon, 07 Sep 2020 07:24:04 -0400
X-MC-Unique: Q1dXKgbuMn6jp-IBtRBeZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFDB805EE4;
 Mon,  7 Sep 2020 11:24:03 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4A095D9D2;
 Mon,  7 Sep 2020 11:24:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/10] x86: acpi: introduce the PCI0.SMI0 ACPI device
Date: Mon,  7 Sep 2020 07:23:46 -0400
Message-Id: <20200907112348.530921-9-imammedo@redhat.com>
In-Reply-To: <20200907112348.530921-1-imammedo@redhat.com>
References: <20200907112348.530921-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When CPU hotplug with SMI has been negotiated, describe the SMI
register block in the DSDT. Pass the ACPI name of the SMI control
register to build_cpus_aml(), so that CPU_SCAN_METHOD can access the
register in the next patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/acpi/cpu.h |  1 +
 hw/i386/acpi-build.c  | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 62f0278ba2..0eeedaa491 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -50,6 +50,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
     bool has_legacy_cphp;
+    const char *smi_path;
 } CPUHotplugFeatures;
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e61c17a484..7a33ef193e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1521,6 +1521,32 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_UID", aml_int(0)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
+
+        if (pm->smi_on_cpuhp) {
+            /* reserve SMI block resources, IO ports 0xB2, 0xB3 */
+            dev = aml_device("PCI0.SMI0");
+            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
+            aml_append(dev, aml_name_decl("_UID", aml_string("SMI resources")));
+            crs = aml_resource_template();
+            aml_append(crs,
+                aml_io(
+                       AML_DECODE16,
+                       ACPI_PORT_SMI_CMD,
+                       ACPI_PORT_SMI_CMD,
+                       1,
+                       2)
+            );
+            aml_append(dev, aml_name_decl("_CRS", crs));
+            aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
+                aml_int(ACPI_PORT_SMI_CMD), 2));
+            field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
+                              AML_WRITE_AS_ZEROS);
+            aml_append(field, aml_named_field("SMIC", 8));
+            aml_append(field, aml_reserved_field(8));
+            aml_append(dev, field);
+            aml_append(sb_scope, dev);
+        }
+
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
@@ -1536,7 +1562,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .acpi_1_compatible = true, .has_legacy_cphp = true
+            .acpi_1_compatible = true, .has_legacy_cphp = true,
+            .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
-- 
2.27.0


