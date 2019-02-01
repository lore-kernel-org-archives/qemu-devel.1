Received: from eggs.gnu.org ([209.51.188.92]:38894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnu-0007Y4-22
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbns-0008Mc-HA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:33 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:11 +0100
Message-Id: <20190201163518.31157-21-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/27] scsi-disk: Acquire the AioContext in
 scsi_*_realize()
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

From: Alberto Garcia <berto@igalia.com>

This fixes a crash when attaching two disks with the same blockdev to
a SCSI device that is using iothreads. Test case included.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c        | 23 ++++++++++++++++++++---
 tests/qemu-iotests/240     | 18 ++++++++++++++++++
 tests/qemu-iotests/240.out | 16 ++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0e9027c8f3..b049026219 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2381,10 +2381,13 @@ static void scsi_realize(SCSIDevice *dev, Error *=
*errp)
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx =3D NULL;
     /* can happen for devices without drive. The error message for missi=
ng
      * backend will be issued in scsi_realize
      */
     if (s->qdev.conf.blk) {
+        ctx =3D blk_get_aio_context(s->qdev.conf.blk);
+        aio_context_acquire(ctx);
         blkconf_blocksizes(&s->qdev.conf);
     }
     s->qdev.blocksize =3D s->qdev.conf.logical_block_size;
@@ -2393,11 +2396,15 @@ static void scsi_hd_realize(SCSIDevice *dev, Erro=
r **errp)
         s->product =3D g_strdup("QEMU HARDDISK");
     }
     scsi_realize(&s->qdev, errp);
+    if (ctx) {
+        aio_context_release(ctx);
+    }
 }
=20
 static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx;
     int ret;
=20
     if (!dev->conf.blk) {
@@ -2408,6 +2415,8 @@ static void scsi_cd_realize(SCSIDevice *dev, Error =
**errp)
         assert(ret =3D=3D 0);
     }
=20
+    ctx =3D blk_get_aio_context(dev->conf.blk);
+    aio_context_acquire(ctx);
     s->qdev.blocksize =3D 2048;
     s->qdev.type =3D TYPE_ROM;
     s->features |=3D 1 << SCSI_DISK_F_REMOVABLE;
@@ -2415,6 +2424,7 @@ static void scsi_cd_realize(SCSIDevice *dev, Error =
**errp)
         s->product =3D g_strdup("QEMU CD-ROM");
     }
     scsi_realize(&s->qdev, errp);
+    aio_context_release(ctx);
 }
=20
 static void scsi_disk_realize(SCSIDevice *dev, Error **errp)
@@ -2553,6 +2563,7 @@ static int get_device_type(SCSIDiskState *s)
 static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, dev);
+    AioContext *ctx;
     int sg_version;
     int rc;
=20
@@ -2567,6 +2578,9 @@ static void scsi_block_realize(SCSIDevice *dev, Err=
or **errp)
                           "be removed in a future version");
     }
=20
+    ctx =3D blk_get_aio_context(s->qdev.conf.blk);
+    aio_context_acquire(ctx);
+
     /* check we are using a driver managing SG_IO (version 3 and after) =
*/
     rc =3D blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
@@ -2574,18 +2588,18 @@ static void scsi_block_realize(SCSIDevice *dev, E=
rror **errp)
         if (rc !=3D -EPERM) {
             error_append_hint(errp, "Is this a SCSI device?\n");
         }
-        return;
+        goto out;
     }
     if (sg_version < 30000) {
         error_setg(errp, "scsi generic interface too old");
-        return;
+        goto out;
     }
=20
     /* get device type from INQUIRY data */
     rc =3D get_device_type(s);
     if (rc < 0) {
         error_setg(errp, "INQUIRY failed");
-        return;
+        goto out;
     }
=20
     /* Make a guess for the block size, we'll fix it when the guest send=
s.
@@ -2605,6 +2619,9 @@ static void scsi_block_realize(SCSIDevice *dev, Err=
or **errp)
=20
     scsi_realize(&s->qdev, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
+
+out:
+    aio_context_release(ctx);
 }
=20
 typedef struct SCSIBlockReq {
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index ead7ee08eb..5d499c9a00 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -83,6 +83,24 @@ run_qemu <<EOF
 { "execute": "quit"}
 EOF
=20
+echo
+echo =3D=3D=3D Attach two SCSI disks using the same block device and the=
 same iothread =3D=3D=3D
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0", "read-only": true}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "sc=
si-hd", "drive": "hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
+{ "execute": "device_del", "arguments": {"id": "scsi0"}}
+{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
+{ "execute": "quit"}
+EOF
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index 432d98111c..701cb5c7d2 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -2,6 +2,22 @@ QA output created by 240
=20
 =3D=3D=3D Unplug a SCSI disk and then plug it again =3D=3D=3D
=20
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+
+=3D=3D=3D Attach two SCSI disks using the same block device and the same=
 iothread =3D=3D=3D
+
 Testing:
 QMP_VERSION
 {"return": {}}
--=20
2.20.1
