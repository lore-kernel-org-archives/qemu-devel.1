Received: from eggs.gnu.org ([2001:4830:134:3::10]:40741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOv-0008B2-6b
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOr-0007Tx-B1
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:21 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOr-0007Tp-40
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:17 -0400
Received: by mail-wr0-x22c.google.com with SMTP id q97so16315199wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:25 +0200
Message-Id: <1497523981-38449-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/41] ivshmem: use ram_from_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Instead of having its own mmap handling code, reuse the code from
exec.c.

Note: memory_region_init_ram_from_fd() adds some restrictions
(check for xen, kvm sync-mmu, etc) and changes (such as size
alignment). This may actually be more correct.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170602141229.15326-6-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6367d04..2f0819d 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -491,9 +491,9 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
 
 static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
 {
+    Error *local_err = NULL;
     struct stat buf;
     size_t size;
-    void *ptr;
 
     if (s->ivshmem_bar2) {
         error_setg(errp, "server sent unexpected shared memory message");
@@ -522,15 +522,13 @@ static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
     }
 
     /* mmap the region and map into the BAR2 */
-    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-    if (ptr == MAP_FAILED) {
-        error_setg_errno(errp, errno, "Failed to mmap shared memory");
-        close(fd);
+    memory_region_init_ram_from_fd(&s->server_bar2, OBJECT(s),
+                                   "ivshmem.bar2", size, true, fd, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
-    memory_region_init_ram_ptr(&s->server_bar2, OBJECT(s),
-                               "ivshmem.bar2", size, ptr);
-    memory_region_set_fd(&s->server_bar2, fd);
+
     s->ivshmem_bar2 = &s->server_bar2;
 }
 
-- 
1.8.3.1
