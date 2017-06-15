Received: from eggs.gnu.org ([2001:4830:134:3::10]:40678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOm-000833-QI
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOl-0007Rn-VJ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:12 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOl-0007R4-PO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:11 -0400
Received: by mail-wr0-x232.google.com with SMTP id q97so16311948wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:24 +0200
Message-Id: <1497523981-38449-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/41] Add memory_region_init_ram_from_fd()
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

Add a new function to initialize a RAM memory region with a file
descriptor to be mmap-ed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170602141229.15326-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 20 ++++++++++++++++++++
 memory.c              | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 80e605a..51a54c9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -456,6 +456,26 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       bool share,
                                       const char *path,
                                       Error **errp);
+
+/**
+ * memory_region_init_ram_from_fd:  Initialize RAM memory region with a
+ *                                  mmap-ed backend.
+ *
+ * @mr: the #MemoryRegion to be initialized.
+ * @owner: the object that tracks the region's reference count
+ * @name: the name of the region.
+ * @size: size of the region.
+ * @share: %true if memory must be mmaped with the MAP_SHARED flag
+ * @fd: the fd to mmap.
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+void memory_region_init_ram_from_fd(MemoryRegion *mr,
+                                    struct Object *owner,
+                                    const char *name,
+                                    uint64_t size,
+                                    bool share,
+                                    int fd,
+                                    Error **errp);
 #endif
 
 /**
diff --git a/memory.c b/memory.c
index 0ddc4cc..b2ace20 100644
--- a/memory.c
+++ b/memory.c
@@ -1397,6 +1397,22 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
+
+void memory_region_init_ram_from_fd(MemoryRegion *mr,
+                                    struct Object *owner,
+                                    const char *name,
+                                    uint64_t size,
+                                    bool share,
+                                    int fd,
+                                    Error **errp)
+{
+    memory_region_init(mr, owner, name, size);
+    mr->ram = true;
+    mr->terminates = true;
+    mr->destructor = memory_region_destructor_ram;
+    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+}
 #endif
 
 void memory_region_init_ram_ptr(MemoryRegion *mr,
-- 
1.8.3.1
