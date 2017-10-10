Received: from eggs.gnu.org ([2001:4830:134:3::10]:34313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1unn-0002Fv-V7
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1unk-0006Xu-0i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:42:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37197 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1unj-0006XH-LY
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:42:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 10 Oct 2017 16:42:05 +0300
Message-Id: <20171010134205.6120-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH RFC] file-posix: make lock_fd read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, berrange@redhat.com, eblake@redhat.com

We do not reopen lock_fd on bdrv_reopen which leads to problems on
reopen image RO. So, lets make lock_fd be always RO.
This is correct, because qemu_lock_fd always called with exclusive=false
on lock_fd.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

We've faced the following problem with our shared-storage migration
scheme. We make an external snapshot and need base image to be reopened
RO. However, bdrv_reopen reopens only .fd of BDRVRawState but not
.lock_fd. So, .lock_fd is left opened RW and this breaks the whole
thing.

The simple fix is here: let's just open lock_fd as RO always. This
looks fine for current code, as we never try to set write locks
(qemu_lock_fd always called with exclusive=false).

However it will not work if we are going to use write locks.


 block/file-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e940..5c52df9174 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -514,7 +514,8 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     s->lock_fd = -1;
     if (s->use_lock) {
-        fd = qemu_open(filename, s->open_flags);
+        /* open it read-only, as we do not reopen it on bdrv_reopen */
+        fd = qemu_open(filename, (s->open_flags & ~BDRV_O_RDWR));
         if (fd < 0) {
             ret = -errno;
             error_setg_errno(errp, errno, "Could not open '%s' for locking",
-- 
2.11.1
