Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13557CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E2920663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E2920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPFV-0007NJ-MG
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 12:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iOPCr-0002mr-Je
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iOPCp-00015Q-K3
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:46:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iOPCk-00010W-Mg; Sat, 26 Oct 2019 12:46:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2fDr-1iQKTd1UyN-004BSz; Sat, 26 Oct 2019 18:45:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v15 02/11] esp: move get_cmd() post-DMA code to get_cmd_cb()
Date: Sat, 26 Oct 2019 18:45:37 +0200
Message-Id: <20191026164546.30020-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191026164546.30020-1-laurent@vivier.eu>
References: <20191026164546.30020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qEwX5isbFNGa0zQho3Hseq3pj3GSiGKiFqKHJbbFyY2mh/Bf0j1
 70PMse50bIjIxXLfq4YIb0LWOHaOhZ3nRMVVX0YtKGxuaEjg3zFNsTRvmWTGuYPxMVIusmv
 m70lIMbjzumH++uMrEYekDRStGvrVCbiz67KT5GCJ/RP84yDWsu3ZKRuvZ8p8Z4OGTKpvXA
 tL6sTHGQpC7v/Fa3UQJQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eEAII27mZ5U=:wVNMsteehC0GcWfyeYN4Ki
 kfBtajpZTdZbOQK5sB3Onu1K1YZfKoULudzEfe177VOGvsT7zZlkoO/wh6jT23VMx6zbBF8Cr
 QEOb0WV3T0HWv+Ce78fS3eE/RO8RBeH34lV/4xKhVUueDSnb1mZayccO9hRDbvrxrY0GU/56A
 mcepC+zHF1oeFCv493RMkHqqgVWF5RstjqAgzpZ6ORex5+6XshZVq+bJ5mSVVZqW9uuD4PLok
 3dWLy72NtU7i/oE5nyoYrOh/3F4mwRv9yqQMFlwz7NKJ+meQh8xboXDXoMOLNKJueZ7P6IPA8
 9Q6j1QJ3X3bR2JpF+UwS05pbEpatV3sU+Q8lAp3LRGHv5AvnfEhimbFjvGUrd9Gg/tT0LY6/4
 h0aPVC/23IfoOF6Z+eYoanNXxbWLBOjDIG4TGxnE3o/MA5FD6Cn40MWC85ruT9xeGXIrGSJLA
 fyGv5UxDpnQI+peP7Ws5f/bizNfoqaJBIZKcwFtZ8oI/dCmg4wZzKOr8BGpztZ1uCX9qQLdhv
 Uq5bnAylyqI1TLMothR9WmTz5ngAlydGG1YQLlsaGTfhIJMgzJIGn7mS7ymBIyWKKif2B7Mg6
 gq5P8Z0StdQU65Vb/EFTXMYdZkYojUbTAKYkDYPpG/rOsVNiClNM0SZwdVePYkcVor73Ldn5/
 vnjcYgYjqHN6y9fUs3WCq7skrGr3n66k7v5pKOfMlnddwoZj7FuTxQLcz6whcsv7edDKhK9SD
 YpN/e41kccqENWWOU6yybWinkyEuuq8FKQ0gwAaWy0fGPIDo5UlyivUu/oHmyFsoF9cUqrZiD
 CWGeam0e+T0RPYtJ2QTJc4SDHn0bQRpDcYlnOKuK17jxF+vtZ0RDDfqOe0ZAhLTUKd8XcKbmi
 Bu2sQgZQb99BXiDxmyEA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be needed to implement pseudo-DMA

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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


