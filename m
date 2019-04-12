Received: from eggs.gnu.org ([209.51.188.92]:38752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFU-0001jn-Cx
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFT-0002K0-8g
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:40 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:09 +0200
Message-Id: <20190412122523.24111-4-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 03/17] s390-bios:
 decouple common boot logic from virtio
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

Create a boot_setup function to handle getting boot information from
the machine/hypervisor. This decouples common boot logic from the
virtio code path and allows us to make use of it for the real dasd boot
scenario.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1554388475-18329-4-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index e82fe2ce23..67df42191b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -14,16 +14,17 @@
=20
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid =3D { .one =3D 1 };
-IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm_str[LOADPARM_LEN + 1] =3D { 0, 0, 0, 0, 0, 0, 0, 0,=
 0 };
 QemuIplParameters qipl;
+IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+static bool have_iplb;
=20
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
 #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_Z=
IPL)
=20
 /*
- * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
+ * Principles of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
  * after list-directed-IPL and ccw-IPL.
  */
@@ -111,23 +112,33 @@ static void css_setup(void)
     enable_mss_facility();
 }
=20
+/*
+ * Collect various pieces of information from the hypervisor/hardware th=
at
+ * we'll use to determine exactly how we'll boot.
+ */
+static void boot_setup(void)
+{
+    char lpmsg[] =3D "LOADPARM=3D[________]\n";
+
+    sclp_get_loadparm_ascii(loadparm_str);
+    memcpy(lpmsg + 10, loadparm_str, 8);
+    sclp_print(lpmsg);
+
+    have_iplb =3D store_iplb(&iplb);
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
     int ssid;
     bool found =3D false;
     uint16_t dev_no;
-    char ldp[] =3D "LOADPARM=3D[________]\n";
     VDev *vdev =3D virtio_get_device();
     QemuIplParameters *early_qipl =3D (QemuIplParameters *)QIPL_ADDRESS;
=20
-    sclp_get_loadparm_ascii(loadparm_str);
-    memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
-    sclp_print(ldp);
-
     memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
=20
-    if (store_iplb(&iplb)) {
+    if (have_iplb) {
         switch (iplb.pbt) {
         case S390_IPL_TYPE_CCW:
             dev_no =3D iplb.ccw.devno;
@@ -174,6 +185,7 @@ int main(void)
 {
     sclp_setup();
     css_setup();
+    boot_setup();
     virtio_setup();
=20
     zipl_load(); /* no return */
--=20
2.21.0
