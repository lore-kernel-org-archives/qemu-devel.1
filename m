Received: from eggs.gnu.org ([2001:4830:134:3::10]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnog-000067-Cm
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnof-0007xy-En
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnof-0007wI-2b
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:54 +0100
Message-Id: <20180313173355.4468-18-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 17/18] linux-user: init_guest_space: Don't try
 to align if we'll reject it
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

If the ensure-alignment code gets triggered, then the
"if (host_start && real_start != current_start)" check will always trigger,
so save 2 syscalls and put that check first.

Note that we can't just switch to using MAP_FIXED for that check, because
then we couldn't differentiate between a failure because "there isn't
enough space" and "there isn't enough space *here*".

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
Message-Id: <20171228180814.9749-9-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c6491a8d35..5c64299961 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1845,6 +1845,11 @@ unsigned long init_guest_space(unsigned long host_start,
             return (unsigned long)-1;
         }
 
+        /* Check to see if the address is valid.  */
+        if (host_start && real_start != current_start) {
+            goto try_again;
+        }
+
         /* Ensure the address is properly aligned.  */
         if (real_start & ~qemu_host_page_mask) {
             /* Ideally, we adjust like
@@ -1879,11 +1884,6 @@ unsigned long init_guest_space(unsigned long host_start,
             aligned_start = real_start;
         }
 
-        /* Check to see if the address is valid.  */
-        if (host_start && aligned_start != current_start) {
-            goto try_again;
-        }
-
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
         /* On 32-bit ARM, we need to also be able to map the commpage.  */
         int valid = init_guest_commpage(aligned_start - guest_start,
-- 
2.14.3
