Received: from eggs.gnu.org ([2001:4830:134:3::10]:55504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoe-0008WU-Jp
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnod-0007vY-IA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnod-0007ti-3Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:47 +0100
Message-Id: <20180313173355.4468-11-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 10/18] linux-user: Use #if to only call
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Luke Shumaker <lukeshu@parabola.nu>

From: Luke Shumaker <lukeshu@parabola.nu>

Instead of defining a bogus validate_guest_space that always returns 1 on
targets other than 32-bit ARM, use #if blocks to only call it on 32-bit ARM
targets.  This makes the "normal" flow control clearer.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
Message-Id: <20171228180814.9749-2-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[lv: fix condition to "!= 1" as requested by Peter]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 85462d30db..7aebc21c04 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -354,7 +354,6 @@ enum {
 
 /* The commpage only exists for 32 bit kernels */
 
-#define TARGET_HAS_VALIDATE_GUEST_SPACE
 /* Return 1 if the proposed guest space is suitable for the guest.
  * Return 0 if the proposed guest space isn't suitable, but another
  * address space should be tried.
@@ -1797,15 +1796,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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
@@ -1819,11 +1809,12 @@ unsigned long init_guest_space(unsigned long host_start,
     /* If just a starting address is given, then just verify that
      * address.  */
     if (host_start && !host_size) {
-        if (validate_guest_space(host_start, host_size) == 1) {
-            return host_start;
-        } else {
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+        if (validate_guest_space(host_start, host_size) != 1) {
             return (unsigned long)-1;
         }
+#endif
+        return host_start;
     }
 
     /* Setup the initial flags and start address.  */
@@ -1862,6 +1853,8 @@ unsigned long init_guest_space(unsigned long host_start,
 
         /* Check to see if the address is valid.  */
         if (!host_start || real_start == current_start) {
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+            /* On 32-bit ARM, we need to also be able to map the commpage.  */
             int valid = validate_guest_space(real_start - guest_start,
                                              real_size);
             if (valid == 1) {
@@ -1870,6 +1863,10 @@ unsigned long init_guest_space(unsigned long host_start,
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
2.14.3
