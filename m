Received: from eggs.gnu.org ([2001:4830:134:3::10]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb819-0000E6-Cg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb816-0001bG-3v
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb815-0001ZO-PQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNjvJ120465
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:26:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k1mea17gx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:26:03 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:26:02 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:41 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-14-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 13/15] s390-bios: Add channel command
 codes/structs needed for dasd-ipl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

The dasd IPL procedure needs to execute a few previously unused
channel commands. Let's define them and their associated data
structures.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index d8e2955..b5c9fd7 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -163,11 +163,14 @@ typedef struct ccw1 {
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
@@ -179,6 +182,12 @@ typedef struct ccw1 {
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
@@ -233,6 +242,20 @@ typedef struct irb {
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
 __u16 cu_type(SubChannelId schid);
-- 
2.7.4
