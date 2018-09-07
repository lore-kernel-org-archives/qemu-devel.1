Received: from eggs.gnu.org ([2001:4830:134:3::10]:39388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fyOw4-0005FO-F4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fyOw1-0001ba-HX
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:09:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fyOw1-0001Ua-A2
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79B494070491
	for <qemu-devel@nongnu.org>; Fri,  7 Sep 2018 22:09:00 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri,  7 Sep 2018 18:08:51 -0400
Message-Id: <20180907220851.9658-4-bsd@redhat.com>
In-Reply-To: <20180907220851.9658-1-bsd@redhat.com>
References: <20180907220851.9658-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] usb-mtp: reset ObjectInfo dataset size
 on cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Stale values in this field may result in qemu
expecting more data on the next operation

Signed-off-by: Bandan Das <bsd@redhat.com>
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
2.14.4
