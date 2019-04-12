Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D22C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3F32171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F32171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvMS-0000dQ-Ga
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:32:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFU-0001jn-Cx
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFT-0002K0-8g
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFS-0002JS-Ub; Fri, 12 Apr 2019 08:25:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37E3CC049E24;
	Fri, 12 Apr 2019 12:25:38 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A40B5D9CC;
	Fri, 12 Apr 2019 12:25:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:09 +0200
Message-Id: <20190412122523.24111-4-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 12 Apr 2019 12:25:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 03/17] s390-bios:
 decouple common boot logic from virtio
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122509.OBeEaVoMb7nCaPbad2dOjPpv1RFyVKlx9CkCaKm-sRY@z>

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


