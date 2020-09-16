Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDEFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC65208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrItd6UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC65208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIdFq-00053D-JI
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kId9D-0000Co-5D
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:31:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54873
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kId98-00018S-KN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600284673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDvbC7sysoVl5NhjtsytuLHIjE6n12LKDfJ/HU+tqiA=;
 b=BrItd6UQ71p/wjO7U62m5skhlqJgnOY7kfhDE62jDzLfgkLSnRy4OQR+NhV/4Fq6KgH8os
 XB1ivcqaN2zz4IgLpTbMwI4foENkPPflkMEAk9S1p9DPoIK5O0UJqjGWtvvmWU7AYaFuTg
 KLexpAUrkP81RLzd0wtpewejToJHozs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-5qUd7LE9NESPR_6DojmsQA-1; Wed, 16 Sep 2020 15:31:11 -0400
X-MC-Unique: 5qUd7LE9NESPR_6DojmsQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3521D18B9F00;
 Wed, 16 Sep 2020 19:31:09 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 359A660CC0;
 Wed, 16 Sep 2020 19:31:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK
Date: Wed, 16 Sep 2020 15:31:00 -0400
Message-Id: <20200916193101.511600-3-ehabkost@redhat.com>
In-Reply-To: <20200916193101.511600-1-ehabkost@redhat.com>
References: <20200916193101.511600-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 11:15:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

INTERFACE_CHECK and OBJECT_CHECK do exactly the same.  There's no
need to have two different methods for declaring the type checker
macro for interface types.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
 include/hw/acpi/acpi_dev_interface.h |  2 +-
 include/hw/arm/linux-boot-if.h       |  2 +-
 include/hw/fw-path-provider.h        |  2 +-
 include/hw/hotplug.h                 |  2 +-
 include/hw/intc/intc.h               |  2 +-
 include/hw/ipmi/ipmi.h               |  2 +-
 include/hw/isa/isa.h                 |  2 +-
 include/hw/mem/memory-device.h       |  2 +-
 include/hw/nmi.h                     |  2 +-
 include/hw/ppc/pnv_xscom.h           |  2 +-
 include/hw/ppc/spapr_irq.h           |  2 +-
 include/hw/ppc/xics.h                |  2 +-
 include/hw/ppc/xive.h                |  6 +++---
 include/hw/rdma/rdma.h               |  2 +-
 include/hw/rtc/m48t59.h              |  2 +-
 include/hw/stream.h                  |  2 +-
 include/hw/vmstate-if.h              |  2 +-
 include/qom/object.h                 | 12 ------------
 include/qom/object_interfaces.h      |  2 +-
 include/sysemu/tpm.h                 |  2 +-
 target/arm/idau.h                    |  2 +-
 tests/check-qom-interface.c          |  2 +-
 22 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 9adf1e4706..5637a41936 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -22,7 +22,7 @@ typedef struct AcpiDeviceIfClass AcpiDeviceIfClass;
 DECLARE_CLASS_CHECKERS(AcpiDeviceIfClass, ACPI_DEVICE_IF,
                        TYPE_ACPI_DEVICE_IF)
 #define ACPI_DEVICE_IF(obj) \
