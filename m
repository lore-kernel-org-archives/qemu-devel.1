Received: from eggs.gnu.org ([2001:4830:134:3::10]:45979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YR-0002L5-O6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YP-0000qf-NM
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:27:59 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:26:57 +0100
Message-Id: <20181212132735.16080-4-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/41] dmg: including dmg-lzfse module inside
 dmg block driver.
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

From: Julio Faracco <jcfaracco@gmail.com>

This commit includes the support to new module dmg-lzfse into dmg block
driver. It includes the support for block type ULFO (0x80000007).

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/dmg.h |  3 +++
 block/dmg.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/block/dmg.h b/block/dmg.h
index 2ecf239ba5..f28929998f 100644
--- a/block/dmg.h
+++ b/block/dmg.h
@@ -55,4 +55,7 @@ typedef struct BDRVDMGState {
 extern int (*dmg_uncompress_bz2)(char *next_in, unsigned int avail_in,
                                  char *next_out, unsigned int avail_out)=
;
=20
+extern int (*dmg_uncompress_lzfse)(char *next_in, unsigned int avail_in,
+                                   char *next_out, unsigned int avail_ou=
t);
+
 #endif
diff --git a/block/dmg.c b/block/dmg.c
index 1d9283ba2f..86bb2344ea 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -33,6 +33,9 @@
 int (*dmg_uncompress_bz2)(char *next_in, unsigned int avail_in,
                           char *next_out, unsigned int avail_out);
=20
+int (*dmg_uncompress_lzfse)(char *next_in, unsigned int avail_in,
+                            char *next_out, unsigned int avail_out);
+
 enum {
     /* Limit chunk sizes to prevent unreasonable amounts of memory being=
 used
      * or truncating when converting to 32-bit types
@@ -107,6 +110,7 @@ static void update_max_chunk_size(BDRVDMGState *s, ui=
nt32_t chunk,
     switch (s->types[chunk]) {
     case 0x80000005: /* zlib compressed */
     case 0x80000006: /* bzip2 compressed */
+    case 0x80000007: /* lzfse compressed */
         compressed_size =3D s->lengths[chunk];
         uncompressed_sectors =3D s->sectorcounts[chunk];
         break;
@@ -188,6 +192,8 @@ static bool dmg_is_known_block_type(uint32_t entry_ty=
pe)
         return true;
     case 0x80000006:    /* bzip2 */
         return !!dmg_uncompress_bz2;
+    case 0x80000007:    /* lzfse */
+        return !!dmg_uncompress_lzfse;
     default:
         return false;
     }
@@ -425,6 +431,7 @@ static int dmg_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     }
=20
     block_module_load_one("dmg-bz2");
+    block_module_load_one("dmg-lzfse");
=20
     s->n_chunks =3D 0;
     s->offsets =3D s->lengths =3D s->sectors =3D s->sectorcounts =3D NUL=
L;
@@ -623,6 +630,27 @@ static inline int dmg_read_chunk(BlockDriverState *b=
s, uint64_t sector_num)
                 return ret;
             }
             break;
+        case 0x80000007:
+            if (!dmg_uncompress_lzfse) {
+                break;
+            }
+            /* we need to buffer, because only the chunk as whole can be
+             * inflated. */
+            ret =3D bdrv_pread(bs->file, s->offsets[chunk],
+                             s->compressed_chunk, s->lengths[chunk]);
+            if (ret !=3D s->lengths[chunk]) {
+                return -1;
+            }
+
+            ret =3D dmg_uncompress_lzfse((char *)s->compressed_chunk,
+                                       (unsigned int) s->lengths[chunk],
+                                       (char *)s->uncompressed_chunk,
+                                       (unsigned int)
+                                           (512 * s->sectorcounts[chunk]=
));
+            if (ret < 0) {
+                return ret;
+            }
+            break;
         case 1: /* copy */
             ret =3D bdrv_pread(bs->file, s->offsets[chunk],
                              s->uncompressed_chunk, s->lengths[chunk]);
--=20
2.19.2
