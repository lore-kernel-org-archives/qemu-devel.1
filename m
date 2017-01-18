Received: from eggs.gnu.org ([2001:4830:134:3::10]:48830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTrl6-00043g-89
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTrl3-0001yL-T0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:44 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:33341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cTrl3-0001xz-ON
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:41 -0500
Received: by mail-yb0-x242.google.com with SMTP id 123so609924ybe.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 07:02:40 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 18 Jan 2017 10:02:35 -0500
Message-Id: <20170118150235.23850-2-bobby.prani@gmail.com>
In-Reply-To: <20170118150235.23850-1-bobby.prani@gmail.com>
References: <20170118150235.23850-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] linux-user: fix tcg/mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

tests/tcg/mmap test fails with values other than default target page
size. When creating a map beyond EOF, extra anonymous pages are added up
to the target page boundary. Currently, this operation is performed only
when qemu_real_host_page_size < TARGET_PAGE_SIZE, but it should be
performed if the configured page size (qemu -p) is larger than
qemu_real_host_page_size too.

(also fixes some style issues to please checkpatch)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 linux-user/mmap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 61685bf79e..0794a4396a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -418,31 +418,32 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     }
 
     /* When mapping files into a memory area larger than the file, accesses
-       to pages beyond the file size will cause a SIGBUS. 
+       to pages beyond the file size will cause a SIGBUS.
 
        For example, if mmaping a file of 100 bytes on a host with 4K pages
        emulating a target with 8K pages, the target expects to be able to
        access the first 8K. But the host will trap us on any access beyond
-       4K.  
+       4K.
 
        When emulating a target with a larger page-size than the hosts, we
        may need to truncate file maps at EOF and add extra anonymous pages
        up to the targets page boundary.  */
 
-    if ((qemu_real_host_page_size < TARGET_PAGE_SIZE)
-        && !(flags & MAP_ANONYMOUS)) {
-       struct stat sb;
+    if ((qemu_real_host_page_size < qemu_host_page_size) &&
+        !(flags & MAP_ANONYMOUS)) {
+        struct stat sb;
 
-       if (fstat (fd, &sb) == -1)
-           goto fail;
+        if (fstat(fd, &sb) == -1) {
+            goto fail;
+        }
 
        /* Are we trying to create a map beyond EOF?.  */
-       if (offset + len > sb.st_size) {
-           /* If so, truncate the file map at eof aligned with 
-              the hosts real pagesize. Additional anonymous maps
-              will be created beyond EOF.  */
-           len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
-       }
+        if (offset + len > sb.st_size) {
+            /* If so, truncate the file map at eof aligned with
+               the hosts real pagesize. Additional anonymous maps
+               will be created beyond EOF.  */
+            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+        }
     }
 
     if (!(flags & MAP_FIXED)) {
-- 
2.11.0
