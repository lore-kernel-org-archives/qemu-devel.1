Received: from eggs.gnu.org ([2001:4830:134:3::10]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exV-0003lo-Bb
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exS-0002eX-HZ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:13 -0400
Received: from mail.kernel.org ([198.145.29.136]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exS-0002dz-Bf
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:10 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:14:43 -0700
Message-Id: <1492805702-19690-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 02/21] xen: rename xen_modified_memory() to
 xen_hvm_modified_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

This patch is a purely cosmetic change that avoids a name collision in
a subsequent patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 include/exec/ram_addr.h | 4 ++--
 include/hw/xen/xen.h    | 2 +-
 xen-hvm-stub.c          | 2 +-
 xen-hvm.c               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b05dc84..2964730 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -260,7 +260,7 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
 
     rcu_read_unlock();
 
-    xen_modified_memory(start, length);
+    xen_hvm_modified_memory(start, length);
 }
 
 #if !defined(_WIN32)
@@ -314,7 +314,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
         rcu_read_unlock();
 
-        xen_modified_memory(start, pages << TARGET_PAGE_BITS);
+        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
         /*
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 09c2ce5..2b1733b 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -43,7 +43,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-void xen_modified_memory(ram_addr_t start, ram_addr_t length);
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
index c500325..3ca6c51 100644
--- a/xen-hvm-stub.c
+++ b/xen-hvm-stub.c
@@ -50,7 +50,7 @@ void xen_register_framebuffer(MemoryRegion *mr)
 {
 }
 
-void xen_modified_memory(ram_addr_t start, ram_addr_t length)
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
 }
 
diff --git a/xen-hvm.c b/xen-hvm.c
index dbb8c66..edf4983 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -1391,7 +1391,7 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
     qemu_system_shutdown_request();
 }
 
-void xen_modified_memory(ram_addr_t start, ram_addr_t length)
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     if (unlikely(xen_in_migration)) {
         int rc;
-- 
1.9.1
