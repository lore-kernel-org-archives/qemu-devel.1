Received: from eggs.gnu.org ([209.51.188.92]:58761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKY-0003nj-PL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKX-00045N-JG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:26 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:31 +0200
Message-Id: <20190425132134.2839-17-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 16/19] s390-bios: Use control unit type to find
 bootable devices
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

When the user does not specify which device to boot from then we end
up guessing. Instead of simply grabbing the first available device let's
be a little bit smarter and only choose devices that might be bootable
like disk, and not console devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <1554388475-18329-17-git-send-email-jjherne@linux.ibm.com>
[thuth: Added fix for virtio_is_supported() not being called anymore]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 45 ++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 3c449ad49688..a69c73349e8f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -21,6 +21,7 @@ static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
+static uint16_t cutype;
 LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
 
 #define LOADPARM_PROMPT "PROMPT  "
@@ -58,11 +59,15 @@ unsigned int get_loadparm_index(void)
  * subchannel information block (schib) with the connected subchannel's info.
  * NOTE: The global variable blk_schid is updated to contain the subchannel
  * information.
+ *
+ * If the caller gives dev_no=-1 then the user did not specify a boot device.
+ * In this case we'll just use the first potentially bootable device we find.
  */
 static bool find_subch(int dev_no)
 {
     Schib schib;
     int i, r;
+    bool is_virtio;
 
     for (i = 0; i < 0x10000; i++) {
         blk_schid.sch_no = i;
@@ -74,16 +79,39 @@ static bool find_subch(int dev_no)
             continue;
         }
 
-        /* Skip net devices since no IPLB is created and therefore no
-         * network bootloader has been loaded
-         */
         enable_subchannel(blk_schid);
-        if (virtio_is_supported(blk_schid) &&
-            virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
-            continue;
+        cutype = cu_type(blk_schid);
+
+        /*
+         * Note: we always have to run virtio_is_supported() here to make
+         * sure that the vdev.senseid data gets pre-initialized correctly
+         */
+        is_virtio = virtio_is_supported(blk_schid);
+
+        /* No specific devno given, just return 1st possibly bootable device */
+        if (dev_no < 0) {
+            switch (cutype) {
+            case CU_TYPE_VIRTIO:
+                if (is_virtio) {
+                    /*
+                     * Skip net devices since no IPLB is created and therefore
+                     * no network bootloader has been loaded
+                     */
+                    if (virtio_get_device_type() != VIRTIO_ID_NET) {
+                        return true;
+                    }
+                }
+                continue;
+            case CU_TYPE_DASD_3990:
+            case CU_TYPE_DASD_2107:
+                return true;
+            default:
+                continue;
+            }
         }
 
-        if ((dev_no < 0) || (schib.pmcw.dev == dev_no)) {
+        /* Caller asked for a specific devno */
+        if (schib.pmcw.dev == dev_no) {
             return true;
         }
     }
@@ -200,15 +228,12 @@ static void virtio_setup(void)
 
 int main(void)
 {
-    uint16_t cutype;
-
     sclp_setup();
     css_setup();
     boot_setup();
     find_boot_device();
     enable_subchannel(blk_schid);
 
-    cutype = cu_type(blk_schid);
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-- 
2.17.2
