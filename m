Received: from eggs.gnu.org ([2001:4830:134:3::10]:47983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCR-0001F9-A3
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCO-0005Qa-26
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCN-0005PX-Pm
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0FlUN045002
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:07 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmur4vpmu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:06 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:06 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:11 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-37-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 36/79] s390x/css: catch section mismatch on load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Prior to the virtio-ccw-2.7 machine (and commit 2a79eb1a), our virtio
devices residing under the virtual-css bus do not have qdev_path based
migration stream identifiers (because their qdev_path is NULL). The ids
are instead generated when the device is registered as a composition of
the so called idstr, which takes the vmsd name as its value, and an
instance_id, which is which is calculated as a maximal instance_id
registered with the same idstr plus one, or zero (if none was registered
previously).

That means, under certain circumstances, one device might try, and even
succeed, to load the state of a different device. This can lead to
trouble.

Let us fail the migration if the above problem is detected during load.

How to reproduce the problem:
1) start qemu-system-s390x making sure you have the following devices
   defined on your command line:
     -device virtio-rng-ccw,id=rng1,devno=fe.0.0001
     -device virtio-rng-ccw,id=rng2,devno=fe.0.0002
2) detach the devices and reattach in reverse order using the monitor:
     (qemu) device_del rng1
     (qemu) device_del rng2
     (qemu) device_add virtio-rng-ccw,id=rng2,devno=fe.0.0002
     (qemu) device_add virtio-rng-ccw,id=rng1,devno=fe.0.0001
3) save the state of the vm into a temporary file and quit QEMU:
     (qemu) migrate "exec:gzip -c > /tmp/tmp_vmstate.gz"
     (qemu) q
4) use your command line from step 1 with
     -incoming "exec:gzip -c -d /tmp/tmp_vmstate.gz"
   appended to reproduce the problem (while trying to to load the saved vm)

CC: qemu-stable@nongnu.org
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Message-Id: <20170518111405.56947-1-pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
(cherry picked from commit 8ed179c937830143dc0e03daac30a55272ed89e3)
* removed context dep on d8d98db5
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/css.c        | 14 ++++++++++++++
 hw/s390x/virtio-ccw.c |  6 +++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 37caa98..b24e8b7 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -14,6 +14,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev.h"
 #include "qemu/bitops.h"
+#include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "hw/s390x/ioinst.h"
@@ -1676,13 +1677,26 @@ void subch_device_save(SubchDev *s, QEMUFile *f)
 int subch_device_load(SubchDev *s, QEMUFile *f)
 {
     SubchDev *old_s;
+    Error *err = NULL;
     uint16_t old_schid = s->schid;
+    uint16_t old_devno = s->devno;
     int i;
 
     s->cssid = qemu_get_byte(f);
     s->ssid = qemu_get_byte(f);
     s->schid = qemu_get_be16(f);
     s->devno = qemu_get_be16(f);
+    if (s->devno != old_devno) {
+        /* Only possible if machine < 2.7 (no css_dev_path) */
+
+        error_setg(&err, "%x != %x", old_devno,  s->devno);
+        error_append_hint(&err, "Devno mismatch, tried to load wrong section!"
+                          " Likely reason: some sequences of plug and unplug"
+                          " can break migration for machine versions prior to"
+                          " 2.7 (known design flaw).\n");
+        error_report_err(err);
+        return -EINVAL;
+    }
     /* Re-assign subch. */
     if (old_schid != s->schid) {
         old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 00b3bde..c0c1db8 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1264,9 +1264,13 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
     SubchDev *s = ccw_dev->sch;
     VirtIODevice *vdev = virtio_ccw_get_vdev(s);
     int len;
+    int ret;
 
     s->driver_data = dev;
-    subch_device_load(s, f);
+    ret = subch_device_load(s, f);
+    if (ret) {
+        return ret;
+    }
     len = qemu_get_be32(f);
     if (len != 0) {
         dev->indicators = get_indicator(qemu_get_be64(f), len);
-- 
2.7.4
