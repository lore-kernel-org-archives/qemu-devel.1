Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6159CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4AC20734
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PfrpkyMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4AC20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkg4-0005yB-6S
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkXo-0007If-K1
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:56:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkXm-0000b8-MB
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:56:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eee78080000>; Sat, 20 Jun 2020 13:56:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sat, 20 Jun 2020 13:56:53 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sat, 20 Jun 2020 13:56:53 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 20:56:44 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 20 Jun 2020 20:56:37 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v25 16/17] vfio: Make vfio-pci device migration capable
Date: Sun, 21 Jun 2020 01:51:25 +0530
Message-ID: <1592684486-18511-17-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592686600; bh=4mBVs2u4Z55g8cokYzZt9bDlmCVwrsx11CQpSDb4qpY=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=PfrpkyMCFG94AO8Yfl8LEntBC2dZlrnmZS+wJ/APqAqPfyxXQ70eCJcuOYSyCxO8r
 U5FmsTqx5aBwLRf8Dr5muq6C5sm4dDf8Qf1duPT0BnFXqXFX5m3c0Xu0KFw5WPk3rP
 H3ZseMnAf9HZVY0oAe2t840gQ07uy0cPeeW05E28qkatygLENNuSaPA3LkqKGytAoy
 0/+HP97U9If2TbXYPvuajyP4wPQDMTj1SbvcWQRAPncXJlbA+HK1d2u0mLy02Ixw68
 /FMGMQtiG3Bs6AU7dtW2lJkjR9ncA9K89CY++KMEh/buS5nd4IO1yml6NZzs4N/7dn
 e+filzxBZjk7A==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 16:54:48
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/vfio/pci.c | 32 +++++++++++---------------------
 hw/vfio/pci.h |  1 -
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5ba340aee1d4..9dc2868993fb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2841,22 +2841,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
@@ -3120,6 +3109,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
@@ -3134,11 +3131,6 @@ out_teardown:
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
@@ -3150,10 +3142,7 @@ static void vfio_instance_finalize(Object *obj)
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
@@ -3181,6 +3170,7 @@ static void vfio_exitfn(PCIDevice *pdev)
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


