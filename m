Received: from eggs.gnu.org ([2001:4830:134:3::10]:41557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fm-0002q3-OC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fl-0006JC-SK
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ct2Fl-0006I8-Mp
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:25 -0400
Date: Wed, 29 Mar 2017 04:18:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490750257-19907-2-git-send-email-mst@redhat.com>
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490750257-19907-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] event_notifier: prevent accidental use
 after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Let's set the handles to the underlying facilities to their extremal
value so no accidental misuse can happen, and to make it obvious that the
notifier is dysfunctional. E.g. if we just close an fd but do not touch
the int holding the fd eventually a read/write could succeed again when
the fd gets reused, and corrupt the file addressed by the fd.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 util/event_notifier-posix.c | 2 ++
 util/event_notifier-win32.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 7e40252..acdbe3b 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -81,8 +81,10 @@ void event_notifier_cleanup(EventNotifier *e)
 {
     if (e->rfd != e->wfd) {
         close(e->rfd);
+        e->rfd = -1;
     }
     close(e->wfd);
+    e->wfd = -1;
 }
 
 int event_notifier_get_fd(const EventNotifier *e)
diff --git a/util/event_notifier-win32.c b/util/event_notifier-win32.c
index 519fb59..62c53b0 100644
--- a/util/event_notifier-win32.c
+++ b/util/event_notifier-win32.c
@@ -25,6 +25,7 @@ int event_notifier_init(EventNotifier *e, int active)
 void event_notifier_cleanup(EventNotifier *e)
 {
     CloseHandle(e->event);
+    e->event = NULL;
 }
 
 HANDLE event_notifier_get_handle(EventNotifier *e)
-- 
MST
