Received: from eggs.gnu.org ([209.51.188.92]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT1-0005TB-8o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pT0-0004ur-Dv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:37:31 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 10:37:21 +0100
Message-Id: <20190307093723.655-3-armbru@redhat.com>
In-Reply-To: <20190307093723.655-1-armbru@redhat.com>
References: <20190307093723.655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v6 2/4] hw/block: Pad undersized read-only
 images with 0xFF
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

We reject undersized images.  As of the previous commit, even with a
decent error message.  Still, this is a potentially confusing
stumbling block when you move from using -bios to using -drive
if=3Dpflash,file=3Dblob,format=3Draw,readonly for loading your firmware
code. To mitigate that we automatically pad in the read-only case and
warn the user when we have performed magic to enable things to Just
Work (tm).

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 75ce8ef489..00980316dc 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -759,8 +759,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     if (pfl->blk) {
         /*
          * Validate the backing store is the right size for pflash
-         * devices. If the user supplies a larger file we ignore the
-         * tail.
+         * devices. If the device is read-only we can elide the check
+         * and just pad the region first. If the user supplies a
+         * larger file we ignore the tail.
          */
         int64_t backing_len =3D blk_getlength(pfl->blk);
         if (backing_len < 0) {
@@ -769,10 +770,21 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
         }
=20
         if (backing_len < total_len) {
-            error_setg(errp, "device needs %" PRIu64 " bytes, "
-                       "backing file provides only %" PRIu64 " bytes",
-                       total_len, backing_len);
-            return;
+            if (pfl->ro) {
+                size_t pad_bytes =3D total_len - backing_len;
+                /* pad with NOR erase pattern */
+                memset((uint8_t *)pfl->storage + backing_len,
+                       0xff, pad_bytes);
+                warn_report("device needs %" PRIu64
+                            " bytes, padded with %zu 0xff bytes",
+                            total_len, pad_bytes);
+                total_len =3D backing_len;
+            } else {
+                error_setg(errp, "device needs %" PRIu64 " bytes, "
+                           "backing file provides only %" PRIu64 " bytes=
",
+                           total_len, backing_len);
+                return;
+            }
         } else if (backing_len > total_len) {
             warn_report("device needs %" PRIu64 " bytes, rest ignored",
                         total_len);
--=20
2.17.2
