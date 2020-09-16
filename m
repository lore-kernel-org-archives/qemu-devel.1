Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E688C2BB84
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7874720732
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG29gw/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7874720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIg45-0002OD-Fg
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 18:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIfzI-0006sQ-Ug
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 18:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIfzF-0000Oz-99
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 18:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600295592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5/G6RxlRRPdtbxOe6FX3VJBFHdCDO1wJZl9HvdrBS8=;
 b=TG29gw/f7vQTBOghTKiAogeeiRWc63Ny4EzUyCWmqLRiOn9RHiyHHZIbfYhee4ZQD6jcPy
 QSeLvwwN3S/q5A+bz8K18VauXNS2+BKON+PpJ3o7+tKA+qC8/Rky+5cXa9uiWaeDojWlUu
 4jR3GwdZuI0+6Qy6PdCISP20h3O83bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-V0-FgDKINT-KIvT6LNF_KA-1; Wed, 16 Sep 2020 18:33:08 -0400
X-MC-Unique: V0-FgDKINT-KIvT6LNF_KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FADB1868428;
 Wed, 16 Sep 2020 22:33:06 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8660D10023A7;
 Wed, 16 Sep 2020 22:33:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qom: Use DECLARE_INTERFACE_CHECKER macro
Date: Wed, 16 Sep 2020 18:32:58 -0400
Message-Id: <20200916223258.599367-3-ehabkost@redhat.com>
In-Reply-To: <20200916223258.599367-1-ehabkost@redhat.com>
References: <20200916223258.599367-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 "Daniel P. Berrange" <berrange@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mechanical search/replace to use the new
DECLARE_INTERFACE_CHECKER macro instead of manually defining
macros using INTERFACE_CHECK.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
This is an alternative to the patches submitted at
https://lore.kernel.org/qemu-devel/20200916193101.511600-3-ehabkost@redhat.com/
https://lore.kernel.org/qemu-devel/20200916193101.511600-4-ehabkost@redhat.com/
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Corey Minyard <minyard@acm.org>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Hervé Poussineau" <hpoussin@reactos.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/acpi/acpi_dev_interface.h |  5 ++---
 include/hw/arm/linux-boot-if.h       |  4 ++--
 include/hw/fw-path-provider.h        |  4 ++--
 include/hw/hotplug.h                 |  4 ++--
 include/hw/intc/intc.h               |  5 ++---
 include/hw/ipmi/ipmi.h               |  4 ++--
 include/hw/isa/isa.h                 |  4 ++--
 include/hw/mem/memory-device.h       |  4 ++--
 include/hw/nmi.h                     |  4 ++--
 include/hw/ppc/pnv_xscom.h           |  4 ++--
 include/hw/ppc/spapr_irq.h           |  4 ++--
 include/hw/ppc/xics.h                |  4 ++--
 include/hw/ppc/xive.h                | 12 ++++++------
 include/hw/rdma/rdma.h               |  5 ++---
 include/hw/rtc/m48t59.h              |  4 ++--
 include/hw/stream.h                  |  4 ++--
 include/hw/vmstate-if.h              |  4 ++--
 include/qom/object_interfaces.h      |  5 ++---
 include/sysemu/tpm.h                 |  4 ++--
 target/arm/idau.h                    |  4 ++--
 tests/check-qom-interface.c          |  4 ++--
 21 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 9adf1e4706..96aa63919a 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -21,9 +21,8 @@ typedef enum {
 typedef struct AcpiDeviceIfClass AcpiDeviceIfClass;
 DECLARE_CLASS_CHECKERS(AcpiDeviceIfClass, ACPI_DEVICE_IF,
                        TYPE_ACPI_DEVICE_IF)
-#define ACPI_DEVICE_IF(obj) \
-     INTERFACE_CHECK(AcpiDeviceIf, (obj), \
-                     TYPE_ACPI_DEVICE_IF)
+DECLARE_INTERFACE_CHECKER(AcpiDeviceIf, ACPI_DEVICE_IF,
+                          TYPE_ACPI_DEVICE_IF)
 
 typedef struct AcpiDeviceIf AcpiDeviceIf;
 
diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boot-if.h
index c85f33b2c5..856d95831c 100644
--- a/include/hw/arm/linux-boot-if.h
+++ b/include/hw/arm/linux-boot-if.h
@@ -12,8 +12,8 @@
 typedef struct ARMLinuxBootIfClass ARMLinuxBootIfClass;
 DECLARE_CLASS_CHECKERS(ARMLinuxBootIfClass, ARM_LINUX_BOOT_IF,
                        TYPE_ARM_LINUX_BOOT_IF)
-#define ARM_LINUX_BOOT_IF(obj) \
-    INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
+DECLARE_INTERFACE_CHECKER(ARMLinuxBootIf, ARM_LINUX_BOOT_IF,
+                          TYPE_ARM_LINUX_BOOT_IF)
 
 typedef struct ARMLinuxBootIf ARMLinuxBootIf;
 
diff --git a/include/hw/fw-path-provider.h b/include/hw/fw-path-provider.h
index 8e1d45651c..93d5fdb6c3 100644
--- a/include/hw/fw-path-provider.h
+++ b/include/hw/fw-path-provider.h
@@ -25,8 +25,8 @@
 typedef struct FWPathProviderClass FWPathProviderClass;
 DECLARE_CLASS_CHECKERS(FWPathProviderClass, FW_PATH_PROVIDER,
                        TYPE_FW_PATH_PROVIDER)
-#define FW_PATH_PROVIDER(obj) \
-     INTERFACE_CHECK(FWPathProvider, (obj), TYPE_FW_PATH_PROVIDER)
+DECLARE_INTERFACE_CHECKER(FWPathProvider, FW_PATH_PROVIDER,
+                          TYPE_FW_PATH_PROVIDER)
 
 typedef struct FWPathProvider FWPathProvider;
 
diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index e15f59c8b3..727c70ca9a 100644
--- a/include/hw/hotplug.h
+++ b/include/hw/hotplug.h
@@ -19,8 +19,8 @@
 typedef struct HotplugHandlerClass HotplugHandlerClass;
 DECLARE_CLASS_CHECKERS(HotplugHandlerClass, HOTPLUG_HANDLER,
                        TYPE_HOTPLUG_HANDLER)
-#define HOTPLUG_HANDLER(obj) \
-     INTERFACE_CHECK(HotplugHandler, (obj), TYPE_HOTPLUG_HANDLER)
+DECLARE_INTERFACE_CHECKER(HotplugHandler, HOTPLUG_HANDLER,
+                          TYPE_HOTPLUG_HANDLER)
 
 typedef struct HotplugHandler HotplugHandler;
 
diff --git a/include/hw/intc/intc.h b/include/hw/intc/intc.h
index 7018f608ca..9f36c9c14f 100644
--- a/include/hw/intc/intc.h
+++ b/include/hw/intc/intc.h
@@ -8,9 +8,8 @@
 typedef struct InterruptStatsProviderClass InterruptStatsProviderClass;
 DECLARE_CLASS_CHECKERS(InterruptStatsProviderClass, INTERRUPT_STATS_PROVIDER,
                        TYPE_INTERRUPT_STATS_PROVIDER)
-#define INTERRUPT_STATS_PROVIDER(obj) \
-    INTERFACE_CHECK(InterruptStatsProvider, (obj), \
-                    TYPE_INTERRUPT_STATS_PROVIDER)
+DECLARE_INTERFACE_CHECKER(InterruptStatsProvider, INTERRUPT_STATS_PROVIDER,
+                          TYPE_INTERRUPT_STATS_PROVIDER)
 
 typedef struct InterruptStatsProvider InterruptStatsProvider;
 
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 3fa5a4abd0..25133264ff 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -109,8 +109,8 @@ uint32_t ipmi_next_uuid(void);
  * and the BMC.
  */
 #define TYPE_IPMI_INTERFACE "ipmi-interface"
-#define IPMI_INTERFACE(obj) \
-     INTERFACE_CHECK(IPMIInterface, (obj), TYPE_IPMI_INTERFACE)
+DECLARE_INTERFACE_CHECKER(IPMIInterface, IPMI_INTERFACE,
+                          TYPE_IPMI_INTERFACE)
 typedef struct IPMIInterfaceClass IPMIInterfaceClass;
 DECLARE_CLASS_CHECKERS(IPMIInterfaceClass, IPMI_INTERFACE,
                        TYPE_IPMI_INTERFACE)
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index ddb6a2d168..9e3e8aaaaa 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -38,8 +38,8 @@ static inline uint16_t applesmc_port(void)
 typedef struct IsaDmaClass IsaDmaClass;
 DECLARE_CLASS_CHECKERS(IsaDmaClass, ISADMA,
                        TYPE_ISADMA)
-#define ISADMA(obj) \
-    INTERFACE_CHECK(IsaDma, (obj), TYPE_ISADMA)
+DECLARE_INTERFACE_CHECKER(IsaDma, ISADMA,
+                          TYPE_ISADMA)
 
 typedef enum {
     ISADMA_TRANSFER_VERIFY,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index cde52e83c9..c5b32e2c6a 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -22,8 +22,8 @@
 typedef struct MemoryDeviceClass MemoryDeviceClass;
 DECLARE_CLASS_CHECKERS(MemoryDeviceClass, MEMORY_DEVICE,
                        TYPE_MEMORY_DEVICE)
-#define MEMORY_DEVICE(obj) \
-     INTERFACE_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
+DECLARE_INTERFACE_CHECKER(MemoryDeviceState, MEMORY_DEVICE,
+                          TYPE_MEMORY_DEVICE)
 
 typedef struct MemoryDeviceState MemoryDeviceState;
 
diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index fff41bebc6..b31082e969 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -29,8 +29,8 @@
 typedef struct NMIClass NMIClass;
 DECLARE_CLASS_CHECKERS(NMIClass, NMI,
                        TYPE_NMI)
-#define NMI(obj) \
-     INTERFACE_CHECK(NMIState, (obj), TYPE_NMI)
+DECLARE_INTERFACE_CHECKER(NMIState, NMI,
+                          TYPE_NMI)
 
 typedef struct NMIState NMIState;
 
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 7e3b189c07..0d24a75827 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -25,8 +25,8 @@
 typedef struct PnvXScomInterface PnvXScomInterface;
 
 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
-#define PNV_XSCOM_INTERFACE(obj) \
-    INTERFACE_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
+DECLARE_INTERFACE_CHECKER(PnvXScomInterface, PNV_XSCOM_INTERFACE,
+                          TYPE_PNV_XSCOM_INTERFACE)
 typedef struct PnvXScomInterfaceClass PnvXScomInterfaceClass;
 DECLARE_CLASS_CHECKERS(PnvXScomInterfaceClass, PNV_XSCOM_INTERFACE,
                        TYPE_PNV_XSCOM_INTERFACE)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..105e1fb4e7 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -34,8 +34,8 @@ struct SpaprMachineState;
 typedef struct SpaprInterruptController SpaprInterruptController;
 
 #define TYPE_SPAPR_INTC "spapr-interrupt-controller"
-#define SPAPR_INTC(obj)                                     \
-    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
+DECLARE_INTERFACE_CHECKER(SpaprInterruptController, SPAPR_INTC,
+                          TYPE_SPAPR_INTC)
 typedef struct SpaprInterruptControllerClass SpaprInterruptControllerClass;
 DECLARE_CLASS_CHECKERS(SpaprInterruptControllerClass, SPAPR_INTC,
                        TYPE_SPAPR_INTC)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index c5a3cdcadc..eea6701371 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -137,8 +137,8 @@ struct ICSIRQState {
 };
 
 #define TYPE_XICS_FABRIC "xics-fabric"
-#define XICS_FABRIC(obj)                                     \
-    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
+DECLARE_INTERFACE_CHECKER(XICSFabric, XICS_FABRIC,
+                          TYPE_XICS_FABRIC)
 typedef struct XICSFabricClass XICSFabricClass;
 DECLARE_CLASS_CHECKERS(XICSFabricClass, XICS_FABRIC,
                        TYPE_XICS_FABRIC)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 482fafccfd..3db9b4e5fd 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -152,8 +152,8 @@
 typedef struct XiveNotifier XiveNotifier;
 
 #define TYPE_XIVE_NOTIFIER "xive-notifier"
-#define XIVE_NOTIFIER(obj)                                     \
-    INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+DECLARE_INTERFACE_CHECKER(XiveNotifier, XIVE_NOTIFIER,
+                          TYPE_XIVE_NOTIFIER)
 typedef struct XiveNotifierClass XiveNotifierClass;
 DECLARE_CLASS_CHECKERS(XiveNotifierClass, XIVE_NOTIFIER,
                        TYPE_XIVE_NOTIFIER)
@@ -389,8 +389,8 @@ typedef struct XiveTCTXMatch {
 } XiveTCTXMatch;
 
 #define TYPE_XIVE_PRESENTER "xive-presenter"
-#define XIVE_PRESENTER(obj)                                     \
-    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
+DECLARE_INTERFACE_CHECKER(XivePresenter, XIVE_PRESENTER,
+                          TYPE_XIVE_PRESENTER)
 typedef struct XivePresenterClass XivePresenterClass;
 DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
                        TYPE_XIVE_PRESENTER)
@@ -414,8 +414,8 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  */
 
 #define TYPE_XIVE_FABRIC "xive-fabric"
-#define XIVE_FABRIC(obj)                                     \
-    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+DECLARE_INTERFACE_CHECKER(XiveFabric, XIVE_FABRIC,
+                          TYPE_XIVE_FABRIC)
 typedef struct XiveFabricClass XiveFabricClass;
 DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
                        TYPE_XIVE_FABRIC)
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
index e77e43a170..ba520b64fe 100644
--- a/include/hw/rdma/rdma.h
+++ b/include/hw/rdma/rdma.h
@@ -22,9 +22,8 @@
 typedef struct RdmaProviderClass RdmaProviderClass;
 DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,
                        INTERFACE_RDMA_PROVIDER)
