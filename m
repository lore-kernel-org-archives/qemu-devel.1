Received: from eggs.gnu.org ([2001:4830:134:3::10]:44655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVMN-0006S7-MT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVMM-0001M8-Eb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVMM-0001Lg-8S
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:18 -0500
Date: Tue, 16 Jan 2018 19:49:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-7-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/34] qemu: add a cleanup callback function
 to EventNotifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Stefan Weil <sw@weilnetz.de>

From: Gal Hammer <ghammer@redhat.com>

Adding a cleanup callback function to the EventNotifier struct
which allows users to execute event_notifier_cleanup in a
different context.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
