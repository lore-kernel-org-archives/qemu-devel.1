Received: from eggs.gnu.org ([2001:4830:134:3::10]:40500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgumS-000202-Kf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgumO-0006Xr-2h
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:54:04 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:58916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgumN-0006Wt-R6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:54:00 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 23 Feb 2017 14:53:52 +0000
Message-ID: <1487861635-17560-3-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/5] xen: rename xen_modified_memory() to
 xen_hvm_modified_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

This patch is a purely cosmetic change that avoids a name collision in
a subsequent patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 include/exec/ram_addr.h | 4 ++--
 include/hw/xen/xen.h    | 2 +-
 xen-hvm-stub.c          | 2 +-
 xen-hvm.c               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3e79466..8715af6 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -259,7 +259,7 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
 
     rcu_read_unlock();
 
-    xen_modified_memory(start, length);
+    xen_hvm_modified_memory(start, length);
 }
 
 #if !defined(_WIN32)
@@ -313,7 +313,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
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
2.1.4
