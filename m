Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F2F20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB1ys1+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F2F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqFj-0007yH-Lm
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAv-0001B2-Cd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAt-0007Ta-Cb
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lw3sIMw7bwLzLn8HrEwoFK0CDMSMemR+m8VLVz6kxxc=;
 b=WB1ys1+RjykSH6d1gLjC+M8XgntkIZiQGsvrFhnjh9XDMUL+bVqsMdlqBfqEp6ELxahoO0
 2jiZ+gGbvjB5f8UbRQ19Ot3zA0pL3iNSOJBfRLyYOroN6gi3hLDS9R0hUo0nMLwo0hCzYD
 eoZRTTef4S8jV43cTRIqk7aBe71olaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-SYtFfmeTPdikeFqDmzCSbg-1; Fri, 24 Jul 2020 01:23:10 -0400
X-MC-Unique: SYtFfmeTPdikeFqDmzCSbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04CAD189CEE0;
 Fri, 24 Jul 2020 05:23:09 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6FFA7AC94;
 Fri, 24 Jul 2020 05:23:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] ide: cancel pending callbacks on SRST
Date: Fri, 24 Jul 2020 01:23:00 -0400
Message-Id: <20200724052300.1163728-8-jsnow@redhat.com>
In-Reply-To: <20200724052300.1163728-1-jsnow@redhat.com>
References: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SRST implementation did not keep up with the rest of IDE; it is
possible to perform a weak reset on an IDE device to remove the BSY/DRQ
bits, and then issue writes to the control/device registers which can
cause chaos with the state machine.

Fix that by actually performing a real reset.

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: https://bugs.launchpad.net/qemu/+bug/1878253
Fixes: https://bugs.launchpad.net/qemu/+bug/1887303
Fixes: https://bugs.launchpad.net/qemu/+bug/1887309
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 58 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index e4c69a7fde..4da689abdf 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2241,6 +2241,37 @@ uint32_t ide_status_read(void *opaque, uint32_t addr)
     return ret;
 }
 
+static void ide_perform_srst(IDEState *s)
+{
+    s->status |= BUSY_STAT;
+
+    /* Halt PIO (Via register state); PIO BH remains scheduled. */
+    ide_transfer_halt(s);
+
+    /* Cancel DMA -- may drain block device and invoke callbacks */
+    ide_cancel_dma_sync(s);
+
+    /* Cancel PIO callback, reset registers/signature, etc */
+    ide_reset(s);
+
+    if (s->drive_kind == IDE_CD) {
+        /* ATAPI drives do not set READY or SEEK */
+        s->status = 0x00;
+    }
+}
+
+static void ide_bus_perform_srst(void *opaque)
+{
+    IDEBus *bus = opaque;
+    IDEState *s;
+    int i;
+
+    for (i = 0; i < 2; i++) {
+        s = &bus->ifs[i];
+        ide_perform_srst(s);
+    }
+}
+
 void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
 {
     IDEBus *bus = opaque;
@@ -2249,26 +2280,17 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
 
     trace_ide_ctrl_write(addr, val, bus);
 
-    /* common for both drives */
-    if (!(bus->cmd & IDE_CTRL_RESET) &&
-        (val & IDE_CTRL_RESET)) {
-        /* reset low to high */
-        for(i = 0;i < 2; i++) {
+    /* Device0 and Device1 each have their own control register,
+     * but QEMU models it as just one register in the controller. */
+    if ((bus->cmd & IDE_CTRL_RESET) &&
+        !(val & IDE_CTRL_RESET)) {
+        /* SRST triggers on falling edge */
+        for (i = 0; i < 2; i++) {
             s = &bus->ifs[i];
-            s->status = BUSY_STAT | SEEK_STAT;
-            s->error = 0x01;
-        }
-    } else if ((bus->cmd & IDE_CTRL_RESET) &&
-               !(val & IDE_CTRL_RESET)) {
-        /* high to low */
-        for(i = 0;i < 2; i++) {
-            s = &bus->ifs[i];
-            if (s->drive_kind == IDE_CD)
-                s->status = 0x00; /* NOTE: READY is _not_ set */
-            else
-                s->status = READY_STAT | SEEK_STAT;
-            ide_set_signature(s);
+            s->status |= BUSY_STAT;
         }
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                ide_bus_perform_srst, bus);
     }
 
     bus->cmd = val;
-- 
2.26.2


