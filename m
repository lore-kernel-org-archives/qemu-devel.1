Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ffzos-00068L-Ux
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 23:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ffzos-000345-5N
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 23:41:35 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jul 2018 11:41:18 +0800
Message-Id: <20180719034118.27741-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Don't lock /dev/null and /dev/zero
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On my Fedora 28, /dev/null is locked by some other process (couldn't
inspect it due to the current lslocks limitation), so iotests 226 fails
with some unexpected image locking errors because it uses qemu-io to
open it.

Actually it's safe to not use any lock on /dev/null or /dev/zero.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 60af4b3d51..8bf034108a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         s->use_lock = false;
         break;
     case ON_OFF_AUTO_AUTO:
-        s->use_lock = qemu_has_ofd_lock();
+        if (!strcmp(filename, "/dev/null") ||
+                   !strcmp(filename, "/dev/zero")) {
+            s->use_lock = false;
+        } else {
+            s->use_lock = qemu_has_ofd_lock();
+        }
         break;
     default:
         abort();
-- 
2.17.1
