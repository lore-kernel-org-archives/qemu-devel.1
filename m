Received: from eggs.gnu.org ([2001:4830:134:3::10]:42385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZk-0001Rq-8A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZj-0005lL-Gj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1drTZj-0005ky-AZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F0C58AE7F
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 18:36:50 +0000 (UTC)
From: wexu@redhat.com
Date: Tue, 12 Sep 2017 02:56:32 +0800
Message-Id: <1505156192-18994-4-git-send-email-wexu@redhat.com>
In-Reply-To: <1505156192-18994-1-git-send-email-wexu@redhat.com>
References: <1505156192-18994-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [Patch 3/3] vfio: remove checking duplicated vfio
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, Wei Xu <wexu@redhat.com>

From: Wei Xu <wexu@redhat.com>

This has been done when introducing 'vfio_lookup_as()'
patch as a side work to reuse the loop.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/vfio/pci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 856cefd..d78f756 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2632,7 +2632,6 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
-    VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     char *tmp, group_path[PATH_MAX], *group_name;
     Error *err = NULL;
@@ -2697,14 +2696,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-        if (strcmp(vbasedev_iter->name, vdev->vbasedev.name) == 0) {
-            error_setg(errp, "device is already attached");
-            vfio_put_group(group);
-            goto error;
-        }
-    }
-
     ret = vfio_get_device(group, vdev->vbasedev.name, &vdev->vbasedev, errp);
     if (ret) {
         vfio_put_group(group);
-- 
1.8.3.1
