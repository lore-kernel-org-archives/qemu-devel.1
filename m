Received: from eggs.gnu.org ([2001:4830:134:3::10]:34031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eoGsq-0002lE-1y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eoGso-0005kL-QB
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:59:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1eoGso-0005js-LP
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:59:34 -0500
From: Bandan Das <bsd@redhat.com>
Date: Tue, 20 Feb 2018 17:59:01 -0500
Message-Id: <20180220225904.16129-3-bsd@redhat.com>
In-Reply-To: <20180220225904.16129-1-bsd@redhat.com>
References: <20180220225904.16129-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/5] usb-mtp: print parent path in
 IN_IGNORED trace fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, eblake@redhat.com, peter.maydell@linaro.org

Fix a possible null dereference when deleting a folder and
its contents. An ignored event might be received for its contents
after the parent folder is deleted which will return a null object.

Signed-off-by: Bandan Das <bsd@redhat.com>
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
2.14.3
