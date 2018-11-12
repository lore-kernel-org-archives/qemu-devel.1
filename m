Received: from eggs.gnu.org ([2001:4830:134:3::10]:60021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfq-0000lP-Al
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfp-0007JE-EP
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:06:00 +0100
Message-Id: <20181112170603.23986-12-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/14] block: Null pointer dereference in
 blk_root_get_parent_desc()
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

From: Liam Merwick <Liam.Merwick@oracle.com>

The dev_id returned by the call to blk_get_attached_dev_id() in
blk_root_get_parent_desc() can be NULL (an internal call to
object_get_canonical_path may have returned NULL).

Instead of just checking this case before before dereferencing,
adjust blk_get_attached_dev_id() to return the empty string if no
object path can be found (similar to the case when blk->dev is NULL
and an empty string is returned).

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Message-id: 1541453919-25973-3-git-send-email-Liam.Merwick@oracle.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 2a8f3b55f8..60d37a0c3d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -918,7 +918,8 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
     } else if (dev->id) {
         return g_strdup(dev->id);
     }
-    return object_get_canonical_path(OBJECT(dev));
+
+    return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
 }
=20
 /*
--=20
2.19.1
