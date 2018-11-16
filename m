Received: from eggs.gnu.org ([2001:4830:134:3::10]:43898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNeBo-0001eL-Q8
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNeBk-0002el-QI
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNeBj-0002dz-4I
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A343307EA9D
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:29:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 14:29:30 +0100
Message-Id: <20181116132931.8737-3-kraxel@redhat.com>
In-Reply-To: <20181116132931.8737-1-kraxel@redhat.com>
References: <20181116132931.8737-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] ui: Allow specifying 'rendernode' display
 option for egl-headless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Erik Skultety <eskultet@redhat.com>

From: Erik Skultety <eskultet@redhat.com>

As libvirt can't predict which rendernode QEMU would pick, it
won't adjust the permissions on the device, hence QEMU getting
"Permission denied" when opening the DRI device. Therefore, enable
'rendernode' option for egl-headless display type.

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=1648236

Signed-off-by: Erik Skultety <eskultet@redhat.com>
Message-id: 27f4617f19aa1072114f10f1aa9dd199735ef982.1542362949.git.eskultet@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-headless.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 42a41310b0..4cf3bbc0e4 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -176,7 +176,7 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
     egl_dpy *edpy;
     int idx;
 
-    if (egl_rendernode_init(NULL, mode) < 0) {
+    if (egl_rendernode_init(opts->u.egl_headless.rendernode, mode) < 0) {
         error_report("egl: render node init failed");
         exit(1);
     }
-- 
2.9.3
