Received: from eggs.gnu.org ([2001:4830:134:3::10]:60111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082o-Gz
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006zC-Bi
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:37 +0300
Message-Id: <599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 6/9] file-posix: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The file-posix code is used for the "file", "host_device" and
"host_cdrom" drivers, and it allows reopening images. However the only
option that is actually processed is "x-check-cache-dropped", and
changes in all other options (e.g. "filename") are silently ignored:

   (qemu) qemu-io virtio0 "reopen -o file.filename=no-such-file"

While we could allow changing some of the other options, let's keep
things as they are for now but return an error if the user tries to
change any of them.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ddac0cc3e6..d4ec2cb3dd 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -850,8 +850,13 @@ static int raw_reopen_prepare(BDRVReopenState *state,
         goto out;
     }
 
-    rs->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
-                                                false);
+    rs->check_cache_dropped =
+        qemu_opt_get_bool_del(opts, "x-check-cache-dropped", false);
+
+    /* This driver's reopen function doesn't currently allow changing
+     * other options, so let's put them back in the original QDict and
+     * bdrv_reopen_prepare() will detect changes and complain. */
+    qemu_opts_to_qdict(opts, state->options);
 
     if (s->type == FTYPE_CD) {
         rs->open_flags |= O_NONBLOCK;
-- 
2.11.0
