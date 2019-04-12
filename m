Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE92082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvNQ-0001mt-PT
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:33:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFm-0002Ov-RY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFi-0002Us-Vr
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFh-0002Sn-B8; Fri, 12 Apr 2019 08:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50F4D3082E5F;
	Fri, 12 Apr 2019 12:25:51 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55DE75D9CC;
	Fri, 12 Apr 2019 12:25:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:14 +0200
Message-Id: <20190412122523.24111-9-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 12 Apr 2019 12:25:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 08/17] s390-bios:
 Support for running format-0/1 channel programs
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
Message-ID: <20190412122514.MMFVf4nE9hpYjer_9YaLyzfyI_frEJ5QzXbzsKSLJQA@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Introduce a library function for executing format-0 and format-1
channel programs and waiting for their completion before continuing
execution.

Add cu_type() to channel io library. This will be used to query control
unit type which is used to determine if we are booting a virtio device or=
 a
real dasd device.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Message-Id: <1554388475-18329-9-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.c      | 144 ++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h      | 130 +++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/s390-ccw.h |   1 +
 pc-bios/s390-ccw/start.S    |  29 ++++++++
 4 files changed, 301 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 87c6b34e88..c43e50b00b 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -13,10 +13,14 @@
=20
 #include "libc.h"
 #include "s390-ccw.h"
+#include "s390-arch.h"
+#include "helper.h"
 #include "cio.h"
=20
 static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)))=
;
=20
+static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb =
*irb);
+
 int enable_mss_facility(void)
 {
     int ret;
@@ -42,3 +46,143 @@ void enable_subchannel(SubChannelId schid)
     schib.pmcw.ena =3D 1;
     msch(schid, &schib);
 }
+
+uint16_t cu_type(SubChannelId schid)
+{
+    Ccw1 sense_id_ccw;
+    SenseId sense_data;
+
+    sense_id_ccw.cmd_code =3D CCW_CMD_SENSE_ID;
+    sense_id_ccw.cda =3D ptr2u32(&sense_data);
+    sense_id_ccw.count =3D sizeof(sense_data);
+    sense_id_ccw.flags |=3D CCW_FLAG_SLI;
+
+    if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FMT1)=
) {
+        panic("Failed to run SenseID CCw\n");
+    }
+
+    return sense_data.cu_type;
+}
+
+int basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data,
+                 uint16_t data_size)
+{
+    Ccw1 senseCcw;
+    Irb irb;
+
+    senseCcw.cmd_code =3D CCW_CMD_BASIC_SENSE;
+    senseCcw.cda =3D ptr2u32(sense_data);
+    senseCcw.count =3D data_size;
+
+    return __do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1, &irb);
+}
+
+static bool irb_error(Irb *irb)
+{
+    if (irb->scsw.cstat) {
+        return true;
+    }
+    return irb->scsw.dstat !=3D (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
+}
+
+/*
+ * Handles executing ssch, tsch and returns the irb obtained from tsch.
+ * Returns 0 on success, -1 if unexpected status pending and we need to =
retry,
+ * otherwise returns condition code from ssch/tsch for error cases.
+ */
+static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb =
*irb)
+{
+    CmdOrb orb =3D {};
+    int rc;
+
+    IPL_assert(fmt =3D=3D 0 || fmt =3D=3D 1, "Invalid ccw format");
+
+    /* ccw_addr must be <=3D 24 bits and point to at least one whole ccw=
. */
+    if (fmt =3D=3D 0) {
+        IPL_assert(ccw_addr <=3D 0xFFFFFF - 8, "Invalid ccw address");
+    }
+
+    orb.fmt =3D fmt;
+    orb.pfch =3D 1;  /* QEMU's cio implementation requires prefetch */
+    orb.c64 =3D 1;   /* QEMU's cio implementation requires 64-bit idaws =
*/
+    orb.lpm =3D 0xFF; /* All paths allowed */
+    orb.cpa =3D ccw_addr;
+
+    rc =3D ssch(schid, &orb);
+    if (rc =3D=3D 1 || rc =3D=3D 2) {
+        /* Subchannel status pending or busy. Eat status and ask for ret=
ry. */
+        tsch(schid, irb);
+        return -1;
+    }
+    if (rc) {
+        print_int("ssch failed with cc=3D", rc);
+        return rc;
+    }
+
+    consume_io_int();
+
+    /* collect status */
+    rc =3D tsch(schid, irb);
+    if (rc) {
+        print_int("tsch failed with cc=3D", rc);
+    }
+
+    return rc;
+}
+
+/*
+ * Executes a channel program at a given subchannel. The request to run =
the
+ * channel program is sent to the subchannel, we then wait for the inter=
rupt
+ * signaling completion of the I/O operation(s) performed by the channel
+ * program. Lastly we verify that the i/o operation completed without er=
ror and
+ * that the interrupt we received was for the subchannel used to run the
+ * channel program.
+ *
+ * Note: This function assumes it is running in an environment where no =
other
+ * cpus are generating or receiving I/O interrupts. So either run it in =
a
+ * single-cpu environment or make sure all other cpus are not doing I/O =
and
+ * have I/O interrupts masked off. We also assume that only one device i=
s
+ * active (generating i/o interrupts).
+ *
+ * Returns non-zero on error.
+ */
+int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr, int f=
mt)
+{
+    Irb irb =3D {};
+    SenseDataEckdDasd sd;
+    int rc, retries =3D 0;
+
+    while (true) {
+        rc =3D __do_cio(schid, ccw_addr, fmt, &irb);
+
+        if (rc =3D=3D -1) {
+            retries++;
+            continue;
+        }
+        if (rc) {
+            /* ssch/tsch error. Message already reported by __do_cio */
+            break;
+        }
+
+        if (!irb_error(&irb)) {
+            break;
+        }
+
+        /*
+         * Unexpected unit check, or interface-control-check. Use sense =
to
+         * clear (unit check only) then retry.
+         */
+        if ((unit_check(&irb) || iface_ctrl_check(&irb)) && retries <=3D=
 2) {
+            if (unit_check(&irb)) {
+                basic_sense(schid, cutype, &sd, sizeof(sd));
+            }
+            retries++;
+            continue;
+        }
+
+        rc =3D -1;
+        break;
+    }
+
+    return rc;
+}
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 218fd96ea3..1637e32070 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -70,9 +70,46 @@ struct scsw {
     __u16 count;
 } __attribute__ ((packed));
