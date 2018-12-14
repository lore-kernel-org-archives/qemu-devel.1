Received: from eggs.gnu.org ([2001:4830:134:3::10]:34517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks3-0008TX-9a
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks0-000565-4m
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gXkrz-00055X-RA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:38:59 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 14 Dec 2018 11:38:50 +0100
Message-Id: <20181214103854.13820-2-kraxel@redhat.com>
In-Reply-To: <20181214103854.13820-1-kraxel@redhat.com>
References: <20181214103854.13820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] pvusb: set max grants only in initialise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Juergen Gross <jgross@suse.com>

From: Juergen Gross <jgross@suse.com>

Don't call xen_be_set_max_grant_refs() in usbback_alloc(), as the
gnttabdev pointer won't be initialised yet. The call can easily be
moved to usbback_connect().

Signed-off-by: Juergen Gross <jgross@suse.com>
Message-id: 20181206133923.30105-1-jgross@suse.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/xen-usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 5b2e21ed18..f5d5c91094 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -860,10 +860,14 @@ static int usbback_connect(struct XenDevice *xendev)
     struct usbif_conn_sring *conn_sring;
     int urb_ring_ref;
     int conn_ring_ref;
-    unsigned int i;
+    unsigned int i, max_grants;
 
     TR_BUS(xendev, "start\n");
 
+    /* max_grants: for each request and for the rings (request and connect). */
+    max_grants = USBIF_MAX_SEGMENTS_PER_REQUEST * USB_URB_RING_SIZE + 2;
+    xen_be_set_max_grant_refs(xendev, max_grants);
+
     usbif = container_of(xendev, struct usbback_info, xendev);
 
     if (xenstore_read_fe_int(xendev, "urb-ring-ref", &urb_ring_ref)) {
@@ -1005,7 +1009,7 @@ static void usbback_alloc(struct XenDevice *xendev)
 {
     struct usbback_info *usbif;
     USBPort *p;
-    unsigned int i, max_grants;
+    unsigned int i;
 
     usbif = container_of(xendev, struct usbback_info, xendev);
 
@@ -1021,10 +1025,6 @@ static void usbback_alloc(struct XenDevice *xendev)
     QTAILQ_INIT(&usbif->req_free_q);
     QSIMPLEQ_INIT(&usbif->hotplug_q);
     usbif->bh = qemu_bh_new(usbback_bh, usbif);
-
-    /* max_grants: for each request and for the rings (request and connect). */
-    max_grants = USBIF_MAX_SEGMENTS_PER_REQUEST * USB_URB_RING_SIZE + 2;
-    xen_be_set_max_grant_refs(xendev, max_grants);
 }
 
 static int usbback_free(struct XenDevice *xendev)
-- 
2.9.3
