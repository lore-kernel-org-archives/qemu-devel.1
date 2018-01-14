Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eafCA-0000Wh-1t
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eafC9-0002Vb-7L
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:07:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1eafC9-0002UT-1m
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:07:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F6E981DFF
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 10:07:16 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
Date: Sun, 14 Jan 2018 12:06:54 +0200
Message-Id: <1515924416-9266-2-git-send-email-ghammer@redhat.com>
In-Reply-To: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
References: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu: add a cleanup callback function to
 EventNotifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gal Hammer <ghammer@redhat.com>

Adding a cleanup callback function to the EventNotifier struct
which allows users to execute event_notifier_cleanup in a
different context.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
---
 include/qemu/event_notifier.h | 1 +
 util/event_notifier-posix.c   | 5 ++++-
 util/event_notifier-win32.c   | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
index 599c99f..b30a454 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -26,6 +26,7 @@ struct EventNotifier {
     int rfd;
     int wfd;
 #endif
+    void (*cleanup)(EventNotifier *);
 };
 
 typedef void EventNotifierHandler(EventNotifier *);
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 73c4046..6525666 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -29,6 +29,7 @@ void event_notifier_init_fd(EventNotifier *e, int fd)
 {
     e->rfd = fd;
     e->wfd = fd;
+    e->cleanup = NULL;
 }
 #endif
 
@@ -65,6 +66,7 @@ int event_notifier_init(EventNotifier *e, int active)
         e->rfd = fds[0];
         e->wfd = fds[1];
     }
+    e->cleanup = NULL;
     if (active) {
         event_notifier_set(e);
     }
@@ -80,10 +82,11 @@ void event_notifier_cleanup(EventNotifier *e)
 {
     if (e->rfd != e->wfd) {
         close(e->rfd);
-        e->rfd = -1;
     }
     close(e->wfd);
+    e->rfd = -1;
     e->wfd = -1;
+    e->cleanup = NULL;
 }
 
 int event_notifier_get_fd(const EventNotifier *e)
diff --git a/util/event_notifier-win32.c b/util/event_notifier-win32.c
index 62c53b0..eff8670 100644
--- a/util/event_notifier-win32.c
+++ b/util/event_notifier-win32.c
@@ -19,6 +19,7 @@ int event_notifier_init(EventNotifier *e, int active)
 {
     e->event = CreateEvent(NULL, TRUE, FALSE, NULL);
     assert(e->event);
+    e->cleanup = NULL;
     return 0;
 }
 
@@ -26,6 +27,7 @@ void event_notifier_cleanup(EventNotifier *e)
 {
     CloseHandle(e->event);
     e->event = NULL;
+    e->cleanup = NULL;
 }
 
 HANDLE event_notifier_get_handle(EventNotifier *e)
-- 
2.7.5
