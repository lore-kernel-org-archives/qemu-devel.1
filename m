Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04DC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2159233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2159233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0h3H-0004US-GJ
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 02:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0gxn-0007Ik-Ei
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0gxj-0004dN-Hy
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0gxj-0004am-5A
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01826308427C;
 Thu, 22 Aug 2019 06:52:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AECA10018F9;
 Thu, 22 Aug 2019 06:52:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7FCE593C9; Thu, 22 Aug 2019 08:52:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 08:52:39 +0200
Message-Id: <20190822065242.12496-3-kraxel@redhat.com>
In-Reply-To: <20190822065242.12496-1-kraxel@redhat.com>
References: <20190822065242.12496-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 06:52:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/5] usb-redir: merge interrupt packets
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Martin Cerveny <M.Cerveny@computer.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Martin Cerveny <M.Cerveny@computer.org>

Interrupt packets (limited by wMaxPacketSize) should be buffered and merged
by algorithm described in USB spec.
(see usb_20.pdf/5.7.3 Interrupt Transfer Packet Size Constraints).

Signed-off-by: Martin Cerveny <M.Cerveny@computer.org>
Message-id: 20190724125859.14624-2-M.Cerveny@computer.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 71 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index be15b9f30334..e0f5ca6f818b 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -819,8 +819,8 @@ static void usbredir_handle_interrupt_in_data(USBRedirDevice *dev,
                                               USBPacket *p, uint8_t ep)
 {
     /* Input interrupt endpoint, buffered packet input */
-    struct buf_packet *intp;
-    int status, len;
+    struct buf_packet *intp, *intp_to_free;
+    int status, len, sum;
 
     if (!dev->endpoint[EP2I(ep)].interrupt_started &&
             !dev->endpoint[EP2I(ep)].interrupt_error) {
@@ -839,9 +839,17 @@ static void usbredir_handle_interrupt_in_data(USBRedirDevice *dev,
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
@@ -852,18 +860,42 @@ static void usbredir_handle_interrupt_in_data(USBRedirDevice *dev,
         }
         return;
     }
-    DPRINTF("interrupt-token-in ep %02X status %d len %d\n", ep,
-            intp->status, intp->len);
-
-    status = intp->status;
-    len = intp->len;
-    if (len > p->iov.size) {
-        ERROR("received int data is larger then packet ep %02X\n", ep);
-        len = p->iov.size;
-        status = usb_redir_babble;
+
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
+    }
+    if (intp_to_free) {
+        bufp_free(dev, intp_to_free, ep);
     }
-    usb_packet_copy(p, intp->data, len);
-    bufp_free(dev, intp, ep);
+    DPRINTF("interrupt-token-in ep %02X summary status %d len %d\n", ep,
+            status, sum);
     usbredir_handle_status(dev, p, status);
 }
 
@@ -2041,22 +2073,17 @@ static void usbredir_interrupt_packet(void *priv, uint64_t id,
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
2.18.1


