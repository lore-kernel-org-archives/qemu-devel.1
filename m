Received: from eggs.gnu.org ([2001:4830:134:3::10]:44543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gJaGg-00082S-86
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gJaGb-0002l9-9a
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:29:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:1761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gJaGa-00026O-Sl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:29:49 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Mon,  5 Nov 2018 16:29:08 +0800
Message-Id: <9619c036a6dc6cb4966f46d2405084f11666e14d.1541425595.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
References: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH v5 3/7] exec: switch qemu_ram_alloc_from_{file,
 fd} to the 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, yu.c.zhang@linux.intel.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com, Zhang Yi <yi.z.zhang@linux.intel.com>

As more flag parameters besides the existing 'share' are going to be
added to qemu_ram_alloc_from_{file,fd}(), let's swith 'share' to a
'flags' parameters in advance, so as to ease the further additions.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 273f668..e92a7da 100644
--- a/exec.c
+++ b/exec.c
@@ -1810,6 +1810,7 @@ static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
                             bool truncate,
+                            uint32_t flags,
                             Error **errp)
 {
     void *area;
@@ -1859,7 +1860,7 @@ static void *file_ram_alloc(RAMBlock *block,
         perror("ftruncate");
     }
 
-    area = qemu_ram_mmap(fd, memory, block->mr->align, block->flags);
+    area = qemu_ram_mmap(fd, memory, block->mr->align, flags);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
@@ -2278,7 +2279,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
+    new_block->host = file_ram_alloc(new_block, size, fd, !file_size,
+            ram_flags, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
-- 
2.7.4
