Received: from eggs.gnu.org ([2001:4830:134:3::10]:50534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e99qK-00076z-UD
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e99qF-0001la-8k
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:11:04 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 30 Oct 2017 14:10:26 +0100
Message-Id: <8d958396d786b6777c71de1a2138e92ef2915649.1509368614.git.jcody@redhat.com>
In-Reply-To: <cover.1509368614.git.jcody@redhat.com>
References: <cover.1509368614.git.jcody@redhat.com>
In-Reply-To: <cover.1509368614.git.jcody@redhat.com>
References: <cover.1509368614.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] block/vhdx.c: Don't blindly update the
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

The VHDX specification requires that before user data modification of
the vhdx image, the VHDX header file and data GUIDs need to be updated.
In vhdx_open(), if the image is set to RDWR, we go ahead and update the
header.

However, just because the image is set to RDWR does not mean we can go
ahead and write at this point - specifically, if the QEMU run state is
INMIGRATE, the underlying file BS may be set to inactive via the BDS
open flag of BDRV_O_INACTIVE.  Attempting to write under this condition
will cause an assert in bdrv_co_pwritev().

We can alternatively latch the first time the image is written.  And lo
and behold, we do just that, via vhdx_user_visible_write() in
vhdx_co_writev().  This means the call to vhdx_update_headers() in
vhdx_open() is likely just vestigial, and can be removed.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 7ae4589879..9956933da6 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1008,13 +1008,6 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    if (flags & BDRV_O_RDWR) {
-        ret = vhdx_update_headers(bs, s, false, NULL);
-        if (ret < 0) {
-            goto fail;
-        }
-    }
-
     /* TODO: differencing files */
 
     return 0;
-- 
2.13.6
