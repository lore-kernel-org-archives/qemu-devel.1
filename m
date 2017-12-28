Received: from eggs.gnu.org ([2001:4830:134:3::10]:54657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbR-00084e-Vw
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013W-2z
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:25 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-00012o-UW
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:08 -0500
Message-Id: <20171228180814.9749-6-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 05/10] linux-user: init_guest_space: Clarify
 page alignment logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Luke Shumaker <lukeshu@parabola.nu>

There are 3 parts to this change:
 - Add a comment showing the relative sizes and positions of the blocks of
   memory
 - introduce and use new aligned_{start,size} instead of adjusting
   real_{start_size}
 - When we clean up (on failure), munmap(real_start, real_size) instead of
   munmap(aligned_start, aligned_size).  It *shouldn't* make any
   difference, but I will admit that this does mean we are making the
   syscall with different values, so this isn't quite a no-op patch.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f41cecc3cb..22f2632dfa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1827,7 +1827,7 @@ unsigned long init_guest_space(unsigned long host_start,
                                unsigned long guest_start,
                                bool fixed)
 {
-    unsigned long current_start, real_start;
+    unsigned long current_start, aligned_start;
     int flags;
 
     assert(host_start || host_size);
@@ -1853,7 +1853,8 @@ unsigned long init_guest_space(unsigned long host_start,
     /* Otherwise, a non-zero size region of memory needs to be mapped
      * and validated.  */
     while (1) {
-        unsigned long real_size = host_size;
+        unsigned long real_start, real_size, aligned_size;
+        aligned_size = real_size = host_size;
 
         /* Do not use mmap_find_vma here because that is limited to the
          * guest address space.  We are going to make the
@@ -1867,26 +1868,48 @@ unsigned long init_guest_space(unsigned long host_start,
 
         /* Ensure the address is properly aligned.  */
         if (real_start & ~qemu_host_page_mask) {
+            /* Ideally, we adjust like
+             *
+             *    pages: [  ][  ][  ][  ][  ]
+             *      old:   [   real   ]
+             *             [ aligned  ]
+             *      new:   [     real     ]
+             *               [ aligned  ]
+             *
+             * But if there is something else mapped right after it,
+             * then obviously it won't have room to grow, and the
+             * kernel will put the new larger real someplace else with
+             * unknown alignment (if we made it to here, then
+             * fixed=false).  Which is why we grow real by a full page
+             * size, instead of by part of one; so that even if we get
+             * moved, we can still guarantee alignment.  But this does
+             * mean that there is a padding of < 1 page both before
+             * and after the aligned range; the "after" could could
+             * cause problems for ARM emulation where it could butt in
+             * to where we need to put the commpage.
+             */
             munmap((void *)real_start, host_size);
-            real_size = host_size + qemu_host_page_size;
+            real_size = aligned_size + qemu_host_page_size;
             real_start = (unsigned long)
                 mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
             if (real_start == (unsigned long)-1) {
                 return (unsigned long)-1;
             }
-            real_start = HOST_PAGE_ALIGN(real_start);
+            aligned_start = HOST_PAGE_ALIGN(real_start);
+        } else {
+            aligned_start = real_start;
         }
 
         /* Check to see if the address is valid.  */
-        if (!host_start || real_start == current_start) {
+        if (!host_start || aligned_start == current_start) {
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
             /* On 32-bit ARM, we need to also be able to map the commpage.  */
-            int valid = init_guest_commpage(real_start - guest_start,
-                                            real_size + guest_start);
+            int valid = init_guest_commpage(aligned_start - guest_start,
+                                            aligned_size + guest_start);
             if (valid == 1) {
                 break;
             } else if (valid == -1) {
-                munmap((void *)real_start, host_size);
+                munmap((void *)real_start, real_size);
                 return (unsigned long)-1;
             }
             /* valid == 0, so try again. */
@@ -1905,7 +1928,7 @@ unsigned long init_guest_space(unsigned long host_start,
          * address space randomization put a shared library somewhere
          * inconvenient.
          */
-        munmap((void *)real_start, host_size);
+        munmap((void *)real_start, real_size);
         current_start += qemu_host_page_size;
         if (host_start == current_start) {
             /* Theoretically possible if host doesn't have any suitably
@@ -1917,7 +1940,7 @@ unsigned long init_guest_space(unsigned long host_start,
 
     qemu_log_mask(CPU_LOG_PAGE, "Reserved 0x%lx bytes of guest address space\n", host_size);
 
-    return real_start;
+    return aligned_start;
 }
 
 static void probe_guest_base(const char *image_name,
-- 
2.15.1
