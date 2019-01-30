Received: from eggs.gnu.org ([209.51.188.92]:58010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor0x-0006sT-6m
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor0w-0001Jl-Ab
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gor0w-0001JB-2M
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:54 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed, 30 Jan 2019 14:37:02 +0000
Message-Id: <1548859022-3969-3-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
References: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 2/2] usb: deal with potential Null pointer
 returned by usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

From: Liam Merwick <Liam.Merwick@oracle.com>

usb_ep_get() can return a Null pointer in the (albeit unlikely) case
that a NULL USBDevice is passed in via the 'dev' parameter.  Before
dereferencing the return value from usb_ep_get(), check its validity
and use a default (invalid) value where needed.

Reported by the Parfait static code analysis tool

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
---
 hw/usb/core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 1aa0051b2b2d..9d46a4b41e99 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -733,19 +733,23 @@ struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
 uint8_t usb_ep_get_type(USBDevice *dev, int pid, int ep)
 {
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
-    return uep->type;
+    return uep ? uep->type : USB_ENDPOINT_XFER_INVALID;
 }
 
 void usb_ep_set_type(USBDevice *dev, int pid, int ep, uint8_t type)
 {
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
-    uep->type = type;
+    if (uep) {
+        uep->type = type;
+    }
 }
 
 void usb_ep_set_ifnum(USBDevice *dev, int pid, int ep, uint8_t ifnum)
 {
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
-    uep->ifnum = ifnum;
+    if (uep) {
+        uep->ifnum = ifnum;
+    }
 }
 
 void usb_ep_set_max_packet_size(USBDevice *dev, int pid, int ep,
@@ -754,6 +758,10 @@ void usb_ep_set_max_packet_size(USBDevice *dev, int pid, int ep,
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
     int size, microframes;
 
+    if (!uep) {
+        return;
+    }
+
     size = raw & 0x7ff;
     switch ((raw >> 11) & 3) {
     case 1:
@@ -774,6 +782,10 @@ void usb_ep_set_max_streams(USBDevice *dev, int pid, int ep, uint8_t raw)
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
     int MaxStreams;
 
+    if (!uep) {
+        return;
+    }
+
     MaxStreams = raw & 0x1f;
     if (MaxStreams) {
         uep->max_streams = 1 << MaxStreams;
@@ -785,7 +797,9 @@ void usb_ep_set_max_streams(USBDevice *dev, int pid, int ep, uint8_t raw)
 void usb_ep_set_halted(USBDevice *dev, int pid, int ep, bool halted)
 {
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
-    uep->halted = halted;
+    if (uep) {
+        uep->halted = halted;
+    }
 }
 
 USBPacket *usb_ep_find_packet_by_id(USBDevice *dev, int pid, int ep,
@@ -794,6 +808,10 @@ USBPacket *usb_ep_find_packet_by_id(USBDevice *dev, int pid, int ep,
     struct USBEndpoint *uep = usb_ep_get(dev, pid, ep);
     USBPacket *p;
 
+    if (!uep) {
+        return NULL;
+    }
+
     QTAILQ_FOREACH(p, &uep->queue, queue) {
         if (p->id == id) {
             return p;
-- 
1.8.3.1
