Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DF12053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2fx-0000PX-Nf
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iB2dA-0006FQ-6N
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iB2QA-00027N-JA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iB2QA-00026j-Ds
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77C2230860DF
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 19:48:53 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC4DF5D6D0;
 Thu, 19 Sep 2019 19:48:52 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com
Subject: [RFC 4/4] ahci media error reporting
Date: Thu, 19 Sep 2019 14:48:47 -0500
Message-Id: <20190919194847.18518-5-tasleson@redhat.com>
In-Reply-To: <20190919194847.18518-1-tasleson@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 19 Sep 2019 19:48:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initial attempt at returning a media error for ahci.  This is certainly
wrong and needs serious improvement.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 hw/ide/ahci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d45393c019..f487764106 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -36,6 +36,7 @@
 #include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "ahci_internal.h"
+#include "block/error_inject.h"
=20
 #include "trace.h"
=20
@@ -999,6 +1000,22 @@ static void ncq_err(NCQTransferState *ncq_tfs)
     ncq_tfs->used =3D 0;
 }
=20
+/*
+ * Figure out correct way to report media error, this is at best a guess
+ * and based on the output of linux kernel, not even remotely close.
+ */
+static void ncq_media_err(NCQTransferState *ncq_tfs, uint64_t err_sector=
)
+{
+    IDEState *ide_state =3D &ncq_tfs->drive->port.ifs[0];
+
+    ide_state->error =3D ECC_ERR;
+    ide_state->status =3D READY_STAT | ERR_STAT;
+    ncq_tfs->drive->port_regs.scr_err |=3D (1 << ncq_tfs->tag);
+    ncq_tfs->lba =3D err_sector;
+    qemu_sglist_destroy(&ncq_tfs->sglist);
+    ncq_tfs->used =3D 0;
+}
+
 static void ncq_finish(NCQTransferState *ncq_tfs)
 {
     /* If we didn't error out, set our finished bit. Errored commands
@@ -1065,6 +1082,8 @@ static void execute_ncq_command(NCQTransferState *n=
cq_tfs)
 {
     AHCIDevice *ad =3D ncq_tfs->drive;
     IDEState *ide_state =3D &ad->port.ifs[0];
+    uint64_t error_sector =3D 0;
+    char device_id[32];
     int port =3D ad->port_no;
=20
     g_assert(is_ncq(ncq_tfs->cmd));
@@ -1072,6 +1091,14 @@ static void execute_ncq_command(NCQTransferState *=
ncq_tfs)
=20
     switch (ncq_tfs->cmd) {
     case READ_FPDMA_QUEUED:
+        sprintf(device_id, "%lu", ide_state->wwn);
+
+        if (error_in_read(device_id, ncq_tfs->lba,
+                ncq_tfs->sector_count, &error_sector)) {
+            ncq_media_err(ncq_tfs, error_sector);
+            return;
+        }
+
         trace_execute_ncq_command_read(ad->hba, port, ncq_tfs->tag,
                                        ncq_tfs->sector_count, ncq_tfs->l=
ba);
         dma_acct_start(ide_state->blk, &ncq_tfs->acct,
--=20
2.21.0