-#define RDMA_PROVIDER(obj) \
-    INTERFACE_CHECK(RdmaProvider, (obj), \
-                    INTERFACE_RDMA_PROVIDER)
+DECLARE_INTERFACE_CHECKER(RdmaProvider, RDMA_PROVIDER,
+                          INTERFACE_RDMA_PROVIDER)
 
 typedef struct RdmaProvider RdmaProvider;
 
diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 04abedf3b2..0e61c6c2c4 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -34,8 +34,8 @@
 typedef struct NvramClass NvramClass;
 DECLARE_CLASS_CHECKERS(NvramClass, NVRAM,
                        TYPE_NVRAM)
-#define NVRAM(obj) \
-    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
+DECLARE_INTERFACE_CHECKER(Nvram, NVRAM,
+                          TYPE_NVRAM)
 
 typedef struct Nvram Nvram;
 
diff --git a/include/hw/stream.h b/include/hw/stream.h
index e39d5a5b55..8662c4fcff 100644
--- a/include/hw/stream.h
+++ b/include/hw/stream.h
@@ -9,8 +9,8 @@
 typedef struct StreamSlaveClass StreamSlaveClass;
 DECLARE_CLASS_CHECKERS(StreamSlaveClass, STREAM_SLAVE,
                        TYPE_STREAM_SLAVE)
