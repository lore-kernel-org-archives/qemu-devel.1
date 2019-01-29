Received: from eggs.gnu.org ([209.51.188.92]:60307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSd-00006l-QZ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSc-0000L3-65
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48878
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSc-0000CG-1Y
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDR7HG114354
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:43 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qapcgd51a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:43 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:42 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:17 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Add struct for format-0 ccws. Support executing format-0 channel
programs and waiting for their completion before continuing execution.
This will be used for real dasd ipl.

Add cu_type() to channel io library. This will be used to query control
unit type which is used to determine if we are booting a virtio device or a
real dasd device.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/cio.c      | 114 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h      | 127 ++++++++++++++++++++++++++++++++++++++++++--
 pc-bios/s390-ccw/s390-ccw.h |   1 +
 pc-bios/s390-ccw/start.S    |  33 +++++++++++-
 4 files changed, 270 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 095f79b..63581c6 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "s390-arch.h"
 #include "cio.h"
 
 static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
@@ -39,3 +40,116 @@ void enable_subchannel(SubChannelId schid)
     schib.pmcw.ena = 1;
     msch(schid, &schib);
 }
+
+uint16_t cu_type(SubChannelId schid)
+{
+    Ccw1 sense_id_ccw;
+    SenseId sense_data;
+
+    sense_id_ccw.cmd_code = CCW_CMD_SENSE_ID;
+    sense_id_ccw.cda = ptr2u32(&sense_data);
+    sense_id_ccw.count = sizeof(sense_data);
+    sense_id_ccw.flags |= CCW_FLAG_SLI;
+
+    if (do_cio(schid, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
+        panic("Failed to run SenseID CCw\n");
+    }
+
+    return sense_data.cu_type;
+}
+
+void basic_sense(SubChannelId schid, void *sense_data, uint16_t data_size)
+{
+    Ccw1 senseCcw;
+
+    senseCcw.cmd_code = CCW_CMD_BASIC_SENSE;
+    senseCcw.cda = ptr2u32(sense_data);
+    senseCcw.count = data_size;
+
+    if (do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1)) {
+        panic("Failed to run Basic Sense CCW\n");
+    }
+}
+
+static bool irb_error(Irb *irb)
+{
+    if (irb->scsw.cstat) {
+        return true;
+    }
+    return irb->scsw.dstat != (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
+}
+
+/*
+ * Executes a channel program at a given subchannel. The request to run the
+ * channel program is sent to the subchannel, we then wait for the interrupt
+ * signaling completion of the I/O operation(s) performed by the channel
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
+    CmdOrb orb = {};
+    Irb irb = {};
+    sense_data_eckd_dasd sd;
+    int rc, retries = 0;
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
+    while (true) {
+        rc = ssch(schid, &orb);
+        if (rc == 1) {
+            /* Status pending, not sure why. Let's eat the status and retry. */
+            tsch(schid, &irb);
+            retries++;
+            continue;
+        }
+        if (rc) {
+            print_int("ssch failed with rc=", rc);
+            break;
+        }
+
+        consume_io_int();
+
+        /* collect status */
+        rc = tsch(schid, &irb);
+        if (rc) {
+            print_int("tsch failed with rc=", rc);
+            break;
+        }
+
+        if (!irb_error(&irb)) {
+            break;
+        }
+
+        /*
+         * Unexpected unit check, or interface-control-check. Use sense to
+         * clear unit check then retry.
+         */
+        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <= 2) {
+            basic_sense(schid, &sd, sizeof(sd));
+            retries++;
+            continue;
+        }
+
+        break;
+    }
+
+    return rc;
+}
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 7b07d75..1086f31 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -70,9 +70,46 @@ struct scsw {
     __u16 count;
 } __attribute__ ((packed));
 
-#define SCSW_FCTL_CLEAR_FUNC 0x1000
-#define SCSW_FCTL_HALT_FUNC 0x2000
+/* Function Control */
 #define SCSW_FCTL_START_FUNC 0x4000
