Received: from eggs.gnu.org ([2001:4830:134:3::10]:42306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52G-00009X-97
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52B-00020l-GS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:24 +0200
Message-Id: <20170808135838.11525-5-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/18] block/vhdx: check for offset overflow to
 bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Jeff Cody <jcody@redhat.com>

VHDX uses uint64_t types for most offsets, following the VHDX spec.
However, bdrv_truncate() takes an int64_t value for the truncating
offset.  Check for overflow before calling bdrv_truncate().

While we are here, replace the bit shifting with QEMU_ALIGN_UP as well.

N.B.: For a compliant image this is not an issue, as the maximum VHDX
image size is defined per the spec to be 64TB.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx-log.c | 6 +++++-
 block/vhdx.c     | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 2e26fd46a5..95972230f0 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -553,7 +553,11 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRV=
VHDXState *s,
             new_file_size =3D desc_entries->hdr.last_file_offset;
             if (new_file_size % (1024*1024)) {
                 /* round up to nearest 1MB boundary */
-                new_file_size =3D ((new_file_size >> 20) + 1) << 20;
+                new_file_size =3D QEMU_ALIGN_UP(new_file_size, MiB);
+                if (new_file_size > INT64_MAX) {
+                    ret =3D -EINVAL;
+                    goto exit;
+                }
                 bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF=
, NULL);
             }
         }
diff --git a/block/vhdx.c b/block/vhdx.c
index 37224b8858..7ae4589879 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1177,6 +1177,9 @@ static int vhdx_allocate_block(BlockDriverState *bs=
, BDRVVHDXState *s,
=20
     /* per the spec, the address for a block is in units of 1MB */
     *new_offset =3D ROUND_UP(*new_offset, 1024 * 1024);
+    if (*new_offset > INT64_MAX) {
+        return -EINVAL;
+    }
=20
     return bdrv_truncate(bs->file, *new_offset + s->block_size,
                          PREALLOC_MODE_OFF, NULL);
--=20
2.13.4
