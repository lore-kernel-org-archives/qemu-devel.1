Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2AFC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C1E212F5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C1E212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeRX-00015D-Sb
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK5-0003NC-16
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK3-0003i4-Bz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeK3-0003hY-3Z; Thu, 25 Apr 2019 09:21:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F40D30944F2;
	Thu, 25 Apr 2019 13:21:54 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD2C15C652;
	Thu, 25 Apr 2019 13:21:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:24 +0200
Message-Id: <20190425132134.2839-10-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 25 Apr 2019 13:21:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/19] s390-bios: cio error handling
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
Message-ID: <20190425132124.dR1t0ifSY_LMcfARTxzjgUkdwgJ4uQtPaSVN_9aFHQ8@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

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
Message-Id: <1554388475-18329-10-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.c  | 235 ++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/libc.h |  11 ++
 2 files changed, 246 insertions(+)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index c43e50b00b8e..339ec5fbe7a4 100644
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
index 818517ff5d44..bcdc45732dd8 100644
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
2.17.2


