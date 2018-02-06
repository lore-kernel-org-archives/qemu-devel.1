Received: from eggs.gnu.org ([2001:4830:134:3::10]:43713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ib-00058i-SX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iX-0007qt-O6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iX-0007qQ-Fy
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JF246115366
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:44 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fygkucw23-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:44 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:43 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:35 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-15-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 14/54] vhost: remove assertion to prevent crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Jay Zhou <jianjay.zhou@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

QEMU will assert on vhost-user backed virtio device hotplug if QEMU is
using more RAM regions than VHOST_MEMORY_MAX_NREGIONS (for example if
it were started with a lot of DIMM devices).

Fix it by returning error instead of asserting and let callers of
vhost_set_mem_table() handle error condition gracefully.

Cc: qemu-stable@nongnu.org
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit f4bf56fb78ed0e9f60fa1ed656c14ff4c494da5a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost-user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675ed98..850056298d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -317,11 +317,14 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                      &offset);
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
+            if (fd_num == VHOST_MEMORY_MAX_NREGIONS) {
+                error_report("Failed preparing vhost-user memory table msg");
+                return -1;
+            }
             msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
             msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
             msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset = offset;
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             fds[fd_num++] = fd;
         }
     }
-- 
2.11.0