=20
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
=20
 /*
  * subchannel information block
@@ -127,7 +164,23 @@ struct tpi_info {
     __u32 reserved4:12;
 } __attribute__ ((packed, aligned(4)));
=20
-/* channel command word (type 1) */
+/* channel command word (format 0) */
+typedef struct ccw0 {
+    __u8 cmd_code;
+    __u32 cda:24;
+    __u32 chainData:1;
+    __u32 chain:1;
+    __u32 sli:1;
+    __u32 skip:1;
+    __u32 pci:1;
+    __u32 ida:1;
+    __u32 suspend:1;
+    __u32 mida:1;
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
=20
+/* do_cio() CCW formats */
+#define CCW_FMT0                 0x00
+#define CCW_FMT1                 0x01
+
 #define CCW_FLAG_DC              0x80
 #define CCW_FLAG_CC              0x40
 #define CCW_FLAG_SLI             0x20
@@ -190,6 +247,11 @@ struct ciw {
     __u16 count;
 };
=20
+#define CU_TYPE_UNKNOWN         0x0000
+#define CU_TYPE_DASD_2107       0x2107
+#define CU_TYPE_VIRTIO          0x3832
+#define CU_TYPE_DASD_3990       0x3990
+
 /*
  * sense-id response buffer layout
  */
@@ -205,6 +267,64 @@ typedef struct senseid {
     struct ciw ciw[62];
 }  __attribute__ ((packed, aligned(4))) SenseId;
=20
+/*
+ * architected values for first sense byte - common_status. Bits 0-5 of =
this
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
+typedef struct SenseDataEckdDasd {
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
+}  __attribute__ ((packed, aligned(4))) SenseDataEckdDasd;
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
@@ -215,6 +335,10 @@ typedef struct irb {
=20
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
+uint16_t cu_type(SubChannelId schid);
+int basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data,
+                 uint16_t data_size);
+int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr, int f=
mt);
=20
 /*
  * Some S390 specific IO instructions as inline
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index b39ee5d323..11bce7d73c 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -52,6 +52,7 @@ typedef unsigned long long __u64;
 /* start.s */
 void disabled_wait(void);
 void consume_sclp_int(void);
+void consume_io_int(void);
=20
 /* main.c */
 void panic(const char *string);
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 5c22cb0849..aa8fceb19d 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -71,6 +71,26 @@ consume_sclp_int:
         larl %r1, enabled_wait_psw
         lpswe 0(%r1)
=20
+/*
+ * void consume_io_int(void)
+ *
+ * eats one I/O interrupt
+ */
+        .globl consume_io_int
+consume_io_int:
+        /* enable I/O interrupts in cr6 */
+        stctg %c6,%c6,0(%r15)
+        oi    4(%r15), 0xff
+        lctlg %c6,%c6,0(%r15)
+        /* prepare i/o call handler */
+        larl  %r1, io_new_code
+        stg   %r1, 0x1f8
+        larl  %r1, io_new_mask
+        mvc   0x1f0(8),0(%r1)
+        /* load enabled wait PSW */
+        larl  %r1, enabled_wait_psw
+        lpswe 0(%r1)
+
 external_new_code:
         /* disable service interrupts in cr0 */
         stctg   %c0,%c0,0(%r15)
@@ -78,6 +98,13 @@ external_new_code:
         lctlg   %c0,%c0,0(%r15)
         br      %r14
=20
+io_new_code:
+        /* disable I/O interrupts in cr6 */
+        stctg %c6,%c6,0(%r15)
+        ni    4(%r15), 0x00
+        lctlg %c6,%c6,0(%r15)
+        br    %r14
+
         .align  8
 disabled_wait_psw:
         .quad   0x0002000180000000,0x0000000000000000
@@ -85,3 +112,5 @@ enabled_wait_psw:
         .quad   0x0302000180000000,0x0000000000000000
 external_new_mask:
         .quad   0x0000000180000000
+io_new_mask:
+        .quad   0x0000000180000000
--=20
2.21.0


