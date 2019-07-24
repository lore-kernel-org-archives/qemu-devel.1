Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41130C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B85218B8
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B85218B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=computer.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGrr-00070U-Am
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <M.Cerveny@computer.org>) id 1hqGrc-0006DB-CH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <M.Cerveny@computer.org>) id 1hqGrb-00016q-5s
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:59:24 -0400
Received: from 2001-1ae9-0158-5901-ecc0-4afa-64c0-20f1.ip6.tmcz.cz
 ([2001:1ae9:158:5901:ecc0:4afa:64c0:20f1]:49878 helo=xen3.c-home.cz)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <M.Cerveny@computer.org>)
 id 1hqGra-00016O-Or
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:59:23 -0400
Received: from xen3.c-home.cz (localhost [127.0.0.1])
 by xen3.c-home.cz (8.15.2/8.15.2) with ESMTP id x6OCx5sj014849;
 Wed, 24 Jul 2019 14:59:20 +0200
From: Martin Cerveny <M.Cerveny@computer.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 24 Jul 2019 14:58:59 +0200
Message-Id: <20190724125859.14624-2-M.Cerveny@computer.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724125859.14624-1-M.Cerveny@computer.org>
References: <20190724125859.14624-1-M.Cerveny@computer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:1ae9:158:5901:ecc0:4afa:64c0:20f1
Subject: [Qemu-devel] [PATCH 1/1] usb-redir: merge interrupt packets
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
Cc: qemu-devel@nongnu.org, Martin Cerveny <M.Cerveny@computer.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Interrupt packets (limited by wMaxPacketSize) should be buffered and merged
by algorithm described in USB spec.
(see usb_20.pdf/5.7.3 Interrupt Transfer Packet Size Constraints).

Signed-off-by: Martin Cerveny <M.Cerveny@computer.org>
---
 hw/usb/redirect.c | 69 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 998fc6e4b0..0c0c86878c 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -815,8 +815,8 @@ static void usbredir_handle_interrupt_in_data(USBRedirDevice *dev,
                                               USBPacket *p, uint8_t ep)
 {
     /* Input interrupt endpoint, buffered packet input */
-    struct buf_packet *intp;
-    int status, len;
+    struct buf_packet *intp, *intp_to_free;
+    int status, len, sum;
 
     if (!dev->endpoint[EP2I(ep)].interrupt_started &&
             !dev->endpoint[EP2I(ep)].interrupt_error) {
@@ -835,9 +835,17 @@ static void usbredir_handle_interrupt_in_data(USBRedirDevice *dev,
         dev->endpoint[EP2I(ep)].bufpq_dropping_packets = 0;
     }
 
-    intp = QTAILQ_FIRST(&dev->endpoint[EP2I(ep)].bufpq);
+    /* check for completed interrupt message (with all fragments) */
+    sum = 0;
+    QTAILQ_FOREACH(intp, &dev->endpoint[EP2I(ep)].bufpq, next) {
+        sum += intp->len;
+        if (intp->len < dev->endpoint[EP2I(ep)].max_packet_size ||
+            sum >= p->iov.size)
+            break;
+    }
+
     if (intp == NULL) {
-        DPRINTF2("interrupt-token-in ep %02X, no intp\n", ep);
+        DPRINTF2("interrupt-token-in ep %02X, no intp, buffered %d\n", ep, sum);
         /* Check interrupt_error for stream errors */
         status = dev->endpoint[EP2I(ep)].interrupt_error;
         dev->endpoint[EP2I(ep)].interrupt_error = 0;
@@ -848,18 +856,42 @@ static void usbredir_handle_interrupt_in_data(USBRedirDevice *dev,
         }
         return;
     }
-    DPRINTF("interrupt-token-in ep %02X status %d len %d\n", ep,
-            intp->status, intp->len);
 
-    status = intp->status;
-    len = intp->len;
-    if (len > p->iov.size) {
-        ERROR("received int data is larger then packet ep %02X\n", ep);
-        len = p->iov.size;
-        status = usb_redir_babble;
+    /* copy of completed interrupt message */
+    sum = 0;
+    status = usb_redir_success;
+    intp_to_free = NULL;
+    QTAILQ_FOREACH(intp, &dev->endpoint[EP2I(ep)].bufpq, next) {
+        if (intp_to_free) {
+            bufp_free(dev, intp_to_free, ep);
+        }
+        DPRINTF("interrupt-token-in ep %02X fragment status %d len %d\n", ep,
+                intp->status, intp->len);
+
+        sum += intp->len;
+        len = intp->len;
+        if (status == usb_redir_success) {
+            status = intp->status;
+        }
+        if (sum > p->iov.size) {
+            ERROR("received int data is larger then packet ep %02X\n", ep);
+            len -= (sum - p->iov.size);
+            sum = p->iov.size;
+            status = usb_redir_babble;
+        }
+
+        usb_packet_copy(p, intp->data, len);
+
+        intp_to_free = intp;
+        if (intp->len < dev->endpoint[EP2I(ep)].max_packet_size ||
+            sum >= p->iov.size)
+            break;
     }
-    usb_packet_copy(p, intp->data, len);
-    bufp_free(dev, intp, ep);
+    if (intp_to_free) {
+        bufp_free(dev, intp_to_free, ep);
+    }
+    DPRINTF("interrupt-token-in ep %02X summary status %d len %d\n", ep,
+            status, sum);
     usbredir_handle_status(dev, p, status);
 }
 
@@ -2032,22 +2064,17 @@ static void usbredir_interrupt_packet(void *priv, uint64_t id,
     }
 
     if (ep & USB_DIR_IN) {
-        bool q_was_empty;
-
         if (dev->endpoint[EP2I(ep)].interrupt_started == 0) {
             DPRINTF("received int packet while not started ep %02X\n", ep);
             free(data);
             return;
         }
 
-        q_was_empty = QTAILQ_EMPTY(&dev->endpoint[EP2I(ep)].bufpq);
-
         /* bufp_alloc also adds the packet to the ep queue */
         bufp_alloc(dev, data, data_len, interrupt_packet->status, ep, data);
 
-        if (q_was_empty) {
-            usb_wakeup(usb_ep_get(&dev->dev, USB_TOKEN_IN, ep & 0x0f), 0);
-        }
+        /* insufficient data solved with USB_RET_NAK */
+        usb_wakeup(usb_ep_get(&dev->dev, USB_TOKEN_IN, ep & 0x0f), 0);
     } else {
         /*
          * We report output interrupt packets as completed directly upon
-- 
2.20.1


