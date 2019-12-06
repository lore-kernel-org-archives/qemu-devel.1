Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3DC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328A824670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMziH11y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A824670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHji-0000n7-TA
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idHMW-0008GZ-Kl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idHMT-00071c-Gn
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idHMN-0006ut-Fw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65dn2EaMCTP37YOCYHLxZUlHztk6cKACuH+ML1W/q/Y=;
 b=aMziH11yQgjQtf/AW/mkS61z6aXPuSFZD+m3gRvZ6GZ7v+5vSaWs+hDv+IgULtwuf1blXD
 Sao1I+yJ5oL1VJG2xBCbFQsvnSX5IMs4RvhREt4roxDfTttSTch353LwNBrjXTdBU3djOq
 mBNYbEQTnLr3iwQaU4Eipx8qpXiUWBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-8050xD_CMJmfp4Lka9As7A-1; Fri, 06 Dec 2019 12:25:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2AF3800D5E;
 Fri,  6 Dec 2019 17:25:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-212.brq.redhat.com [10.40.204.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 068835C1C3;
 Fri,  6 Dec 2019 17:25:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 2/6] hw/pci-host/i440fx: Extract PCII440FXState to
 "hw/pci-host/i440fx.h"
Date: Fri,  6 Dec 2019 18:25:10 +0100
Message-Id: <20191206172514.21268-3-philmd@redhat.com>
In-Reply-To: <20191206172514.21268-1-philmd@redhat.com>
References: <20191206172514.21268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8050xD_CMJmfp4Lka9As7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the PCII440FXState structure public, so it can be used out of
this source file. This will allow us to extract the IGD Passthrough
Host Bridge, which is a children of the TYPE_I440FX_PCI_DEVICE.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/pci-host/i440fx.h | 19 +++++++++++++++++--
 hw/pci-host/i440fx.c         | 18 ------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index f54e6466e4..cc58d82ed4 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -13,12 +13,27 @@
=20
 #include "hw/hw.h"
 #include "hw/pci/pci_bus.h"
-
-typedef struct PCII440FXState PCII440FXState;
+#include "hw/pci-host/pam.h"
=20
 #define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
 #define TYPE_I440FX_PCI_DEVICE "i440FX"
=20
+#define I440FX_PCI_DEVICE(obj) \
+    OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
+
+typedef struct PCII440FXState {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion *system_memory;
+    MemoryRegion *pci_address_space;
+    MemoryRegion *ram_memory;
+    PAMMemoryRegion pam_regions[13];
+    MemoryRegion smram_region;
+    MemoryRegion smram, low_smram;
+} PCII440FXState;
+
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
=20
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 3fc94426ea..fbdc563599 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -31,7 +31,6 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/pci-host/pam.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
=20
@@ -51,23 +50,6 @@ typedef struct I440FXState {
     uint32_t short_root_bus;
 } I440FXState;
=20
-#define I440FX_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
-
-struct PCII440FXState {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion *system_memory;
-    MemoryRegion *pci_address_space;
-    MemoryRegion *ram_memory;
-    PAMMemoryRegion pam_regions[13];
-    MemoryRegion smram_region;
-    MemoryRegion smram, low_smram;
-};
-
-
 #define I440FX_PAM      0x59
 #define I440FX_PAM_SIZE 7
 #define I440FX_SMRAM    0x72
--=20
2.21.0


