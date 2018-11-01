Received: from eggs.gnu.org ([2001:4830:134:3::10]:33821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifeng1519@gmail.com>) id 1gIAIQ-0000tP-NA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifeng1519@gmail.com>) id 1gIAIP-0002SM-NQ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:33:50 -0400
From: Li Feng <lifeng1519@gmail.com>
Date: Thu,  1 Nov 2018 18:38:07 +0800
Message-Id: <20181101103807.25862-1-lifeng1519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] block/nvme: optimize the performance of nvme
 driver based on vfio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fengli@smartx.com
Cc: Li Feng <lifeng1519@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:NVMe Block Driver" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

When the IO size is larger than 2 pages, we move the the pointer one by
one in the pagelist, this is inefficient.

This is a simple benchmark result:

Before:
$ qemu-io -c 'write 0 1G' nvme://0000:00:04.0/1

wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:02.41 (424.504 MiB/sec and 0.4146 ops/sec)

 $ qemu-io -c 'read 0 1G' nvme://0000:00:04.0/1

read 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:02.03 (503.055 MiB/sec and 0.4913 ops/sec)

After:
$ qemu-io -c 'write 0 1G' nvme://0000:00:04.0/1

wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:02.17 (471.517 MiB/sec and 0.4605 ops/sec)

 $ qemu-io -c 'read 0 1G' nvme://0000:00:04.0/1                                                                                                                                                                                                                                                                      1 ↵

read 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:01.94 (526.770 MiB/sec and 0.5144 ops/sec)

Signed-off-by: Li Feng <lifeng1519@gmail.com>
---
 block/nvme.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 29294038fc..982097b5b1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -837,7 +837,7 @@ try_map:
         }
 
         for (j = 0; j < qiov->iov[i].iov_len / s->page_size; j++) {
-            pagelist[entries++] = iova + j * s->page_size;
+            pagelist[entries++] = cpu_to_le64(iova + j * s->page_size);
         }
         trace_nvme_cmd_map_qiov_iov(s, i, qiov->iov[i].iov_base,
                                     qiov->iov[i].iov_len / s->page_size);
@@ -850,20 +850,16 @@ try_map:
     case 0:
         abort();
     case 1:
-        cmd->prp1 = cpu_to_le64(pagelist[0]);
+        cmd->prp1 = pagelist[0];
         cmd->prp2 = 0;
         break;
     case 2:
-        cmd->prp1 = cpu_to_le64(pagelist[0]);
-        cmd->prp2 = cpu_to_le64(pagelist[1]);;
+        cmd->prp1 = pagelist[0];
+        cmd->prp2 = pagelist[1];
         break;
     default:
-        cmd->prp1 = cpu_to_le64(pagelist[0]);
-        cmd->prp2 = cpu_to_le64(req->prp_list_iova);
-        for (i = 0; i < entries - 1; ++i) {
-            pagelist[i] = cpu_to_le64(pagelist[i + 1]);
-        }
-        pagelist[entries - 1] = 0;
+        cmd->prp1 = pagelist[0];
+        cmd->prp2 = cpu_to_le64(req->prp_list_iova + sizeof(uint64_t));
         break;
     }
     trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
-- 
2.11.0
