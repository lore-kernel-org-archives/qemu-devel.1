Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DCC4321B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C12B212F5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C12B212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeRm-0001JN-Ox
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:29:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKY-0003nj-PL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKX-00045N-JG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeKV-0003xp-PO; Thu, 25 Apr 2019 09:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFEE53008CDB;
	Thu, 25 Apr 2019 13:22:13 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 50CDF60BE5;
	Thu, 25 Apr 2019 13:22:13 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:31 +0200
Message-Id: <20190425132134.2839-17-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 25 Apr 2019 13:22:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/19] s390-bios: Use control unit type to find
 bootable devices
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
Message-ID: <20190425132131.iXqRK1IulQYQS4_5GUdNdw2mqX90b-odarlBFAAPg4Q@z>

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


