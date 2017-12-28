Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00083x-TP
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-000131-Nn
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-0000yG-IK
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:23 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:05 -0500
Message-Id: <20171228180814.9749-3-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 02/10] linux-user: Rename validate_guest_space
 => init_guest_commpage
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

init_guest_commpage is a much more honest description of what the function
does.  validate_guest_space not only suggests that the function has no
side-effects, but also introduces confusion as to why it is only needed on
32-bit ARM targets.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cac991159c..453394239c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -362,8 +362,8 @@ enum {
  * The guest code may leave a page mapped and populate it if the
  * address is suitable.
  */
-static int validate_guest_space(unsigned long guest_base,
-                                unsigned long guest_size)
+static int init_guest_commpage(unsigned long guest_base,
+                               unsigned long guest_size)
 {
     unsigned long real_start, test_page_addr;
 
@@ -1836,7 +1836,7 @@ unsigned long init_guest_space(unsigned long host_start,
      * address.  */
     if (host_start && !host_size) {
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-        if (validate_guest_space(host_start, host_size) == 1) {
+        if (init_guest_commpage(host_start, host_size) != 1) {
             return (unsigned long)-1;
         }
 #endif
@@ -1881,8 +1881,8 @@ unsigned long init_guest_space(unsigned long host_start,
         if (!host_start || real_start == current_start) {
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
             /* On 32-bit ARM, we need to also be able to map the commpage.  */
-            int valid = validate_guest_space(real_start - guest_start,
-                                             real_size);
+            int valid = init_guest_commpage(real_start - guest_start,
+                                            real_size);
             if (valid == 1) {
                 break;
             } else if (valid == -1) {
-- 
2.15.1
