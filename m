Received: from eggs.gnu.org ([2001:4830:134:3::10]:33283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjVEG-0002e1-ON
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cjVED-0006R5-If
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:13:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cjVED-0006Qb-9T
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:13:25 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v22I8hrC061295
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 13:13:23 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xpbs6kxa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 13:13:23 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 2 Mar 2017 18:13:21 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu,  2 Mar 2017 19:13:08 +0100
Message-Id: <20170302181308.69662-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] event_notifier: prevent accidental use
 after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

Let's set the handles to the underlying facilities to their extremal
value so no accidental misuse can happen, and to make it obvious that the
notifier is dysfunctional. E.g. if we just close an fd but do not touch
the int holding the fd eventually a read/write could succeed again when
the fd gets reused, and corrupt the file addressed by the fd.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

No strong feelings about this, but obviously, I do think it's worth a
try.

The one who brought this unfortunate possibility to my attention was
Michael Tsirkin.
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
2.8.4
