Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991F2205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991F2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxs4h-0004Yl-QG
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1hxs3y-00048d-8L
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hxs3w-0007Rn-VO
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hxs3w-0007RY-OM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:07:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F23C7BDA7;
 Wed, 14 Aug 2019 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.10.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ABBB34913;
 Wed, 14 Aug 2019 12:07:24 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Aug 2019 17:35:21 +0530
Message-Id: <20190814120521.20907-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 14 Aug 2019 12:07:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4] scsi: lsi: exit infinite loop while
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Bugs SysSec <bugs-syssec@rub.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When executing script in lsi_execute_script(), the LSI scsi adapter
emulator advances 's->dsp' index to read next opcode. This can lead
to an infinite loop if the next opcode is empty. Exit such loop
after 10k iterations.

Reported-by: Bugs SysSec <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/lsi53c895a.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

Update v4: slightly modify the check and exit
  -> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg02304.html

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 10468c1ec1..72f7b59ab5 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -185,6 +185,9 @@ static const char *names[] =3D {
 /* Flag set if this is a tagged command.  */
 #define LSI_TAG_VALID     (1 << 16)
=20
+/* Maximum instructions to process. */
+#define LSI_MAX_INSN    10000
+
 typedef struct lsi_request {
     SCSIRequest *req;
     uint32_t tag;
@@ -1132,7 +1135,21 @@ static void lsi_execute_script(LSIState *s)
=20
     s->istat1 |=3D LSI_ISTAT1_SRUN;
 again:
-    insn_processed++;
+    if (++insn_processed > LSI_MAX_INSN) {
+        /* Some windows drivers make the device spin waiting for a memor=
y
+           location to change.  If we have been executed a lot of code t=
hen
+           assume this is the case and force an unexpected device discon=
nect.
+           This is apparently sufficient to beat the drivers into submis=
sion.
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
     insn =3D read_dword(s, s->dsp);
     if (!insn) {
         /* If we receive an empty opcode increment the DSP by 4 bytes
@@ -1569,19 +1586,7 @@ again:
             }
         }
     }
-    if (insn_processed > 10000 && s->waiting =3D=3D LSI_NOWAIT) {
-        /* Some windows drivers make the device spin waiting for a memor=
y
-           location to change.  If we have been executed a lot of code t=
hen
-           assume this is the case and force an unexpected device discon=
nect.
-           This is apparently sufficient to beat the drivers into submis=
sion.
-         */
-        if (!(s->sien0 & LSI_SIST0_UDC)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "lsi_scsi: inf. loop with UDC masked");
-        }
-        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
-        lsi_disconnect(s);
-    } else if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting =3D=3D LSI_NOWA=
IT) {
+    if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting =3D=3D LSI_NOWAIT) {
         if (s->dcntl & LSI_DCNTL_SSM) {
             lsi_script_dma_interrupt(s, LSI_DSTAT_SSI);
         } else {
@@ -1969,6 +1974,10 @@ static void lsi_reg_writeb(LSIState *s, int offset=
, uint8_t val)
     case 0x2f: /* DSP[24:31] */
         s->dsp &=3D 0x00ffffff;
         s->dsp |=3D val << 24;
+        /*
+         * FIXME: if s->waiting !=3D LSI_NOWAIT, this will only execute =
one
+         * instruction.  Is this correct?
+         */
         if ((s->dmode & LSI_DMODE_MAN) =3D=3D 0
             && (s->istat1 & LSI_ISTAT1_SRUN) =3D=3D 0)
             lsi_execute_script(s);
@@ -1987,6 +1996,10 @@ static void lsi_reg_writeb(LSIState *s, int offset=
, uint8_t val)
         break;
     case 0x3b: /* DCNTL */
         s->dcntl =3D val & ~(LSI_DCNTL_PFF | LSI_DCNTL_STD);
+        /*
+         * FIXME: if s->waiting !=3D LSI_NOWAIT, this will only execute =
one
+         * instruction.  Is this correct?
+         */
         if ((val & LSI_DCNTL_STD) && (s->istat1 & LSI_ISTAT1_SRUN) =3D=3D=
 0)
             lsi_execute_script(s);
         break;
--=20
2.21.0


