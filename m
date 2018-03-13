Received: from eggs.gnu.org ([2001:4830:134:3::10]:55555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnog-00006G-GB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnof-0007xn-Dp
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnof-0007wf-2b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:53 +0100
Message-Id: <20180313173355.4468-17-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 16/18] linux-user: init_guest_space: Clean up
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Luke Shumaker <lukeshu@parabola.nu>

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
Message-Id: <20171228180814.9749-8-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[lv: modified to try again fi valid == 0, not valid == -1 (error case)]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8699f430b1..c6491a8d35 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1880,24 +1880,28 @@ unsigned long init_guest_space(unsigned long host_start,
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
+        } else if (valid == 0) {
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
2.14.3
