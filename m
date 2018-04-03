Received: from eggs.gnu.org ([2001:4830:134:3::10]:34657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3HQf-0004L7-1u
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3HQd-0002kp-Uu
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:36:33 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  3 Apr 2018 10:36:23 +0200
Message-Id: <20180403083625.15297-2-cohuck@redhat.com>
In-Reply-To: <20180403083625.15297-1-cohuck@redhat.com>
References: <20180403083625.15297-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 1/3] hw/s390x: fix memory leak in
 s390_init_ipl_dev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Cornelia Huck <cohuck@redhat.com>

From: Greg Kurz <groug@kaod.org>

The string returned by object_property_get_str() is dynamically allocated.

Fixes: 3c4e9baacf4d9
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <152231460685.69730.14860451936216690693.stgit@bahia.lan>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 864145a7c6..435f7c99e7 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -246,6 +246,7 @@ static void s390_init_ipl_dev(const char *kernel_filename,
 {
     Object *new = object_new(TYPE_S390_IPL);
     DeviceState *dev = DEVICE(new);
+    char *netboot_fw_prop;
 
     if (kernel_filename) {
         qdev_prop_set_string(dev, "kernel", kernel_filename);
@@ -256,9 +257,11 @@ static void s390_init_ipl_dev(const char *kernel_filename,
     qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
     qdev_prop_set_string(dev, "firmware", firmware);
     qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
-    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
+    netboot_fw_prop = object_property_get_str(new, "netboot_fw", &error_abort);
+    if (!strlen(netboot_fw_prop)) {
         qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
     }
+    g_free(netboot_fw_prop);
     object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
                               new, NULL);
     object_unref(new);
-- 
2.14.3
