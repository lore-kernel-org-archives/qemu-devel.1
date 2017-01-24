Received: from eggs.gnu.org ([2001:4830:134:3::10]:58803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykY-0004pa-7b
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykU-0006Sb-3u
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:27 +0300
Message-Id: <c15c23efebc92bfcf886114d06b8e2a1bc8e48bb.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 23/31] util/mmap-alloc: refactor a little bit
 for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

1st mmap returns *ptr* which aligns to host page size,

    |             size + align               |
    ------------------------------------------
 ptr

input param *align* could be 1M, or 2M, or host page size. After
QEMU_ALIGN_UP, offset will >= 0

2nd mmap use flag MAP_FIXED, then it return ptr+offset, or else fail.
If it success, then we will have something like:

    | offset |          size             |
    --------------------------------------
 ptr      ptr1

*ptr1* is what we really want to return, it equals ptr+offset.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 util/mmap-alloc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index d713a72..2f55f5e 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -84,22 +84,20 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
         return MAP_FAILED;
     }
 
-    ptr += offset;
-    total -= offset;
-
     if (offset > 0) {
-        munmap(ptr - offset, offset);
+        munmap(ptr, offset);
     }
 
     /*
      * Leave a single PROT_NONE page allocated after the RAM block, to serve as
      * a guard page guarding against potential buffer overflows.
      */
+    total -= offset;
     if (total > size + getpagesize()) {
-        munmap(ptr + size + getpagesize(), total - size - getpagesize());
+        munmap(ptr1 + size + getpagesize(), total - size - getpagesize());
     }
 
-    return ptr;
+    return ptr1;
 }
 
 void qemu_ram_munmap(void *ptr, size_t size)
-- 
2.1.4
