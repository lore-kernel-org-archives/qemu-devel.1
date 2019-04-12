Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E14C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3238C2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3238C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtGG-0005OQ-9r
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:18:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3k-0001Y4-Gu
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3h-0004H1-Hl
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt3a-0004DV-8G; Fri, 12 Apr 2019 06:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F9E17EBC4;
	Fri, 12 Apr 2019 10:05:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4D4C19C65;
	Fri, 12 Apr 2019 10:05:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:37 +0200
Message-Id: <20190412100354.6409-11-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 12 Apr 2019 10:05:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 10/27] memory: Add IOMMUConfigNotifier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100337.eY5vt_jUP2RBrZP-QKUILS-AP4Ltrvw8F1-LJDPHvP8@z>

With this patch, an IOMMUNotifier can now be either
an IOTLB notifier or a config notifier. A config notifier
is supposed to be called on guest translation config change.
This gives host a chance to update the physical IOMMU
configuration so that is consistent with the guest view.

The notifier is passed an IOMMUConfig. The first type of
configuration introduced here consists in the PASID
configuration.

We introduce the associated helpers, iommu_config_notifier_init,
memory_region_config_notify_iommu

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- use pasid_table config
- pass IOMMUNotifierFlag flags to iommu_config_notifier_init
  to prepare for other config flags
- Introduce IOMMUConfig
- s/IOMMU_NOTIFIER_S1_CFG/IOMMU_NOTIFIER_PASID_CFG
- remove unused IOMMUStage1ConfigType
---
 hw/vfio/common.c      | 15 ++++++++-----
 include/exec/memory.h | 52 ++++++++++++++++++++++++++++++++++++++++++-
 memory.c              | 25 +++++++++++++++++++++
 3 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a9004b6d20..0853c8c376 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -703,11 +703,16 @@ static void vfio_listener_region_del(MemoryListener=
 *listener,
         VFIOGuestIOMMU *giommu;
=20
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
-            if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr &&
-                is_iommu_iotlb_notifier(&giommu->n) &&
-                giommu->n.iotlb_notifier.start =3D=3D section->offset_wi=
thin_region) {
-                memory_region_unregister_iommu_notifier(section->mr,
-                                                        &giommu->n);
+            if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr) {
+                if (is_iommu_iotlb_notifier(&giommu->n) &&
+                    giommu->n.iotlb_notifier.start =3D=3D
+                        section->offset_within_region) {
+                    memory_region_unregister_iommu_notifier(section->mr,
+                                                            &giommu->n);
+                } else {
+                    memory_region_unregister_iommu_notifier(section->mr,
+                                                            &giommu->n);
+                }
                 QLIST_REMOVE(giommu, giommu_next);
                 g_free(giommu);
                 break;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3918352a17..f54052e9b3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -26,6 +26,9 @@
 #include "qom/object.h"
 #include "qemu/rcu.h"
 #include "hw/qdev-core.h"
+#ifdef CONFIG_LINUX
+#include <linux/iommu.h>
+#endif
=20
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
=20
@@ -74,6 +77,14 @@ struct IOMMUTLBEntry {
     IOMMUAccessFlags perm;
 };
=20
+typedef struct IOMMUConfig {
+    union {
+#ifdef __linux__
+        struct iommu_pasid_table_config pasid_cfg;
+#endif
+          };
+} IOMMUConfig;
+
 /*
  * Bitmap for different IOMMUNotifier capabilities. Each notifier can
  * register with one or multiple IOMMU Notifier capability bit(s).
@@ -84,13 +95,18 @@ typedef enum {
     IOMMU_NOTIFIER_IOTLB_UNMAP =3D 0x1,
     /* Notify entry changes (newly created entries) */
     IOMMU_NOTIFIER_IOTLB_MAP =3D 0x2,
+    /* Notify stage 1 config changes */
+    IOMMU_NOTIFIER_CONFIG_PASID =3D 0x4,
 } IOMMUNotifierFlag;
=20
 #define IOMMU_NOTIFIER_IOTLB_ALL (IOMMU_NOTIFIER_IOTLB_MAP | IOMMU_NOTIF=
IER_IOTLB_UNMAP)
+#define IOMMU_NOTIFIER_CONFIG_ALL (IOMMU_NOTIFIER_CONFIG_PASID)
=20
 struct IOMMUNotifier;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
                             IOMMUTLBEntry *data);
