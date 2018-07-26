Received: from eggs.gnu.org ([2001:4830:134:3::10]:50795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1figL3-0004Oy-WB
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1figL1-0004G6-0r
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:54 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1figL0-0004Dx-Pk
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:50 -0400
Received: by mail-wm0-x241.google.com with SMTP id h20-v6so2005017wmb.4
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 06:29:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 26 Jul 2018 14:29:46 +0100
Message-Id: <20180726132947.28538-2-alex.bennee@linaro.org>
In-Reply-To: <20180726132947.28538-1-alex.bennee@linaro.org>
References: <20180726132947.28538-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 for 3.0 1/2] linux-user/mmap.c: handle len =
 0 maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, umarcor <1783362@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

I've slightly re-organised the check to more closely match the
sequence that the kernel uses in do_mmap().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: umarcor <1783362@bugs.launchpad.net>
---
 linux-user/mmap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d0c50e4888..3ef69fa2d0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -391,14 +391,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     }
 #endif
 
-    if (offset & ~TARGET_PAGE_MASK) {
+    if (!len) {
         errno = EINVAL;
         goto fail;
     }
 
     len = TARGET_PAGE_ALIGN(len);
-    if (len == 0)
-        goto the_end;
+    if (!len) {
+        errno = EINVAL;
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
