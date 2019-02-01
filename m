Received: from eggs.gnu.org ([209.51.188.92]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboO-000849-2L
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboK-0000I9-A8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:18 +0100
Message-Id: <20190201163518.31157-28-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/27] scsi-disk: Add device_id property
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

The new device_id property specifies which value to use for the vendor
specific designator in the Device Identification VPD page.

In particular, this is necessary for libvirt to maintain guest ABI
compatibility when no serial number is given and a VM is switched from
-drive (where the BlockBackend name is used) to -blockdev (where the
vendor specific designator is left out by default).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/scsi/scsi-disk.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 11392a8db8..e6db6d7c15 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -104,6 +104,7 @@ typedef struct SCSIDiskState
     char *serial;
     char *vendor;
     char *product;
+    char *device_id;
     bool tray_open;
     bool tray_locked;
     /*
@@ -642,13 +643,8 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *r=
eq, uint8_t *outbuf)
=20
     case 0x83: /* Device identification page, mandatory */
     {
-        const char *str =3D s->serial ?: blk_name(s->qdev.conf.blk);
-        int max_len =3D s->serial ? 20 : 255 - 8;
-        int id_len =3D strlen(str);
+        int id_len =3D s->device_id ? MIN(strlen(s->device_id), 255 - 8)=
 : 0;
=20
-        if (id_len > max_len) {
-            id_len =3D max_len;
-        }
         DPRINTF("Inquiry EVPD[Device identification] "
                 "buffer size %zd\n", req->cmd.xfer);
=20
@@ -657,7 +653,7 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *re=
q, uint8_t *outbuf)
             outbuf[buflen++] =3D 0;   /* not officially assigned */
             outbuf[buflen++] =3D 0;   /* reserved */
             outbuf[buflen++] =3D id_len; /* length of data following */
-            memcpy(outbuf + buflen, str, id_len);
+            memcpy(outbuf + buflen, s->device_id, id_len);
             buflen +=3D id_len;
         }
=20
@@ -2363,6 +2359,16 @@ static void scsi_realize(SCSIDevice *dev, Error **=
errp)
     if (!s->vendor) {
         s->vendor =3D g_strdup("QEMU");
     }
+    if (!s->device_id) {
+        if (s->serial) {
+            s->device_id =3D g_strdup_printf("%.20s", s->serial);
+        } else {
+            const char *str =3D blk_name(s->qdev.conf.blk);
+            if (str && *str) {
+                s->device_id =3D g_strdup(str);
+            }
+        }
+    }
=20
     if (blk_is_sg(s->qdev.conf.blk)) {
         error_setg(errp, "unwanted /dev/sg*");
@@ -2921,7 +2927,9 @@ static const TypeInfo scsi_disk_base_info =3D {
     DEFINE_PROP_STRING("ver", SCSIDiskState, version),               \
     DEFINE_PROP_STRING("serial", SCSIDiskState, serial),             \
     DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),             \
-    DEFINE_PROP_STRING("product", SCSIDiskState, product)
+    DEFINE_PROP_STRING("product", SCSIDiskState, product),           \
+    DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id)
+
=20
 static Property scsi_hd_properties[] =3D {
     DEFINE_SCSI_DISK_PROPERTIES(),
--=20
2.20.1
