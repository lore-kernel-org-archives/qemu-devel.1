Received: from eggs.gnu.org ([209.51.188.92]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqz-0002Ji-5L
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqx-00033J-L2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:01 +0200
Message-Id: <20190402124907.24421-4-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] block/gluster: limit the transfer size to
 512 MiB
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

From: Stefano Garzarella <sgarzare@redhat.com>

Several versions of GlusterFS (3.12? -> 6.0.1) fail when the
transfer size is greater or equal to 1024 MiB, so we are
limiting the transfer size to 512 MiB to avoid this rare issue.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1691320
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/gluster.c b/block/gluster.c
index 51f184cbd8..e664ca4462 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <glusterfs/api/glfs.h>
 #include "block/block_int.h"
 #include "block/qdict.h"
@@ -41,6 +42,12 @@
 #define GLUSTER_DEBUG_MAX           9
 #define GLUSTER_OPT_LOGFILE         "logfile"
 #define GLUSTER_LOGFILE_DEFAULT     "-" /* handled in libgfapi as /dev/s=
tderr */
+/*
+ * Several versions of GlusterFS (3.12? -> 6.0.1) fail when the transfer=
 size
+ * is greater or equal to 1024 MiB, so we are limiting the transfer size=
 to 512
+ * MiB to avoid this rare issue.
+ */
+#define GLUSTER_MAX_TRANSFER        (512 * MiB)
=20
 #define GERR_INDEX_HINT "hint: check in 'server' array index '%d'\n"
=20
@@ -887,6 +894,11 @@ out:
     return ret;
 }
=20
+static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error **er=
rp)
+{
+    bs->bl.max_transfer =3D GLUSTER_MAX_TRANSFER;
+}
+
 static int qemu_gluster_reopen_prepare(BDRVReopenState *state,
                                        BlockReopenQueue *queue, Error **=
errp)
 {
@@ -1544,6 +1556,7 @@ static BlockDriver bdrv_gluster =3D {
     .bdrv_co_pwrite_zeroes        =3D qemu_gluster_co_pwrite_zeroes,
 #endif
     .bdrv_co_block_status         =3D qemu_gluster_co_block_status,
+    .bdrv_refresh_limits          =3D qemu_gluster_refresh_limits,
     .create_opts                  =3D &qemu_gluster_create_opts,
     .strong_runtime_opts          =3D gluster_strong_open_opts,
 };
@@ -1574,6 +1587,7 @@ static BlockDriver bdrv_gluster_tcp =3D {
     .bdrv_co_pwrite_zeroes        =3D qemu_gluster_co_pwrite_zeroes,
 #endif
     .bdrv_co_block_status         =3D qemu_gluster_co_block_status,
+    .bdrv_refresh_limits          =3D qemu_gluster_refresh_limits,
     .create_opts                  =3D &qemu_gluster_create_opts,
     .strong_runtime_opts          =3D gluster_strong_open_opts,
 };
@@ -1604,6 +1618,7 @@ static BlockDriver bdrv_gluster_unix =3D {
     .bdrv_co_pwrite_zeroes        =3D qemu_gluster_co_pwrite_zeroes,
 #endif
     .bdrv_co_block_status         =3D qemu_gluster_co_block_status,
+    .bdrv_refresh_limits          =3D qemu_gluster_refresh_limits,
     .create_opts                  =3D &qemu_gluster_create_opts,
     .strong_runtime_opts          =3D gluster_strong_open_opts,
 };
@@ -1640,6 +1655,7 @@ static BlockDriver bdrv_gluster_rdma =3D {
     .bdrv_co_pwrite_zeroes        =3D qemu_gluster_co_pwrite_zeroes,
 #endif
     .bdrv_co_block_status         =3D qemu_gluster_co_block_status,
+    .bdrv_refresh_limits          =3D qemu_gluster_refresh_limits,
     .create_opts                  =3D &qemu_gluster_create_opts,
     .strong_runtime_opts          =3D gluster_strong_open_opts,
 };
--=20
2.20.1
