Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71627206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZP5S5GNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71627206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqDk-0005pO-Na
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAq-0000yw-Bq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAm-0007RW-02
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhGJpZGOCRF1db9wHuts2huHwM/xClDsqI5d+Pu/uiM=;
 b=ZP5S5GNNVRsMd47hgsmsX8Kdr70rIIETuu5UuSmaDAu1JsCi5+j/iutqP9DSWMpNQyE9KO
 ewZ9QCHjjnW1Jl/edaqOS90hMHK1zlSo0Szv6sqkDpOGeT9ZZAL9CaEO19ZtY4XlaFdJ1j
 JthduXC3jD4GJ5PlXGgD5LeixW0i/G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-yovbNaBNM7KeG_6B3rtXOg-1; Fri, 24 Jul 2020 01:23:05 -0400
X-MC-Unique: yovbNaBNM7KeG_6B3rtXOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3719A8005B0;
 Fri, 24 Jul 2020 05:23:04 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 932F57AC80;
 Fri, 24 Jul 2020 05:23:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] ide: model HOB correctly
Date: Fri, 24 Jul 2020 01:22:56 -0400
Message-Id: <20200724052300.1163728-4-jsnow@redhat.com>
In-Reply-To: <20200724052300.1163728-1-jsnow@redhat.com>
References: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I have been staring at this FIXME for years and I never knew what it
meant. I finally stumbled across it!

When writing to the command registers, the old value is shifted into a
HOB copy of the register and the new value is written into the primary
register. When reading registers, the value retrieved is dependent on
the HOB bit in the CONTROL register.

By setting bit 7 (0x80) in CONTROL, any register read will, if it has
one, yield the HOB value for that register instead.

Our code has a problem: We were using bit 7 of the DEVICE register to
model this. We use bus->cmd roughly as the control register already, as
it stores the value from ide_ctrl_write.

Lastly, all command register writes reset the HOB, so fix that, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide/internal.h |  1 +
 hw/ide/core.c             | 15 +++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 10ea6e1e23..16d806e0cf 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -58,6 +58,7 @@ typedef struct IDEDMAOps IDEDMAOps;
 #define TAG_MASK		0xf8
 
 /* Bits of Device Control register */
+#define IDE_CTRL_HOB            0x80
 #define IDE_CTRL_RESET          0x04
 #define IDE_CTRL_DISABLE_IRQ    0x02
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5cedebc408..a880b91b47 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1215,8 +1215,7 @@ static void ide_cmd_lba48_transform(IDEState *s, int lba48)
 static void ide_clear_hob(IDEBus *bus)
 {
     /* any write clears HOB high bit of device control register */
-    bus->ifs[0].select &= ~(1 << 7);
-    bus->ifs[1].select &= ~(1 << 7);
+    bus->cmd &= ~(IDE_CTRL_HOB);
 }
 
 /* IOport [W]rite [R]egisters */
@@ -1256,12 +1255,14 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         return;
     }
 
+    /* NOTE: Device0 and Device1 both receive incoming register writes.
+     * (They're on the same bus! They have to!) */
+
     switch (reg_num) {
     case 0:
         break;
     case ATA_IOPORT_WR_FEATURES:
         ide_clear_hob(bus);
-        /* NOTE: data is written to the two drives */
         bus->ifs[0].hob_feature = bus->ifs[0].feature;
         bus->ifs[1].hob_feature = bus->ifs[1].feature;
         bus->ifs[0].feature = val;
@@ -1296,7 +1297,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         bus->ifs[1].hcyl = val;
         break;
     case ATA_IOPORT_WR_DEVICE_HEAD:
-        /* FIXME: HOB readback uses bit 7 */
+        ide_clear_hob(bus);
         bus->ifs[0].select = val | 0xa0;
         bus->ifs[1].select = val | 0xa0;
         /* select drive */
@@ -1304,7 +1305,7 @@ void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         break;
     default:
     case ATA_IOPORT_WR_COMMAND:
-        /* command */
+        ide_clear_hob(bus);
         ide_exec_cmd(bus, val);
         break;
     }
@@ -2142,9 +2143,7 @@ uint32_t ide_ioport_read(void *opaque, uint32_t addr)
     int ret, hob;
 
     reg_num = addr & 7;
-    /* FIXME: HOB readback uses bit 7, but it's always set right now */
-    //hob = s->select & (1 << 7);
-    hob = 0;
+    hob = bus->cmd & (IDE_CTRL_HOB);
     switch (reg_num) {
     case ATA_IOPORT_RR_DATA:
         ret = 0xff;
-- 
2.26.2


