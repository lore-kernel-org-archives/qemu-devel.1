Received: from eggs.gnu.org ([2001:4830:134:3::10]:56983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpbCf-0003XP-N9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpbCa-0001po-5Y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dpbCZ-0001pX-Tn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E55AC0587D6
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 14:21:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  6 Sep 2017 16:21:09 +0200
Message-Id: <20170906142109.2685-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] console: fix dpy_gfx_replace_surface assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

virtio-gpu can trigger the assert added by commit "6905b93447 console:
add same surface replace pre-condition" in multihead setups (where
surface can be NULL for secondary displays).  Allow surface being NULL.

Fixes: 6905b93447a42e606dfd126b90f75f4cd3c6fe94
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index d2d3534c49..f0292d7820 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1540,7 +1540,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
     DisplaySurface *old_surface = con->surface;
     DisplayChangeListener *dcl;
 
-    assert(old_surface != surface);
+    assert(old_surface != surface || surface == NULL);
 
     con->surface = surface;
     QLIST_FOREACH(dcl, &s->listeners, next) {
-- 
2.9.3
