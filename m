Received: from eggs.gnu.org ([209.51.188.92]:60093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h28wN-00007l-3g
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h28wM-00038R-57
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:25:07 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 07:24:55 +0100
Message-Id: <20190308062455.29755-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7] pflash: Require backend size to match
 device, improve errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, philmd@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

We reject undersized backends with a rather enigmatic "failed to read
the initial flash content" error.

We happily accept oversized images, ignoring their tail.  Throwing
away parts of firmware that way is pretty much certain to end in an
even more enigmatic failure to boot.

Require the backend's size to match the device's size exactly.  Report
mismatch as "device requires N bytes, block backend 'NAME' provides M
bytes".

Improve the error for actual read failures to "can't read initial
flash content from block backend 'NAME'.

We disabled code to limit device sizes to 8, 16, 32 or 64MiB more than
a decade ago in commit 95d1f3edd5e and c8b153d7949, v0.9.1.  Bury.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c | 31 ++++++++++++++++++++++---------
 hw/block/pflash_cfi02.c | 31 +++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9d1c356eb6..2e3a05c0b3 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -730,13 +730,6 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
     }
     device_len =3D sector_len_per_device * blocks_per_device;
=20
-    /* XXX: to be fixed */
-#if 0
-    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 * =
1024) &&
-        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024 *=
 1024))
-        return NULL;
-#endif
-
     memory_region_init_rom_device(
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
@@ -763,12 +756,32 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
     }
=20
     if (pfl->blk) {
+        /*
+         * Validate the backing store is the right size for pflash
+         * devices. If the user supplies a larger file we ignore the
+         * tail.
+         */
+        int64_t backing_len =3D blk_getlength(pfl->blk);
+
+        if (backing_len < 0) {
+            error_setg(errp, "can't get size of block backend '%s'",
+                       blk_name(pfl->blk));
+            return;
+        }
+        if (backing_len !=3D total_len) {
+            error_setg(errp, "device requires %" PRIu64 " bytes, "
+                       "block backend '%s' provides %" PRIu64 " bytes",
+                       total_len, blk_name(pfl->blk), backing_len);
+            return;
+        }
+
         /* read the initial flash content */
         ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
-
         if (ret < 0) {
             vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
-            error_setg(errp, "failed to read the initial flash content")=
;
+            error_setg(errp, "can't read initial flash content"
+                       " from block backend '%s'",
+                       blk_name(pfl->blk));
             return;
         }
     }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 33779ce807..45b88d65d8 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -550,12 +550,6 @@ static void pflash_cfi02_realize(DeviceState *dev, E=
rror **errp)
     }
=20
     chip_len =3D pfl->sector_len * pfl->nb_blocs;
-    /* XXX: to be fixed */
-#if 0
-    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 * =
1024) &&
-        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024 *=
 1024))
-        return NULL;
-#endif
=20
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
                                   &pflash_cfi02_ops_be : &pflash_cfi02_o=
ps_le,
@@ -581,11 +575,32 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
     }
=20
     if (pfl->blk) {
+        /*
+         * Validate the backing store is the right size for pflash
+         * devices. If the user supplies a larger file we ignore the
+         * tail.
+         */
+        int64_t backing_len =3D blk_getlength(pfl->blk);
+
+        if (backing_len < 0) {
+            error_setg(errp, "can't get size of block backend '%s'",
+                       blk_name(pfl->blk));
+            return;
+        }
+        if (backing_len !=3D chip_len) {
+            error_setg(errp, "device requires %" PRIu32 " bytes, "
+                       "block backend '%s' provides %" PRIu64 " bytes",
+                       chip_len, blk_name(pfl->blk), backing_len);
+            return;
+        }
+
         /* read the initial flash content */
         ret =3D blk_pread(pfl->blk, 0, pfl->storage, chip_len);
         if (ret < 0) {
-            vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
-            error_setg(errp, "failed to read the initial flash content")=
;
+            vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
+            error_setg(errp, "can't read initial flash content"
+                       " from block backend '%s'",
+                       blk_name(pfl->blk));
             return;
         }
     }
--=20
2.17.2
