Received: from eggs.gnu.org ([209.51.188.92]:54780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT4-0005Wg-Vm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT4-0004yK-66
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:34 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 10:37:20 +0100
Message-Id: <20190307093723.655-2-armbru@redhat.com>
In-Reply-To: <20190307093723.655-1-armbru@redhat.com>
References: <20190307093723.655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v6 1/4] hw/block: better reporting on
 pflash backing file mismatch
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

It looks like there was going to be code to check we had some sort of
alignment so let's replace it with an actual check.  Reject undersized
images with "device needs N bytes, backing file provides only M
bytes".  This is a bit more useful than the enigmatic "failed to read
the initial flash content" when we attempt to read the number of bytes
the device should have.  Continue to accept oversized images, but warn
"device needs N bytes, rest ignored".

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9d1c356eb6..75ce8ef489 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -45,6 +45,7 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
@@ -730,13 +731,6 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
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
@@ -763,6 +757,27 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
     }
=20
     if (pfl->blk) {
+        /*
+         * Validate the backing store is the right size for pflash
+         * devices. If the user supplies a larger file we ignore the
+         * tail.
+         */
+        int64_t backing_len =3D blk_getlength(pfl->blk);
+        if (backing_len < 0) {
+            error_setg(errp, "unable to check size of backing file");
+            return;
+        }
+
+        if (backing_len < total_len) {
+            error_setg(errp, "device needs %" PRIu64 " bytes, "
+                       "backing file provides only %" PRIu64 " bytes",
+                       total_len, backing_len);
+            return;
+        } else if (backing_len > total_len) {
+            warn_report("device needs %" PRIu64 " bytes, rest ignored",
+                        total_len);
+        }
+
         /* read the initial flash content */
         ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
=20
--=20
2.17.2
