Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57117CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DA120873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DA120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9zN-0003aB-31
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zh-0002YO-Vh
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zg-0003xD-LO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:05 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iP9Zg-0003w4-Bq; Mon, 28 Oct 2019 14:17:04 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MpUpW-1hdxG41tG8-00psSJ; Mon, 28 Oct 2019 19:16:52 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] esp: move get_cmd() post-DMA code to get_cmd_cb()
Date: Mon, 28 Oct 2019 19:16:34 +0100
Message-Id: <20191028181643.5143-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
References: <20191028181643.5143-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KoHlabvA03FPSJtuk/zidWr5y9K83Kjw8M/6QBYO9SOrVlvEj0q
 Y+Fx2srY+x9yshKO/JHF0k3ROtiME7Vy+nBvUC0FFcLIxPABVCuf54y1pKWQHp9vdTOBx1T
 KnWPh9qksyK61U687NLS6gPWAyG3GO6kApNJ2vT7ZjiEWt+tNL/tniilDPB5aBS72OPP4Ux
 FZY20yGhpgaS2S6JALd/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/AS9RZQHuQ0=:gn5w/ToHbGeW7B0irQRTDi
 AsUS4MNxHANf041FJEQqpqD+MUJCr3rVlFha10fEkyJv4cKLbHxh4OHGIKKzwUoZ09hJmz/bU
 UeG5LY/Edonh7c8wN7Ja0bTmZdgbxPVHaQhNalhIh7GF+vkW+sRn3j61iHR+SfA5Ue94VpEWS
 dqzaH3xPLxRuDhlKSUf/oYje0HkfAE8TzZYOdUTi0Jjkb/CEQOqFeYwT5QgN4gRnZQTZv59zW
 bPG51kYUj6+umEaI4e1PiC8w7nJD4/fvJFPNCZ65w6Xyw2HGKt3uqH2sMKA7VYqXUTS1LZkeg
 KerEsMKZY16Hzaxt/0xZcWKRiHgtqZZfJhcoxtfCve3D+ADXRK4La2w9vB8N1m4XzZ9ri/cy2
 GLMa4EmssZMVQd04z80wb299IsoG109WCe6ORU9YnbfAjXwotCqOTLHcVXQmFxbewo1+jEaIQ
 koakGuYK1+IJeNhy0ZXIzfV8jaZog+pXKhemcirURI+E14UWIPhqBEFfh3jqK/vl/zGKJtda9
 z0rFyIt2eqtt6/sZKnYoNxzV8xTOh0DJr2As/6w7uuJwWyRDoDEyE1zrXTZUpjWoVszGLrcMO
 hfyEPHBoeVAV2zgPrB0W+oe/mY6/BNx8dwXFlT+zB+lkyRvBenxj4bG5Z0fdVySCtx+j0eXyH
 iInbs2HgaVok5SzpxLo5s2IszbRKPbkOX5lQpfaxOOp6mA/dyiTSBjrBxeBmBrl3AGBISEhuh
 Qro+3vymdKwQNKpHRhKiSEKda2FIoOcw5SStyrCXEse+62H4kRzJSSMwGjteRAq+SLy4llMvb
 3SnaXTJ9MvbW4qBxkLczAhjxKRvmepHkk8ucvP9ebY393hL3r3wl/i2GBtJI4HmkOPn4T36xO
 /PNJMkTo8CvR6IlVpskl0kK9mYS6T0rht8128yTSY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be needed to implement pseudo-DMA

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20191026164546.30020-3-laurent@vivier.eu>
---
 hw/scsi/esp.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 09b28cba17..0230ede21d 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -84,6 +84,34 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
+static int get_cmd_cb(ESPState *s)
+{
+    int target;
+
+    target = s->wregs[ESP_WBUSID] & BUSID_DID;
+
+    s->ti_size = 0;
+    s->ti_rptr = 0;
+    s->ti_wptr = 0;
+
+    if (s->current_req) {
+        /* Started a new command before the old one finished.  Cancel it.  */
+        scsi_req_cancel(s->current_req);
+        s->async_len = 0;
+    }
+
+    s->current_dev = scsi_device_find(&s->bus, 0, target, 0);
+    if (!s->current_dev) {
+        /* No such drive */
+        s->rregs[ESP_RSTAT] = 0;
+        s->rregs[ESP_RINTR] = INTR_DC;
+        s->rregs[ESP_RSEQ] = SEQ_0;
+        esp_raise_irq(s);
+        return -1;
+    }
+    return 0;
+}
+
 static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
 {
     uint32_t dmalen;
@@ -108,23 +136,7 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
     }
     trace_esp_get_cmd(dmalen, target);
 
-    s->ti_size = 0;
-    s->ti_rptr = 0;
-    s->ti_wptr = 0;
-
-    if (s->current_req) {
-        /* Started a new command before the old one finished.  Cancel it.  */
-        scsi_req_cancel(s->current_req);
-        s->async_len = 0;
-    }
-
-    s->current_dev = scsi_device_find(&s->bus, 0, target, 0);
-    if (!s->current_dev) {
-        // No such drive
-        s->rregs[ESP_RSTAT] = 0;
-        s->rregs[ESP_RINTR] = INTR_DC;
-        s->rregs[ESP_RSEQ] = SEQ_0;
-        esp_raise_irq(s);
+    if (get_cmd_cb(s) < 0) {
         return 0;
     }
     return dmalen;
-- 
2.21.0


