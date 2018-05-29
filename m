Received: from eggs.gnu.org ([2001:4830:134:3::10]:56049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smcpolin@smcpolin-M01.vmware.com>)
	id 1fNjr9-00052r-OY
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smcpolin@smcpolin-M01.vmware.com>)
	id 1fNjr6-0002Xb-Hn
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:00:27 -0400
Received: from [69.196.150.84] (port=47177 helo=smcpolin-M01.vmware.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smcpolin@smcpolin-M01.vmware.com>)
	id 1fNjr6-0002WW-6e
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:00:24 -0400
From: Steve Mcpolin <smcpolin@vmware.com>
Date: Tue, 29 May 2018 14:15:25 -0400
Message-Id: <20180529190022.D3B2FC01BBA@smcpolin-M01.vmware.com>
Subject: [Qemu-devel] [PATCH v3] linux-user: Remove extra mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu, smcpolin@vmware.com

When a guest mmap()'d a file, an anonymous mapping was created to
align different host and client page granularity and provide for
beyond EOF mappings.  The file was then mapped ontop of this mapping,
releasing the memory reserved by it.  A file based mmap does not reserve
memory, but the anonymous map does; thus this anonymous mapping could
could cause spurious failures.

This patch minimizes the size of the anonymous mapping to prevent spurious
failures.

Signed-off-by: Steve Mcpolin <smcpolin@vmware.com>
---
 linux-user/mmap.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9168a20..7a975c8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -453,21 +453,29 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         /* Note: we prefer to control the mapping address. It is
            especially important if qemu_host_page_size >
            qemu_real_host_page_size */
-        p = mmap(g2h(start), host_len, prot,
-                 flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED)
-            goto fail;
-        /* update start so that it points to the file position at 'offset' */
-        host_start = (unsigned long)p;
-        if (!(flags & MAP_ANONYMOUS)) {
-            p = mmap(g2h(start), len, prot,
+        if (flags & MAP_ANONYMOUS) {
+            offset = 0;
+            host_offset = 0;
+            fd = -1;
+        }
+        p = mmap(g2h(start), len, prot,
                      flags | MAP_FIXED, fd, host_offset);
-            if (p == MAP_FAILED) {
-                munmap(g2h(start), host_len);
-                goto fail;
+        host_start = (uintptr_t)p;
+        if (p != MAP_FAILED && host_len > REAL_HOST_PAGE_ALIGN(len)) {
+            void *q;
+            q = mmap(g2h(start + len), host_len - REAL_HOST_PAGE_ALIGN(len),
+                     prot, MAP_FIXED | (flags & MAP_TYPE) | MAP_ANONYMOUS,
+                     -1, 0);
+            if (q == MAP_FAILED) {
+                p = MAP_FAILED;
             }
-            host_start += offset - host_offset;
         }
+        if (p == MAP_FAILED) {
+            munmap(g2h(start), host_len);
+            goto fail;
+        }
+        host_start += offset - host_offset;
+        /* update start so that it points to the file position at 'offset' */
         start = h2g(host_start);
     } else {
         if (start & ~TARGET_PAGE_MASK) {
-- 
2.7.4
