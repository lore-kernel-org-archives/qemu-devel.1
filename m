Received: from eggs.gnu.org ([209.51.188.92]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznOZ-0006ZK-62
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznOW-0004Wp-Tk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gznOV-0004Jy-4d
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21J0EsX126643
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 14:00:19 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qy9fd2rrq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 14:00:15 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 1 Mar 2019 18:59:46 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri,  1 Mar 2019 13:59:36 -0500
In-Reply-To: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1551466776-29123-17-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 16/16] s390-bios: dasd-ipl: Use control unit
 type to customize error data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Propagate control unit type from main through the dasd ipl call chain.
The control unit type can be used to determine if we are attempting to
boot from a real dasd device. If something goes wrong we'll want to print
detailed dasd sense data (for diagnostic use) but only if we're attempting
to boot from a real dasd device.

Note: We also query and print the dasd sense data if we fail while
attempting to determine the control unit type. In this case, we don't know
if we're dealing with a real dasd device yet, but if we are, then the sense
data may be useful for figuring out what went wrong. Since determining
the control unit type is the very first thing we do with any real dasd device,
this is our most likely point of failure.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.c      | 16 ++++++++++------
 pc-bios/s390-ccw/cio.h      |  6 ++++--
 pc-bios/s390-ccw/dasd-ipl.c | 25 +++++++++++++------------
 pc-bios/s390-ccw/dasd-ipl.h |  2 +-
 pc-bios/s390-ccw/main.c     |  2 +-
 pc-bios/s390-ccw/virtio.c   |  2 +-
 6 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index c528bbf..593fb33 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -54,14 +54,15 @@ uint16_t cu_type(SubChannelId schid)
     sense_id_ccw.count = sizeof(sense_data);
     sense_id_ccw.flags |= CCW_FLAG_SLI;
 
-    if (do_cio(schid, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
+    if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
         panic("Failed to run SenseID CCw\n");
     }
 
     return sense_data.cu_type;
 }
 
-void basic_sense(SubChannelId schid, void *sense_data, uint16_t data_size)
+void basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data,
+                 uint16_t data_size)
 {
     Ccw1 senseCcw;
 
@@ -69,7 +70,7 @@ void basic_sense(SubChannelId schid, void *sense_data, uint16_t data_size)
     senseCcw.cda = ptr2u32(sense_data);
     senseCcw.count = data_size;
 
-    if (do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1)) {
+    if (do_cio(schid, cutype, ptr2u32(&senseCcw), CCW_FMT1)) {
         panic("Failed to run Basic Sense CCW\n");
     }
 }
@@ -364,7 +365,7 @@ static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb *irb)
  *
  * Returns non-zero on error.
  */
-int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
+int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr, int fmt)
 {
     Irb irb = {};
     SenseDataEckdDasd sd;
@@ -402,10 +403,13 @@ int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
         print_int("  ssid  ", schid.ssid);
         print_int("  cssid ", schid.cssid);
         print_int("  sch_no", schid.sch_no);
+        print_int("  ctrl-unit type", cutype);
         sclp_print("\n");
         print_irb_err(&irb);
-        basic_sense(schid, &sd, sizeof(sd));
-        print_eckd_dasd_sense_data(&sd);
+        if (cutype == CU_TYPE_DASD_3990 || cutype == CU_TYPE_UNKNOWN) {
+            basic_sense(schid, cutype, &sd, sizeof(sd));
+            print_eckd_dasd_sense_data(&sd);
+        }
         rc = -1;
         break;
     }
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 053dc6b..bd39b9f 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -256,6 +256,7 @@ struct ciw {
     __u16 count;
 };
 
+#define CU_TYPE_UNKNOWN         0x0000
 #define CU_TYPE_VIRTIO          0x3832
 #define CU_TYPE_DASD_3990       0x3990
 
