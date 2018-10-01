Received: from eggs.gnu.org ([2001:4830:134:3::10]:44389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVq-0004ht-Gw
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVn-0000kj-Ax
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6uVn-0000k2-2r
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34B0031649A4
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:29:06 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 11:28:46 +0200
Message-Id: <20181001092848.11082-4-kraxel@redhat.com>
In-Reply-To: <20181001092848.11082-1-kraxel@redhat.com>
References: <20181001092848.11082-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] usb-mtp: reset ObjectInfo dataset size on
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

Stale values in this field may result in qemu
expecting more data on the next operation

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20180907220851.9658-4-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 15edf3bb82..00a3691bae 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1568,6 +1568,7 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
             if (s->write_pending) {
                 g_free(s->dataset.filename);
                 s->write_pending = false;
+                s->dataset.size = 0;
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
@@ -1693,6 +1694,7 @@ done:
     }
 free:
     g_free(s->dataset.filename);
+    s->dataset.size = 0;
     g_free(path);
     s->write_pending = false;
 }
-- 
2.9.3
