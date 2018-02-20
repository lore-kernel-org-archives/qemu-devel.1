Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9qi-0006Yn-If
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9qe-000887-I4
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:28:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo9qe-00087Z-Dd
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:28:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D2DC84258
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 15:28:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 16:28:39 +0100
Message-Id: <20180220152843.26464-3-kraxel@redhat.com>
In-Reply-To: <20180220152843.26464-1-kraxel@redhat.com>
References: <20180220152843.26464-1-kraxel@redhat.com>
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
Message-id: 20180215231129.14710-3-bsd@redhat.com
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
