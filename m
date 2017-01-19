Received: from eggs.gnu.org ([2001:4830:134:3::10]:53702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrd-0008JU-Ew
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrc-0003E1-M7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:38:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 22:38:04 +0800
Message-Id: <20170119143816.21972-5-famz@redhat.com>
In-Reply-To: <20170119143816.21972-1-famz@redhat.com>
References: <20170119143816.21972-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 04/16] qemu-img: Set "share-rw" flag in
 read-only commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

Checking the status of an image when it is being used by guest is
usually useful, and there is no risk of corrupting data, so don't let
the upcoming image locking feature limit this use case.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe..6a091e0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -705,6 +705,10 @@ static int img_check(int argc, char **argv)
         return 1;
     }
 
+    if (!(flags & BDRV_O_RDWR)) {
+        flags |= BDRV_O_SHARE_RW;
+    }
+
     blk = img_open(image_opts, filename, fmt, flags, writethrough, quiet);
     if (!blk) {
         return 1;
@@ -1238,6 +1242,7 @@ static int img_compare(int argc, char **argv)
         goto out3;
     }
 
+    flags |= BDRV_O_SHARE_RW;
     blk1 = img_open(image_opts, filename1, fmt1, flags, writethrough, quiet);
     if (!blk1) {
         ret = 2;
@@ -2286,7 +2291,8 @@ static ImageInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO | BDRV_O_SHARE_RW,
+                       false, false);
         if (!blk) {
             goto err;
         }
@@ -2612,7 +2618,7 @@ static int img_map(int argc, char **argv)
         return 1;
     }
 
-    blk = img_open(image_opts, filename, fmt, 0, false, false);
+    blk = img_open(image_opts, filename, fmt, BDRV_O_SHARE_RW, false, false);
     if (!blk) {
         return 1;
     }
-- 
2.9.3
