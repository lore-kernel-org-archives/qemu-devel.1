Received: from eggs.gnu.org ([209.51.188.92]:37929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV8-0002EH-Rd
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV6-0001k3-0H
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:40 +0000
Message-Id: <20190222140756.29834-12-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/27] block/vmdk: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-12-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-12-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/vmdk.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 096e8eb662..41048741cd 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1371,7 +1371,6 @@ static int vmdk_write_extent(VmdkExtent *extent, in=
t64_t cluster_offset,
     VmdkGrainMarker *data =3D NULL;
     uLongf buf_len;
     QEMUIOVector local_qiov;
-    struct iovec iov;
     int64_t write_offset;
     int64_t write_end_sector;
=20
@@ -1399,11 +1398,7 @@ static int vmdk_write_extent(VmdkExtent *extent, i=
nt64_t cluster_offset,
         data->size =3D cpu_to_le32(buf_len);
=20
         n_bytes =3D buf_len + sizeof(VmdkGrainMarker);
-        iov =3D (struct iovec) {
-            .iov_base   =3D data,
-            .iov_len    =3D n_bytes,
-        };
-        qemu_iovec_init_external(&local_qiov, &iov, 1);
+        qemu_iovec_init_buf(&local_qiov, data, n_bytes);
=20
         BLKDBG_EVENT(extent->file, BLKDBG_WRITE_COMPRESSED);
     } else {
--=20
2.20.1
