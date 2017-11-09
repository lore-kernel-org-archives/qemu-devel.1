Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eChPg-0000Co-BV
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eChPd-0001zl-5O
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:38:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eChPc-0001zJ-VX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:38:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D26B55D9EA
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 07:38:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Nov 2017 08:37:59 +0100
Message-Id: <20171109073759.5910-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: fix dcl unregister
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

register checks for dcl->ds being NULL, to avoid registering
the same dcl twice.

Therefore dcl->ds must be cleared on unregister, otherwise
un-registering and re-registering doesn't work.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1510809
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 1 +
 ui/vnc.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index eca854cbd5..c4c95abed7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1471,6 +1471,7 @@ void unregister_displaychangelistener(DisplayChangeListener *dcl)
         dcl->con->dcls--;
     }
     QLIST_REMOVE(dcl, next);
+    dcl->ds = NULL;
     gui_setup_refresh(ds);
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 9f8d5a1b1f..bd46f11fcc 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3044,6 +3044,7 @@ void vnc_display_init(const char *id)
 {
     VncDisplay *vd;
 
+    fprintf(stderr, "%s: %s\n", __func__, id);
     if (vnc_display_find(id) != NULL) {
         return;
     }
@@ -3982,6 +3983,7 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     if (con != vd->dcl.con) {
+        fprintf(stderr, "%s: %s\n", __func__, id);
         unregister_displaychangelistener(&vd->dcl);
         vd->dcl.con = con;
         register_displaychangelistener(&vd->dcl);
-- 
2.9.3
