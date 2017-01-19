Received: from eggs.gnu.org ([2001:4830:134:3::10]:34581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUERA-0006St-7u
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUER7-0006K8-OA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:15:40 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:35769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cUER7-0006GN-Jd
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:15:37 -0500
Received: by mail-yw0-x243.google.com with SMTP id 17so4651256ywk.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 07:15:35 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 19 Jan 2017 10:15:33 -0500
Message-Id: <20170119151533.29328-2-bobby.prani@gmail.com>
In-Reply-To: <20170119151533.29328-1-bobby.prani@gmail.com>
References: <20170119151533.29328-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 2/2] linux-user: fix tcg/mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org, laurent@vivier.eu, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
---
 linux-user/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 61685bf79e..76905cc9fd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -429,9 +429,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
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
2.11.0