@@ -357,8 +358,9 @@ typedef struct CcwSearchIdData {
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
 uint16_t cu_type(SubChannelId schid);
-void basic_sense(SubChannelId schid, void *sense_data, uint16_t data_size);
-int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt);
+void basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data,
+                 uint16_t data_size);
+int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr, int fmt);
 
 /*
  * Some S390 specific IO instructions as inline
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
index 5a863f0..11afa46 100644
--- a/pc-bios/s390-ccw/dasd-ipl.c
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -72,7 +72,8 @@ static bool dynamic_cp_fixup(uint32_t ccw_addr, uint32_t  *next_cpa)
     return false;
 }
 
-static int run_dynamic_ccw_program(SubChannelId schid, uint32_t cpa)
+static int run_dynamic_ccw_program(SubChannelId schid, uint16_t cutype,
+                                   uint32_t cpa)
 {
     bool has_next;
     uint32_t next_cpa = 0;
@@ -83,7 +84,7 @@ static int run_dynamic_ccw_program(SubChannelId schid, uint32_t cpa)
 
         print_int("executing ccw chain at ", cpa);
         enable_prefixing();
-        rc = do_cio(schid, cpa, CCW_FMT0);
+        rc = do_cio(schid, cutype, cpa, CCW_FMT0);
         disable_prefixing();
 
         if (rc) {
@@ -106,9 +107,9 @@ static void make_readipl(void)
     ccwIplRead->count = 0x18; /* Read 0x18 bytes of data */
 }
 
-static void run_readipl(SubChannelId schid)
+static void run_readipl(SubChannelId schid, uint16_t cutype)
 {
-    if (do_cio(schid, 0x00, CCW_FMT0)) {
+    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
         panic("dasd-ipl: Failed to run Read IPL channel program");
     }
 }
@@ -183,19 +184,19 @@ static void ipl1_fixup(void)
     ccwSearchTic->cda = ptr2u32(ccwSearchID);
 }
 
-static void run_ipl1(SubChannelId schid)
+static void run_ipl1(SubChannelId schid, uint16_t cutype)
  {
     uint32_t startAddr = 0x08;
 
-    if (do_cio(schid, startAddr, CCW_FMT0)) {
+    if (do_cio(schid, cutype, startAddr, CCW_FMT0)) {
         panic("dasd-ipl: Failed to run IPL1 channel program");
     }
 }
 
-static void run_ipl2(SubChannelId schid, uint32_t addr)
+static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
 {
 
-    if (run_dynamic_ccw_program(schid, addr)) {
+    if (run_dynamic_ccw_program(schid, cutype, addr)) {
         panic("dasd-ipl: Failed to run IPL2 channel program");
     }
 }
@@ -222,13 +223,13 @@ static void lpsw(void *psw_addr)
  * Limitations in QEMU's CCW support complicate the IPL process. Details can
  * be found in docs/devel/s390-dasd-ipl.txt
  */
-void dasd_ipl(SubChannelId schid)
+void dasd_ipl(SubChannelId schid, uint16_t cutype)
 {
     uint32_t ipl2_addr;
 
     /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
     make_readipl();
-    run_readipl(schid);
+    run_readipl(schid, cutype);
     ipl2_addr = read_ipl2_addr();
     check_ipl1();
 
@@ -237,13 +238,13 @@ void dasd_ipl(SubChannelId schid)
      * to read IPL2 channel program from boot disk.
      */
     ipl1_fixup();
-    run_ipl1(schid);
+    run_ipl1(schid, cutype);
     check_ipl2(ipl2_addr);
 
     /*
      * Run IPL2 channel program to read operating system code from boot disk
      * then transfer control to the guest operating system
      */
-    run_ipl2(schid, ipl2_addr);
+    run_ipl2(schid, cutype, ipl2_addr);
     lpsw(0);
 }
diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
index 56bba82..8e699f4 100644
--- a/pc-bios/s390-ccw/dasd-ipl.h
+++ b/pc-bios/s390-ccw/dasd-ipl.h
@@ -11,6 +11,6 @@
 #ifndef DASD_IPL_H
 #define DASD_IPL_H
 
-void dasd_ipl(SubChannelId schid);
+void dasd_ipl(SubChannelId schid, uint16_t cutype);
 
 #endif /* DASD_IPL_H */
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index f5989f8..3eb6690 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -210,7 +210,7 @@ int main(void)
     cutype = cu_type(blk_schid);
     switch (cutype) {
     case CU_TYPE_DASD_3990:
-        dasd_ipl(blk_schid); /* no return */
+        dasd_ipl(blk_schid, cutype); /* no return */
         break;
     case CU_TYPE_VIRTIO:
         virtio_setup();
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 711daf5..4cd09eb 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -103,7 +103,7 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
     }
 
     enable_subchannel(vdev->schid);
-    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
+    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
 }
 
 static void vring_init(VRing *vr, VqInfo *info)
-- 
2.7.4