+#define SCSW_FCTL_HALT_FUNC 0x2000
+#define SCSW_FCTL_CLEAR_FUNC 0x1000
+
+/* Activity Control */
+#define SCSW_ACTL_RESUME_PEND   0x0800
+#define SCSW_ACTL_START_PEND    0x0400
+#define SCSW_ACTL_HALT_PEND     0x0200
+#define SCSW_ACTL_CLEAR_PEND    0x0100
+#define SCSW_ACTL_CH_ACTIVE     0x0080
+#define SCSW_ACTL_DEV_ACTIVE    0x0040
+#define SCSW_ACTL_SUSPENDED     0x0020
+
+/* Status Control */
+#define SCSW_SCTL_ALERT         0x0010
+#define SCSW_SCTL_INTERMED      0x0008
+#define SCSW_SCTL_PRIMARY       0x0004
+#define SCSW_SCTL_SECONDARY     0x0002
+#define SCSW_SCTL_STATUS_PEND   0x0001
+
+/* SCSW Device Status Flags */
+#define SCSW_DSTAT_ATTN     0x80
+#define SCSW_DSTAT_STATMOD  0x40
+#define SCSW_DSTAT_CUEND    0x20
+#define SCSW_DSTAT_BUSY     0x10
+#define SCSW_DSTAT_CHEND    0x08
+#define SCSW_DSTAT_DEVEND   0x04
+#define SCSW_DSTAT_UCHK     0x02
+#define SCSW_DSTAT_UEXCP    0x01
+
+/* SCSW Subchannel Status Flags */
+#define SCSW_CSTAT_PCINT    0x80
+#define SCSW_CSTAT_BADLEN   0x40
+#define SCSW_CSTAT_PROGCHK  0x20
+#define SCSW_CSTAT_PROTCHK  0x10
+#define SCSW_CSTAT_CHDCHK   0x08
+#define SCSW_CSTAT_CHCCHK   0x04
+#define SCSW_CSTAT_ICCHK    0x02
+#define SCSW_CSTAT_CHAINCHK 0x01
 
 /*
  * subchannel information block
@@ -127,7 +164,23 @@ struct tpi_info {
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
@@ -135,6 +188,10 @@ typedef struct ccw1 {
     __u32 cda;
 } __attribute__ ((packed, aligned(8))) Ccw1;
 
+/* do_cio() CCW formats */
+#define CCW_FMT0                 0x00
+#define CCW_FMT1                 0x01
+
 #define CCW_FLAG_DC              0x80
 #define CCW_FLAG_CC              0x40
 #define CCW_FLAG_SLI             0x20
@@ -190,6 +247,9 @@ struct ciw {
     __u16 count;
 };
 
+#define CU_TYPE_VIRTIO          0x3832
+#define CU_TYPE_DASD_3990       0x3990
+
 /*
  * sense-id response buffer layout
  */
@@ -205,6 +265,64 @@ typedef struct senseid {
     struct ciw ciw[62];
 }  __attribute__ ((packed, aligned(4))) SenseId;
 
