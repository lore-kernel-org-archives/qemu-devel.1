Received: from eggs.gnu.org ([2001:4830:134:3::10]:38854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smcpolin@smcpolin-M01.vmware.com>)
	id 1fNMYC-0004Jv-J3
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smcpolin@smcpolin-M01.vmware.com>)
	id 1fNMY8-0004wP-0k
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:07:20 -0400
Received: from [69.196.150.84] (port=47521 helo=smcpolin-M01.vmware.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smcpolin@smcpolin-M01.vmware.com>)
	id 1fNMY7-0004wD-Rp
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:07:15 -0400
From: Steve Mcpolin <smcpolin@vmware.com>
Date: Mon, 28 May 2018 12:59:39 -0400
Message-Id: <20180528180714.A8DCABD6612@smcpolin-M01.vmware.com>
Subject: [Qemu-devel] [PATCH v2] linux-user: Remove extra mapping
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

When a guest mmap()'d a file, a transient MAP_ANONYMOUS mapping was
created, which required the kernel to reserve this memory, then
subsequently released by applying a mapping with just the requested
flags and fd.
This transient mapping causes spurious failures when the available
memory is smaller than the mapping.  This patch avoids this transient
mapping.

Signed-off-by: Steve Mcpolin <smcpolin@vmware.com>
---
 linux-user/mmap.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9168a20..b33adf2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -453,21 +453,28 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
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
+                     prot, MAP_FIXED | MAP_ANONYMOUS, -1, 0);
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
