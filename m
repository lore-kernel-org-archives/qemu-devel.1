Received: from eggs.gnu.org ([2001:4830:134:3::10]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOl-00082n-Hx
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOi-0007Ou-AP
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:11 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOi-0007Ny-3k
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:08 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so2745037wrb.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:21 +0200
Message-Id: <1497523981-38449-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/41] exec: check kvm mmu notifiers earlier
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

Move kvm mmu notifiers check before calling file_ram_alloc(), with the
other xen precondition. (file_ram_alloc() will be reused in other cases
than -mem-path).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170602141229.15326-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index a93e209..a5be851 100644
--- a/exec.c
+++ b/exec.c
@@ -1495,12 +1495,6 @@ static void *file_ram_alloc(RAMBlock *block,
     int fd = -1;
     int64_t file_size;
 
-    if (kvm_enabled() && !kvm_has_sync_mmu()) {
-        error_setg(errp,
-                   "host lacks kvm mmu notifiers, -mem-path unsupported");
-        return NULL;
-    }
-
     for (;;) {
         fd = open(path, O_RDWR);
         if (fd >= 0) {
@@ -1943,6 +1937,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
+    if (kvm_enabled() && !kvm_has_sync_mmu()) {
+        error_setg(errp,
+                   "host lacks kvm mmu notifiers, -mem-path unsupported");
+        return NULL;
+    }
+
     if (phys_mem_alloc != qemu_anon_ram_alloc) {
         /*
          * file_ram_alloc() needs to allocate just like
-- 
1.8.3.1
