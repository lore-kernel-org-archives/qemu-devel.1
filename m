Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF2-00020X-8Q
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF0-0000XP-N7
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 30 Jul 2018 00:27:44 +0300
Message-Id: <20180729212744.23709-7-lbloch@janustech.com>
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 6/6] qcow2: Resize the cache upon image resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

The caches are now recalculated upon image resizing. This is done
because the new default behavior of assigning a sufficient L2 cache to
cover the entire image implies that the cache will still be sufficient
after image resizing. To put a limit on the cache, the options
cache-size and l2-cache-size can be used.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 74f2cb10a4..06fac1bb8c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3656,6 +3656,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     s->l1_vm_state_index = new_l1_size;
+    /* Update cache sizes */
+    QDict *options = qdict_clone_shallow(bs->options);
+    ret = qcow2_update_options(bs, options, s->flags, errp);
+    if (ret < 0) {
+        goto fail;
+    }
     ret = 0;
 fail:
     qemu_co_mutex_unlock(&s->lock);
-- 
2.17.1
