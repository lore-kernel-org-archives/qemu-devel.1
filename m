Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4327DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0670C20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi3rOBgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0670C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEWs-0005OU-8w
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETn-0008TO-6a
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETl-0001QF-9a
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtvGed/OFKwo/KPonF6wNPBQThzBS/0Dl1GdOBvffZw=;
 b=Gi3rOBgRw1wGMYnUR1hUHwmjhrjtApCsInm4yRzDNSBDWnTqvnnPoXWk9wU5HCJc+/xTQM
 C6b5gyvXvLFEf0duu9g3kQ2MEhv0jdpS56OjH4a2ieGjqMpKgyQpY6HKKRvcSc11rly0Va
 vwINJfY+b+TWoErJCLLr0eoSdSzkWg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-EZigzOzBNpGNtzOIav3qvA-1; Wed, 24 Jun 2020 19:06:51 -0400
X-MC-Unique: EZigzOzBNpGNtzOIav3qvA-1
Received: by mail-wm1-f71.google.com with SMTP id v6so2542709wmg.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OtvGed/OFKwo/KPonF6wNPBQThzBS/0Dl1GdOBvffZw=;
 b=aQ8XN52jQ3WNNcBNz5M954UdkI5re9U1Qlu81f45S+HhVoJQwT4oPl38T3cz4jbcSW
 n2p2fwf2lKFZTGS6/Q7ViVJ8jNT897wqi6wjE+V3RKP4UF+md9wn6l2rSQgBWAkTSMyl
 bG2Eo6cJXmZtEmnqwrFYA6IkVtByv3ekkH/j0FPZ78lq4o2odZSwxSt2qRYhCASZ0lEU
 6x8FuoT2qvGOBqk/vfrNZFhc68U47n/Lhw/ujtn25l6MCskTsObgHEGuU9NHeCyFYssH
 8LrtCpLWF78oI23x6kqdoC+Df7Lha+2LtP9JCwQlu5UrvZGf8m6Y/TO3QTF165Xhid6o
 7OIw==
X-Gm-Message-State: AOAM530iKMK5mYiV37D6S6G9s4PQqmJZMDL00iebXXtbq/2Lq6AXMhcM
 KMwiwHW2mgfK0sJm+nmOqbTkHaoPwm+19dR5kTQLCJZLcrXWhOkRBxbn6QkPw64nUrfjRnOwWor
 f5o/y+ZIIuFyLR58=
X-Received: by 2002:adf:e68d:: with SMTP id r13mr28428359wrm.141.1593040009613; 
 Wed, 24 Jun 2020 16:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztrMV1Bsnja9uCJaWHYmsKJLkfIStaHHf7JmnrceFOVmlkAoLSTJWM9U4xr8z2dgTUyyCNgw==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr28428338wrm.141.1593040009426; 
 Wed, 24 Jun 2020 16:06:49 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 h29sm30691207wrc.78.2020.06.24.16.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:48 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] acpi: factor out fw_cfg_add_acpi_dsdt()
Message-ID: <20200624230609.703104-8-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Add helper function to add fw_cfg device,
also move code to hw/i386/fw_cfg.c.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200619091905.21676-8-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/fw_cfg.h     |  1 +
 hw/i386/acpi-build.c | 24 +-----------------------
 hw/i386/fw_cfg.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 9e74278779..275f15c1c5 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -25,5 +25,6 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                uint16_t apic_id_limit);
 void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
+void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
 
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 13113e83df..19e9c298dc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1802,30 +1802,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     /* create fw_cfg node, unconditionally */
     {
-        /* when using port i/o, the 8-bit data register *always* overlaps
-         * with half of the 16-bit control register. Hence, the total size
-         * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
-         * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
-        uint8_t io_size = object_property_get_bool(OBJECT(x86ms->fw_cfg),
-                                                   "dma_enabled", NULL) ?
-                          ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
-                          FW_CFG_CTL_SIZE;
-
         scope = aml_scope("\\_SB.PCI0");
-        dev = aml_device("FWCF");
-
-        aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
-
-        /* device present, functioning, decoding, not shown in UI */
-        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
-
-        crs = aml_resource_template();
-        aml_append(crs,
-            aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_size)
-        );
-        aml_append(dev, aml_name_decl("_CRS", crs));
-
-        aml_append(scope, dev);
+        fw_cfg_add_acpi_dsdt(scope, x86ms->fw_cfg);
         aml_append(dsdt, scope);
     }
 
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index da60ada594..c55abfb01a 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/numa.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/firmware/smbios.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/timer/hpet.h"
@@ -179,3 +180,30 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
     *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
     fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
 }
+
+void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
+{
+    /*
+     * when using port i/o, the 8-bit data register *always* overlaps
+     * with half of the 16-bit control register. Hence, the total size
+     * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
+     * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
+     */
+    Object *obj = OBJECT(fw_cfg);
+    uint8_t io_size = object_property_get_bool(obj, "dma_enabled", NULL) ?
+        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
+        FW_CFG_CTL_SIZE;
+    Aml *dev = aml_device("FWCF");
+    Aml *crs = aml_resource_template();
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
+
+    /* device present, functioning, decoding, not shown in UI */
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
+
+    aml_append(crs,
+        aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_size));
+
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
-- 
MST


