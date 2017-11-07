Received: from eggs.gnu.org ([2001:4830:134:3::10]:53956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfq-0000vP-Ax
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfo-00081p-8i
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:34 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  6 Nov 2017 21:31:19 -0500
Message-Id: <659e4cdba6ef4c651737852777c8c93d27b38040.1510021573.git.jcody@redhat.com>
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
References: <cover.1510021573.git.jcody@redhat.com>
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
References: <cover.1510021573.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] block/vhdx.c: Don't blindly update the
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
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 7ae4589..9956933 100644
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
2.9.5
