Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280CFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E2B20809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="giJ/WJjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E2B20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzy5-0008VZ-4D
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzUO-0002Wp-0q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:12:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzUK-0000Or-TJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:12:31 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f96a0f60000>; Mon, 26 Oct 2020 03:12:06 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 10:12:18 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 10:12:10 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v29 16/17] vfio: Make vfio-pci device migration capable
Date: Mon, 26 Oct 2020 15:06:26 +0530
Message-ID: <1603704987-20977-17-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603707126; bh=nCYpwJQEjO7H8gbweFgxqcZaCOvpoYqsMgrm+Dahf8U=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=giJ/WJjwj0hrFx02XRhxxw0avwbY9oqqMxrFRJOzf0bIQlBuulG4GKdBE06Z7/3Ew
 N8Pk1uTlFYjQKVIe87i4nBHmEBEJdaQECnQVgUuWL99IDDLnU0LAH0tcgIA7BHoc7W
 XNrDI9hwOk8LF9q8/dW3BGyVddWedoPfIpMYFj8xj3nkF8er2ZrIiwMuBngwWWp/i1
 Y++ettSdf/ubuX/J7q7RwJTovM15bdV9J+dh7p6ZPhaqLYCDbgH4PSvgid7CmX+Hf3
 LI1HX/U/QfKVc5/0ORQIOii7mDFFOEfNMLCS6ww98lvAfpDf8yBGLzrZDkoaCQQSK3
 Xh4SZhN58ay9g==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 06:10:16
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the device is not a failover primary device, call
vfio_migration_probe() and vfio_migration_finalize() to enable
migration support for those devices that support it respectively to
tear it down again.
Removed migration blocker from VFIO PCI device specific structure and use
migration blocker from generic structure of  VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/pci.c | 28 ++++++++--------------------
 hw/vfio/pci.h |  1 -
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e27c88be6d85..58c0ce8971e3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2791,17 +2791,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
-    if (!pdev->failover_pair_id) {
-        error_setg(&vdev->migration_blocker,
-                "VFIO device doesn't support migration");
-        ret = migrate_add_blocker(vdev->migration_blocker, errp);
-        if (ret) {
-            error_free(vdev->migration_blocker);
-            vdev->migration_blocker = NULL;
-            return;
-        }
-    }
-
     vdev->vbasedev.name = g_path_get_basename(vdev->vbasedev.sysfsdev);
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
@@ -3069,6 +3058,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (!pdev->failover_pair_id) {
+        ret = vfio_migration_probe(&vdev->vbasedev, errp);
+        if (ret) {
+            error_report("%s: Migration disabled", vdev->vbasedev.name);
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3083,11 +3079,6 @@ out_teardown:
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
@@ -3099,10 +3090,6 @@ static void vfio_instance_finalize(Object *obj)
     vfio_bars_finalize(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
-    if (vdev->migration_blocker) {
-        migrate_del_blocker(vdev->migration_blocker);
-        error_free(vdev->migration_blocker);
-    }
     /*
      * XXX Leaking igd_opregion is not an oversight, we can't remove the
      * fw_cfg entry therefore leaking this allocation seems like the safest
@@ -3130,6 +3117,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     }
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
+    vfio_migration_finalize(&vdev->vbasedev);
 }
 
 static void vfio_pci_reset(DeviceState *dev)
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bce71a9ac93f..1574ef983f8f 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -172,7 +172,6 @@ struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
-    Error *migration_blocker;
     Notifier irqchip_change_notifier;
 };
 
-- 
2.7.0


