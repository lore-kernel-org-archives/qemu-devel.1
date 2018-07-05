Received: from eggs.gnu.org ([2001:4830:134:3::10]:48747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb819-0000EG-I3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb816-0001as-10
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb815-0001YT-La
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNfGD022146
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:26:02 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1qb18xrt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:26:02 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:26:01 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:38 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 10/15] s390-bios: Support for running format-0/1
 channel programs
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

Add struct for format-0 ccws. Support executing format-0 channel
programs and waiting for their completion before continuing execution.
This will be used for real dasd ipl.

Add cu_type() to channel io library. This will be used to query control
unit type which is used to determine if we are booting a virtio device or a
real dasd device.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h |  25 +++++++++-
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 095f79b..f440380 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "s390-arch.h"
 #include "cio.h"
 
 static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
@@ -39,3 +40,129 @@ void enable_subchannel(SubChannelId schid)
     schib.pmcw.ena = 1;
     msch(schid, &schib);
 }
+
+__u16 cu_type(SubChannelId schid)
+{
+    Ccw1 senseIdCcw;
+    SenseId senseData;
+
+    senseIdCcw.cmd_code = CCW_CMD_SENSE_ID;
+    senseIdCcw.cda = ptr2u32(&senseData);
+    senseIdCcw.count = sizeof(senseData);
+
+    if (do_cio(schid, ptr2u32(&senseIdCcw), CCW_FMT1)) {
+        panic("Failed to run SenseID CCw\n");
+    }
+
+    return senseData.cu_type;
+}
+
+static bool irb_error(Irb *irb)
+{
+    /* We have to ignore Incorrect Length (cstat == 0x40) indicators because
+     * real devices expect a 24 byte SenseID  buffer, and virtio devices expect
+     * a much larger buffer. Neither device type can tolerate a buffer size
+     * different from what they expect so they set this indicator.
+     */
+    if (irb->scsw.cstat != 0x00 && irb->scsw.cstat != 0x40) {
+        return true;
+    }
+    return irb->scsw.dstat != 0xc;
+}
+
+/* Executes a channel program at a given subchannel. The request to run the
+ * channel program is sent to the subchannel, we then wait for the interrupt
+ * singaling completion of the I/O operation(s) perfomed by the channel
+ * program. Lastly we verify that the i/o operation completed without error and
+ * that the interrupt we received was for the subchannel used to run the
+ * channel program.
+ *
+ * Note: This function assumes it is running in an environment where no other
+ * cpus are generating or receiving I/O interrupts. So either run it in a
+ * single-cpu environment or make sure all other cpus are not doing I/O and
+ * have I/O interrupts masked off.
+ */
+int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt)
+{
+    Ccw0 *this_ccw, *prev_ccw;
+    CmdOrb orb = {};
+    Irb irb = {};
+    int rc;
+
+    IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
+
+    /* ccw_addr must be <= 24 bits and point to at least one whole ccw. */
+    if (fmt == 0) {
+        IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
+    }
+
+    orb.fmt = fmt ;
+    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
+    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
+    orb.lpm = 0xFF; /* All paths allowed */
+    orb.cpa = ccw_addr;
+
+    rc = ssch(schid, &orb);
+    if (rc) {
+        print_int("ssch failed with rc=", rc);
+        return rc;
+    }
+
+    await_io_int(schid.sch_no);
+
+    /* Clear read */
+    rc = tsch(schid, &irb);
+    if (rc) {
+        print_int("tsch failed with rc=", rc);
+        return rc;
+    }
+
+    if (irb_error(&irb)) {
+        this_ccw = u32toptr(irb.scsw.cpa);
+        prev_ccw = u32toptr(irb.scsw.cpa - 8);
+
+        print_int("irb_error: cstat=", irb.scsw.cstat);
+        print_int("           dstat=", irb.scsw.dstat);
+        print_int("           cpa=", irb.scsw.cpa);
+        print_int("           prev_ccw=", *((uint64_t *)prev_ccw));
+        print_int("           this_ccw=", *((uint64_t *)this_ccw));
+    }
+
+    return 0;
+}
+
+void await_io_int(uint16_t sch_no)
+{
+    /*
+     * wait_psw and ctl6 must be static to avoid stack allocation as gcc cannot
+     * align stack variables. The stctg, lctlg and lpswe instructions require
+     * that their operands be aligned on an 8-byte boundary.
+    */
+    static uint64_t ctl6 __attribute__((__aligned__(8)));
+    static PSW wait_psw;
+
+    /* PSW to load when I/O interrupt happens */
+    lowcore->io_new_psw.mask = PSW_MASK_ZMODE;
+    lowcore->io_new_psw.addr = (uint64_t)&&IOIntWakeup; /* Wake-up address */
+
+    /* Enable io interrupts subclass mask */
+    asm volatile("stctg 6,6,%0" : "=S" (ctl6) : : "memory");
+    ctl6 |= 0x00000000FF000000;
+    asm volatile("lctlg 6,6,%0" : : "S" (ctl6));
+
+    /* Set wait psw enabled for io interrupt */
+    wait_psw.mask = (PSW_MASK_ZMODE | PSW_MASK_IOINT | PSW_MASK_WAIT);
+    asm volatile("lpswe %0" : : "Q" (wait_psw) : "cc");
+
+    panic("await_io_int: lpswe failed!!\n");
+
+IOIntWakeup:
+    /* Should never happen - all other subchannels are disabled by default */
+    IPL_assert(lowcore->subchannel_nr == sch_no,
+               "Interrupt from unexpected device");
+
+    /* Disable all subclasses of I/O interrupts for this cpu */
+    asm volatile("stctg 6,6,%0" : "=S" (ctl6) : : "memory");
+    ctl6 &= ~(0x00000000FF000000);
+    asm volatile("lctlg 6,6,%0" : : "S" (ctl6));
+}
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 7b07d75..d8e2955 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -127,7 +127,23 @@ struct tpi_info {
     __u32 reserved4  : 12;
 } __attribute__ ((packed, aligned(4)));
 
-/* channel command word (type 1) */
+/* channel command word (format 0) */
+typedef struct ccw0 {
+    __u8 cmd_code;
+    __u32 cda        : 24;
+    __u32 chainData  : 1;
+    __u32 chain      : 1;
+    __u32 sli        : 1;
+    __u32 skip       : 1;
+    __u32 pci        : 1;
+    __u32 ida        : 1;
+    __u32 suspend    : 1;
+    __u32 mida       : 1;
+    __u8 reserved;
+    __u16 count;
+} __attribute__ ((packed, aligned(8))) Ccw0;
+
+/* channel command word (format 1) */
 typedef struct ccw1 {
     __u8 cmd_code;
     __u8 flags;
@@ -135,6 +151,10 @@ typedef struct ccw1 {
     __u32 cda;
 } __attribute__ ((packed, aligned(8))) Ccw1;
 
+/* do_cio() CCW formats */
+#define CCW_FMT0                 0x00
+#define CCW_FMT1                 0x01
+
 #define CCW_FLAG_DC              0x80
 #define CCW_FLAG_CC              0x40
 #define CCW_FLAG_SLI             0x20
@@ -215,6 +235,9 @@ typedef struct irb {
 
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
+__u16 cu_type(SubChannelId schid);
+void await_io_int(uint16_t sch_no);
+int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt);
 
 /*
  * Some S390 specific IO instructions as inline
-- 
2.7.4