+typedef void (*IOMMUConfigNotify)(struct IOMMUNotifier *notifier,
+                                  IOMMUConfig *cfg);
=20
 typedef struct IOMMUIOLTBNotifier {
     IOMMUNotify notify;
@@ -99,10 +115,15 @@ typedef struct IOMMUIOLTBNotifier {
     hwaddr end;
 } IOMMUIOLTBNotifier;
=20
+typedef struct IOMMUConfigNotifier {
+    IOMMUConfigNotify notify;
+} IOMMUConfigNotifier;
+
 struct IOMMUNotifier {
     IOMMUNotifierFlag notifier_flags;
     union {
         IOMMUIOLTBNotifier iotlb_notifier;
+        IOMMUConfigNotifier config_notifier;
     };
     int iommu_idx;
     QLIST_ENTRY(IOMMUNotifier) node;
@@ -147,6 +168,16 @@ static inline void iommu_iotlb_notifier_init(IOMMUNo=
tifier *n, IOMMUNotify fn,
     n->iommu_idx =3D iommu_idx;
 }
=20
+static inline void iommu_config_notifier_init(IOMMUNotifier *n,
+                                              IOMMUConfigNotify fn,
+                                              IOMMUNotifierFlag flags,
+                                              int iommu_idx)
+{
+    n->notifier_flags =3D flags;
+    n->iommu_idx =3D iommu_idx;
+    n->config_notifier.notify =3D fn;
+}
+
 /*
  * Memory region callbacks
  */
@@ -647,6 +678,12 @@ static inline bool is_iommu_iotlb_notifier(IOMMUNoti=
fier *n)
 {
     return n->notifier_flags & IOMMU_NOTIFIER_IOTLB_ALL;
 }
+
+static inline bool is_iommu_config_notifier(IOMMUNotifier *n)
+{
+    return n->notifier_flags & IOMMU_NOTIFIER_CONFIG_ALL;
+}
+
 #ifdef CONFIG_POSIX
=20
 /**
@@ -1054,6 +1091,19 @@ void memory_region_iotlb_notify_iommu(IOMMUMemoryR=
egion *iommu_mr,
                                       int iommu_idx,
                                       IOMMUTLBEntry entry);
=20
+/**
+ * memory_region_config_notify_iommu: notify a change in a translation
+ * configuration structure.
+ * @iommu_mr: the memory region that was changed
+ * @iommu_idx: the IOMMU index for the translation table which has chang=
ed
+ * @flag: config change type
+ * @config: new guest config
+ */
+void memory_region_config_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                       int iommu_idx,
+                                       IOMMUNotifierFlag flag,
+                                       IOMMUConfig *config);
+
 /**
  * memory_region_iotlb_notify_one: notify a change in an IOMMU translati=
on
  *                                 entry to a single notifier
@@ -1071,7 +1121,7 @@ void memory_region_iotlb_notify_one(IOMMUNotifier *=
notifier,
=20
 /**
  * memory_region_register_iommu_notifier: register a notifier for change=
s to
- * IOMMU translation entries.
+ * IOMMU translation entries or translation config settings.
  *
  * @mr: the memory region to observe
  * @n: the IOMMUNotifier to be added; the notify callback receives a
diff --git a/memory.c b/memory.c
index bd9f425f0d..8cd3c65872 100644
--- a/memory.c
+++ b/memory.c
@@ -1934,6 +1934,13 @@ void memory_region_unregister_iommu_notifier(Memor=
yRegion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr);
 }
=20
+static void
+memory_region_config_notify_one(IOMMUNotifier *notifier,
+                                IOMMUConfig *cfg)
+{
+    notifier->config_notifier.notify(notifier, cfg);
+}
+
 void memory_region_iotlb_notify_one(IOMMUNotifier *notifier,
                                     IOMMUTLBEntry *entry)
 {
@@ -1976,6 +1983,24 @@ void memory_region_iotlb_notify_iommu(IOMMUMemoryR=
egion *iommu_mr,
     }
 }
=20
+void memory_region_config_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                       int iommu_idx,
+                                       IOMMUNotifierFlag flag,
+                                       IOMMUConfig *config)
+{
+    IOMMUNotifier *iommu_notifier;
+
+    assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
+
+    IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
+        if (iommu_notifier->iommu_idx =3D=3D iommu_idx &&
+            is_iommu_config_notifier(iommu_notifier) &&
+            iommu_notifier->notifier_flags =3D=3D flag) {
+            memory_region_config_notify_one(iommu_notifier, config);
+        }
+    }
+}
+
 int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
                                  enum IOMMUMemoryRegionAttr attr,
                                  void *data)
--=20
2.20.1


