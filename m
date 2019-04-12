Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D67C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D81F20652
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D81F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvWz-00035n-La
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:43:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFp-0002S2-D2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFn-0002Y9-A5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFm-0002Vg-Ry; Fri, 12 Apr 2019 08:25:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D01BB81E00;
	Fri, 12 Apr 2019 12:25:55 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B05775D9CC;
	Fri, 12 Apr 2019 12:25:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:15 +0200
Message-Id: <20190412122523.24111-10-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 12 Apr 2019 12:25:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 09/17] s390-bios: cio
 error handling
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
Message-ID: <20190412122515.VgYfZcFq_mN5EQoj9Uc2dFXFiuBB0w2XyoSdwIhBzWI@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Add verbose error output for when unexpected i/o errors happen. This ease=
s the
burden of debugging and reporting i/o errors. No error information is pri=
nted
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
    cpa=3D: 0x000000007f8d6038
    prev_ccw=3D: 0x0000000000000000
    this_ccw=3D: 0x0000000000000000
Eckd Dasd Sense Data (fmt 32-bytes):
    Sense Condition Flags :
    Residual Count     =3D: 0x0000000000000000
    Phys Drive ID      =3D: 0x000000000000009e
    low cyl address    =3D: 0x0000000000000000
    head addr & hi cyl =3D: 0x0000000000000000
    format/message     =3D: 0x0000000000000008
    fmt-dependent[0-7] =3D: 0x0000000000000004
    fmt-dependent[8-15]=3D: 0xe561282305082fff
    prog action code   =3D: 0x0000000000000016
    Configuration info =3D: 0x00000000000040e0
    mcode / hi-cyl     =3D: 0x0000000000000000
    cyl & head addr [0]=3D: 0x0000000000000000
    cyl & head addr [1]=3D: 0x0000000000000000
    cyl & head addr [2]=3D: 0x0000000000000000

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
index c43e50b00b..339ec5fbe7 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -85,6 +85,228 @@ static bool irb_error(Irb *irb)
     return irb->scsw.dstat !=3D (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
 }
=20
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
+    print_int("    Residual Count     =3D", sd->res_count);
+    print_int("    Phys Drive ID      =3D", sd->phys_drive_id);
+    print_int("    low cyl address    =3D", sd->low_cyl_addr);
+    print_int("    head addr & hi cyl =3D", sd->head_high_cyl_addr);
+    print_int("    format/message     =3D", sd->fmt_msg);
+    print_int("    fmt-dependent[0-7] =3D", sd->fmt_dependent_info[0]);
+    print_int("    fmt-dependent[8-15]=3D", sd->fmt_dependent_info[1]);
+    print_int("    prog action code   =3D", sd->program_action_code);
+    print_int("    Configuration info =3D", sd->config_info);
+    print_int("    mcode / hi-cyl     =3D", sd->mcode_hicyl);
+    print_int("    cyl & head addr [0]=3D", sd->cyl_head_addr[0]);
+    print_int("    cyl & head addr [1]=3D", sd->cyl_head_addr[1]);
+    print_int("    cyl & head addr [2]=3D", sd->cyl_head_addr[2]);
+}
+
+static void print_irb_err(Irb *irb)
+{
+    uint64_t this_ccw =3D *(uint64_t *)u32toptr(irb->scsw.cpa);
+    uint64_t prev_ccw =3D *(uint64_t *)u32toptr(irb->scsw.cpa - 8);
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
+    msgline[0] =3D '\0';
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
+    msgline[0] =3D '\0';
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
+    msgline[0] =3D '\0';
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
+    msgline[0] =3D '\0';
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
+    print_int("    cpa=3D", irb->scsw.cpa);
+    print_int("    prev_ccw=3D", prev_ccw);
+    print_int("    this_ccw=3D", this_ccw);
+}
+
 /*
  * Handles executing ssch, tsch and returns the irb obtained from tsch.
  * Returns 0 on success, -1 if unexpected status pending and we need to =
retry,
@@ -180,6 +402,19 @@ int do_cio(SubChannelId schid, uint16_t cutype, uint=
32_t ccw_addr, int fmt)
             continue;
         }
=20
+        sclp_print("cio device error\n");
+        print_int("  ssid  ", schid.ssid);
+        print_int("  cssid ", schid.cssid);
+        print_int("  sch_no", schid.sch_no);
+        print_int("  ctrl-unit type", cutype);
+        sclp_print("\n");
+        print_irb_err(&irb);
+        if (cutype =3D=3D CU_TYPE_DASD_3990 || cutype =3D=3D CU_TYPE_DAS=
D_2107 ||
+            cutype =3D=3D CU_TYPE_UNKNOWN) {
+            if (!basic_sense(schid, cutype, &sd, sizeof(sd))) {
+                print_eckd_dasd_sense_data(&sd);
+            }
+        }
         rc =3D -1;
         break;
     }
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 818517ff5d..bcdc45732d 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -67,6 +67,17 @@ static inline size_t strlen(const char *str)
     return i;
 }
=20
+static inline char *strcat(char *dest, const char *src)
+{
+    int i;
+    char *dest_end =3D dest + strlen(dest);
+
+    for (i =3D 0; i <=3D strlen(src); i++) {
+        dest_end[i] =3D src[i];
+    }
+    return dest;
+}
+
 static inline int isdigit(int c)
 {
     return (c >=3D '0') && (c <=3D '9');
--=20
2.21.0


