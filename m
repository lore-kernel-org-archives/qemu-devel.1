Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC36C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD51F206C9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxZHTl5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD51F206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO362-0007me-Vg
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fa-0003Y1-05
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fW-0006pO-Rk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601574422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hsx9Nql06fYoiWOehfxk009P/c16XD32+LqOt/kOyJA=;
 b=AxZHTl5fX+iYfGKjzeFyFD+C7skXy0IqmFGS5Tpu6qVJjAMSCyHM6O/EMa0wGtu3kklp6R
 +2UjLjS0diorcgt2L/+jqt/gaAs5gYSemjR44qy71lP+HUBbiiVviHAkL+QA+fjPQfYy/z
 IrmAFfMXELu4HFqVOwExDbJrvv50QzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-XK7JhAEZPlSmkHF-SCZ0Sw-1; Thu, 01 Oct 2020 13:47:00 -0400
X-MC-Unique: XK7JhAEZPlSmkHF-SCZ0Sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F018801AC2;
 Thu,  1 Oct 2020 17:46:59 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3A3E5C1CF;
 Thu,  1 Oct 2020 17:46:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 5/9] ide: model HOB correctly
Date: Thu,  1 Oct 2020 13:46:45 -0400
Message-Id: <20201001174649.1911016-6-jsnow@redhat.com>
In-Reply-To: <20201001174649.1911016-1-jsnow@redhat.com>
References: <20201001174649.1911016-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
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
index a23bb2f3481..5b7b0e47e60 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -58,6 +58,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 #define TAG_MASK		0xf8
 
 /* Bits of Device Control register */
+#define IDE_CTRL_HOB            0x80
 #define IDE_CTRL_RESET          0x04
 #define IDE_CTRL_DISABLE_IRQ    0x02
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 29dc5dc4b45..6ececa5dfee 100644
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


