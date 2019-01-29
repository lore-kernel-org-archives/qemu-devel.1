Received: from eggs.gnu.org ([209.51.188.92]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSh-0000AQ-L1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSg-0000Ol-Q4
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53878
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSg-0008Rw-LZ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDS9S6136034
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:31 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qaq8tt1cw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:31 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:30 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:09 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-3-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 02/15] s390-bios: decouple cio setup from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Move channel i/o setup code out to a separate function. This decouples cio
setup from the virtio code path and allows us to make use of it for booting
dasd devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 544851d..e82fe2c 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -99,6 +99,18 @@ static void menu_setup(void)
     }
 }
 
+/*
+ * Initialize the channel I/O subsystem so we can talk to our ipl/boot device.
+ */
+static void css_setup(void)
+{
+    /*
+     * Unconditionally enable mss support. In every sane configuration this
+     * will succeed; and even if it doesn't, stsch_err() can handle it.
+     */
+    enable_mss_facility();
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
@@ -109,13 +121,6 @@ static void virtio_setup(void)
     VDev *vdev = virtio_get_device();
     QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
 
-    /*
-     * We unconditionally enable mss support. In every sane configuration,
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
 
     zipl_load(); /* no return */
-- 
2.7.4
