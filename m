Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44271C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E4820652
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E4820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeUJ-0003dM-7k
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:32:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK6-0003OI-7F
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK5-0003js-5N
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeK4-0003jJ-Vq; Thu, 25 Apr 2019 09:21:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FD17307EA92;
	Thu, 25 Apr 2019 13:21:56 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E1EB01001E6C;
	Thu, 25 Apr 2019 13:21:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:25 +0200
Message-Id: <20190425132134.2839-11-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 25 Apr 2019 13:21:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/19] s390-bios: Extend find_dev() for
 non-virtio devices
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
Message-ID: <20190425132125.XaNEHRdQXo-OROdiFmoRyj1IF9p1mLIsAlokmvpCuko@z>

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


