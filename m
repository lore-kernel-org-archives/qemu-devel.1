Received: from eggs.gnu.org ([2001:4830:134:3::10]:36313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA1-0001fc-2E
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA0-0006wT-6L
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:19 +0200
Message-Id: <1494513181-7900-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/58] file-win32: Error out if locking=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

We share the same set of QAPI options with file-posix, but locking is
not supported here. So error out if it is specified as 'on' for now.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-win32.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/file-win32.c b/block/file-win32.c
index d1eb0a1..1a35dba 100644
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
1.8.3.1
