Received: from eggs.gnu.org ([2001:4830:134:3::10]:55550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnog-000068-DC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnod-0007vt-Pr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnod-0007th-Gw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:48 +0100
Message-Id: <20180313173355.4468-12-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/18] linux-user: Rename validate_guest_space
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Luke Shumaker <lukeshu@parabola.nu>

From: Luke Shumaker <lukeshu@parabola.nu>

init_guest_commpage is a much more honest description of what the function
does.  validate_guest_space not only suggests that the function has no
side-effects, but also introduces confusion as to why it is only needed on
32-bit ARM targets.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
Message-Id: <20171228180814.9749-3-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7aebc21c04..eaa52afe79 100644
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
 
@@ -1810,7 +1810,7 @@ unsigned long init_guest_space(unsigned long host_start,
      * address.  */
     if (host_start && !host_size) {
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-        if (validate_guest_space(host_start, host_size) != 1) {
+        if (init_guest_commpage(host_start, host_size) != 1) {
             return (unsigned long)-1;
         }
 #endif
@@ -1855,8 +1855,8 @@ unsigned long init_guest_space(unsigned long host_start,
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
2.14.3
