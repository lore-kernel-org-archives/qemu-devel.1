Received: from eggs.gnu.org ([209.51.188.92]:43770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3SM-0007ME-7b
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3SK-0004PP-Be
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49758
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hC3SK-0004OF-1H
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34EPpXb055109
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 10:35:03 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnkfp1dj6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:35:01 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 4 Apr 2019 15:35:00 +0100
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  4 Apr 2019 10:34:28 -0400
In-Reply-To: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1554388475-18329-10-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v6 09/16] s390-bios: cio error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Add verbose error output for when unexpected i/o errors happen. This eases the
burden of debugging and reporting i/o errors. No error information is printed
in the success case, here is an example of what is output on error:

cio device error
  ssid  : 0x0000000000000000
  cssid : 0x0000000000000000
  sch_no: 0x0000000000000000

Interrupt Response Block Data:
    Function Ctrl : [Start]
    Activity Ctrl : [Start-Pending]
    Status Ctrl : [Alert] [Primary] [Secondary] [Status-Pending]
    Device Status : [Unit-Check]
    Channel Status :
    cpa=: 0x000000007f8d6038
    prev_ccw=: 0x0000000000000000
    this_ccw=: 0x0000000000000000
Eckd Dasd Sense Data (fmt 32-bytes):
    Sense Condition Flags :
    Residual Count     =: 0x0000000000000000
    Phys Drive ID      =: 0x000000000000009e
    low cyl address    =: 0x0000000000000000
    head addr & hi cyl =: 0x0000000000000000
    format/message     =: 0x0000000000000008
    fmt-dependent[0-7] =: 0x0000000000000004
    fmt-dependent[8-15]=: 0xe561282305082fff
    prog action code   =: 0x0000000000000016
    Configuration info =: 0x00000000000040e0
    mcode / hi-cyl     =: 0x0000000000000000
    cyl & head addr [0]=: 0x0000000000000000
    cyl & head addr [1]=: 0x0000000000000000
    cyl & head addr [2]=: 0x0000000000000000

The Sense Data section is currently only printed for ECKD DASD.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/cio.c  | 235 ++++++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/libc.h |  11 +++
 2 files changed, 246 insertions(+)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index c43e50b..339ec5f 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -85,6 +85,228 @@ static bool irb_error(Irb *irb)
     return irb->scsw.dstat != (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
 }
 
