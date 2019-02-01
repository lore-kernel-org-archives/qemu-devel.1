Received: from eggs.gnu.org ([209.51.188.92]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboE-0007wU-M7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboA-0000CB-PW
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:12 +0100
Message-Id: <20190201163518.31157-22-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/27] virtio-scsi: Forbid devices with
 different iothreads sharing a blockdev
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

This patch forbids attaching a disk to a SCSI device if its using a
different AioContext. Test case included.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/virtio-scsi.c      |  7 +++++++
 tests/qemu-iotests/240     | 22 ++++++++++++++++++++++
 tests/qemu-iotests/240.out | 20 ++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index e1f7b208c7..eb90288f47 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -791,9 +791,16 @@ static void virtio_scsi_hotplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
     SCSIDevice *sd =3D SCSI_DEVICE(dev);
=20
     if (s->ctx && !s->dataplane_fenced) {
+        AioContext *ctx;
         if (blk_op_is_blocked(sd->conf.blk, BLOCK_OP_TYPE_DATAPLANE, err=
p)) {
             return;
         }
+        ctx =3D blk_get_aio_context(sd->conf.blk);
+        if (ctx !=3D s->ctx && ctx !=3D qemu_get_aio_context()) {
+            error_setg(errp, "Cannot attach a blockdev that is using "
+                       "a different iothread");
+            return;
+        }
         virtio_scsi_acquire(s);
         blk_set_aio_context(sd->conf.blk, s->ctx);
         virtio_scsi_release(s);
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 5d499c9a00..65cc3b39b1 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -101,6 +101,28 @@ run_qemu <<EOF
 { "execute": "quit"}
 EOF
=20
+echo
+echo =3D=3D=3D Attach two SCSI disks using the same block device but dif=
ferent iothreads =3D=3D=3D
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-na=
me": "hd0", "read-only": true}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread0"}}
+{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "=
iothread1"}}
+{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${vir=
tio_scsi}", "iothread": "iothread0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi1", "driver": "${vir=
tio_scsi}", "iothread": "iothread1"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "sc=
si-hd", "drive": "hd0", "bus": "scsi0.0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "sc=
si-hd", "drive": "hd0", "bus": "scsi1.0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
+{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "sc=
si-hd", "drive": "hd0", "bus": "scsi1.0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
+{ "execute": "device_del", "arguments": {"id": "scsi0"}}
+{ "execute": "device_del", "arguments": {"id": "scsi1"}}
+{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
+{ "execute": "quit"}
+EOF
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index 701cb5c7d2..d76392966c 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -31,4 +31,24 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
+
+=3D=3D=3D Attach two SCSI disks using the same block device but differen=
t iothreads =3D=3D=3D
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot attach a blockdev th=
at is using a different iothread"}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
 *** done
--=20
2.20.1
