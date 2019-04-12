Received: from eggs.gnu.org ([209.51.188.92]:39295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvGC-0003Tq-Gc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvG9-0002sv-Lh
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:22 +0200
Message-Id: <20190412122523.24111-17-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 16/17] s390-bios: Use
 control unit type to find bootable devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com

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
index 3c449ad496..a69c73349e 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -21,6 +21,7 @@ static char loadparm_str[LOADPARM_LEN + 1] =3D { 0, 0, =
0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
+static uint16_t cutype;
 LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
=20
 #define LOADPARM_PROMPT "PROMPT  "
@@ -58,11 +59,15 @@ unsigned int get_loadparm_index(void)
  * subchannel information block (schib) with the connected subchannel's =
info.
  * NOTE: The global variable blk_schid is updated to contain the subchan=
nel
  * information.
+ *
+ * If the caller gives dev_no=3D-1 then the user did not specify a boot =
device.
+ * In this case we'll just use the first potentially bootable device we =
find.
  */
 static bool find_subch(int dev_no)
 {
     Schib schib;
     int i, r;
+    bool is_virtio;
=20
     for (i =3D 0; i < 0x10000; i++) {
         blk_schid.sch_no =3D i;
@@ -74,16 +79,39 @@ static bool find_subch(int dev_no)
             continue;
         }
=20
-        /* Skip net devices since no IPLB is created and therefore no
-         * network bootloader has been loaded
-         */
         enable_subchannel(blk_schid);
-        if (virtio_is_supported(blk_schid) &&
-            virtio_get_device_type() =3D=3D VIRTIO_ID_NET && dev_no < 0)=
 {
-            continue;
+        cutype =3D cu_type(blk_schid);
+
+        /*
+         * Note: we always have to run virtio_is_supported() here to mak=
e
+         * sure that the vdev.senseid data gets pre-initialized correctl=
y
+         */
+        is_virtio =3D virtio_is_supported(blk_schid);
+
+        /* No specific devno given, just return 1st possibly bootable de=
vice */
+        if (dev_no < 0) {
+            switch (cutype) {
+            case CU_TYPE_VIRTIO:
+                if (is_virtio) {
+                    /*
+                     * Skip net devices since no IPLB is created and the=
refore
+                     * no network bootloader has been loaded
+                     */
+                    if (virtio_get_device_type() !=3D VIRTIO_ID_NET) {
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
=20
-        if ((dev_no < 0) || (schib.pmcw.dev =3D=3D dev_no)) {
+        /* Caller asked for a specific devno */
+        if (schib.pmcw.dev =3D=3D dev_no) {
             return true;
         }
     }
@@ -200,15 +228,12 @@ static void virtio_setup(void)
=20
 int main(void)
 {
-    uint16_t cutype;
-
     sclp_setup();
     css_setup();
     boot_setup();
     find_boot_device();
     enable_subchannel(blk_schid);
=20
-    cutype =3D cu_type(blk_schid);
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
--=20
2.21.0
