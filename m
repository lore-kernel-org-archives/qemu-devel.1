Received: from eggs.gnu.org ([2001:4830:134:3::10]:46870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn1-0002oG-Pv
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn1-0007ww-1J
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:39 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:30 +0200
Message-Id: <20180612104430.25745-9-kraxel@redhat.com>
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] usb-mtp: Return error on suspicious
 TYPE_DATA packet from initiator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

CID 1390604
If the initiator sends a packet with TYPE_DATA set without
initiating a CMD_GET_OBJECT_INFO first, then usb_mtp_get_data
can trip on a null s->data_out.

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-Id: <jpgr2m8ajfk.fsf_-_@linux.bootlegged.copy>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index b0ab6a7912..1ded7ac9a3 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1700,6 +1700,11 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
     uint64_t dlen;
     uint32_t data_len = p->iov.size;
 
+    if (!d) {
+            usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, 0,
+                                 0, 0, 0, 0);
+            return;
+    }
     if (d->first) {
         /* Total length of incoming data */
         d->length = cpu_to_le32(container->length) - sizeof(mtp_container);
-- 
2.9.3
