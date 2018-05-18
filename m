Received: from eggs.gnu.org ([2001:4830:134:3::10]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fJkRD-0006Fr-1c
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fJkR9-0008Bt-63
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:49:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fJkR9-0008BY-07
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:49:07 -0400
From: Bandan Das <bsd@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
	<20180507094448.32386-2-kraxel@redhat.com>
	<CAFEAcA9Edg2pk0x05mvfDwa8F4OjKmG-WTcnt9v17o3YVPQiWg@mail.gmail.com>
	<jpgr2maq7rs.fsf@linux.bootlegged.copy>
	<jpga7swygak.fsf_-_@linux.bootlegged.copy>
Date: Fri, 18 May 2018 14:49:03 -0400
In-Reply-To: <jpga7swygak.fsf_-_@linux.bootlegged.copy> (Bandan Das's message
	of "Fri, 18 May 2018 14:22:59 -0400")
Message-ID: <jpgr2m8ajfk.fsf_-_@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] usb-mtp: Return error on suspicious
 TYPE_DATA packet from initiator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


CID 1390604
If the initiator sends a packet with TYPE_DATA set without
initiating a CMD_GET_OBJECT_INFO first, then usb_mtp_get_data
can trip on a null s->data_out.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 3d59fe4944..28384ea3b0 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1696,6 +1696,11 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
2.14.3
