Received: from eggs.gnu.org ([2001:4830:134:3::10]:38318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ecCMN-0006TU-1k
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ecCMJ-00049h-Vq
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:44:11 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ecCMJ-000489-Pu
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:44:07 -0500
Received: by mail-pf0-x243.google.com with SMTP id k19so14892446pfj.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:44:07 -0800 (PST)
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 18 Jan 2018 23:41:56 +0800
Message-Id: <1516290116-4366-1-git-send-email-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH] libvhost-user: Fix resource leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com
Cc: dgilbert@redhat.com, maxime.coquelin@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org

Free the mmaped memory when we need to mmap new memory
space on vu_set_mem_table_exec() and vu_set_log_base_exec() to
avoid memory leak.

Also close the corresponding fd after mmap() on
vu_set_log_base_exec() to avoid fd leak.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
---
 contrib/libvhost-user/libvhost-user.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index f409bd3..cadced7 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -405,6 +405,15 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
     VhostUserMemory *memory = &vmsg->payload.memory;
+
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *r = &dev->regions[i];
+        void *m = (void *) (uintptr_t) r->mmap_addr;
+
+        if (m) {
+            munmap(m, r->size + r->mmap_offset);
+        }
+    }
     dev->nregions = memory->nregions;
 
     DPRINT("Nregions: %d\n", memory->nregions);
@@ -470,9 +479,14 @@ vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     rc = mmap(0, log_mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
               log_mmap_offset);
+    close(fd);
     if (rc == MAP_FAILED) {
         perror("log mmap error");
     }
+
+    if (dev->log_table) {
+        munmap(dev->log_table, dev->log_size);
+    }
     dev->log_table = rc;
     dev->log_size = log_mmap_size;
 
-- 
1.7.9.5
