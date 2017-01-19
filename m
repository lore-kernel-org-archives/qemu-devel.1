Received: from eggs.gnu.org ([2001:4830:134:3::10]:50220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUDcT-0003UP-Dt
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUDcR-0004ZH-0d
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:23:17 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cUDcQ-0004Z9-Sm
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:23:14 -0500
Received: by mail-yw0-x242.google.com with SMTP id u68so4412342ywg.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 06:23:14 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 19 Jan 2017 09:23:11 -0500
Message-Id: <20170119142311.8310-2-bobby.prani@gmail.com>
In-Reply-To: <20170119142311.8310-1-bobby.prani@gmail.com>
References: <20170119142311.8310-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/2] linux-user: fix tcg/mmap test
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

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
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
