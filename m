Received: from eggs.gnu.org ([209.51.188.92]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1wLv-00014M-1O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1wLt-00015V-2O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1wLp-00012n-BL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:58:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61BF7318A601
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 16:58:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu,  7 Mar 2019 16:58:24 +0000
Message-Id: <20190307165824.18059-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] io: fix handling of EOF / error conditions
 in websock GSource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

We were never reporting the G_IO_HUP event when an end of file was hit
on the websocket channel.

We also didn't report G_IO_ERR when we hit a fatal error processing the
websocket protocol.

The latter in particular meant that the chardev code would not notice
when an eof/error was encountered on the websocket channel, unless the
guest OS happened to trigger a write operation.

This meant that once the first client had quit, the chardev would never
listen to accept a new client.

Fixes launchpad bug 1816819
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

Changed in v2:
 - Fix typo
 - Remove use of G_IO_IN at same time as HUP/ERR since. It is
   not required since the websock source doesn't do a real
   poll itself.

 io/channel-websock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index dc43dc6bb9..77d30f0e4a 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -1225,12 +1225,18 @@ qio_channel_websock_source_check(GSource *source)
     QIOChannelWebsockSource *wsource =3D (QIOChannelWebsockSource *)sour=
ce;
     GIOCondition cond =3D 0;
=20
-    if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
+    if (wsource->wioc->rawinput.offset) {
         cond |=3D G_IO_IN;
     }
     if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER=
) {
         cond |=3D G_IO_OUT;
     }
+    if (wsource->wioc->io_eof) {
+        cond |=3D G_IO_HUP;
+    }
+    if (wsource->wioc->io_err) {
+        cond |=3D G_IO_ERR;
+    }
=20
     return cond & wsource->condition;
 }
--=20
2.20.1
