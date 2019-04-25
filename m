Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E4C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A87B206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A87B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeaq-0000bW-7e
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:39:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKH-0003Wf-5D
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKG-0003uB-63
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeKF-0003tX-To; Thu, 25 Apr 2019 09:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CD253158793;
	Thu, 25 Apr 2019 13:22:07 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB5B35D70A;
	Thu, 25 Apr 2019 13:22:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:29 +0200
Message-Id: <20190425132134.2839-15-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 13:22:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/19] s390-bios: Add channel command
 codes/structs needed for dasd-ipl
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
Message-ID: <20190425132129.PIS26Y_VU20RudZEfd3B_U9SotDzqq8-lFQeDmEMzto@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

The dasd IPL procedure needs to execute a few previously unused
channel commands. Let's define them and their associated data
structures.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-15-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 1637e32070f3..aaa432deddb9 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -200,11 +200,14 @@ typedef struct ccw1 {
 #define CCW_FLAG_IDA             0x04
 #define CCW_FLAG_SUSPEND         0x02
 
+/* Common CCW commands */
+#define CCW_CMD_READ_IPL         0x02
 #define CCW_CMD_NOOP             0x03
 #define CCW_CMD_BASIC_SENSE      0x04
 #define CCW_CMD_TIC              0x08
 #define CCW_CMD_SENSE_ID         0xe4
 
+/* Virtio CCW commands */
 #define CCW_CMD_SET_VQ           0x13
 #define CCW_CMD_VDEV_RESET       0x33
 #define CCW_CMD_READ_FEAT        0x12
@@ -216,6 +219,12 @@ typedef struct ccw1 {
 #define CCW_CMD_SET_CONF_IND     0x53
 #define CCW_CMD_READ_VQ_CONF     0x32
 
+/* DASD CCW commands */
+#define CCW_CMD_DASD_READ             0x06
+#define CCW_CMD_DASD_SEEK             0x07
+#define CCW_CMD_DASD_SEARCH_ID_EQ     0x31
+#define CCW_CMD_DASD_READ_MT          0x86
+
 /*
  * Command-mode operation request block
  */
@@ -333,6 +342,20 @@ typedef struct irb {
     __u32 emw[8];
 }  __attribute__ ((packed, aligned(4))) Irb;
 
+/* Used for SEEK ccw commands */
+typedef struct CcwSeekData {
+    uint16_t reserved;
+    uint16_t cyl;
+    uint16_t head;
+} __attribute__((packed)) CcwSeekData;
+
+/* Used for SEARCH ID ccw commands */
+typedef struct CcwSearchIdData {
+    uint16_t cyl;
+    uint16_t head;
+    uint8_t record;
+} __attribute__((packed)) CcwSearchIdData;
+
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
 uint16_t cu_type(SubChannelId schid);
-- 
2.17.2


