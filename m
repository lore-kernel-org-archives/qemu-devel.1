Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5ano-0004P5-Bu
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5ann-0000lQ-Li
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:28 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:51 +0800
Message-Id: <20170502163558.7611-17-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 16/23] file-win32: Error out if locking=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

We share the same set of QAPI options with file-posix, but locking is
not supported here. So error out if it is specified as 'on' for now.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-win32.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/file-win32.c b/block/file-win32.c
index 7872e00..534021b 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -344,6 +344,11 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    if (qdict_get_try_bool(options, "locking", false)) {
+        error_setg(errp, "locking=on is not supported on Windows");
+        goto fail;
+    }
+
     filename = qemu_opt_get(opts, "filename");
 
     use_aio = get_aio_option(opts, flags, &local_err);
-- 
2.9.3
