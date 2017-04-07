Received: from eggs.gnu.org ([2001:4830:134:3::10]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavE-000651-4s
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavD-0003Ss-Ev
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:55:56 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  7 Apr 2017 16:55:27 -0400
Message-Id: <be2e5fb2d285cbece2b6d06bed54a6f56520d251.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 3/8] block: honor BDRV_O_ALLOW_RDWR
 when clearing bs->read_only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com

The BDRV_O_ALLOW_RDWR flag allows / prohibits the changing of
the BDS 'read_only' state, but there are a few places where it
is ignored.  In the bdrv_set_read_only() helper, make sure to
honor the flag.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index c9eb613..68a18b0 100644
--- a/block.c
+++ b/block.c
@@ -201,6 +201,13 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
         return -EINVAL;
     }
 
+    /* Do not clear read_only if it is prohibited */
+    if (!read_only && !(bs->open_flags & BDRV_O_ALLOW_RDWR)) {
+        error_setg(errp, "Node '%s' is read only",
+                   bdrv_get_device_or_node_name(bs));
+        return -EPERM;
+    }
+
     bs->read_only = read_only;
     return 0;
 }
-- 
2.9.3
