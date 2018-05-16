Received: from eggs.gnu.org ([2001:4830:134:3::10]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjelen@redhat.com>) id 1fIv2A-0005Xi-2Z
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjelen@redhat.com>) id 1fIv26-0005Hn-IC
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:55:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjelen@redhat.com>) id 1fIv26-0005Gs-D8
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5978F4201AE9
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:55:49 +0000 (UTC)
From: jjelen@redhat.com
Date: Wed, 16 May 2018 13:55:44 +0200
Message-Id: <20180516115544.3897-2-jjelen@redhat.com>
In-Reply-To: <20180516115544.3897-1-jjelen@redhat.com>
References: <20180516115544.3897-1-jjelen@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] hw/usb/dev-smartcard-reader: Handle 64 B
 USB packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jakub Jelen <jjelen@redhat.com>

From: Jakub Jelen <jjelen@redhat.com>

The current code was not correctly handling 64 B (Max USB 1.1 payload size)
packets and therefore preventing some of the messages from smart card to
pass through to the guest.

If the smart card in host responded with 34 B of data in APDU layer, the
CCID headers added up to 64 B. The packet was send, but not correctly
committed per USB specification (8.5.3.2  Variable-length Data Stage):

>   When all of the data structure is returned to the host, the function
> should indicate that the Data stage is ended by returning a packet
> that is shorter than the MaxPacketSize for the pipe.  If the data
> structure is an exact multiple of wMaxPacketSize for the pipe, the
> function will return a zero-length packet to indicate the end of the
> Data stage.

This lead the guest applications to timeout while waiting for the rest
of data (the emulation layer is answering with NAK until the timeout).

This patch is checking the current maximum packet size and if the
payload of this size is detected, the message buffer is not yet released.
With the next call, the empty buffer is sent and the message buffer
is finally released.

Signed-off-by: Jakub Jelen <jjelen@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index cabb564788..f7451923f4 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1064,7 +1064,8 @@ err:
     return;
 }
 
-static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
+static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
+    unsigned int max_packet_size)
 {
     int len = 0;
 
@@ -1072,10 +1073,13 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
     if (s->current_bulk_in != NULL) {
         len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
                   p->iov.size);
-        usb_packet_copy(p, s->current_bulk_in->data +
-                        s->current_bulk_in->pos, len);
+        if (len) {
+            usb_packet_copy(p, s->current_bulk_in->data +
+                            s->current_bulk_in->pos, len);
+        }
         s->current_bulk_in->pos += len;
-        if (s->current_bulk_in->pos == s->current_bulk_in->len) {
+        if (s->current_bulk_in->pos == s->current_bulk_in->len
+            && len != max_packet_size) {
             ccid_bulk_in_release(s);
         }
     } else {
@@ -1107,7 +1111,7 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
     case USB_TOKEN_IN:
         switch (p->ep->nr) {
         case CCID_BULK_IN_EP:
-            ccid_bulk_in_copy_to_guest(s, p);
+            ccid_bulk_in_copy_to_guest(s, p, dev->ep_ctl.max_packet_size);
             break;
         case CCID_INT_IN_EP:
             if (s->notify_slot_change) {
-- 
2.14.3
