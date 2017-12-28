Received: from eggs.gnu.org ([2001:4830:134:3::10]:54678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbS-000857-ET
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013w-5X
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:26 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013G-1N
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:13 -0500
Message-Id: <20171228180814.9749-11-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 10/10] linux-user: init_guest_space: Try to
 make ARM space+commpage continuous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: paul@codesourcery.com, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Luke Shumaker <lukeshu@parabola.nu>

At a fixed distance after the usable memory that init_guest_space maps, for
32-bit ARM targets we also need to map a commpage.  The normal
init_guest_space logic doesn't keep this in mind when searching for an
address range.

If !host_start, then try to find a big continuous segment where we can put
both the usable memory and the commpage; we then munmap that segment and
set current_start to that address; and let the normal code mmap the usable
memory and the commpage separately.  That is: if we don't have hint of
where to start looking for memory, come up with one that is better than
NULL.  Depending on host_size and guest_start, there may or may not be a
gap between the usable memory and the commpage, so this is slightly more
restrictive than it needs to be; but it's only a hint, so that's OK.

We only do that for !host start, because if host_start, then either:
 - we got an address passed in with -B, in which case we don't want to
   interfere with what the user said;
 - or host_start is based off of the ELF image's loaddr.  The check "if
   (host_start && real_start != current_start)" suggests that we really
   want lowest available address that is >= loaddr.  I don't know why that
   is, but I'm trusting that Paul Brook knew what he was doing when he
   wrote the original version of that check in
   c581deda322080e8beb88b2e468d4af54454e4b3 way back in 2010.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7736ea2c3a..cd3a7d877d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1857,6 +1857,55 @@ unsigned long init_guest_space(unsigned long host_start,
 
     /* Otherwise, a non-zero size region of memory needs to be mapped
      * and validated.  */
+
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+    /* On 32-bit ARM, we need to map not just the usable memory, but
+     * also the commpage.  Try to find a suitable place by allocating
+     * a big chunk for all of it.  If host_start, then the naive
+     * strategy probably does good enough.
+     */
+    if (!host_start) {
+        unsigned long guest_full_size, host_full_size, real_start;
+
+        guest_full_size =
+            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
+        host_full_size = guest_full_size - guest_start;
+        real_start = (unsigned long)
+            mmap(NULL, host_full_size, PROT_NONE, flags, -1, 0);
+        if (real_start == (unsigned long)-1) {
+            if (host_size < host_full_size - qemu_host_page_size) {
+                /* We failed to map a continous segment, but we're
+                 * allowed to have a gap between the usable memory and
+                 * the commpage where other things can be mapped.
+                 * This sparseness gives us more flexibility to find
+                 * an address range.
+                 */
+                goto naive;
+            }
+            return (unsigned long)-1;
+        }
+        munmap((void *)real_start, host_full_size);
+        if (real_start & ~qemu_host_page_mask) {
+            /* The same thing again, but with an extra qemu_host_page_size
+             * so that we can shift around alignment.
+             */
+            unsigned long real_size = host_full_size + qemu_host_page_size;
+            real_start = (unsigned long)
+                mmap(NULL, real_size, PROT_NONE, flags, -1, 0);
+            if (real_start == (unsigned long)-1) {
+                if (host_size < host_full_size - qemu_host_page_size) {
+                    goto naive;
+                }
+                return (unsigned long)-1;
+            }
+            munmap((void *)real_start, real_size);
+            real_start = HOST_PAGE_ALIGN(real_start);
+        }
+        current_start = real_start;
+    }
+ naive:
+#endif
+
     while (1) {
         unsigned long real_start, real_size, aligned_size;
         aligned_size = real_size = host_size;
-- 
2.15.1