+/*
+ * architected values for first sense byte - common_status. Bits 0-5 of this
+ * field are common to all device types.
+ */
+#define SNS_STAT0_CMD_REJECT         0x80
+#define SNS_STAT0_INTERVENTION_REQ   0x40
+#define SNS_STAT0_BUS_OUT_CHECK      0x20
+#define SNS_STAT0_EQUIPMENT_CHECK    0x10
+#define SNS_STAT0_DATA_CHECK         0x08
+#define SNS_STAT0_OVERRUN            0x04
+#define SNS_STAT0_INCOMPL_DOMAIN     0x01
+
+/* ECKD DASD status[0] byte */
+#define SNS_STAT1_PERM_ERR           0x80
+#define SNS_STAT1_INV_TRACK_FORMAT   0x40
+#define SNS_STAT1_EOC                0x20
+#define SNS_STAT1_MESSAGE_TO_OPER    0x10
+#define SNS_STAT1_NO_REC_FOUND       0x08
+#define SNS_STAT1_FILE_PROTECTED     0x04
+#define SNS_STAT1_WRITE_INHIBITED    0x02
+#define SNS_STAT1_IMPRECISE_END      0x01
+
+/* ECKD DASD status[1] byte */
+#define SNS_STAT2_REQ_INH_WRITE      0x80
+#define SNS_STAT2_CORRECTABLE        0x40
+#define SNS_STAT2_FIRST_LOG_ERR      0x20
+#define SNS_STAT2_ENV_DATA_PRESENT   0x10
+#define SNS_STAT2_IMPRECISE_END      0x04
+
+/* ECKD DASD 24-byte Sense fmt_msg codes */
+#define SENSE24_FMT_PROG_SYS    0x0
+#define SENSE24_FMT_EQUIPMENT   0x2
+#define SENSE24_FMT_CONTROLLER  0x3
+#define SENSE24_FMT_MISC        0xF
+
+/* basic sense response buffer layout */
+typedef struct sense_data_eckd_dasd {
+    uint8_t common_status;
+    uint8_t status[2];
+    uint8_t res_count;
+    uint8_t phys_drive_id;
+    uint8_t low_cyl_addr;
+    uint8_t head_high_cyl_addr;
+    uint8_t fmt_msg;
+    uint64_t fmt_dependent_info[2];
+    uint8_t reserved;
+    uint8_t program_action_code;
+    uint16_t config_info;
+    uint8_t mcode_hicyl;
+    uint8_t cyl_head_addr[3];
+}  __attribute__ ((packed, aligned(4))) sense_data_eckd_dasd;
+
+#define ECKD_SENSE24_GET_FMT(sd)     (sd->fmt_msg & 0xF0 >> 4)
+#define ECKD_SENSE24_GET_MSG(sd)     (sd->fmt_msg & 0x0F)
+
+#define unit_check(irb)         ((irb)->scsw.dstat & SCSW_DSTAT_UCHK)
+#define iface_ctrl_check(irb)   ((irb)->scsw.cstat & SCSW_CSTAT_ICCHK)
+
 /* interruption response block */
 typedef struct irb {
     struct scsw scsw;
@@ -215,6 +333,9 @@ typedef struct irb {
 
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
+uint16_t cu_type(SubChannelId schid);
+void basic_sense(SubChannelId schid, void *sense_data, uint16_t data_size);
+int do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt);
 
 /*
  * Some S390 specific IO instructions as inline
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b39ee5d..11bce7d 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -52,6 +52,7 @@ typedef unsigned long long __u64;
 /* start.s */
 void disabled_wait(void);
 void consume_sclp_int(void);
+void consume_io_int(void);
 
 /* main.c */
 void panic(const char *string);
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index eb8d024..22b38ec 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -65,12 +65,32 @@ consume_sclp_int:
         /* prepare external call handler */
         larl %r1, external_new_code
         stg %r1, 0x1b8
-        larl %r1, external_new_mask
+        larl %r1, int_new_mask
         mvc 0x1b0(8),0(%r1)
         /* load enabled wait PSW */
         larl %r1, enabled_wait_psw
         lpswe 0(%r1)
 
+/*
+ * void consume_io_int(void)
+ *
+ * eats one I/O interrupt
+ */
+        .globl consume_io_int
+consume_io_int:
+        /* enable I/O interrupts in cr6 */
+        stctg 6,6,0(15)
+        oi 4(15), 0xff
+        lctlg 6,6,0(15)
+        /* prepare i/o call handler */
+        larl %r1, io_new_code
+        stg %r1, 0x1f8
+        larl %r1, int_new_mask
+        mvc 0x1f0(8),0(%r1)
+        /* load enabled wait PSW */
+        larl %r1, enabled_wait_psw
+        lpswe 0(%r1)
+
 external_new_code:
         /* disable service interrupts in cr0 */
         stctg 0,0,0(15)
@@ -78,10 +98,19 @@ external_new_code:
         lctlg 0,0,0(15)
         br 14
 
+io_new_code:
+        /* disable I/O interrupts in cr6 */
+        stctg 6,6,0(15)
+        ni 4(15), 0x00
+        lctlg 6,6,0(15)
+        br 14
+
+
+
         .align  8
 disabled_wait_psw:
         .quad   0x0002000180000000,0x0000000000000000
 enabled_wait_psw:
         .quad   0x0302000180000000,0x0000000000000000
-external_new_mask:
+int_new_mask:
         .quad   0x0000000180000000
-- 
2.7.4
