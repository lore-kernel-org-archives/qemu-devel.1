Received: from eggs.gnu.org ([2001:4830:134:3::10]:40739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOv-0008B0-68
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOs-0007US-Au
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:21 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOs-0007U5-4L
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:18 -0400
Received: by mail-wr0-x242.google.com with SMTP id y25so545047wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:26 +0200
Message-Id: <1497523981-38449-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/41] memory: remove memory_region_set_fd
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

Now unnecessary since ivshmem uses memory_region_init_ram_from_fd.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170602141229.15326-7-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 11 -----------
 memory.c              | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 51a54c9..37f8e78 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -825,17 +825,6 @@ static inline bool memory_region_is_rom(MemoryRegion *mr)
 int memory_region_get_fd(MemoryRegion *mr);
 
 /**
- * memory_region_set_fd: Mark a RAM memory region as backed by a
- * file descriptor.
- *
- * This function is typically used after memory_region_init_ram_ptr().
- *
- * @mr: the memory region being queried.
- * @fd: the file descriptor that backs @mr.
- */
-void memory_region_set_fd(MemoryRegion *mr, int fd);
-
-/**
  * memory_region_from_host: Convert a pointer into a RAM memory region
  * and an offset within it.
  *
diff --git a/memory.c b/memory.c
index b2ace20..e08fa0a 100644
--- a/memory.c
+++ b/memory.c
@@ -1851,16 +1851,6 @@ int memory_region_get_fd(MemoryRegion *mr)
     return fd;
 }
 
-void memory_region_set_fd(MemoryRegion *mr, int fd)
-{
-    rcu_read_lock();
-    while (mr->alias) {
-        mr = mr->alias;
-    }
-    mr->ram_block->fd = fd;
-    rcu_read_unlock();
-}
-
 void *memory_region_get_ram_ptr(MemoryRegion *mr)
 {
     void *ptr;
-- 
1.8.3.1
