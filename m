Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78714C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D982067C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4r7v2My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D982067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCr7K-0004Gp-DT
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr3R-0006Z6-0C
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:09:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr3K-0000GJ-BJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598908161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ojy6MWy/DzAyErvgCmn51pVG+i8cRZzkqltq6E54Yos=;
 b=c4r7v2MyyGJlzc2D289Py0hYSliwPo9cnXlFRphbtM2czkPoSjCW1K+PwwKv6uJyz2rYAq
 rzH0aH0m0eYQz/3VHira7hAKQGQBkNcCb9iDAi03LWrL7+lkkZLtzCyH2EBvDKkJfQ6Mc6
 +5oXAPZ4Qpvg416+5we5KteUXI42giw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-72hnS22zNrmWSUNO5L5__g-1; Mon, 31 Aug 2020 17:09:19 -0400
X-MC-Unique: 72hnS22zNrmWSUNO5L5__g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D7141005E5B;
 Mon, 31 Aug 2020 21:09:17 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C11D5D9D3;
 Mon, 31 Aug 2020 21:09:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/18] [automated] Use DECLARE_*CHECKER* macros (pass 2)
Date: Mon, 31 Aug 2020 17:07:34 -0400
Message-Id: <20200831210740.126168-13-ehabkost@redhat.com>
In-Reply-To: <20200831210740.126168-1-ehabkost@redhat.com>
References: <20200831210740.126168-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 $ ./scripts/codeconverter/converter.py -i \
   --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v3 -> v4: none

Changes series v2 -> v3: this is a new patch added in series v3

The script was re-run after rebase and after additional patches
were added to this series.

This is being submitted as a separate patch to make review
easier, but it can be squashed into the previous patch once it
gets reviewed.

---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-s390x@nongnu.org
---
 include/hw/block/swim.h            |  3 ++-
 include/hw/display/macfb.h         |  8 ++-----
 include/hw/i386/x86-iommu.h        |  8 ++-----
 include/hw/misc/imx_ccm.h          |  8 ++-----
 include/hw/misc/mos6522.h          |  7 ++----
 include/hw/ppc/xive.h              | 36 ++++++++++++------------------
 include/hw/rdma/rdma.h             |  6 +----
 include/hw/s390x/s390-virtio-ccw.h |  6 ++---
 migration/migration.h              |  8 ++-----
 target/arm/cpu-qom.h               |  6 ++---
 target/rx/cpu-qom.h                |  8 ++-----
 hw/arm/integratorcp.c              | 12 +++++-----
 hw/arm/versatilepb.c               |  4 ++--
 hw/sd/pl181.c                      |  3 ++-
 14 files changed, 43 insertions(+), 80 deletions(-)

diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 29fccb41f1..8287da7c30 100644
--- a/include/hw/block/swim.h
+++ b/include/hw/block/swim.h
@@ -71,7 +71,8 @@ struct SWIMCtrl {
 
 #define TYPE_SWIM "swim"
 typedef struct Swim Swim;
-#define SWIM(obj) OBJECT_CHECK(Swim, (obj), TYPE_SWIM)
+DECLARE_INSTANCE_CHECKER(Swim, SWIM,
+                         TYPE_SWIM)
 
 struct Swim {
     SysBusDevice parent_obj;
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index f317fe93d9..0960480b75 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -45,10 +45,8 @@ struct MacfbSysBusState {
 #define TYPE_NUBUS_MACFB "nubus-macfb"
 typedef struct MacfbNubusDeviceClass MacfbNubusDeviceClass;
 typedef struct MacfbNubusState MacfbNubusState;
-#define NUBUS_MACFB_CLASS(class) \
-    OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
-#define NUBUS_MACFB_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
+DECLARE_OBJ_CHECKERS(MacfbNubusState, MacfbNubusDeviceClass,
+                     NUBUS_MACFB, TYPE_NUBUS_MACFB)
 
 struct MacfbNubusDeviceClass {
     DeviceClass parent_class;
@@ -56,8 +54,6 @@ struct MacfbNubusDeviceClass {
     DeviceRealize parent_realize;
 };
 
-#define NUBUS_MACFB(obj) \
-    OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
 
 struct MacfbNubusState {
     NubusDevice busdev;
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index dae2eab800..bbfaf44e79 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -28,12 +28,8 @@
 #define  TYPE_X86_IOMMU_DEVICE  ("x86-iommu")
 typedef struct X86IOMMUClass X86IOMMUClass;
 typedef struct X86IOMMUState X86IOMMUState;
-#define  X86_IOMMU_DEVICE(obj) \
-    OBJECT_CHECK(X86IOMMUState, (obj), TYPE_X86_IOMMU_DEVICE)
-#define  X86_IOMMU_DEVICE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(X86IOMMUClass, (klass), TYPE_X86_IOMMU_DEVICE)
-#define  X86_IOMMU_DEVICE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(X86IOMMUClass, obj, TYPE_X86_IOMMU_DEVICE)
+DECLARE_OBJ_CHECKERS(X86IOMMUState, X86IOMMUClass,
+                     X86_IOMMU_DEVICE, TYPE_X86_IOMMU_DEVICE)
 
 #define X86_IOMMU_SID_INVALID             (0xffff)
 
diff --git a/include/hw/misc/imx_ccm.h b/include/hw/misc/imx_ccm.h
index 174248e5df..e9d82a2a50 100644
--- a/include/hw/misc/imx_ccm.h
+++ b/include/hw/misc/imx_ccm.h
@@ -30,12 +30,8 @@
 #define TYPE_IMX_CCM "imx.ccm"
 typedef struct IMXCCMClass IMXCCMClass;
 typedef struct IMXCCMState IMXCCMState;
-#define IMX_CCM(obj) \
-     OBJECT_CHECK(IMXCCMState, (obj), TYPE_IMX_CCM)
-#define IMX_CCM_CLASS(klass) \
-     OBJECT_CLASS_CHECK(IMXCCMClass, (klass), TYPE_IMX_CCM)
-#define IMX_CCM_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(IMXCCMClass, (obj), TYPE_IMX_CCM)
+DECLARE_OBJ_CHECKERS(IMXCCMState, IMXCCMClass,
+                     IMX_CCM, TYPE_IMX_CCM)
 
 struct IMXCCMState {
     /* <private> */
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index b099814879..f73271ba67 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -126,7 +126,8 @@ typedef struct MOS6522State MOS6522State;
 
 #define TYPE_MOS6522 "mos6522"
 typedef struct MOS6522DeviceClass MOS6522DeviceClass;
-#define MOS6522(obj) OBJECT_CHECK(MOS6522State, (obj), TYPE_MOS6522)
+DECLARE_OBJ_CHECKERS(MOS6522State, MOS6522DeviceClass,
+                     MOS6522, TYPE_MOS6522)
 
 struct MOS6522DeviceClass {
     DeviceClass parent_class;
@@ -143,10 +144,6 @@ struct MOS6522DeviceClass {
     uint64_t (*get_timer2_load_time)(MOS6522State *dev, MOS6522Timer *ti);
 };
 
-#define MOS6522_CLASS(cls) \
-    OBJECT_CLASS_CHECK(MOS6522DeviceClass, (cls), TYPE_MOS6522)
-#define MOS6522_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(MOS6522DeviceClass, (obj), TYPE_MOS6522)
 
 extern const VMStateDescription vmstate_mos6522;
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 8ef9af1969..48595ab641 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -155,10 +155,8 @@ typedef struct XiveNotifier XiveNotifier;
 #define XIVE_NOTIFIER(obj)                                     \
     INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
 typedef struct XiveNotifierClass XiveNotifierClass;
-#define XIVE_NOTIFIER_CLASS(klass)                                     \
-    OBJECT_CLASS_CHECK(XiveNotifierClass, (klass), TYPE_XIVE_NOTIFIER)
-#define XIVE_NOTIFIER_GET_CLASS(obj)                                   \
-    OBJECT_GET_CLASS(XiveNotifierClass, (obj), TYPE_XIVE_NOTIFIER)
+DECLARE_CLASS_CHECKERS(XiveNotifierClass, XIVE_NOTIFIER,
+                       TYPE_XIVE_NOTIFIER)
 
 struct XiveNotifierClass {
     InterfaceClass parent;
@@ -171,7 +169,8 @@ struct XiveNotifierClass {
 
 #define TYPE_XIVE_SOURCE "xive-source"
 typedef struct XiveSource XiveSource;
-#define XIVE_SOURCE(obj) OBJECT_CHECK(XiveSource, (obj), TYPE_XIVE_SOURCE)
+DECLARE_INSTANCE_CHECKER(XiveSource, XIVE_SOURCE,
+                         TYPE_XIVE_SOURCE)
 
 /*
  * XIVE Interrupt Source characteristics, which define how the ESB are
@@ -308,7 +307,8 @@ void xive_source_set_irq(void *opaque, int srcno, int val);
 
 #define TYPE_XIVE_TCTX "xive-tctx"
 typedef struct XiveTCTX XiveTCTX;
-#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
+DECLARE_INSTANCE_CHECKER(XiveTCTX, XIVE_TCTX,
+                         TYPE_XIVE_TCTX)
 
 /*
  * XIVE Thread interrupt Management register rings :
@@ -349,12 +349,8 @@ typedef struct XiveRouter XiveRouter;
 
 #define TYPE_XIVE_ROUTER "xive-router"
 typedef struct XiveRouterClass XiveRouterClass;
-#define XIVE_ROUTER(obj)                                \
-    OBJECT_CHECK(XiveRouter, (obj), TYPE_XIVE_ROUTER)
-#define XIVE_ROUTER_CLASS(klass)                                        \
-    OBJECT_CLASS_CHECK(XiveRouterClass, (klass), TYPE_XIVE_ROUTER)
-#define XIVE_ROUTER_GET_CLASS(obj)                              \
-    OBJECT_GET_CLASS(XiveRouterClass, (obj), TYPE_XIVE_ROUTER)
+DECLARE_OBJ_CHECKERS(XiveRouter, XiveRouterClass,
+                     XIVE_ROUTER, TYPE_XIVE_ROUTER)
 
 struct XiveRouterClass {
     SysBusDeviceClass parent;
@@ -398,10 +394,8 @@ typedef struct XiveTCTXMatch {
 #define XIVE_PRESENTER(obj)                                     \
     INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
 typedef struct XivePresenterClass XivePresenterClass;
-#define XIVE_PRESENTER_CLASS(klass)                                     \
-    OBJECT_CLASS_CHECK(XivePresenterClass, (klass), TYPE_XIVE_PRESENTER)
-#define XIVE_PRESENTER_GET_CLASS(obj)                                   \
-    OBJECT_GET_CLASS(XivePresenterClass, (obj), TYPE_XIVE_PRESENTER)
+DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
+                       TYPE_XIVE_PRESENTER)
 
 struct XivePresenterClass {
     InterfaceClass parent;
@@ -425,10 +419,8 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 #define XIVE_FABRIC(obj)                                     \
     INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
 typedef struct XiveFabricClass XiveFabricClass;
-#define XIVE_FABRIC_CLASS(klass)                                     \
-    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
-#define XIVE_FABRIC_GET_CLASS(obj)                                   \
-    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
+DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
+                       TYPE_XIVE_FABRIC)
 
 struct XiveFabricClass {
     InterfaceClass parent;
@@ -444,8 +436,8 @@ struct XiveFabricClass {
 
 #define TYPE_XIVE_END_SOURCE "xive-end-source"
 typedef struct XiveENDSource XiveENDSource;
-#define XIVE_END_SOURCE(obj) \
-    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
+DECLARE_INSTANCE_CHECKER(XiveENDSource, XIVE_END_SOURCE,
+                         TYPE_XIVE_END_SOURCE)
 
 struct XiveENDSource {
     DeviceState parent;
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
index aef82e58db..e77e43a170 100644
--- a/include/hw/rdma/rdma.h
+++ b/include/hw/rdma/rdma.h
@@ -20,12 +20,8 @@
 #define INTERFACE_RDMA_PROVIDER "rdma"
 
 typedef struct RdmaProviderClass RdmaProviderClass;
-#define RDMA_PROVIDER_CLASS(klass) \
-    OBJECT_CLASS_CHECK(RdmaProviderClass, (klass), \
+DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,
                        INTERFACE_RDMA_PROVIDER)
-#define RDMA_PROVIDER_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(RdmaProviderClass, (obj), \
-                     INTERFACE_RDMA_PROVIDER)
 #define RDMA_PROVIDER(obj) \
     INTERFACE_CHECK(RdmaProvider, (obj), \
                     INTERFACE_RDMA_PROVIDER)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index f20c503b19..54d14da0a6 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -18,11 +18,9 @@
 
 typedef struct S390CcwMachineClass S390CcwMachineClass;
 typedef struct S390CcwMachineState S390CcwMachineState;
-#define S390_CCW_MACHINE(obj) \
-    OBJECT_CHECK(S390CcwMachineState, (obj), TYPE_S390_CCW_MACHINE)
+DECLARE_OBJ_CHECKERS(S390CcwMachineState, S390CcwMachineClass,
+                     S390_CCW_MACHINE, TYPE_S390_CCW_MACHINE)
 
-#define S390_CCW_MACHINE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
 
 struct S390CcwMachineState {
     /*< private >*/
diff --git a/migration/migration.h b/migration/migration.h
index 4103e549bb..bdc7450da3 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -116,12 +116,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
 #define TYPE_MIGRATION "migration"
 
 typedef struct MigrationClass MigrationClass;
-#define MIGRATION_OBJ_CLASS(klass) \
-    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
-#define MIGRATION_OBJ(obj) \
-    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
-#define MIGRATION_OBJ_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
+DECLARE_OBJ_CHECKERS(MigrationState, MigrationClass,
+                     MIGRATION_OBJ, TYPE_MIGRATION)
 
 struct MigrationClass {
     /*< private >*/
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index f12ca3a44c..92d58f84fe 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -63,10 +63,8 @@ struct ARMCPUClass {
 
 #define TYPE_AARCH64_CPU "aarch64-cpu"
 typedef struct AArch64CPUClass AArch64CPUClass;
-#define AARCH64_CPU_CLASS(klass) \
-    OBJECT_CLASS_CHECK(AArch64CPUClass, (klass), TYPE_AARCH64_CPU)
-#define AARCH64_CPU_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(AArch64CPUClass, (obj), TYPE_AARCH64_CPU)
+DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
+                       TYPE_AARCH64_CPU)
 
 struct AArch64CPUClass {
     /*< private >*/
diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index dd96469e04..05f5773ab1 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -28,12 +28,8 @@
 
 typedef struct RXCPU RXCPU;
 typedef struct RXCPUClass RXCPUClass;
-#define RX_CPU_CLASS(klass) \
-    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
-#define RX_CPU(obj) \
-    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
-#define RX_CPU_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
+DECLARE_OBJ_CHECKERS(RXCPU, RXCPUClass,
+                     RX_CPU, TYPE_RX_CPU)
 
 /*
  * RXCPUClass:
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 75e608e68e..19989b61b9 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -30,8 +30,8 @@
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
 typedef struct IntegratorCMState IntegratorCMState;
-#define INTEGRATOR_CM(obj) \
-    OBJECT_CHECK(IntegratorCMState, (obj), TYPE_INTEGRATOR_CM)
+DECLARE_INSTANCE_CHECKER(IntegratorCMState, INTEGRATOR_CM,
+                         TYPE_INTEGRATOR_CM)
 
 struct IntegratorCMState {
     /*< private >*/
@@ -329,8 +329,8 @@ static void integratorcm_realize(DeviceState *d, Error **errp)
 
 #define TYPE_INTEGRATOR_PIC "integrator_pic"
 typedef struct icp_pic_state icp_pic_state;
-#define INTEGRATOR_PIC(obj) \
-   OBJECT_CHECK(icp_pic_state, (obj), TYPE_INTEGRATOR_PIC)
+DECLARE_INSTANCE_CHECKER(icp_pic_state, INTEGRATOR_PIC,
+                         TYPE_INTEGRATOR_PIC)
 
 struct icp_pic_state {
     /*< private >*/
@@ -469,8 +469,8 @@ static void icp_pic_init(Object *obj)
 
 #define TYPE_ICP_CONTROL_REGS "icp-ctrl-regs"
 typedef struct ICPCtrlRegsState ICPCtrlRegsState;
-#define ICP_CONTROL_REGS(obj) \
-    OBJECT_CHECK(ICPCtrlRegsState, (obj), TYPE_ICP_CONTROL_REGS)
+DECLARE_INSTANCE_CHECKER(ICPCtrlRegsState, ICP_CONTROL_REGS,
+                         TYPE_ICP_CONTROL_REGS)
 
 struct ICPCtrlRegsState {
     /*< private >*/
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 0e2d74cef2..2ba69f24b7 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -36,8 +36,8 @@
 
 #define TYPE_VERSATILE_PB_SIC "versatilepb_sic"
 typedef struct vpb_sic_state vpb_sic_state;
-#define VERSATILE_PB_SIC(obj) \
-    OBJECT_CHECK(vpb_sic_state, (obj), TYPE_VERSATILE_PB_SIC)
+DECLARE_INSTANCE_CHECKER(vpb_sic_state, VERSATILE_PB_SIC,
+                         TYPE_VERSATILE_PB_SIC)
 
 struct vpb_sic_state {
     SysBusDevice parent_obj;
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index cb2ef0fb39..7829e933a5 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -24,7 +24,8 @@
 
 #define TYPE_PL181 "pl181"
 typedef struct PL181State PL181State;
-#define PL181(obj) OBJECT_CHECK(PL181State, (obj), TYPE_PL181)
+DECLARE_INSTANCE_CHECKER(PL181State, PL181,
+                         TYPE_PL181)
 
 #define TYPE_PL181_BUS "pl181-bus"
 
-- 
2.26.2