+static void print_eckd_dasd_sense_data(SenseDataEckdDasd *sd)
+{
+    char msgline[512];
+
+    if (sd->config_info & 0x8000) {
+        sclp_print("Eckd Dasd Sense Data (fmt 24-bytes):\n");
+    } else {
+        sclp_print("Eckd Dasd Sense Data (fmt 32-bytes):\n");
+    }
+
+    strcat(msgline, "    Sense Condition Flags :");
+    if (sd->common_status & SNS_STAT0_CMD_REJECT) {
+        strcat(msgline, " [Cmd-Reject]");
+    }
+    if (sd->common_status & SNS_STAT0_INTERVENTION_REQ) {
+        strcat(msgline, " [Intervention-Required]");
+    }
+    if (sd->common_status & SNS_STAT0_BUS_OUT_CHECK) {
+        strcat(msgline, " [Bus-Out-Parity-Check]");
+    }
+    if (sd->common_status & SNS_STAT0_EQUIPMENT_CHECK) {
+        strcat(msgline, " [Equipment-Check]");
+    }
+    if (sd->common_status & SNS_STAT0_DATA_CHECK) {
+        strcat(msgline, " [Data-Check]");
+    }
+    if (sd->common_status & SNS_STAT0_OVERRUN) {
+        strcat(msgline, " [Overrun]");
+    }
+    if (sd->common_status & SNS_STAT0_INCOMPL_DOMAIN) {
+        strcat(msgline, " [Incomplete-Domain]");
+    }
+
+    if (sd->status[0] & SNS_STAT1_PERM_ERR) {
+        strcat(msgline, " [Permanent-Error]");
+    }
+    if (sd->status[0] & SNS_STAT1_INV_TRACK_FORMAT) {
+        strcat(msgline, " [Invalid-Track-Fmt]");
+    }
+    if (sd->status[0] & SNS_STAT1_EOC) {
+        strcat(msgline, " [End-of-Cyl]");
+    }
+    if (sd->status[0] & SNS_STAT1_MESSAGE_TO_OPER) {
+        strcat(msgline, " [Operator-Msg]");
+    }
+    if (sd->status[0] & SNS_STAT1_NO_REC_FOUND) {
+        strcat(msgline, " [No-Record-Found]");
+    }
+    if (sd->status[0] & SNS_STAT1_FILE_PROTECTED) {
+        strcat(msgline, " [File-Protected]");
+    }
+    if (sd->status[0] & SNS_STAT1_WRITE_INHIBITED) {
+        strcat(msgline, " [Write-Inhibited]");
+    }
+    if (sd->status[0] & SNS_STAT1_IMPRECISE_END) {
+        strcat(msgline, " [Imprecise-Ending]");
+    }
+
+    if (sd->status[1] & SNS_STAT2_REQ_INH_WRITE) {
+        strcat(msgline, " [Req-Inhibit-Write]");
+    }
+    if (sd->status[1] & SNS_STAT2_CORRECTABLE) {
+        strcat(msgline, " [Correctable-Data-Check]");
+    }
+    if (sd->status[1] & SNS_STAT2_FIRST_LOG_ERR) {
+        strcat(msgline, " [First-Error-Log]");
+    }
+    if (sd->status[1] & SNS_STAT2_ENV_DATA_PRESENT) {
+        strcat(msgline, " [Env-Data-Present]");
+    }
+    if (sd->status[1] & SNS_STAT2_IMPRECISE_END) {
+        strcat(msgline, " [Imprecise-End]");
+    }
+    strcat(msgline, "\n");
+    sclp_print(msgline);
+
+    print_int("    Residual Count     =", sd->res_count);
+    print_int("    Phys Drive ID      =", sd->phys_drive_id);
+    print_int("    low cyl address    =", sd->low_cyl_addr);
+    print_int("    head addr & hi cyl =", sd->head_high_cyl_addr);
+    print_int("    format/message     =", sd->fmt_msg);
+    print_int("    fmt-dependent[0-7] =", sd->fmt_dependent_info[0]);
+    print_int("    fmt-dependent[8-15]=", sd->fmt_dependent_info[1]);
+    print_int("    prog action code   =", sd->program_action_code);
+    print_int("    Configuration info =", sd->config_info);
+    print_int("    mcode / hi-cyl     =", sd->mcode_hicyl);
+    print_int("    cyl & head addr [0]=", sd->cyl_head_addr[0]);
+    print_int("    cyl & head addr [1]=", sd->cyl_head_addr[1]);
+    print_int("    cyl & head addr [2]=", sd->cyl_head_addr[2]);
+}
+
+static void print_irb_err(Irb *irb)
+{
+    uint64_t this_ccw = *(uint64_t *)u32toptr(irb->scsw.cpa);
+    uint64_t prev_ccw = *(uint64_t *)u32toptr(irb->scsw.cpa - 8);
+    char msgline[256];
+
+    sclp_print("Interrupt Response Block Data:\n");
+
+    strcat(msgline, "    Function Ctrl :");
+    if (irb->scsw.ctrl & SCSW_FCTL_START_FUNC) {
+        strcat(msgline, " [Start]");
+    }
+    if (irb->scsw.ctrl & SCSW_FCTL_HALT_FUNC) {
+        strcat(msgline, " [Halt]");
+    }
+    if (irb->scsw.ctrl & SCSW_FCTL_CLEAR_FUNC) {
+        strcat(msgline, " [Clear]");
+    }
+    strcat(msgline, "\n");
+    sclp_print(msgline);
+
+    msgline[0] = '\0';
+    strcat(msgline, "    Activity Ctrl :");
+    if (irb->scsw.ctrl & SCSW_ACTL_RESUME_PEND) {
+        strcat(msgline, " [Resume-Pending]");
+    }
+    if (irb->scsw.ctrl & SCSW_ACTL_START_PEND) {
+        strcat(msgline, " [Start-Pending]");
+    }
+    if (irb->scsw.ctrl & SCSW_ACTL_HALT_PEND) {
+        strcat(msgline, " [Halt-Pending]");
+    }
+    if (irb->scsw.ctrl & SCSW_ACTL_CLEAR_PEND) {
+        strcat(msgline, " [Clear-Pending]");
+    }
+    if (irb->scsw.ctrl & SCSW_ACTL_CH_ACTIVE) {
+        strcat(msgline, " [Channel-Active]");
+    }
+    if (irb->scsw.ctrl & SCSW_ACTL_DEV_ACTIVE) {
+        strcat(msgline, " [Device-Active]");
+    }
+    if (irb->scsw.ctrl & SCSW_ACTL_SUSPENDED) {
+        strcat(msgline, " [Suspended]");
+    }
+    strcat(msgline, "\n");
+    sclp_print(msgline);
+
+    msgline[0] = '\0';
+    strcat(msgline, "    Status Ctrl :");
+    if (irb->scsw.ctrl & SCSW_SCTL_ALERT) {
+        strcat(msgline, " [Alert]");
+    }
+    if (irb->scsw.ctrl & SCSW_SCTL_INTERMED) {
+        strcat(msgline, " [Intermediate]");
+    }
+    if (irb->scsw.ctrl & SCSW_SCTL_PRIMARY) {
+        strcat(msgline, " [Primary]");
+    }
+    if (irb->scsw.ctrl & SCSW_SCTL_SECONDARY) {
+        strcat(msgline, " [Secondary]");
+    }
+    if (irb->scsw.ctrl & SCSW_SCTL_STATUS_PEND) {
+        strcat(msgline, " [Status-Pending]");
+    }
+
+    strcat(msgline, "\n");
+    sclp_print(msgline);
+
+    msgline[0] = '\0';
+    strcat(msgline, "    Device Status :");
+    if (irb->scsw.dstat & SCSW_DSTAT_ATTN) {
+        strcat(msgline, " [Attention]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_STATMOD) {
+        strcat(msgline, " [Status-Modifier]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_CUEND) {
+        strcat(msgline, " [Ctrl-Unit-End]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_BUSY) {
+        strcat(msgline, " [Busy]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_CHEND) {
+        strcat(msgline, " [Channel-End]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_DEVEND) {
+        strcat(msgline, " [Device-End]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_UCHK) {
+        strcat(msgline, " [Unit-Check]");
+    }
+    if (irb->scsw.dstat & SCSW_DSTAT_UEXCP) {
+        strcat(msgline, " [Unit-Exception]");
+    }
+    strcat(msgline, "\n");
+    sclp_print(msgline);
+
+    msgline[0] = '\0';
+    strcat(msgline, "    Channel Status :");
+    if (irb->scsw.cstat & SCSW_CSTAT_PCINT) {
+        strcat(msgline, " [Program-Ctrl-Interruption]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_BADLEN) {
+        strcat(msgline, " [Incorrect-Length]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_PROGCHK) {
+        strcat(msgline, " [Program-Check]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_PROTCHK) {
+        strcat(msgline, " [Protection-Check]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_CHDCHK) {
+        strcat(msgline, " [Channel-Data-Check]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_CHCCHK) {
+        strcat(msgline, " [Channel-Ctrl-Check]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_ICCHK) {
+        strcat(msgline, " [Interface-Ctrl-Check]");
+    }
+    if (irb->scsw.cstat & SCSW_CSTAT_CHAINCHK) {
+        strcat(msgline, " [Chaining-Check]");
+    }
+    strcat(msgline, "\n");
+    sclp_print(msgline);
+
+    print_int("    cpa=", irb->scsw.cpa);
+    print_int("    prev_ccw=", prev_ccw);
+    print_int("    this_ccw=", this_ccw);
+}
+
 /*
  * Handles executing ssch, tsch and returns the irb obtained from tsch.
  * Returns 0 on success, -1 if unexpected status pending and we need to retry,
@@ -180,6 +402,19 @@ int do_cio(SubChannelId schid, uint16_t cutype, uint32_t ccw_addr, int fmt)
             continue;
         }
 
+        sclp_print("cio device error\n");
+        print_int("  ssid  ", schid.ssid);
+        print_int("  cssid ", schid.cssid);
+        print_int("  sch_no", schid.sch_no);
+        print_int("  ctrl-unit type", cutype);
+        sclp_print("\n");
+        print_irb_err(&irb);
+        if (cutype == CU_TYPE_DASD_3990 || cutype == CU_TYPE_DASD_2107 ||
+            cutype == CU_TYPE_UNKNOWN) {
+            if (!basic_sense(schid, cutype, &sd, sizeof(sd))) {
+                print_eckd_dasd_sense_data(&sd);
+            }
+        }
         rc = -1;
         break;
     }
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 818517f..bcdc457 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -67,6 +67,17 @@ static inline size_t strlen(const char *str)
     return i;
 }
 
+static inline char *strcat(char *dest, const char *src)
+{
+    int i;
+    char *dest_end = dest + strlen(dest);
+
+    for (i = 0; i <= strlen(src); i++) {
+        dest_end[i] = src[i];
+    }
+    return dest;
+}
+
 static inline int isdigit(int c)
 {
     return (c >= '0') && (c <= '9');
-- 
2.7.4
