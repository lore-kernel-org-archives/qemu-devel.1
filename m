Received: from eggs.gnu.org ([209.51.188.92]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK6-0003OI-7F
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK5-0003js-5N
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:58 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:25 +0200
Message-Id: <20190425132134.2839-11-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/19] s390-bios: Extend find_dev() for
 non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

We need a method for finding the subchannel of a dasd device. Let's
modify find_dev to handle this since it mostly does what we need. Up to
this point find_dev has been specific to only virtio devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1554388475-18329-11-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index e403b5f733e4..d04ea8972a0c 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -52,6 +52,12 @@ unsigned int get_loadparm_index(void)
     return atoui(loadparm_str);
 }
 
+/*
+ * Find the subchannel connected to the given device (dev_no) and fill in the
+ * subchannel information block (schib) with the connected subchannel's info.
+ * NOTE: The global variable blk_schid is updated to contain the subchannel
+ * information.
+ */
 static bool find_dev(Schib *schib, int dev_no)
 {
     int i, r;
@@ -65,15 +71,15 @@ static bool find_dev(Schib *schib, int dev_no)
         if (!schib->pmcw.dnv) {
             continue;
         }
-        if (!virtio_is_supported(blk_schid)) {
-            continue;
-        }
+
         /* Skip net devices since no IPLB is created and therefore no
-         * no network bootloader has been loaded
+         * network bootloader has been loaded
          */
-        if (virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
+        if (virtio_is_supported(blk_schid) &&
+            virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
             continue;
         }
+
         if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
             return true;
         }
-- 
2.17.2
