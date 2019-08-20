Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ABBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1302082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1302082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyaT-0000Fb-1b
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8z-0005zw-PZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8y-0003qB-1F
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12097)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8x-0003iK-NG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24EEE300BEAC;
 Tue, 20 Aug 2019 07:01:17 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9C860F88;
 Tue, 20 Aug 2019 07:01:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:54 +0200
Message-Id: <1566284395-30287-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 20 Aug 2019 07:01:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 35/36] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When executing script in lsi_execute_script(), the LSI scsi adapter
emulator advances 's->dsp' index to read next opcode. This can lead
to an infinite loop if the next opcode is empty. Move the existing
loop exit after 10k iterations so that it covers no-op opcodes as
well.

Reported-by: Bugs SysSec <bugs-syssec@rub.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 10468c1..72f7b59 100644
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
1.8.3.1



