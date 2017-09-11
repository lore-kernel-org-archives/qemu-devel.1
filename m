Received: from eggs.gnu.org ([2001:4830:134:3::10]:42354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZi-0001RQ-7U
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZh-0005kB-0w
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1drTZg-0005jo-QU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7DC2C07F67E
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 18:36:47 +0000 (UTC)
From: wexu@redhat.com
Date: Tue, 12 Sep 2017 02:56:31 +0800
Message-Id: <1505156192-18994-3-git-send-email-wexu@redhat.com>
In-Reply-To: <1505156192-18994-1-git-send-email-wexu@redhat.com>
References: <1505156192-18994-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel]  [Patch 2/3] vfio: invoke looking up address space.
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

Invoke looking up correct address space before getting an
IOMMU group.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/vfio/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 31e1edf..856cefd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2640,6 +2640,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     struct stat st;
     int groupid;
     int i, ret;
+    AddressSpace *as;
 
     if (!vdev->vbasedev.sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2686,7 +2687,12 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     trace_vfio_realize(vdev->vbasedev.name, groupid);
 
-    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
+    as = vfio_lookup_as(groupid, pdev, errp);
+    if (!as) {
+        goto error;
+    }
+
+    group = vfio_get_group(groupid, as, errp);
     if (!group) {
         goto error;
     }
-- 
1.8.3.1
