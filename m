Received: from eggs.gnu.org ([2001:4830:134:3::10]:41738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gH13i-0003Qb-P5
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gH13i-0008M9-5M
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:29:54 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 28 Oct 2018 23:29:40 -0700
Message-Id: <1540794581-33578-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
References: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] nvme: don't unref ctrl_mem when device
 unrealized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Currently, when hotplug/unhotplug nvme device, it will cause an
assert in object.c. Following is the backtrack:

ERROR:qom/object.c:981:object_unref: assertion failed: (obj->ref > 0)

Thread 2 "qemu-system-x86" received signal SIGABRT, Aborted.
[Switching to Thread 0x7fffcbd32700 (LWP 18844)]
0x00007fffdb9e4fff in raise () from /lib/x86_64-linux-gnu/libc.so.6
(gdb) bt
/lib/x86_64-linux-gnu/libglib-2.0.so.0
/lib/x86_64-linux-gnu/libglib-2.0.so.0
qom/object.c:981
/home/liqiang02/qemu-upstream/qemu/memory.c:1732
/home/liqiang02/qemu-upstream/qemu/memory.c:285
util/qemu-thread-posix.c:504
/lib/x86_64-linux-gnu/libpthread.so.0

This is caused by memory_region_unref in nvme_exit.

Remove it to make the PCIdevice refcount correct.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/block/nvme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb816..359a06d0ad 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1331,9 +1331,6 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
-    if (n->cmbsz) {
-        memory_region_unref(&n->ctrl_mem);
-    }
 
     msix_uninit_exclusive_bar(pci_dev);
 }
-- 
2.11.0
