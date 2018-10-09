Received: from eggs.gnu.org ([2001:4830:134:3::10]:59692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xnG-0001fI-0G
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xnD-0007K0-Ep
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  9 Oct 2018 21:35:24 +0200
Message-Id: <20181009193524.19052-5-kwolf@redhat.com>
In-Reply-To: <20181009193524.19052-1-kwolf@redhat.com>
References: <20181009193524.19052-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] file-posix: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If read-only=off, but auto-read-only=on are given, open the file
read-write if we have the permissions, but instead of erroring out for
read-only files, just degrade to read-only.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2da3a76355..69b312a3a3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -450,6 +450,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     int fd, ret;
     struct stat st;
     OnOffAuto locking;
+    bool auto_readonly = bdrv_flags & BDRV_O_AUTO_RDONLY;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -527,6 +528,18 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     s->fd = -1;
     fd = qemu_open(filename, s->open_flags, 0644);
+
+    if (auto_readonly && fd < 0 && (errno == EACCES || errno == EROFS)) {
+        ret = bdrv_set_read_only(bs, true, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+        bdrv_flags &= ~BDRV_O_RDWR;
+        raw_parse_flags(bdrv_flags, &s->open_flags);
+        assert(!(s->open_flags & O_CREAT));
+        fd = qemu_open(filename, s->open_flags);
+    }
+
     if (fd < 0) {
         ret = -errno;
         error_setg_errno(errp, errno, "Could not open '%s'", filename);
-- 
2.13.6
