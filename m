Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCC-0005Pj-1C
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCA-0006fG-O1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:00 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 20 Jan 2017 11:47:55 +0800
Message-ID: <1484884080-28836-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/6] docs/block-replication: Add description
 for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Wen
	Congyang <wency@cn.fujitsu.com>

Introuduce the scenario of shared-disk block replication
and how to use it.

Reviewed-by: Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 docs/block-replication.txt | 139 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 4 deletions(-)

diff --git a/docs/block-replication.txt b/docs/block-replication.txt
index 6bde673..fbfe005 100644
--- a/docs/block-replication.txt
+++ b/docs/block-replication.txt
@@ -24,7 +24,7 @@ only dropped at next checkpoint time. To reduce the network transportation
 effort during a vmstate checkpoint, the disk modification operations of
 the Primary disk are asynchronously forwarded to the Secondary node.
 
-== Workflow ==
+== Non-shared disk workflow ==
 The following is the image of block replication workflow:
 
         +----------------------+            +------------------------+
@@ -57,7 +57,7 @@ The following is the image of block replication workflow:
     4) Secondary write requests will be buffered in the Disk buffer and it
        will overwrite the existing sector content in the buffer.
 
-== Architecture ==
+== Non-shared disk architecture ==
 We are going to implement block replication from many basic
 blocks that are already in QEMU.
 
@@ -106,6 +106,74 @@ any state that would otherwise be lost by the speculative write-through
 of the NBD server into the secondary disk. So before block replication,
 the primary disk and secondary disk should contain the same data.
 
+== Shared Disk Mode Workflow ==
+The following is the image of block replication workflow:
+
+        +----------------------+            +------------------------+
+        |Primary Write Requests|            |Secondary Write Requests|
+        +----------------------+            +------------------------+
+                  |                                       |
+                  |                                      (4)
+                  |                                       V
+                  |                              /-------------\
+                  | (2)Forward and write through |             |
+                  | +--------------------------> | Disk Buffer |
+                  | |                            |             |
+                  | |                            \-------------/
+                  | |(1)read                           |
+                  | |                                  |
+       (3)write   | |                                  | backing file
+                  V |                                  |
+                 +-----------------------------+       |
+                 | Shared Disk                 | <-----+
+                 +-----------------------------+
+
+    1) Primary writes will read original data and forward it to Secondary
+       QEMU.
+    2) Before Primary write requests are written to Shared disk, the
+       original sector content will be read from Shared disk and
+       forwarded and buffered in the Disk buffer on the secondary site,
+       but it will not overwrite the existing sector content (it could be
+       from either "Secondary Write Requests" or previous COW of "Primary
+       Write Requests") in the Disk buffer.
+    3) Primary write requests will be written to Shared disk.
+    4) Secondary write requests will be buffered in the Disk buffer and it
+       will overwrite the existing sector content in the buffer.
+
+== Shared Disk Mode Architecture ==
+We are going to implement block replication from many basic
+blocks that are already in QEMU.
+         virtio-blk                     ||                               .----------
+             /                          ||                               | Secondary
+            /                           ||                               '----------
+           /                            ||                                 virtio-blk
+          /                             ||                                      |
+          |                             ||                               replication(5)
+          |                    NBD  -------->   NBD   (2)                       |
+          |                  client     ||    server ---> hidden disk <-- active disk(4)
+          |                     ^       ||                      |
+          |              replication(1) ||                      |
+          |                     |       ||                      |
+          |   +-----------------'       ||                      |
+         (3)  |drive-backup sync=none   ||                      |
+--------. |   +-----------------+       ||                      |
+Primary | |                     |       ||           backing    |
+--------' |                     |       ||                      |
+          V                     |                               |
+       +-------------------------------------------+            |
+       |               shared disk                 | <----------+
+       +-------------------------------------------+
+
+
+    1) Primary writes will read original data and forward it to Secondary
+       QEMU.
+    2) The hidden-disk buffers the original content that is modified by the
+       primary VM. It should also be an empty disk, and the driver supports
+       bdrv_make_empty() and backing file.
+    3) Primary write requests will be written to Shared disk.
+    4) Secondary write requests will be buffered in the active disk and it
+       will overwrite the existing sector content in the buffer.
+
 == Failure Handling ==
 There are 7 internal errors when block replication is running:
 1. I/O error on primary disk
@@ -145,7 +213,7 @@ d. replication_stop_all()
    things except failover. The caller must hold the I/O mutex lock if it is
    in migration/checkpoint thread.
 
-== Usage ==
+== Non-shared disk usage ==
 Primary:
   -drive if=xxx,driver=quorum,read-pattern=fifo,id=colo1,vote-threshold=1,\
          children.0.file.filename=1.raw,\
@@ -234,6 +302,69 @@ Secondary:
   The primary host is down, so we should do the following thing:
   { 'execute': 'nbd-server-stop' }
 
+== Shared disk usage ==
+Primary:
+ -drive if=virtio,id=primary_disk0,file.filename=1.raw,driver=raw
+
+Issue qmp command:
+  { 'execute': 'blockdev-add',
+    'arguments': {
+        'driver': 'replication',
+        'node-name': 'rep',
+        'mode': 'primary',
+        'shared-disk-id': 'primary_disk0',
+        'shared-disk': true,
+        'file': {
+            'driver': 'nbd',
+            'export': 'hidden_disk0',
+            'server': {
+                'type': 'inet',
+                'data': {
+                    'host': 'xxx.xxx.xxx.xxx',
+                    'port': 'yyy'
+                }
+            }
+        }
+     }
+  }
+
+Secondary:
+ -drive if=none,driver=qcow2,file.filename=/mnt/ramfs/hidden_disk.img,id=hidden_disk0,\
+        backing.driver=raw,backing.file.filename=1.raw \
+ -drive if=virtio,id=active-disk0,driver=replication,mode=secondary,\
+        file.driver=qcow2,top-id=active-disk0,\
+        file.file.filename=/mnt/ramfs/active_disk.img,\
+        file.backing=hidden_disk0,shared-disk=on
+
+Issue qmp command:
+1. { 'execute': 'nbd-server-start',
+     'arguments': {
+        'addr': {
+            'type': 'inet',
+            'data': {
+                'host': '0',
+                'port': 'yyy'
+            }
+        }
+     }
+   }
+2. { 'execute': 'nbd-server-add',
+     'arguments': {
+        'device': 'hidden_disk0',
+        'writable': true
+    }
+  }
+
+After Failover:
+Primary:
+  { 'execute': 'x-blockdev-del',
+    'arguments': {
+        'node-name': 'rep'
+    }
+  }
+
+Secondary:
+  {'execute': 'nbd-server-stop' }
+
 TODO:
 1. Continuous block replication
-2. Shared disk
-- 
1.8.3.1
