Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbR-00084b-UX
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013k-4B
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:25 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-000137-0J
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:10 -0500
Message-Id: <20171228180814.9749-8-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 07/10] linux-user: init_guest_space: Clean up
 control flow a bit
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

Instead of doing

        if (check1) {
            if (check2) {
               success;
            }
        }

        retry;

Do a clearer

        if (!check1) {
           goto try_again;
        }

        if (!check2) {
           goto try_again;
        }

        success;

    try_again:
        retry;

Besides being clearer, this makes it easier to insert more checks that
need to trigger a retry on check failure, or rearrange them, or anything
like that.

Because some indentation is changing, "ignore space change" may be useful
for viewing this patch.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b560f5d6fe..5c0ad65611 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1906,24 +1906,28 @@ unsigned long init_guest_space(unsigned long host_start,
         }
 
         /* Check to see if the address is valid.  */
-        if (!host_start || aligned_start == current_start) {
+        if (host_start && aligned_start != current_start) {
+            goto try_again;
+        }
+
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-            /* On 32-bit ARM, we need to also be able to map the commpage.  */
-            int valid = init_guest_commpage(aligned_start - guest_start,
-                                            aligned_size + guest_start);
-            if (valid == 1) {
-                break;
-            } else if (valid == -1) {
-                munmap((void *)real_start, real_size);
-                return (unsigned long)-1;
-            }
-            /* valid == 0, so try again. */
-#else
-            /* On other architectures, whatever we have here is fine.  */
-            break;
-#endif
+        /* On 32-bit ARM, we need to also be able to map the commpage.  */
+        int valid = init_guest_commpage(aligned_start - guest_start,
+                                        aligned_size + guest_start);
+        if (valid == -1) {
+            munmap((void *)real_start, real_size);
+            return (unsigned long)-1;
+        } else if (valid == -1) {
+            goto try_again;
         }
+#endif
+
+        /* If nothing has said `return -1` or `goto try_again` yet,
+         * then the address we have is good.
+         */
+        break;
 
+    try_again:
         /* That address didn't work.  Unmap and try a different one.
          * The address the host picked because is typically right at
          * the top of the host address space and leaves the guest with
-- 
2.15.1
