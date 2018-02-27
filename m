Received: from eggs.gnu.org ([2001:4830:134:3::10]:52775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqanH-00062t-Tq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqanE-0001tM-RV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:39:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqanE-0001t7-MU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:39:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4798B818AAEB
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:39:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:39:16 +0100
Message-Id: <20180227083919.12339-3-kraxel@redhat.com>
In-Reply-To: <20180227083919.12339-1-kraxel@redhat.com>
References: <20180227083919.12339-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] usb-mtp: print parent path in IN_IGNORED
 trace fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Bandan Das <bsd@redhat.com>

Fix a possible null dereference when deleting a folder and
its contents. An ignored event might be received for its contents
after the parent folder is deleted which will return a null object.

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20180223164829.29683-3-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index b55aa8205e..63f8f3b90b 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -540,9 +540,8 @@ static void inotify_watchfn(void *arg)
                 break;
 
             case IN_IGNORED:
-                o = usb_mtp_object_lookup_name(parent, event->name, event->len);
-                trace_usb_mtp_inotify_event(s->dev.addr, o->path,
-                                      event->mask, "Obj ignored");
+                trace_usb_mtp_inotify_event(s->dev.addr, parent->path,
+                                      event->mask, "Obj parent dir ignored");
                 break;
 
             default:
-- 
2.9.3
