Received: from eggs.gnu.org ([2001:4830:134:3::10]:50102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qQ-0006Lo-8P
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qI-00052B-0q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qH-000517-O2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5905693D6
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:48 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:19 +0000
Message-Id: <20171218191228.31018-5-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 04/13] ui: avoid pointless VNC updates if
 framebuffer isn't dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The vnc_update_client() method checks the 'has_dirty' flag to see if there are
dirty regions that are pending to send to the client. Regardless of this flag,
if a forced update is requested, updates must be sent. For unknown reasons
though, the code also tries to sent updates if audio capture is enabled. This
makes no sense as audio capture state does not impact framebuffer contents, so
this check is removed.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index a61fcbd20c..f53eddb8e5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -984,7 +984,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
         return 0;
     }
 
-    if (!vs->has_dirty && !vs->audio_cap && !vs->force_update) {
+    if (!vs->has_dirty && !vs->force_update) {
         return 0;
     }
 
-- 
2.14.3
