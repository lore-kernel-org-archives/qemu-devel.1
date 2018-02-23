Received: from eggs.gnu.org ([2001:4830:134:3::10]:47409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1epGWs-0003NT-UG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1epGWp-0001zr-4I
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:49:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1epGWo-0001xd-Rm
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:48:58 -0500
From: Bandan Das <bsd@redhat.com>
Date: Fri, 23 Feb 2018 11:48:26 -0500
Message-Id: <20180223164829.29683-3-bsd@redhat.com>
In-Reply-To: <20180223164829.29683-1-bsd@redhat.com>
References: <20180223164829.29683-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/5] usb-mtp: print parent path in
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
Cc: kraxel@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, berrange@redhat.com

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