-#define STREAM_SLAVE(obj) \
-     INTERFACE_CHECK(StreamSlave, (obj), TYPE_STREAM_SLAVE)
+DECLARE_INTERFACE_CHECKER(StreamSlave, STREAM_SLAVE,
+                          TYPE_STREAM_SLAVE)
 
 typedef struct StreamSlave StreamSlave;
 
diff --git a/include/hw/vmstate-if.h b/include/hw/vmstate-if.h
index 52df571d17..9797cb4321 100644
--- a/include/hw/vmstate-if.h
+++ b/include/hw/vmstate-if.h
@@ -16,8 +16,8 @@
 typedef struct VMStateIfClass VMStateIfClass;
 DECLARE_CLASS_CHECKERS(VMStateIfClass, VMSTATE_IF,
                        TYPE_VMSTATE_IF)
-#define VMSTATE_IF(obj)                             \
-    INTERFACE_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
+DECLARE_INTERFACE_CHECKER(VMStateIf, VMSTATE_IF,
+                          TYPE_VMSTATE_IF)
 
 typedef struct VMStateIf VMStateIf;
 
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index f118fb516b..1e6a6ce811 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -9,9 +9,8 @@
 typedef struct UserCreatableClass UserCreatableClass;
 DECLARE_CLASS_CHECKERS(UserCreatableClass, USER_CREATABLE,
                        TYPE_USER_CREATABLE)
