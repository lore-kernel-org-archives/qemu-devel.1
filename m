Received: from eggs.gnu.org ([2001:4830:134:3::10]:53126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVM-0000j9-VR
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003nF-1S
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:48:58 +0300
Message-Id: <af0539860d6fa3285a56ece87f18467869d03377.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 01/10] file-posix: Forbid trying to change
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

The file-posix code is used for the "file", "host_device" and
"host_cdrom" drivers, and it allows reopening images. However the only
option that is actually processed is "x-check-cache-dropped", and
changes in all other options (e.g. "filename") are silently ignored.

While we could allow changing some of the other options, let's keep
things as they are for now but return an error if the user tries to
change any of them.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061fe4..1511a4d69d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -813,8 +813,13 @@ static int raw_reopen_prepare(BDRVReopenState *state,
         goto out;
     }
 
-    rs->check_cache_dropped = qemu_opt_get_bool(opts, "x-check-cache-dropped",
-                                                s->check_cache_dropped);
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
