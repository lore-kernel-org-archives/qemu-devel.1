Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQFD-0003QX-Ej
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkQFA-0006et-0L
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:03 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkQF9-0006di-NN
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:42:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 31 Jul 2018 10:42:01 +0200
Message-Id: <20180731084203.29959-2-laurent@vivier.eu>
In-Reply-To: <20180731084203.29959-1-laurent@vivier.eu>
References: <20180731084203.29959-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/3] linux-user/mmap.c: handle invalid len maps
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, umarcor <1783362@bugs.launchpad.net>

From: Alex Bennée <alex.bennee@linaro.org>

I've slightly re-organised the check to more closely match the
sequence that the kernel uses in do_mmap(). We check for both the zero
case (EINVAL) and the overflow length case (ENOMEM).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: umarcor <1783362@bugs.launchpad.net>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180730134321.19898-2-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d0c50e4888..41e0983ce8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -391,14 +391,23 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     }
 #endif
 
-    if (offset & ~TARGET_PAGE_MASK) {
+    if (!len) {
         errno = EINVAL;
         goto fail;
     }
 
+    /* Also check for overflows... */
     len = TARGET_PAGE_ALIGN(len);
-    if (len == 0)
-        goto the_end;
+    if (!len) {
+        errno = ENOMEM;
+        goto fail;
+    }
+
+    if (offset & ~TARGET_PAGE_MASK) {
+        errno = EINVAL;
+        goto fail;
+    }
+
     real_start = start & qemu_host_page_mask;
     host_offset = offset & qemu_host_page_mask;
 
-- 
2.17.1
