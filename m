Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE660C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F1020663
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq3h-0007rn-PD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsl-00056m-2x; Tue, 23 Jun 2020 16:51:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56444
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsj-0001wO-9n; Tue, 23 Jun 2020 16:51:02 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsg-0007T1-4M; Tue, 23 Jun 2020 21:51:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Tue, 23 Jun 2020 21:49:28 +0100
Message-Id: <20200623204936.24064-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/22] adb: use adb_request() only for explicit requests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently adb_request() is called both for explicit ADB requests and internal
autopoll requests via adb_poll().

Move the current functionality into do_adb_request() to be used internally and
add a simple adb_request() wrapper for explicit requests.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/input/adb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index a7a482fdfa..b3ad7c5fca 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -38,7 +38,8 @@ static void adb_device_reset(ADBDevice *d)
     qdev_reset_all(DEVICE(d));
 }
 
-int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
+static int do_adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf,
+                          int len)
 {
     ADBDevice *d;
     ADBDeviceClass *adc;
@@ -83,6 +84,11 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
     return ADB_RET_NOTPRESENT;
 }
 
+int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
+{
+    return do_adb_request(s, obuf, buf, len);
+}
+
 /* XXX: move that to cuda ? */
 int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
 {
@@ -98,7 +104,7 @@ int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
         d = s->devices[s->poll_index];
         if ((1 << d->devaddr) & poll_mask) {
             buf[0] = ADB_READREG | (d->devaddr << 4);
-            olen = adb_request(s, obuf + 1, buf, 1);
+            olen = do_adb_request(s, obuf + 1, buf, 1);
             /* if there is data, we poll again the same device */
             if (olen > 0) {
                 s->status |= ADB_STATUS_POLLREPLY;
-- 
2.20.1


