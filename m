Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cXGDg-0004Ol-6R
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 18:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cXGDd-0005nI-3F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 18:46:16 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1cXGDc-0005mw-Sn
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 18:46:13 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so61519680wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 15:46:11 -0800 (PST)
From: Nir Soffer <nirsof@gmail.com>
Date: Sat, 28 Jan 2017 01:45:54 +0200
Message-Id: <20170127234554.1196-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-img: Do not truncate before preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Nir Soffer <nirsof@gmail.com>

From: Nir Soffer <nsoffer@redhat.com>

When using file system that does not support fallocate(),
posix_fallocate() fallback to emulation mode. In this mode, when
preallocating blocks before file end, posix_preallocate is calling
one pread() and one pwrite() per block. But when preallocation blocks
after file end, it calls only one pwrite per block.

Truncating the file only when preallocation=OFF speeds up creating raw
file in this situation.

Here are example run with without and with this change, tested on Fedora
25 VM, creating a raw image on NFS version 3 mount over 1G nic:

$ time ./qemu-img create -f raw -o preallocation=falloc mnt/test 1g
Formatting 'mnt/test', fmt=raw size=1073741824 preallocation=falloc

real 0m17.083s
user 0m0.020s
sys 0m0.404s

$ rm mnt/test
$ time ./qemu-img create -f raw -o preallocation=falloc mnt/test 1g
Formatting 'mnt/test', fmt=raw size=1073741824 preallocation=falloc

real 0m12.372s
user 0m0.020s
sys 0m0.376s

$ strace ./qemu-img-up create -f raw -o preallocation=falloc mnt/test 8192
...
pread64(9, "\0", 1, 4095)               = 1
pwrite64(9, "\0", 1, 4095)              = 1
pread64(9, "\0", 1, 8191)               = 1
pwrite64(9, "\0", 1, 8191)              = 1

$ strace ./qemu-img-fix create -f raw -o preallocation=falloc mnt/test 8192
...
pwrite64(9, "\0", 1, 4095)              = 1
pwrite64(9, "\0", 1, 8191)              = 1

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/file-posix.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 28b47d9..d7f6129 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1588,12 +1588,6 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 #endif
     }
 
-    if (ftruncate(fd, total_size) != 0) {
-        result = -errno;
-        error_setg_errno(errp, -result, "Could not resize file");
-        goto out_close;
-    }
-
     switch (prealloc) {
 #ifdef CONFIG_POSIX_FALLOCATE
     case PREALLOC_MODE_FALLOC:
@@ -1633,6 +1627,10 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
         break;
     }
     case PREALLOC_MODE_OFF:
+        if (ftruncate(fd, total_size) != 0) {
+            result = -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+        }
         break;
     default:
         result = -EINVAL;
@@ -1641,7 +1639,6 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
         break;
     }
 
-out_close:
     if (qemu_close(fd) != 0 && result == 0) {
         result = -errno;
         error_setg_errno(errp, -result, "Could not close the new file");
-- 
2.9.3
