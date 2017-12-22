Received: from eggs.gnu.org ([2001:4830:134:3::10]:56714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6B-0005Ft-1Q
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP69-0001pV-UB
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:18:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:12 +0100
Message-Id: <20171222151846.28110-2-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 01/35] block: Formats don't need
 CONSISTENT_READ with NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Commit 1f4ad7d fixed 'qemu-img info' for raw images that are currently
in use as a mirror target. It is not enough for image formats, though,
as these still unconditionally request BLK_PERM_CONSISTENT_READ.

As this permission is geared towards whether the guest-visible data is
consistent, and has no impact on whether the metadata is sane, and
'qemu-img info' does not read guest-visible data (except for the raw
format), it makes sense to not require BLK_PERM_CONSISTENT_READ if there
is not going to be any guest I/O performed, regardless of image format.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1c37ce4554..db0be7ef36 100644
--- a/block.c
+++ b/block.c
@@ -1924,6 +1924,8 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
     assert(role == &child_backing || role == &child_file);
 
     if (!backing) {
+        int flags = bdrv_reopen_get_flags(reopen_queue, bs);
+
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
         bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
@@ -1936,7 +1938,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
 
         /* bs->file always needs to be consistent because of the metadata. We
          * can never allow other users to resize or write to it. */
-        perm |= BLK_PERM_CONSISTENT_READ;
+        if (!(flags & BDRV_O_NO_IO)) {
+            perm |= BLK_PERM_CONSISTENT_READ;
+        }
         shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
     } else {
         /* We want consistent read from backing files if the parent needs it.
-- 
2.13.6
