Received: from eggs.gnu.org ([2001:4830:134:3::10]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbR-000842-03
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-00012t-My
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-0000xm-8F
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:23 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:04 -0500
Message-Id: <20171228180814.9749-2-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 01/10] linux-user: Use #if to only call
 validate_guest_space for 32-bit ARM target
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

Instead of defining a bogus validate_guest_space that always returns 1 on
targets other than 32-bit ARM, use #if blocks to only call it on 32-bit ARM
targets.  This makes the "normal" flow control clearer.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c3..cac991159c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -354,7 +354,6 @@ enum {
 
 /* The commpage only exists for 32 bit kernels */
 
-#define TARGET_HAS_VALIDATE_GUEST_SPACE
 /* Return 1 if the proposed guest space is suitable for the guest.
  * Return 0 if the proposed guest space isn't suitable, but another
  * address space should be tried.
@@ -1823,15 +1822,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     return sp;
 }
 
-#ifndef TARGET_HAS_VALIDATE_GUEST_SPACE
-/* If the guest doesn't have a validation function just agree */
-static int validate_guest_space(unsigned long guest_base,
-                                unsigned long guest_size)
-{
-    return 1;
-}
-#endif
-
 unsigned long init_guest_space(unsigned long host_start,
                                unsigned long host_size,
                                unsigned long guest_start,
@@ -1845,11 +1835,12 @@ unsigned long init_guest_space(unsigned long host_start,
     /* If just a starting address is given, then just verify that
      * address.  */
     if (host_start && !host_size) {
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
         if (validate_guest_space(host_start, host_size) == 1) {
-            return host_start;
-        } else {
             return (unsigned long)-1;
         }
+#endif
+        return host_start;
     }
 
     /* Setup the initial flags and start address.  */
@@ -1888,6 +1879,8 @@ unsigned long init_guest_space(unsigned long host_start,
 
         /* Check to see if the address is valid.  */
         if (!host_start || real_start == current_start) {
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+            /* On 32-bit ARM, we need to also be able to map the commpage.  */
             int valid = validate_guest_space(real_start - guest_start,
                                              real_size);
             if (valid == 1) {
@@ -1896,6 +1889,10 @@ unsigned long init_guest_space(unsigned long host_start,
                 return (unsigned long)-1;
             }
             /* valid == 0, so try again. */
+#else
+            /* On other architectures, whatever we have here is fine.  */
+            break;
+#endif
         }
 
         /* That address didn't work.  Unmap and try a different one.
-- 
2.15.1
