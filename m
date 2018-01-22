Received: from eggs.gnu.org ([2001:4830:134:3::10]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1edWS5-00064b-Ts
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1edWS5-00028K-4f
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:23:33 -0500
From: Lin Ma <lma@suse.com>
Date: Mon, 22 Jan 2018 15:21:02 +0800
Message-Id: <20180122072102.4141-1-lma@suse.com>
Subject: [Qemu-devel] [PATCH] raw: Disable probing if image format is given
 by driver-specific options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com

If the user specifies image format through driver-specific options, The
format probing should be prohibited and the warning message should not
be printed.

e.g.:
$ qemu-system-x86_64 ... -drive file.file.filename=disk0.raw,file.driver=raw ...
WARNING: Image format was not specified for 'disk0.raw' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, ...

Signed-off-by: Lin Ma <lma@suse.com>
---
 blockdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 29d569a24e..ef4c167235 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -529,6 +529,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
             goto early_err;
         }
         qdict_put_str(bs_opts, "driver", buf);
+    } else if (qdict_haskey(bs_opts, "file.driver")) {
+        qdict_put_str(bs_opts, "driver", qdict_get_str(bs_opts, "file.driver"));
     }
 
     on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
-- 
2.15.1
