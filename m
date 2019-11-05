Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7EC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD31B21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD31B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6WY-0007hd-BQ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5qb-0002ke-06
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5qZ-0003Ak-Jh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:54:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5qZ-0003AI-Bl; Tue, 05 Nov 2019 15:54:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KsVFX043595; Tue, 5 Nov 2019 15:54:37 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3e19w8mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:54:37 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KsaDh044098;
 Tue, 5 Nov 2019 15:54:36 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3e19w8k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:54:36 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5Knxfc018313;
 Tue, 5 Nov 2019 20:53:22 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01wdc.us.ibm.com with ESMTP id 2w11e7177y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:22 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrIHl53871066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:18 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70D46124052;
 Tue,  5 Nov 2019 20:53:18 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D6AE12405B;
 Tue,  5 Nov 2019 20:53:18 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:18 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/55] scsi: lsi: exit infinite loop while executing script
 (CVE-2019-12068)
Date: Tue,  5 Nov 2019 14:52:42 -0600
Message-Id: <20191105205243.3766-55-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

When executing script in lsi_execute_script(), the LSI scsi adapter
emulator advances 's->dsp' index to read next opcode. This can lead
to an infinite loop if the next opcode is empty. Move the existing
loop exit after 10k iterations so that it covers no-op opcodes as
well.

Reported-by: Bugs SysSec <bugs-syssec@rub.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit de594e47659029316bbf9391efb79da0a1a08e08)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/lsi53c895a.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 10468c1ec1..72f7b59ab5 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -185,6 +185,9 @@ static const char *names[] = {
 /* Flag set if this is a tagged command.  */
 #define LSI_TAG_VALID     (1 << 16)
 
+/* Maximum instructions to process. */
+#define LSI_MAX_INSN    10000
+
 typedef struct lsi_request {
     SCSIRequest *req;
     uint32_t tag;
@@ -1132,7 +1135,21 @@ static void lsi_execute_script(LSIState *s)
 
     s->istat1 |= LSI_ISTAT1_SRUN;
 again:
-    insn_processed++;
+    if (++insn_processed > LSI_MAX_INSN) {
+        /* Some windows drivers make the device spin waiting for a memory
+           location to change.  If we have been executed a lot of code then
+           assume this is the case and force an unexpected device disconnect.
+           This is apparently sufficient to beat the drivers into submission.
+         */
+        if (!(s->sien0 & LSI_SIST0_UDC)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "lsi_scsi: inf. loop with UDC masked");
+        }
+        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
+        lsi_disconnect(s);
+        trace_lsi_execute_script_stop();
+        return;
+    }
     insn = read_dword(s, s->dsp);
     if (!insn) {
         /* If we receive an empty opcode increment the DSP by 4 bytes
@@ -1569,19 +1586,7 @@ again:
             }
         }
     }
-    if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
-        /* Some windows drivers make the device spin waiting for a memory
-           location to change.  If we have been executed a lot of code then
-           assume this is the case and force an unexpected device disconnect.
-           This is apparently sufficient to beat the drivers into submission.
-         */
-        if (!(s->sien0 & LSI_SIST0_UDC)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "lsi_scsi: inf. loop with UDC masked");
-        }
-        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
-        lsi_disconnect(s);
-    } else if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting == LSI_NOWAIT) {
+    if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting == LSI_NOWAIT) {
         if (s->dcntl & LSI_DCNTL_SSM) {
             lsi_script_dma_interrupt(s, LSI_DSTAT_SSI);
         } else {
@@ -1969,6 +1974,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
     case 0x2f: /* DSP[24:31] */
         s->dsp &= 0x00ffffff;
         s->dsp |= val << 24;
+        /*
+         * FIXME: if s->waiting != LSI_NOWAIT, this will only execute one
+         * instruction.  Is this correct?
+         */
         if ((s->dmode & LSI_DMODE_MAN) == 0
             && (s->istat1 & LSI_ISTAT1_SRUN) == 0)
             lsi_execute_script(s);
@@ -1987,6 +1996,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
         break;
     case 0x3b: /* DCNTL */
         s->dcntl = val & ~(LSI_DCNTL_PFF | LSI_DCNTL_STD);
+        /*
+         * FIXME: if s->waiting != LSI_NOWAIT, this will only execute one
+         * instruction.  Is this correct?
+         */
         if ((val & LSI_DCNTL_STD) && (s->istat1 & LSI_ISTAT1_SRUN) == 0)
             lsi_execute_script(s);
         break;
-- 
2.17.1


