Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qN-0006J1-Pf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qD-0004wx-6T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qC-0004w4-Us
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05C1D356CF
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:44 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:17 +0000
Message-Id: <20171218191228.31018-3-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 02/13] ui: remove unreachable code in
 vnc_update_client
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

A previous commit:

  commit 5a8be0f73d6f60ff08746377eb09ca459f39deab
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Wed Jul 13 12:21:20 2016 +0200

    vnc: make sure we finish disconnect

Added a check for vs->disconnecting at the very start of the
vnc_update_client method. This means that the very next "if"
statement check for !vs->disconnecting always evaluates true,
and is thus redundant. This in turn means the vs->disconnecting
check at the very end of the method never evaluates true, and
is thus unreachable code.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 7ba3297dfa..869c75bbcf 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -969,7 +969,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
     }
 
     vs->has_dirty += has_dirty;
-    if (vs->need_update && !vs->disconnecting) {
+    if (vs->need_update) {
         VncDisplay *vd = vs->vd;
         VncJob *job;
         int y;
@@ -1030,10 +1030,6 @@ static int vnc_update_client(VncState *vs, int has_dirty)
         return n;
     }
 
-    if (vs->disconnecting) {
-        vnc_disconnect_finish(vs);
-    }
-
     return 0;
 }
 
-- 
2.14.3
