Received: from eggs.gnu.org ([209.51.188.92]:35046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjk-0005aP-TL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1pjk-0007sp-3E
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1pjj-0007sB-QS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:54:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F0A47EBA7
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 09:54:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 10:54:40 +0100
Message-Id: <20190307095441.31921-4-kraxel@redhat.com>
In-Reply-To: <20190307095441.31921-1-kraxel@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] usb-mtp: prevent null dereference while
 deleting objects
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

Spotted by Coverity: CID 1399144

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20190306210409.14842-4-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1f22284949df..06e376bcd211 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1177,9 +1177,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
             usb_mtp_object_free_one(s, o);
             success = true;
         }
-    }
-
-    if (o->format == FMT_ASSOCIATION) {
+    } else if (o->format == FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
             partial_delete = true;
         } else {
-- 
2.18.1
