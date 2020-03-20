Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8DC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F02B2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5bPEwS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLDd-0000OP-9T
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFL3g-0001Pq-1K
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFL3e-0000ND-Fn
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFL3e-0000Mf-Bs
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10d0S1knWvaB7RR5Q5lIcqZkHnGR/yx7K2EPlbxhGxo=;
 b=L5bPEwS8DOmEKgp976OArJ1HNPhLTbFR6scAsqTmtPIsi+EOfEDm3ZfPZccjBOVOKaInsL
 Z+ZAE7+zCPmrjImCFlMTK9yelRHE7lKSsxe5LedhaOqW2Oqjovd2LqflMWj3RmwDsEJgRQ
 syYEzFQlq/m3Ol6yDnE/vkUnrGIHEcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-ZnlyhPPlN1CUJC3yfpDnDA-1; Fri, 20 Mar 2020 13:03:38 -0400
X-MC-Unique: ZnlyhPPlN1CUJC3yfpDnDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F36710CE786;
 Fri, 20 Mar 2020 17:03:36 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E693616D22;
 Fri, 20 Mar 2020 17:03:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 22/24] hw/arm/smmuv3: Pass stage 1 configurations to the host
Date: Fri, 20 Mar 2020 17:58:38 +0100
Message-Id: <20200320165840.30057-23-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case PASID PciOps are set for the device we call
the set_pasid_table() callback on each STE update.

This allows to pass the guest stage 1 configuration
to the host and apply it at physical level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4 -> v5:
- Use PciOps instead of config notifiers

v3 -> v4:
- fix compile issue with mingw

v2 -> v3:
- adapt to pasid_cfg field changes. Use local variable
- add trace event
- set version fields
- use CONFIG_PASID

v1 -> v2:
- do not notify anymore on CD change. Anyway the smmuv3 linux
  driver is not sending any CD invalidation commands. If we were
  to propagate CD invalidation commands, we would use the
  CACHE_INVALIDATE VFIO ioctl.
- notify a precise config flags to prepare for addition of new
  flags
---
 hw/arm/smmuv3.c     | 77 +++++++++++++++++++++++++++++++++++----------
 hw/arm/trace-events |  1 +
 2 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index edd76bce4c..7a805030e2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -16,6 +16,10 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+#ifdef __linux__
+#include "linux/iommu.h"
+#endif
+
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
@@ -861,6 +865,60 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, in=
t asid,
     }
 }
=20
+static void smmuv3_notify_config_change(SMMUState *bs, uint32_t sid)
+{
+#ifdef __linux__
+    IOMMUMemoryRegion *mr =3D smmu_iommu_mr(bs, sid);
+    SMMUEventInfo event =3D {.type =3D SMMU_EVT_NONE, .sid =3D sid,
+                           .inval_ste_allowed =3D true};
+    IOMMUConfig iommu_config;
+    SMMUTransCfg *cfg;
+    SMMUDevice *sdev;
+
+    if (!mr) {
+        return;
+    }
+
+    sdev =3D container_of(mr, SMMUDevice, iommu);
+
+    /* flush QEMU config cache */
+    smmuv3_flush_config(sdev);
+
+    if (!pci_device_is_pasid_ops_set(sdev->bus, sdev->devfn)) {
+        return;
+    }
+
+    cfg =3D smmuv3_get_config(sdev, &event);
+
+    if (!cfg) {
+        return;
+    }
+
+    iommu_config.pasid_cfg.version =3D PASID_TABLE_CFG_VERSION_1;
+    iommu_config.pasid_cfg.format =3D IOMMU_PASID_FORMAT_SMMUV3;
+    iommu_config.pasid_cfg.base_ptr =3D cfg->s1ctxptr;
+    iommu_config.pasid_cfg.pasid_bits =3D 0;
+    iommu_config.pasid_cfg.smmuv3.version =3D PASID_TABLE_SMMUV3_CFG_VERSI=
ON_1;
+
+    if (cfg->disabled || cfg->bypassed) {
+        iommu_config.pasid_cfg.config =3D IOMMU_PASID_CONFIG_BYPASS;
+    } else if (cfg->aborted) {
+        iommu_config.pasid_cfg.config =3D IOMMU_PASID_CONFIG_ABORT;
+    } else {
+        iommu_config.pasid_cfg.config =3D IOMMU_PASID_CONFIG_TRANSLATE;
+    }
+
+    trace_smmuv3_notify_config_change(mr->parent_obj.name,
+                                      iommu_config.pasid_cfg.config,
+                                      iommu_config.pasid_cfg.base_ptr);
+
+    if (pci_device_set_pasid_table(sdev->bus, sdev->devfn, &iommu_config))=
 {
+        error_report("Failed to pass PASID table to host for iommu mr %s (=
%m)",
+                     mr->parent_obj.name);
+    }
+#endif
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs =3D ARM_SMMU(s);
@@ -911,22 +969,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_STE:
         {
             uint32_t sid =3D CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr =3D smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
=20
             if (CMD_SSEC(&cmd)) {
                 cmd_error =3D SMMU_CERROR_ILL;
                 break;
             }
=20
-            if (!mr) {
-                break;
-            }
-
             trace_smmuv3_cmdq_cfgi_ste(sid);
-            sdev =3D container_of(mr, SMMUDevice, iommu);
-            smmuv3_flush_config(sdev);
-
+            smmuv3_notify_config_change(bs, sid);
             break;
         }
         case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
@@ -943,14 +993,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_cfgi_ste_range(start, end);
=20
             for (i =3D start; i <=3D end; i++) {
-                IOMMUMemoryRegion *mr =3D smmu_iommu_mr(bs, i);
-                SMMUDevice *sdev;
-
-                if (!mr) {
-                    continue;
-                }
-                sdev =3D container_of(mr, SMMUDevice, iommu);
-                smmuv3_flush_config(sdev);
+                smmuv3_notify_config_change(bs, i);
             }
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3809005cba..741e645ae2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -52,4 +52,5 @@ smmuv3_config_cache_inv(uint32_t sid) "Config cache INV f=
or sid %d"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu=
 mr=3D%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu=
 mr=3D%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova) =
"iommu mr=3D%s asid=3D%d iova=3D0x%"PRIx64
+smmuv3_notify_config_change(const char *name, uint8_t config, uint64_t s1c=
txptr) "iommu mr=3D%s config=3D%d s1ctxptr=3D0x%"PRIx64
=20
--=20
2.20.1


