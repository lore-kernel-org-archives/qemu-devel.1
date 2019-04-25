Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37771C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6986121537
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6986121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeOQ-0006oE-CA
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:26:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJs-000389-G9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJr-0003ba-H3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeJr-0003bC-8s; Thu, 25 Apr 2019 09:21:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FA4B319939F;
	Thu, 25 Apr 2019 13:21:42 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0381001E6C;
	Thu, 25 Apr 2019 13:21:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:18 +0200
Message-Id: <20190425132134.2839-4-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 13:21:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/19] s390-bios: decouple common boot logic
 from virtio
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132118.59kxc2_7P2QYobYziumotwHr5B6w8Cn-Mkq1O2nY_Rw@z>

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
index e82fe2ce2315..67df42191b94 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -14,16 +14,17 @@
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
-IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
+IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+static bool have_iplb;
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
 #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
 
 /*
- * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
+ * Principles of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
  * after list-directed-IPL and ccw-IPL.
  */
@@ -111,23 +112,33 @@ static void css_setup(void)
     enable_mss_facility();
 }
 
+/*
+ * Collect various pieces of information from the hypervisor/hardware that
+ * we'll use to determine exactly how we'll boot.
+ */
+static void boot_setup(void)
+{
+    char lpmsg[] = "LOADPARM=[________]\n";
+
+    sclp_get_loadparm_ascii(loadparm_str);
+    memcpy(lpmsg + 10, loadparm_str, 8);
+    sclp_print(lpmsg);
+
+    have_iplb = store_iplb(&iplb);
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
     int ssid;
     bool found = false;
     uint16_t dev_no;
-    char ldp[] = "LOADPARM=[________]\n";
     VDev *vdev = virtio_get_device();
     QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
 
-    sclp_get_loadparm_ascii(loadparm_str);
-    memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
-    sclp_print(ldp);
-
     memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
 
-    if (store_iplb(&iplb)) {
+    if (have_iplb) {
         switch (iplb.pbt) {
         case S390_IPL_TYPE_CCW:
             dev_no = iplb.ccw.devno;
@@ -174,6 +185,7 @@ int main(void)
 {
     sclp_setup();
     css_setup();
+    boot_setup();
     virtio_setup();
 
     zipl_load(); /* no return */
-- 
2.17.2


