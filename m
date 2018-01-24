Received: from eggs.gnu.org ([2001:4830:134:3::10]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl7-00080O-8B
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl6-0006ez-BY
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeOl6-0006de-5A
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:48 -0500
Date: Wed, 24 Jan 2018 19:22:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516814467-25906-4-git-send-email-mst@redhat.com>
References: <1516814467-25906-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516814467-25906-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 3/3] Revert "qemu: add a cleanup callback
 function to EventNotifier"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Sitong Liu <siliu@redhat.com>, Xiaoling Gao <xiagao@redhat.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>

This reverts commit f87d72f5c5bff0837d409a56bd34f439a90119ca as that is
part of a patchset reported to break cleanup and migration.

Cc: Gal Hammer <ghammer@redhat.com>
Cc: Sitong Liu <siliu@redhat.com>
Cc: Xiaoling Gao <xiagao@redhat.com>
Suggested-by: Greg Kurz <groug@kaod.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 include/qemu/event_notifier.h | 1 -
 util/event_notifier-posix.c   | 5 +----
 util/event_notifier-win32.c   | 2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
index b30a454..599c99f 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -26,7 +26,6 @@ struct EventNotifier {
     int rfd;
     int wfd;
 #endif
-    void (*cleanup)(EventNotifier *);
 };
 
 typedef void EventNotifierHandler(EventNotifier *);
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 6525666..73c4046 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -29,7 +29,6 @@ void event_notifier_init_fd(EventNotifier *e, int fd)
 {
     e->rfd = fd;
     e->wfd = fd;
-    e->cleanup = NULL;
 }
 #endif
 
@@ -66,7 +65,6 @@ int event_notifier_init(EventNotifier *e, int active)
         e->rfd = fds[0];
         e->wfd = fds[1];
     }
-    e->cleanup = NULL;
     if (active) {
         event_notifier_set(e);
     }
@@ -82,11 +80,10 @@ void event_notifier_cleanup(EventNotifier *e)
 {
     if (e->rfd != e->wfd) {
         close(e->rfd);
+        e->rfd = -1;
     }
     close(e->wfd);
-    e->rfd = -1;
     e->wfd = -1;
-    e->cleanup = NULL;
 }
 
 int event_notifier_get_fd(const EventNotifier *e)
diff --git a/util/event_notifier-win32.c b/util/event_notifier-win32.c
index eff8670..62c53b0 100644
--- a/util/event_notifier-win32.c
+++ b/util/event_notifier-win32.c
@@ -19,7 +19,6 @@ int event_notifier_init(EventNotifier *e, int active)
 {
     e->event = CreateEvent(NULL, TRUE, FALSE, NULL);
     assert(e->event);
-    e->cleanup = NULL;
     return 0;
 }
 
@@ -27,7 +26,6 @@ void event_notifier_cleanup(EventNotifier *e)
 {
     CloseHandle(e->event);
     e->event = NULL;
-    e->cleanup = NULL;
 }
 
 HANDLE event_notifier_get_handle(EventNotifier *e)
-- 
MST
