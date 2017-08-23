Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPB-00065S-Vi
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPA-0007fx-Rl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYPA-0007fk-Iw
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:20 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:57 +0200
Message-Id: <20170823162004.27337-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/27] vhost-user-scsi: don't copy
 iscsi/scsi-lowlevel.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There is no need to include hw/virtio/virtio-scsi.h, then the conflict
with SCSI_XFER enum goes away.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 96 +++----------------------=
------
 1 file changed, 9 insertions(+), 87 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 2ab14f1a83..795799ec14 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -12,8 +12,9 @@
=20
 #include "qemu/osdep.h"
 #include "contrib/libvhost-user/libvhost-user.h"
-#include "hw/virtio/virtio-scsi.h"
+#include "standard-headers/linux/virtio_scsi.h"
 #include "iscsi/iscsi.h"
+#include "iscsi/scsi-lowlevel.h"
=20
 #include <glib.h>
=20
@@ -161,90 +162,11 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd,=
 GIOCondition cond,
                                     (gpointer)(uintptr_t)id);
 }
=20
-/* from libiscsi's scsi-lowlevel.h **
- *
- * nb. We can't directly include scsi-lowlevel.h due to a namespace conf=
lict:
- *     QEMU's scsi.h also defines "SCSI_XFER_NONE".
- */
-
-#define SCSI_CDB_MAX_SIZE           16
-
-struct scsi_iovector {
-    struct scsi_iovec *iov;
-    int niov;
-    int nalloc;
-    size_t offset;
-    int consumed;
-};
-
-struct scsi_allocated_memory {
-    struct scsi_allocated_memory *next;
-    char buf[0];
-};
-
-struct scsi_data {
-    int            size;
-    unsigned char *data;
-};
-
-enum scsi_sense_key {
-    SCSI_SENSE_NO_SENSE            =3D 0x00,
-    SCSI_SENSE_RECOVERED_ERROR     =3D 0x01,
-    SCSI_SENSE_NOT_READY           =3D 0x02,
-    SCSI_SENSE_MEDIUM_ERROR        =3D 0x03,
-    SCSI_SENSE_HARDWARE_ERROR      =3D 0x04,
-    SCSI_SENSE_ILLEGAL_REQUEST     =3D 0x05,
-    SCSI_SENSE_UNIT_ATTENTION      =3D 0x06,
-    SCSI_SENSE_DATA_PROTECTION     =3D 0x07,
-    SCSI_SENSE_BLANK_CHECK         =3D 0x08,
-    SCSI_SENSE_VENDOR_SPECIFIC     =3D 0x09,
-    SCSI_SENSE_COPY_ABORTED        =3D 0x0a,
-    SCSI_SENSE_COMMAND_ABORTED     =3D 0x0b,
-    SCSI_SENSE_OBSOLETE_ERROR_CODE =3D 0x0c,
-    SCSI_SENSE_OVERFLOW_COMMAND    =3D 0x0d,
-    SCSI_SENSE_MISCOMPARE          =3D 0x0e
-};
-
-struct scsi_sense {
-    unsigned char       error_type;
-    enum scsi_sense_key key;
-    int                 ascq;
-    unsigned            sense_specific:1;
-    unsigned            ill_param_in_cdb:1;
-    unsigned            bit_pointer_valid:1;
-    unsigned char       bit_pointer;
-    uint16_t            field_pointer;
-};
-
-enum scsi_residual {
-    SCSI_RESIDUAL_NO_RESIDUAL =3D 0,
-    SCSI_RESIDUAL_UNDERFLOW,
-    SCSI_RESIDUAL_OVERFLOW
-};
-
-struct scsi_task {
-    int status;
-    int cdb_size;
-    int xfer_dir;
-    int expxferlen;
-    unsigned char cdb[SCSI_CDB_MAX_SIZE];
-    enum scsi_residual residual_status;
-    size_t residual;
-    struct scsi_sense sense;
-    struct scsi_data datain;
-    struct scsi_allocated_memory *mem;
-    void *ptr;
-
-    uint32_t itt;
-    uint32_t cmdsn;
-    uint32_t lun;
-
-    struct scsi_iovector iovector_in;
-    struct scsi_iovector iovector_out;
-};
-
 /** libiscsi integration **/
=20
+typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
+typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
+
 static int vus_iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
 {
     struct iscsi_url *iscsi_url;
@@ -363,12 +285,12 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
     if (!out_len && !in_len) {
         dir =3D SCSI_XFER_NONE;
     } else if (out_len) {
-        dir =3D SCSI_XFER_TO_DEV;
+        dir =3D SCSI_XFER_WRITE;
         for (i =3D 0; i < out_len; i++) {
             len +=3D out[i].iov_len;
         }
     } else {
-        dir =3D SCSI_XFER_FROM_DEV;
+        dir =3D SCSI_XFER_READ;
         for (i =3D 0; i < in_len; i++) {
             len +=3D in[i].iov_len;
         }
@@ -376,10 +298,10 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
=20
     task =3D scsi_task_new(cdb_len, req->cdb, dir, len);
=20
-    if (dir =3D=3D SCSI_XFER_TO_DEV) {
+    if (dir =3D=3D SCSI_XFER_WRITE) {
         task->iovector_out.iov =3D (struct scsi_iovec *)out;
         task->iovector_out.niov =3D out_len;
-    } else if (dir =3D=3D SCSI_XFER_FROM_DEV) {
+    } else if (dir =3D=3D SCSI_XFER_READ) {
         task->iovector_in.iov =3D (struct scsi_iovec *)in;
         task->iovector_in.niov =3D in_len;
     }
--=20
2.14.1.146.gd35faa819
