Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1DF212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1DF212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokh5-0000j7-UP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokbj-0006SG-EP; Fri, 26 Jun 2020 05:25:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34382
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokbh-0005e0-RU; Fri, 26 Jun 2020 05:25:15 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokbf-0007bz-Kq; Fri, 26 Jun 2020 10:25:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Fri, 26 Jun 2020 10:23:15 +0100
Message-Id: <20200626092317.3875-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
References: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 20/22] adb: only call autopoll callbacks when autopoll is not
 blocked
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

Handle this at the ADB bus level so that individual implementations do not need
to handle this themselves.

Finally add an assert() into adb_request() to prevent developers from accidentally
making an explicit ADB request without blocking autopoll.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200623204936.24064-21-mark.cave-ayland@ilande.co.uk>
---
 hw/input/adb.c    | 7 +++++--
 hw/misc/mac_via.c | 6 +-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 70aa1f4570..fe0f6c7ef3 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -86,10 +86,11 @@ static int do_adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf,
 
 int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
 {
+    assert(s->autopoll_blocked);
+
     return do_adb_request(s, obuf, buf, len);
 }
 
-/* XXX: move that to cuda ? */
 int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
 {
     ADBDevice *d;
@@ -181,7 +182,9 @@ static void adb_autopoll(void *opaque)
 {
     ADBBusState *s = opaque;
 
-    s->autopoll_cb(s->autopoll_cb_opaque);
+    if (!s->autopoll_blocked) {
+        s->autopoll_cb(s->autopoll_cb_opaque);
+    }
 
     timer_mod(s->autopoll_timer,
               qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 71b6f92645..d76d7b28d3 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -615,11 +615,7 @@ static void adb_via_poll(void *opaque)
      * received, however we must block autopoll until the point where
      * the entire reply has been read back to the host
      */
-    if (adb_bus->autopoll_blocked) {
-        return;
-    } else {
-        adb_autopoll_block(adb_bus);
-    }
+    adb_autopoll_block(adb_bus);
 
     m->adb_data_in_index = 0;
     m->adb_data_out_index = 0;
-- 
2.20.1


