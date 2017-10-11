Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxr-0004ls-Ao
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Dxn-0001p3-2w
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2Dxm-0001no-TR
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE7158124A
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:10:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 11 Oct 2017 11:09:53 +0100
Message-Id: <20171011100959.29326-2-berrange@redhat.com>
In-Reply-To: <20171011100959.29326-1-berrange@redhat.com>
References: <20171011100959.29326-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/7] io: monitor encoutput buffer size from
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

This issue is assigned CVE-2017-????, publically reported in

  https://bugs.launchpad.net/qemu/+bug/1718964

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index d1d471f86e..04bcc059cd 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -28,7 +28,7 @@
 #include <time.h>
 
 
-/* Max amount to allow in rawinput/rawoutput buffers */
+/* Max amount to allow in rawinput/encoutput buffers */
 #define QIO_CHANNEL_WEBSOCK_MAX_BUFFER 8192
 
 #define QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN 24
@@ -1208,7 +1208,7 @@ qio_channel_websock_source_check(GSource *source)
     if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
         cond |= G_IO_IN;
     }
-    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
+    if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
         cond |= G_IO_OUT;
     }
 
-- 
2.13.5
