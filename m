Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85862C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53952206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixLGYziU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53952206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqDo-0005vU-Kg
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAt-00015s-Gt
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAq-0007SZ-8L
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Co9wodFwNQgOYcGNEqwkwsaqy/+vDOfCIdf+CIoN+U=;
 b=ixLGYziUpodw5w9IXI8jY/ZSsHdAfMA+D2dt45RznOGn25Um7yd7tO1MH+ZJTxSHXJvXiZ
 1lJln4IHsFTGF9ZoJk4lvfzZbNNTXX6bVmU4o16LbyWvhBHY3kVcMohrFXtxHurAx18lsX
 z2JPhba2BfXXY8JOPWJGffp78Vx9Eh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-DRW_1XZvPIKMJaWiS0yUcQ-1; Fri, 24 Jul 2020 01:23:07 -0400
X-MC-Unique: DRW_1XZvPIKMJaWiS0yUcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD6A6189CEE0;
 Fri, 24 Jul 2020 05:23:06 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0F4D7AC80;
 Fri, 24 Jul 2020 05:23:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] ide: remove magic constants from the device register
Date: Fri, 24 Jul 2020 01:22:58 -0400
Message-Id: <20200724052300.1163728-6-jsnow@redhat.com>
In-Reply-To: <20200724052300.1163728-1-jsnow@redhat.com>
References: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(In QEMU, we call this the "select" register.)

My memory isn't good enough to memorize what these magic runes
do. Label them to prevent mixups from happening in the future.

Side note: I assume it's safe to always set 0xA0 even though ATA2 claims
these bits are reserved, because ATA3 immediately reinstated that these
bits should be always on. ATA4 and subsequent specs only claim that the
fields are obsolete, so I assume it's safe to leave these set and that
it should work with the widest array of guests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide/internal.h | 11 +++++++++++
 hw/ide/core.c             | 26 ++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 16d806e0cf..d5a6ba1056 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -29,6 +29,17 @@ typedef struct IDEDMAOps IDEDMAOps;
 
 #define MAX_IDE_DEVS 2
 
+/* Device/Head ("select") Register */
+#define ATA_DEV_SELECT          0x10
+/* ATA1,3: Defined as '1'.
+ * ATA2:   Reserved.
+ * ATA3-7: obsolete. */
+#define ATA_DEV_ALWAYS_ON       0xA0
+#define ATA_DEV_LBA             0x40
+#define ATA_DEV_LBA_MSB         0x0F  /* LBA 24:27 */
+#define ATA_DEV_HS              0x0F  /* HS 3:0 */
+
+
 /* Bits of HD_STATUS */
 #define ERR_STAT		0x01
 #define INDEX_STAT		0x02
diff --git a/hw/ide/core.c b/hw/ide/core.c
index f35864070b..5f4f004312 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -367,7 +367,7 @@ fill_buffer:
 
 static void ide_set_signature(IDEState *s)
 {
-    s->select &= 0xf0; /* clear head */
+    s->select &= ~(ATA_DEV_HS); /* clear head */
     /* put signature */
     s->nsector = 1;
     s->sector = 1;
@@ -586,7 +586,7 @@ void ide_transfer_stop(IDEState *s)
 int64_t ide_get_sector(IDEState *s)
 {
     int64_t sector_num;
-    if (s->select & 0x40) {
+    if (s->select & (ATA_DEV_LBA)) {
         if (s->lba48) {
             sector_num = ((int64_t)s->hob_hcyl << 40) |
                 ((int64_t) s->hob_lcyl << 32) |
@@ -595,13 +595,13 @@ int64_t ide_get_sector(IDEState *s)
                 ((int64_t) s->lcyl << 8) | s->sector;
         } else {
             /* LBA28 */
-            sector_num = ((s->select & 0x0f) << 24) | (s->hcyl << 16) |
-                (s->lcyl << 8) | s->sector;
+            sector_num = ((s->select & (ATA_DEV_LBA_MSB)) << 24) |
+                (s->hcyl << 16) | (s->lcyl << 8) | s->sector;
         }
     } else {
         /* CHS */
         sector_num = ((s->hcyl << 8) | s->lcyl) * s->heads * s->sectors +
-            (s->select & 0x0f) * s->sectors + (s->sector - 1);
+            (s->select & (ATA_DEV_HS)) * s->sectors + (s->sector - 1);
     }
 
     return sector_num;
@@ -610,7 +610,7 @@ int64_t ide_get_sector(IDEState *s)
 void ide_set_sector(IDEState *s, int64_t sector_num)
 {
     unsigned int cyl, r;
-    if (s->select & 0x40) {
+    if (s->select & (ATA_DEV_LBA)) {
         if (s->lba48) {
             s->sector = sector_num;
             s->lcyl = sector_num >> 8;
@@ -620,7 +620,8 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
             s->hob_hcyl = sector_num >> 40;
         } else {
             /* LBA28 */
-            s->select = (s->select & 0xf0) | (sector_num >> 24);
+            s->select = (s->select & ~(ATA_DEV_LBA_MSB)) |
+                ((sector_num >> 24) & (ATA_DEV_LBA_MSB));
             s->hcyl = (sector_num >> 16);
             s->lcyl = (sector_num >> 8);
             s->sector = (sector_num);
@@ -631,7 +632,8 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
         r = sector_num % (s->heads * s->sectors);
         s->hcyl = cyl >> 8;
         s->lcyl = cyl;
-        s->select = (s->select & 0xf0) | ((r / s->sectors) & 0x0f);
+        s->select = (s->select & ~(ATA_DEV_HS)) |
+            ((r / s->sectors) & (ATA_DEV_HS));
         s->sector = (r % s->sectors) + 1;
     }
 }
@@ -1302,10 +1304,10 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         break;
     case ATA_IOPORT_WR_DEVICE_HEAD:
         ide_clear_hob(bus);
-        bus->ifs[0].select = val | 0xa0;
-        bus->ifs[1].select = val | 0xa0;
+        bus->ifs[0].select = val | (ATA_DEV_ALWAYS_ON);
+        bus->ifs[1].select = val | (ATA_DEV_ALWAYS_ON);
         /* select drive */
-        bus->unit = (val >> 4) & 1;
+        bus->unit = (val & (ATA_DEV_SELECT)) ? 1 : 0;
         break;
     default:
     case ATA_IOPORT_WR_COMMAND:
@@ -1343,7 +1345,7 @@ static void ide_reset(IDEState *s)
     s->hob_lcyl = 0;
     s->hob_hcyl = 0;
 
-    s->select = 0xa0;
+    s->select = (ATA_DEV_ALWAYS_ON);
     s->status = READY_STAT | SEEK_STAT;
 
     s->lba48 = 0;
-- 
2.26.2


