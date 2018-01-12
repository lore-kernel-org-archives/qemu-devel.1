Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZpPJ-000811-6I
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZpPG-0001OS-1j
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 21:49:25 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 12 Jan 2018 10:47:57 +0800
Message-ID: <d8d0fbbcfded0e374b6b05ee7d97d8d099b72727.1515724314.git.jianjay.zhou@huawei.com>
In-Reply-To: <cover.1515724314.git.jianjay.zhou@huawei.com>
References: <cover.1515724314.git.jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/3] vhost: remove assertion to prevent crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, jianjay.zhou@huawei.com, liuzhe13@huawei.com, qemu-stable@nongnu.org

QEMU will assert on vhost-user backed virtio device hotplug if QEMU is
using more RAM regions than VHOST_MEMORY_MAX_NREGIONS (for example if
it were started with a lot of DIMM devices).

Fix it by returning error instead of asserting and let callers of
vhost_set_mem_table() handle error condition gracefully.

Cc: qemu-stable@nongnu.org
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 hw/virtio/vhost-user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..8500562 100644
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
1.8.3.1
