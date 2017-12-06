Received: from eggs.gnu.org ([2001:4830:134:3::10]:49420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCR-0000iQ-Pm
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCO-0000f9-Hf
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39416
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCO-0000du-BH
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE94b050860
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:39 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epk5h2m15-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:39 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:39 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:26 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-34-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 33/55] io: monitor encoutput buffer size from
 websocket GSource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The websocket GSource is monitoring the size of the rawoutput
buffer to determine if the channel can accepts more writes.
The rawoutput buffer, however, is merely a temporary staging
buffer before data is copied into the encoutput buffer. Thus
its size will always be zero when the GSource runs.

This flaw causes the encoutput buffer to grow without bound
if the other end of the underlying data channel doesn't
read data being sent. This can be seen with VNC if a client
is on a slow WAN link and the guest OS is sending many screen
updates. A malicious VNC client can act like it is on a slow
link by playing a video in the guest and then reading data
very slowly, causing QEMU host memory to expand arbitrarily.

This issue is assigned CVE-2017-15268, publically reported in

  https://bugs.launchpad.net/qemu/+bug/1718964

(cherry picked from commit a7b20a8efa28e5f22c26c06cd06c2f12bc863493)

Reviewed-by: Eric Blake <eblake@redhat.com>

[Dan: Added extra checks to deal with code refactored in master but
 not stable 2.10]

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 io/channel-websock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5a3badbec2..19116dc148 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -26,7 +26,7 @@
 #include "trace.h"
 
 
-/* Max amount to allow in rawinput/rawoutput buffers */
+/* Max amount to allow in rawinput/encoutput buffers */
 #define QIO_CHANNEL_WEBSOCK_MAX_BUFFER 8192
 
 #define QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN 24
@@ -1006,7 +1006,7 @@ qio_channel_websock_source_prepare(GSource *source,
     if (wsource->wioc->rawinput.offset) {
         cond |= G_IO_IN;
     }
-    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
+    if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
         cond |= G_IO_OUT;
     }
 
@@ -1022,7 +1022,7 @@ qio_channel_websock_source_check(GSource *source)
     if (wsource->wioc->rawinput.offset) {
         cond |= G_IO_IN;
     }
-    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
+    if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
         cond |= G_IO_OUT;
     }
 
@@ -1041,7 +1041,7 @@ qio_channel_websock_source_dispatch(GSource *source,
     if (wsource->wioc->rawinput.offset) {
         cond |= G_IO_IN;
     }
-    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
+    if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
         cond |= G_IO_OUT;
     }
 
-- 
2.11.0
