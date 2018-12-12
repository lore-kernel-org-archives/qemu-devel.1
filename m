Received: from eggs.gnu.org ([2001:4830:134:3::10]:43688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Ex-0006EH-Kr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Ev-0006qJ-SZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:39 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:19 +0100
Message-Id: <20181212095519.6390-7-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
References: <20181212095519.6390-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] hw/s390x/virtio-ccw.c: Don't take address
 of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by not using the
"modify in place" byte swapping functions.

Patch produced with scripts/coccinelle/inplace-byteswaps.cocci
(with a couple of long lines manually wrapped).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181210120436.30522-1-peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 212b3d3dea..c2b78c8e9b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -287,18 +287,18 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch, =
CCW1 ccw, bool check_len,
     }
     if (is_legacy) {
         ccw_dstream_read(&sch->cds, linfo);
-        be64_to_cpus(&linfo.queue);
-        be32_to_cpus(&linfo.align);
-        be16_to_cpus(&linfo.index);
-        be16_to_cpus(&linfo.num);
+        linfo.queue =3D be64_to_cpu(linfo.queue);
+        linfo.align =3D be32_to_cpu(linfo.align);
+        linfo.index =3D be16_to_cpu(linfo.index);
+        linfo.num =3D be16_to_cpu(linfo.num);
         ret =3D virtio_ccw_set_vqs(sch, NULL, &linfo);
     } else {
         ccw_dstream_read(&sch->cds, info);
-        be64_to_cpus(&info.desc);
-        be16_to_cpus(&info.index);
-        be16_to_cpus(&info.num);
-        be64_to_cpus(&info.avail);
-        be64_to_cpus(&info.used);
+        info.desc =3D be64_to_cpu(info.desc);
+        info.index =3D be16_to_cpu(info.index);
+        info.num =3D be16_to_cpu(info.num);
+        info.avail =3D be64_to_cpu(info.avail);
+        info.used =3D be64_to_cpu(info.used);
         ret =3D virtio_ccw_set_vqs(sch, &info, NULL);
     }
     sch->curr_status.scsw.count =3D 0;
@@ -382,7 +382,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 features.features =3D 0;
             }
             ccw_dstream_rewind(&sch->cds);
-            cpu_to_le32s(&features.features);
+            features.features =3D cpu_to_le32(features.features);
             ccw_dstream_write(&sch->cds, features.features);
             sch->curr_status.scsw.count =3D ccw.count - sizeof(features)=
;
             ret =3D 0;
@@ -403,7 +403,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret =3D -EFAULT;
         } else {
             ccw_dstream_read(&sch->cds, features);
-            le32_to_cpus(&features.features);
+            features.features =3D le32_to_cpu(features.features);
             if (features.index =3D=3D 0) {
                 virtio_set_features(vdev,
                                     (vdev->guest_features & 0xffffffff00=
000000ULL) |
@@ -546,7 +546,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret =3D -EFAULT;
         } else {
             ccw_dstream_read(&sch->cds, indicators);
-            be64_to_cpus(&indicators);
+            indicators =3D be64_to_cpu(indicators);
             dev->indicators =3D get_indicator(indicators, sizeof(uint64_=
t));
             sch->curr_status.scsw.count =3D ccw.count - sizeof(indicator=
s);
             ret =3D 0;
@@ -567,7 +567,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret =3D -EFAULT;
         } else {
             ccw_dstream_read(&sch->cds, indicators);
-            be64_to_cpus(&indicators);
+            indicators =3D be64_to_cpu(indicators);
             dev->indicators2 =3D get_indicator(indicators, sizeof(uint64=
_t));
             sch->curr_status.scsw.count =3D ccw.count - sizeof(indicator=
s);
             ret =3D 0;
@@ -588,14 +588,14 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret =3D -EFAULT;
         } else {
             ccw_dstream_read(&sch->cds, vq_config.index);
-            be16_to_cpus(&vq_config.index);
+            vq_config.index =3D be16_to_cpu(vq_config.index);
             if (vq_config.index >=3D VIRTIO_QUEUE_MAX) {
                 ret =3D -EINVAL;
                 break;
             }
             vq_config.num_max =3D virtio_queue_get_num(vdev,
                                                      vq_config.index);
-            cpu_to_be16s(&vq_config.num_max);
+            vq_config.num_max =3D cpu_to_be16(vq_config.num_max);
             ccw_dstream_write(&sch->cds, vq_config.num_max);
             sch->curr_status.scsw.count =3D ccw.count - sizeof(vq_config=
);
             ret =3D 0;
@@ -621,9 +621,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (ccw_dstream_read(&sch->cds, thinint)) {
                 ret =3D -EFAULT;
             } else {
-                be64_to_cpus(&thinint.ind_bit);
-                be64_to_cpus(&thinint.summary_indicator);
-                be64_to_cpus(&thinint.device_indicator);
+                thinint.ind_bit =3D be64_to_cpu(thinint.ind_bit);
+                thinint.summary_indicator =3D
+                    be64_to_cpu(thinint.summary_indicator);
+                thinint.device_indicator =3D
+                    be64_to_cpu(thinint.device_indicator);
=20
                 dev->summary_indicator =3D
                     get_indicator(thinint.summary_indicator, sizeof(uint=
8_t));
@@ -654,8 +656,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             break;
         }
         ccw_dstream_read_buf(&sch->cds, &revinfo, 4);
-        be16_to_cpus(&revinfo.revision);
-        be16_to_cpus(&revinfo.length);
+        revinfo.revision =3D be16_to_cpu(revinfo.revision);
+        revinfo.length =3D be16_to_cpu(revinfo.length);
         if (ccw.count < len + revinfo.length ||
             (check_len && ccw.count > len + revinfo.length)) {
             ret =3D -EINVAL;
--=20
2.17.2
