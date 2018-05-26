Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgC-00063r-NL
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRg9-0004Bz-Jb
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:23:48 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRg9-0004BU-Ed
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:23:45 -0400
Received: by mail-qk0-x233.google.com with SMTP id c23-v6so5675037qkb.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:23:45 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:03 -0400
Message-Id: <b8019eac434b2e61813a2061090d85401c6c44c4.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 01/13] 9p: linux: Fix a couple Linux assumptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

 - Guard two Linux only headers.
 - Define `ENOATTR` only if not only defined
   (it's defined in system headers on Darwin).

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 fsdev/file-op-9p.h   | 2 ++
 hw/9pfs/9p-local.c   | 2 ++
 include/qemu/xattr.h | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 3fa062b..a13e729 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -16,7 +16,9 @@
 
 #include <dirent.h>
 #include <utime.h>
+#ifdef CONFIG_LINUX
 #include <sys/vfs.h>
+#endif
 #include "qemu-fsdev-throttle.h"
 
 #define SM_LOCAL_MODE_BITS    0600
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index b37b1db..f6c7526 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -27,10 +27,12 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include <libgen.h>
+#ifdef CONFIG_LINUX
 #include <linux/fs.h>
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
 #endif
+#endif
 #include <sys/ioctl.h>
 
 #ifndef XFS_SUPER_MAGIC
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index a83fe8e..f1d0f7b 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -22,7 +22,9 @@
 #ifdef CONFIG_LIBATTR
 #  include <attr/xattr.h>
 #else
-#  define ENOATTR ENODATA
+#  if !defined(ENOATTR)
+#    define ENOATTR ENODATA
+#  endif
 #  include <sys/xattr.h>
 #endif
 
-- 
2.8.1
