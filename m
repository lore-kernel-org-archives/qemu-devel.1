Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB532C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA01207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3H9NpxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA01207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA9l-0002HV-U0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xp-0003se-6h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xn-0001in-19
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNJ6FXWMCX2j0lKt+KziOzsAG/P8oH2Ou8qDxyL/5Co=;
 b=S3H9NpxAxV2rjMcKkHtWAjFH3LZbvMDWp9PCLN2Brh/51X46Q0ZT5OjiAXbKwm7L/Ao8dA
 1farcJzDKKVtyaYGzwPEz5jOGbh15SWtY5qR7nqVxbUyZrefOsPxOAXxUiO2ozYlo2+spc
 j+qyzCnmkK9YWK+xP8AVhVt4wcnw0Ys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-9Hz8gZ2EPgCsOsikx2ktDA-1; Tue, 29 Sep 2020 03:22:11 -0400
X-MC-Unique: 9Hz8gZ2EPgCsOsikx2ktDA-1
Received: by mail-wr1-f72.google.com with SMTP id v12so1369968wrm.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lNJ6FXWMCX2j0lKt+KziOzsAG/P8oH2Ou8qDxyL/5Co=;
 b=YfVODJkn/vZ/y+sv/vWF2mulguXTVmqXLCJckSwWfVA7VOUAyZOk4+vJ3DupqLeVuW
 T3rh7i34MKXsufircLAC35MVRXBSb6BRt1SyxF3We9cz+8hsdGSgm4W5p1jtKLleAhcX
 tv5B2JooDKD7OYtX9JspTpyZJYvGh8s+Go2l2RS1pgYxIorm3ppfSjFrk65SdAgYDLpU
 YCQuXJsXGV2fsmsLPSPuCP9xdFbvquF70KQTA/QrmgRUef2JshPECxvmjC4IUuIKdokT
 0bw2L+vWD57bXzWeIASoAbREUToKQ0n80EqsaZD/9R95TfRcoFanx6tn9Bm80jeMNeda
 4ccw==
X-Gm-Message-State: AOAM533EDutDNPm7vPNGwy+vqtLmCwW7fwbgYgPCL4D7i1Ki+Qji46vP
 MZfA5fLVj0XGrk4SjRA+uQnlbQnbznc2b0GgiAwM+1DAWSVt9S6CaAp8eVAzqzGVmoTApqE+pvx
 Tv6yp88hiBOBn3R8=
X-Received: by 2002:adf:e488:: with SMTP id i8mr2730306wrm.116.1601364130399; 
 Tue, 29 Sep 2020 00:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj/wRVQrKynUYWWxm2ZjvCobmkrSBMSUclhGePth/QWLWTF5vT193/r1AoRLOJOq9gllApIw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr2730287wrm.116.1601364130216; 
 Tue, 29 Sep 2020 00:22:10 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 70sm4245329wme.15.2020.09.29.00.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:09 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 28/48] x86: acpi: introduce the PCI0.SMI0 ACPI device
Message-ID: <20200929071948.281157-29-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

When CPU hotplug with SMI has been negotiated, describe the SMI
register block in the DSDT. Pass the ACPI name of the SMI control
register to build_cpus_aml(), so that CPU_SCAN_METHOD can access the
register in the next patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200923094650.1301166-9-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index b408d62560..b49d360ab2 100644
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
MST


