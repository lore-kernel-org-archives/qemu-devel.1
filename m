Received: from eggs.gnu.org ([2001:4830:134:3::10]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4SzY-0008Sh-UB
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4SzQ-0004Oo-It
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:37:08 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 17 Oct 2017 15:36:55 +0100
Message-Id: <20171017143655.31277-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.10] io: monitor encoutput buffer size
 from websocket GSource
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
2.13.6
