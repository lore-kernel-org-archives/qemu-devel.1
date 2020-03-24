Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B6DC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E281F20735
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k4k8erAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E281F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGrU3-0003Pi-4R
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrLb-0008Rz-DF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrLa-00055W-4U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:44:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGrLZ-000559-Um
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:44:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a7f0f0000>; Tue, 24 Mar 2020 14:43:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 14:44:28 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 24 Mar 2020 14:44:28 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 21:44:28 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 24 Mar 2020 21:44:22 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v16 QEMU 16/16] vfio: Make vfio-pci device migration capable
Date: Wed, 25 Mar 2020 02:39:14 +0530
Message-ID: <1585084154-29461-17-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585086224; bh=hDf/HIPA6TG0mzp9mQMoERUyUraLSc/fd3dkuNF7XRs=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=k4k8erALNwHT0/c9Gyo0yfjgq2D2wQugQwuJhYxwD8QHojVp6qRuWJp4rgvBbmvMu
 8PW5BIXd4JUZsh3u+AAWnl9CYGvmHBBwABz3FKtKvqFguFiiAxrNXHRq4s8n0Eqmg5
 /nT5CYB1A44dCZFf5weop9hMXjt84X9dSReKtdBdHDxnDgJP+Q7ndKEgEnB1R4w6Ea
 mAjSGe1vsdBF8Spf68VqcfH3W65USrmLLCvIomUUkU2JtcdQOeomhXZ9uW5K69Vwz3
 zBRZnmajf+ME3l3T0LnN8d2sWGy6bEqpCE8mmmmjZjMCjyyHyACWhcYm/6MY5aqAix
 1nwv2s0G0BS9Q==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If device is not failover primary device call vfio_migration_probe()
and vfio_migration_finalize() functions for vfio-pci device to enable
migration for vfio PCI device which support migration.
Removed vfio_pci_vmstate structure.
Removed migration blocker from VFIO PCI device specific structure and use
migration blocker from generic structure of  VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c | 32 +++++++++++---------------------
 hw/vfio/pci.h |  1 -
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8deb11e87ef7..c70f153d431a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2916,22 +2916,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
-    if (!pdev->failover_pair_id) {
-        error_setg(&vdev->migration_blocker,
-                "VFIO device doesn't support migration");
-        ret = migrate_add_blocker(vdev->migration_blocker, &err);
-        if (ret) {
-            error_propagate(errp, err);
-            error_free(vdev->migration_blocker);
-            vdev->migration_blocker = NULL;
-            return;
-        }
-    }
-
     vdev->vbasedev.name = g_path_get_basename(vdev->vbasedev.sysfsdev);
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
     vdev->vbasedev.dev = DEVICE(vdev);
+    vdev->vbasedev.device_state = 0;
 
     tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
@@ -3195,6 +3184,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (!pdev->failover_pair_id) {
+        ret = vfio_migration_probe(&vdev->vbasedev, errp);
+        if (ret) {
+            error_report("%s: Failed to setup for migration",
+                         vdev->vbasedev.name);
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3209,11 +3206,6 @@ out_teardown:
     vfio_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-    if (vdev->migration_blocker) {
-        migrate_del_blocker(vdev->migration_blocker);
-        error_free(vdev->migration_blocker);
-        vdev->migration_blocker = NULL;
-    }
 }
 
 static void vfio_instance_finalize(Object *obj)
@@ -3225,10 +3217,7 @@ static void vfio_instance_finalize(Object *obj)
     vfio_bars_finalize(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
-    if (vdev->migration_blocker) {
-        migrate_del_blocker(vdev->migration_blocker);
-        error_free(vdev->migration_blocker);
-    }
+
     /*
      * XXX Leaking igd_opregion is not an oversight, we can't remove the
      * fw_cfg entry therefore leaking this allocation seems like the safest
@@ -3256,6 +3245,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     }
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
+    vfio_migration_finalize(&vdev->vbasedev);
 }
 
 static void vfio_pci_reset(DeviceState *dev)
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0da7a20a7ec2..b148c937ef72 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -168,7 +168,6 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
-    Error *migration_blocker;
     Notifier irqchip_change_notifier;
 } VFIOPCIDevice;
 
-- 
2.7.0


