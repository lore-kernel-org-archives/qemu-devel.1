Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F58DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7C32080C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/LLfocT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7C32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHLf-0003Rb-27
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKM-00012L-31
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKK-0007oi-LM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKK-0007nr-Eq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyGr9EDP8Lt47BNdtDV45HB9ePlMiacy+4RxxiFGp9U=;
 b=X/LLfocTbOx5/QNOzhUGPBEZwCBYQw3z5eLGXyj7qz3stJgs08D/NzxC6EkrldMvJBsoa0
 +aK1FNR1cpZMXzmcxCrKPYf1pC5V41FZ+XBhQ5R2fgJ45fYUImEjkVsEvY8UdgCIL0mEDJ
 wbobkhzaTJXFbNg4QJr43aw+3QCVAhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-rxfCmH3lOduVPwIVp0sFNg-1; Fri, 03 Apr 2020 04:05:15 -0400
X-MC-Unique: rxfCmH3lOduVPwIVp0sFNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8951005516;
 Fri,  3 Apr 2020 08:05:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9F671147CE;
 Fri,  3 Apr 2020 08:05:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6465C17524; Fri,  3 Apr 2020 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] acpi: factor out fw_cfg_add_acpi_dsdt()
Date: Fri,  3 Apr 2020 10:05:02 +0200
Message-Id: <20200403080502.8154-13-kraxel@redhat.com>
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add helper function to add fw_cfg device,
also move code to hw/i386/fw_cfg.c.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/fw_cfg.h     |  1 +
 hw/i386/acpi-build.c | 24 +-----------------------
 hw/i386/fw_cfg.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 9e742787792b..275f15c1c5e8 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -25,5 +25,6 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                uint16_t apic_id_limit);
 void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
+void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
=20
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 23817d9005cc..55ece91655cf 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1874,30 +1874,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
=20
     /* create fw_cfg node, unconditionally */
     {
-        /* when using port i/o, the 8-bit data register *always* overlaps
-         * with half of the 16-bit control register. Hence, the total size
-         * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
-         * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
-        uint8_t io_size =3D object_property_get_bool(OBJECT(x86ms->fw_cfg)=
,
-                                                   "dma_enabled", NULL) ?
-                          ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t=
) :
-                          FW_CFG_CTL_SIZE;
-
         scope =3D aml_scope("\\_SB.PCI0");
-        dev =3D aml_device("FWCF");
-
-        aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
-
-        /* device present, functioning, decoding, not shown in UI */
-        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
-
-        crs =3D aml_resource_template();
-        aml_append(crs,
-            aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_=
size)
-        );
-        aml_append(dev, aml_name_decl("_CRS", crs));
-
-        aml_append(scope, dev);
+        fw_cfg_add_acpi_dsdt(scope, x86ms->fw_cfg);
         aml_append(dsdt, scope);
     }
=20
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index da60ada59462..c55abfb01abb 100644
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
@@ -179,3 +180,30 @@ void fw_cfg_build_feature_control(MachineState *ms, FW=
CfgState *fw_cfg)
     *val =3D cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
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
+    Object *obj =3D OBJECT(fw_cfg);
+    uint8_t io_size =3D object_property_get_bool(obj, "dma_enabled", NULL)=
 ?
+        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
+        FW_CFG_CTL_SIZE;
+    Aml *dev =3D aml_device("FWCF");
+    Aml *crs =3D aml_resource_template();
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
+
+    /* device present, functioning, decoding, not shown in UI */
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
+
+    aml_append(crs,
+        aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_size=
));
+
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
--=20
2.18.2


