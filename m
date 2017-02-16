Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxU-0002fG-3r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxQ-0002Mp-Ti
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:56 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:64456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxQ-0002M3-Ff
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:24 +0100
Message-Id: <20170216142227.27448-12-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/14] linux-user: fix tcg/mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>, Laurent Vivier <laurent@vivier.eu>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

tests/tcg/mmap test fails with values other than default target page
size. When creating a map beyond EOF, extra anonymous pages are added up
to the target page boundary. Currently, this operation is performed only
when qemu_real_host_page_size < TARGET_PAGE_SIZE, but it should be
performed if the configured page size (qemu -p) is larger than
qemu_real_host_page_size too.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[pranith: dropped checkpatch changes]
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170119151533.29328-2-bobby.prani@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4ed9cad..4888f53 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -426,9 +426,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
        may need to truncate file maps at EOF and add extra anonymous pages
        up to the targets page boundary.  */
 
-    if ((qemu_real_host_page_size < TARGET_PAGE_SIZE)
-        && !(flags & MAP_ANONYMOUS)) {
-       struct stat sb;
+    if ((qemu_real_host_page_size < qemu_host_page_size) &&
+        !(flags & MAP_ANONYMOUS)) {
+        struct stat sb;
 
        if (fstat (fd, &sb) == -1)
            goto fail;
-- 
2.9.3
