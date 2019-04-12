Received: from eggs.gnu.org ([209.51.188.92]:38726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFR-0001dk-C5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFQ-0002IQ-BL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:37 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:08 +0200
Message-Id: <20190412122523.24111-3-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 02/17] s390-bios:
 decouple cio setup from virtio
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

Move channel i/o setup code out to a separate function. This decouples ci=
o
setup from the virtio code path and allows us to make use of it for booti=
ng
dasd devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1554388475-18329-3-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 544851d672..e82fe2ce23 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -99,6 +99,18 @@ static void menu_setup(void)
     }
 }
=20
+/*
+ * Initialize the channel I/O subsystem so we can talk to our ipl/boot d=
evice.
+ */
+static void css_setup(void)
+{
+    /*
+     * Unconditionally enable mss support. In every sane configuration t=
his
+     * will succeed; and even if it doesn't, stsch_err() can handle it.
+     */
+    enable_mss_facility();
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
@@ -109,13 +121,6 @@ static void virtio_setup(void)
     VDev *vdev =3D virtio_get_device();
     QemuIplParameters *early_qipl =3D (QemuIplParameters *)QIPL_ADDRESS;
=20
-    /*
-     * We unconditionally enable mss support. In every sane configuratio=
n,
-     * this will succeed; and even if it doesn't, stsch_err() can deal
-     * with the consequences.
-     */
-    enable_mss_facility();
-
     sclp_get_loadparm_ascii(loadparm_str);
     memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
     sclp_print(ldp);
@@ -168,6 +173,7 @@ static void virtio_setup(void)
 int main(void)
 {
     sclp_setup();
+    css_setup();
     virtio_setup();
=20
     zipl_load(); /* no return */
--=20
2.21.0
