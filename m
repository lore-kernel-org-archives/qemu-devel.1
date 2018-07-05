Received: from eggs.gnu.org ([2001:4830:134:3::10]:48860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb81F-0000Jb-2N
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb81C-0001pB-0A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb81B-0001mY-Lt
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNx5M082180
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:26:08 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1p3243wf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:26:08 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:26:07 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:43 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-16-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 15/15] s390-bios: Use sense ccw to ensure
 consistent device state at boot time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

If a vfio-ccw device is left in an error state (example: pending unit
check) then it is possible for that state to persist for a vfio-ccw device even
after the enable subchannel that we do to bring the device online. If this state
is allowed to persist then even simple I/O operations will needlessly fail. A
basic sense ccw is used to clear this error state for the boot device.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.c  | 13 +++++++++++++
 pc-bios/s390-ccw/cio.h  | 13 +++++++++++++
 pc-bios/s390-ccw/main.c |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index f440380..e77ec94 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -57,6 +57,19 @@ __u16 cu_type(SubChannelId schid)
     return senseData.cu_type;
 }
 
+void basic_sense(SubChannelId schid, SenseData *sd)
+{
+    Ccw1 senseCcw;
+
+    senseCcw.cmd_code = CCW_CMD_BASIC_SENSE;
+    senseCcw.cda = ptr2u32(sd);
+    senseCcw.count = sizeof(*sd);
+
+    if (do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1)) {
+        panic("Failed to run Basic Sense CCW\n");
+    }
+}
+
 static bool irb_error(Irb *irb)
 {
     /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index b5c9fd7..003524e 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -234,6 +234,18 @@ typedef struct senseid {
     struct ciw ciw[62];
 }  __attribute__ ((packed, aligned(4))) SenseId;
 
+/* basic sense response buffer layout */
+typedef struct senseData {
+    uint8_t status[3];
+    uint8_t res_count;
+    uint8_t phys_drive_id;
+    uint8_t low_cyl_addr;
+    uint8_t head_high_cyl_addr;
+    uint8_t fmt_msg;
+    uint8_t reserved[16];
+    uint8_t reserved2[8];
+}  __attribute__ ((packed, aligned(4))) SenseData;
+
 /* interruption response block */
 typedef struct irb {
     struct scsw scsw;
@@ -260,6 +272,7 @@ int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
 __u16 cu_type(SubChannelId schid);
 void await_io_int(uint16_t sch_no);
+void basic_sense(SubChannelId schid, SenseData *sd);
 int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt);
 
 /*
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 2bccfa7..e0ce59b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -201,12 +201,17 @@ static void virtio_setup(void)
 
 int main(void)
 {
+    SenseData sd;
+
     sclp_setup();
     cio_setup();
     boot_setup();
     find_boot_device();
     enable_subchannel(blk_schid);
 
+    /* Clear any outstanding device error conditions */
+    basic_sense(blk_schid, &sd);
+
     switch (cu_type(blk_schid)) {
     case 0x3990:  /* Real DASD device */
         dasd_ipl(blk_schid); /* no return */
-- 
2.7.4
