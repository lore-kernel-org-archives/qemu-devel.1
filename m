Received: from eggs.gnu.org ([2001:4830:134:3::10]:57096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZk-0001BY-Ij
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZe-0002ZX-Vd
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:33 +0200
Message-Id: <20170811140536.2792-5-kwolf@redhat.com>
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] qcow2: Check failure of bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

qcow2_co_pwritev_compressed() should not call bdrv_truncate()
if determining the size failed.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 99407403ea..40ba26c111 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3282,12 +3282,15 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs,=
 uint64_t offset,
     z_stream strm;
     int ret, out_len;
     uint8_t *buf, *out_buf;
-    uint64_t cluster_offset;
+    int64_t cluster_offset;
=20
     if (bytes =3D=3D 0) {
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
         cluster_offset =3D bdrv_getlength(bs->file->bs);
+        if (cluster_offset < 0) {
+            return cluster_offset;
+        }
         return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF=
, NULL);
     }
=20
--=20
2.13.4