-#define USER_CREATABLE(obj) \
-     INTERFACE_CHECK(UserCreatable, (obj), \
-                     TYPE_USER_CREATABLE)
+DECLARE_INTERFACE_CHECKER(UserCreatable, USER_CREATABLE,
+                          TYPE_USER_CREATABLE)
 
 typedef struct UserCreatable UserCreatable;
 
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 1a85564e47..5a7f13400d 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -29,8 +29,8 @@ typedef enum TPMVersion {
 typedef struct TPMIfClass TPMIfClass;
 DECLARE_CLASS_CHECKERS(TPMIfClass, TPM_IF,
                        TYPE_TPM_IF)
-#define TPM_IF(obj)                             \
-    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
+DECLARE_INTERFACE_CHECKER(TPMIf, TPM_IF,
+                          TYPE_TPM_IF)
 
 typedef struct TPMIf TPMIf;
 
diff --git a/target/arm/idau.h b/target/arm/idau.h
index 0ef5251971..0d09ad0abd 100644
--- a/target/arm/idau.h
+++ b/target/arm/idau.h
@@ -31,8 +31,8 @@
 #include "qom/object.h"
 
 #define TYPE_IDAU_INTERFACE "idau-interface"
-#define IDAU_INTERFACE(obj) \
-    INTERFACE_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
+DECLARE_INTERFACE_CHECKER(IDAUInterface, IDAU_INTERFACE,
+                          TYPE_IDAU_INTERFACE)
 typedef struct IDAUInterfaceClass IDAUInterfaceClass;
 DECLARE_CLASS_CHECKERS(IDAUInterfaceClass, IDAU_INTERFACE,
                        TYPE_IDAU_INTERFACE)
diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
index c99be97ed8..b0ca517510 100644
--- a/tests/check-qom-interface.c
+++ b/tests/check-qom-interface.c
@@ -19,8 +19,8 @@
 typedef struct TestIfClass TestIfClass;
 DECLARE_CLASS_CHECKERS(TestIfClass, TEST_IF,
                        TYPE_TEST_IF)
-#define TEST_IF(obj) \
-     INTERFACE_CHECK(TestIf, (obj), TYPE_TEST_IF)
+DECLARE_INTERFACE_CHECKER(TestIf, TEST_IF,
+                          TYPE_TEST_IF)
 
 typedef struct TestIf TestIf;
 
-- 
2.26.2


