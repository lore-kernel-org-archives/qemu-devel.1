Received: from eggs.gnu.org ([2001:4830:134:3::10]:36716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdc-0000Wg-A8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBbdb-00049L-9w
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBbdb-00049H-0j
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDAB87F4A3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:43:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 14:43:27 +0800
Message-Id: <1495176212-14446-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-1-git-send-email-peterx@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/6] io: only allow return path for socket
 typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>

We don't really have a return path for the other types yet. Let's check
this when .get_return_path() is called.

For this, we introduce a new feature bit, and set it up only for socket
typed IO channels.

This will help detect earlier failure for postcopy, e.g., logically
speaking postcopy cannot work with "exec:". Before this patch, when we
try to migrate with "migrate -d exec:cat>out", we'll hang the system.
With this patch, we'll get:

(qemu) migrate -d exec:cat>out
Unable to open return-path for postcopy

CC: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h          | 1 +
 io/channel-socket.c           | 1 +
 migration/qemu-file-channel.c | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index db9bb02..7876534 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -45,6 +45,7 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_FD_PASS,
     QIO_CHANNEL_FEATURE_SHUTDOWN,
     QIO_CHANNEL_FEATURE_LISTEN,
+    QIO_CHANNEL_FEATURE_RETURN_PATH,
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7..ee81b2d 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -56,6 +56,7 @@ qio_channel_socket_new(void)
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
+    qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_RETURN_PATH);
 
 #ifdef WIN32
     ioc->event = CreateEvent(NULL, FALSE, FALSE, NULL);
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index 45c13f1..3bd7940 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qom/object.h"
 #include "migration/qemu-file.h"
 #include "io/channel-socket.h"
 #include "qemu/iov.h"
@@ -139,6 +140,10 @@ static QEMUFile *channel_get_input_return_path(void *opaque)
 {
     QIOChannel *ioc = QIO_CHANNEL(opaque);
 
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_RETURN_PATH)) {
+        return NULL;
+    }
+
     return qemu_fopen_channel_output(ioc);
 }
 
@@ -146,6 +151,10 @@ static QEMUFile *channel_get_output_return_path(void *opaque)
 {
     QIOChannel *ioc = QIO_CHANNEL(opaque);
 
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_RETURN_PATH)) {
+        return NULL;
+    }
+
     return qemu_fopen_channel_input(ioc);
 }
 
-- 
2.7.4
