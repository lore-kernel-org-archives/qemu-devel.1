Received: from eggs.gnu.org ([2001:4830:134:3::10]:54632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbR-00084S-N7
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013f-3w
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:25 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-000134-0c
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:11 -0500
Message-Id: <20171228180814.9749-9-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 08/10] linux-user: init_guest_space: Don't try
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
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Luke Shumaker <lukeshu@parabola.nu>

If the ensure-alignment code gets triggered, then the
"if (host_start && real_start != current_start)" check will always trigger,
so save 2 syscalls and put that check first.

Note that we can't just switch to using MAP_FIXED for that check, because
then we couldn't differentiate between a failure because "there isn't
enough space" and "there isn't enough space *here*".

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5c0ad65611..1b7583d659 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1871,6 +1871,11 @@ unsigned long init_guest_space(unsigned long host_start,
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
@@ -1905,11 +1910,6 @@ unsigned long init_guest_space(unsigned long host_start,
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
2.15.1