-     INTERFACE_CHECK(AcpiDeviceIf, (obj), \
+     OBJECT_CHECK(AcpiDeviceIf, (obj), \
                      TYPE_ACPI_DEVICE_IF)
 
 typedef struct AcpiDeviceIf AcpiDeviceIf;
diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boot-if.h
index c85f33b2c5..4b86bb1067 100644
--- a/include/hw/arm/linux-boot-if.h
+++ b/include/hw/arm/linux-boot-if.h
@@ -13,7 +13,7 @@ typedef struct ARMLinuxBootIfClass ARMLinuxBootIfClass;
 DECLARE_CLASS_CHECKERS(ARMLinuxBootIfClass, ARM_LINUX_BOOT_IF,
                        TYPE_ARM_LINUX_BOOT_IF)
 #define ARM_LINUX_BOOT_IF(obj) \
-    INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
+    OBJECT_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
 
 typedef struct ARMLinuxBootIf ARMLinuxBootIf;
 
diff --git a/include/hw/fw-path-provider.h b/include/hw/fw-path-provider.h
index 8e1d45651c..9b00b2eb37 100644
--- a/include/hw/fw-path-provider.h
+++ b/include/hw/fw-path-provider.h
@@ -26,7 +26,7 @@ typedef struct FWPathProviderClass FWPathProviderClass;
 DECLARE_CLASS_CHECKERS(FWPathProviderClass, FW_PATH_PROVIDER,
                        TYPE_FW_PATH_PROVIDER)
 #define FW_PATH_PROVIDER(obj) \
-     INTERFACE_CHECK(FWPathProvider, (obj), TYPE_FW_PATH_PROVIDER)
+     OBJECT_CHECK(FWPathProvider, (obj), TYPE_FW_PATH_PROVIDER)
 
 typedef struct FWPathProvider FWPathProvider;
 
diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index e15f59c8b3..c87dfba941 100644
--- a/include/hw/hotplug.h
+++ b/include/hw/hotplug.h
@@ -20,7 +20,7 @@ typedef struct HotplugHandlerClass HotplugHandlerClass;
 DECLARE_CLASS_CHECKERS(HotplugHandlerClass, HOTPLUG_HANDLER,
                        TYPE_HOTPLUG_HANDLER)
 #define HOTPLUG_HANDLER(obj) \
-     INTERFACE_CHECK(HotplugHandler, (obj), TYPE_HOTPLUG_HANDLER)
+     OBJECT_CHECK(HotplugHandler, (obj), TYPE_HOTPLUG_HANDLER)
 
 typedef struct HotplugHandler HotplugHandler;
 
diff --git a/include/hw/intc/intc.h b/include/hw/intc/intc.h
index 7018f608ca..c01d696937 100644
--- a/include/hw/intc/intc.h
+++ b/include/hw/intc/intc.h
@@ -9,7 +9,7 @@ typedef struct InterruptStatsProviderClass InterruptStatsProviderClass;
 DECLARE_CLASS_CHECKERS(InterruptStatsProviderClass, INTERRUPT_STATS_PROVIDER,
                        TYPE_INTERRUPT_STATS_PROVIDER)
 #define INTERRUPT_STATS_PROVIDER(obj) \
-    INTERFACE_CHECK(InterruptStatsProvider, (obj), \
+    OBJECT_CHECK(InterruptStatsProvider, (obj), \
                     TYPE_INTERRUPT_STATS_PROVIDER)
 
 typedef struct InterruptStatsProvider InterruptStatsProvider;
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 3fa5a4abd0..7073472ff8 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -110,7 +110,7 @@ uint32_t ipmi_next_uuid(void);
  */
 #define TYPE_IPMI_INTERFACE "ipmi-interface"
 #define IPMI_INTERFACE(obj) \
-     INTERFACE_CHECK(IPMIInterface, (obj), TYPE_IPMI_INTERFACE)
+     OBJECT_CHECK(IPMIInterface, (obj), TYPE_IPMI_INTERFACE)
 typedef struct IPMIInterfaceClass IPMIInterfaceClass;
 DECLARE_CLASS_CHECKERS(IPMIInterfaceClass, IPMI_INTERFACE,
                        TYPE_IPMI_INTERFACE)
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index ddb6a2d168..492e0f073f 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -39,7 +39,7 @@ typedef struct IsaDmaClass IsaDmaClass;
 DECLARE_CLASS_CHECKERS(IsaDmaClass, ISADMA,
                        TYPE_ISADMA)
 #define ISADMA(obj) \
-    INTERFACE_CHECK(IsaDma, (obj), TYPE_ISADMA)
+    OBJECT_CHECK(IsaDma, (obj), TYPE_ISADMA)
 
 typedef enum {
     ISADMA_TRANSFER_VERIFY,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index cde52e83c9..5eaa106dc3 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -23,7 +23,7 @@ typedef struct MemoryDeviceClass MemoryDeviceClass;
 DECLARE_CLASS_CHECKERS(MemoryDeviceClass, MEMORY_DEVICE,
                        TYPE_MEMORY_DEVICE)
 #define MEMORY_DEVICE(obj) \
-     INTERFACE_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
+     OBJECT_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
 
 typedef struct MemoryDeviceState MemoryDeviceState;
 
diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index fff41bebc6..faa1c62aaa 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -30,7 +30,7 @@ typedef struct NMIClass NMIClass;
 DECLARE_CLASS_CHECKERS(NMIClass, NMI,
                        TYPE_NMI)
 #define NMI(obj) \
-     INTERFACE_CHECK(NMIState, (obj), TYPE_NMI)
+     OBJECT_CHECK(NMIState, (obj), TYPE_NMI)
 
 typedef struct NMIState NMIState;
 
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 7e3b189c07..597784393f 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -26,7 +26,7 @@ typedef struct PnvXScomInterface PnvXScomInterface;
 
 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
 #define PNV_XSCOM_INTERFACE(obj) \
-    INTERFACE_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
+    OBJECT_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
 typedef struct PnvXScomInterfaceClass PnvXScomInterfaceClass;
 DECLARE_CLASS_CHECKERS(PnvXScomInterfaceClass, PNV_XSCOM_INTERFACE,
                        TYPE_PNV_XSCOM_INTERFACE)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..c2f8665a51 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -35,7 +35,7 @@ typedef struct SpaprInterruptController SpaprInterruptController;
 
 #define TYPE_SPAPR_INTC "spapr-interrupt-controller"
 #define SPAPR_INTC(obj)                                     \
-    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
+    OBJECT_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
 typedef struct SpaprInterruptControllerClass SpaprInterruptControllerClass;
 DECLARE_CLASS_CHECKERS(SpaprInterruptControllerClass, SPAPR_INTC,
                        TYPE_SPAPR_INTC)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index c5a3cdcadc..884dc5ae28 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -138,7 +138,7 @@ struct ICSIRQState {
 
 #define TYPE_XICS_FABRIC "xics-fabric"
 #define XICS_FABRIC(obj)                                     \
-    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
+    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
 typedef struct XICSFabricClass XICSFabricClass;
 DECLARE_CLASS_CHECKERS(XICSFabricClass, XICS_FABRIC,
                        TYPE_XICS_FABRIC)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 482fafccfd..fba72e0304 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -153,7 +153,7 @@ typedef struct XiveNotifier XiveNotifier;
 
 #define TYPE_XIVE_NOTIFIER "xive-notifier"
 #define XIVE_NOTIFIER(obj)                                     \
-    INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+    OBJECT_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
 typedef struct XiveNotifierClass XiveNotifierClass;
 DECLARE_CLASS_CHECKERS(XiveNotifierClass, XIVE_NOTIFIER,
                        TYPE_XIVE_NOTIFIER)
@@ -390,7 +390,7 @@ typedef struct XiveTCTXMatch {
 
 #define TYPE_XIVE_PRESENTER "xive-presenter"
 #define XIVE_PRESENTER(obj)                                     \
-    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
+    OBJECT_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
 typedef struct XivePresenterClass XivePresenterClass;
 DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
                        TYPE_XIVE_PRESENTER)
@@ -415,7 +415,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 
 #define TYPE_XIVE_FABRIC "xive-fabric"
 #define XIVE_FABRIC(obj)                                     \
-    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+    OBJECT_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
 typedef struct XiveFabricClass XiveFabricClass;
 DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
                        TYPE_XIVE_FABRIC)
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
index e77e43a170..3f46986550 100644
--- a/include/hw/rdma/rdma.h
+++ b/include/hw/rdma/rdma.h
@@ -23,7 +23,7 @@ typedef struct RdmaProviderClass RdmaProviderClass;
 DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,
                        INTERFACE_RDMA_PROVIDER)
 #define RDMA_PROVIDER(obj) \
-    INTERFACE_CHECK(RdmaProvider, (obj), \
+    OBJECT_CHECK(RdmaProvider, (obj), \
                     INTERFACE_RDMA_PROVIDER)
 
 typedef struct RdmaProvider RdmaProvider;
diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 04abedf3b2..7e3b077741 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -35,7 +35,7 @@ typedef struct NvramClass NvramClass;
 DECLARE_CLASS_CHECKERS(NvramClass, NVRAM,
                        TYPE_NVRAM)
 #define NVRAM(obj) \
-    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
+    OBJECT_CHECK(Nvram, (obj), TYPE_NVRAM)
 
 typedef struct Nvram Nvram;
 
diff --git a/include/hw/stream.h b/include/hw/stream.h
index e39d5a5b55..afa6679c64 100644
--- a/include/hw/stream.h
+++ b/include/hw/stream.h
@@ -10,7 +10,7 @@ typedef struct StreamSlaveClass StreamSlaveClass;
 DECLARE_CLASS_CHECKERS(StreamSlaveClass, STREAM_SLAVE,
                        TYPE_STREAM_SLAVE)
 #define STREAM_SLAVE(obj) \
-     INTERFACE_CHECK(StreamSlave, (obj), TYPE_STREAM_SLAVE)
+     OBJECT_CHECK(StreamSlave, (obj), TYPE_STREAM_SLAVE)
 
 typedef struct StreamSlave StreamSlave;
 
diff --git a/include/hw/vmstate-if.h b/include/hw/vmstate-if.h
index 52df571d17..99bb1de7c2 100644
--- a/include/hw/vmstate-if.h
+++ b/include/hw/vmstate-if.h
@@ -17,7 +17,7 @@ typedef struct VMStateIfClass VMStateIfClass;
 DECLARE_CLASS_CHECKERS(VMStateIfClass, VMSTATE_IF,
                        TYPE_VMSTATE_IF)
 #define VMSTATE_IF(obj)                             \
-    INTERFACE_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
+    OBJECT_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
 
 typedef struct VMStateIf VMStateIf;
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 6c0d424b51..c0c692f761 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -920,18 +920,6 @@ struct InterfaceClass
 #define INTERFACE_CLASS(klass) \
     OBJECT_CLASS_CHECK(InterfaceClass, klass, TYPE_INTERFACE)
 
-/**
- * INTERFACE_CHECK:
- * @interface: the type to return
- * @obj: the object to convert to an interface
- * @name: the interface type name
- *
- * Returns: @obj casted to @interface if cast is valid, otherwise raise error.
- */
-#define INTERFACE_CHECK(interface, obj, name) \
-    ((interface *)object_dynamic_cast_assert(OBJECT((obj)), (name), \
-                                             __FILE__, __LINE__, __func__))
-
 /**
  * object_new_with_class:
  * @klass: The class to instantiate.
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index f118fb516b..a6626e0ed6 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -10,7 +10,7 @@ typedef struct UserCreatableClass UserCreatableClass;
 DECLARE_CLASS_CHECKERS(UserCreatableClass, USER_CREATABLE,
                        TYPE_USER_CREATABLE)
 #define USER_CREATABLE(obj) \
-     INTERFACE_CHECK(UserCreatable, (obj), \
+     OBJECT_CHECK(UserCreatable, (obj), \
                      TYPE_USER_CREATABLE)
 
 typedef struct UserCreatable UserCreatable;
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 1a85564e47..102217c348 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -30,7 +30,7 @@ typedef struct TPMIfClass TPMIfClass;
 DECLARE_CLASS_CHECKERS(TPMIfClass, TPM_IF,
                        TYPE_TPM_IF)
 #define TPM_IF(obj)                             \
-    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
+    OBJECT_CHECK(TPMIf, (obj), TYPE_TPM_IF)
 
 typedef struct TPMIf TPMIf;
 
diff --git a/target/arm/idau.h b/target/arm/idau.h
index 0ef5251971..6b28d26da9 100644
--- a/target/arm/idau.h
+++ b/target/arm/idau.h
@@ -32,7 +32,7 @@
 
 #define TYPE_IDAU_INTERFACE "idau-interface"
 #define IDAU_INTERFACE(obj) \
-    INTERFACE_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
+    OBJECT_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
 typedef struct IDAUInterfaceClass IDAUInterfaceClass;
 DECLARE_CLASS_CHECKERS(IDAUInterfaceClass, IDAU_INTERFACE,
                        TYPE_IDAU_INTERFACE)
diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
index c99be97ed8..53bdcb8878 100644
--- a/tests/check-qom-interface.c
+++ b/tests/check-qom-interface.c
@@ -20,7 +20,7 @@ typedef struct TestIfClass TestIfClass;
 DECLARE_CLASS_CHECKERS(TestIfClass, TEST_IF,
                        TYPE_TEST_IF)
 #define TEST_IF(obj) \
-     INTERFACE_CHECK(TestIf, (obj), TYPE_TEST_IF)
+     OBJECT_CHECK(TestIf, (obj), TYPE_TEST_IF)
 
 typedef struct TestIf TestIf;
 
-- 
2.26.2


