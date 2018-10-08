Received: from eggs.gnu.org ([2001:4830:134:3::10]:44978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9abz-00050T-Fo
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9abv-0002IJ-Eq
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:50:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1g9abp-0002Ea-S0
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:50:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E70FDDF2C
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 18:50:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  8 Oct 2018 20:50:13 +0200
Message-Id: <20181008185013.19371-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

There are some 2D resource formats that can be used through virtio-gpu,
but which are not supported by SDL2 when used for a scanout; these are
all alpha-channel formats and also XBGR (RGBX in non-BE pixman).

Add these formats in the switch converting pixman to SDL format
constants so a guest cannot crash the VM by triggering the
g_assert_not_reached() with an unsupported format.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 ui/sdl2-2d.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 85484407be..c9df72636a 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -101,15 +101,24 @@ void sdl2_2d_switch(DisplayChangeListener *dcl,
     case PIXMAN_r5g6b5:
         format = SDL_PIXELFORMAT_RGB565;
         break;
+    case PIXMAN_a8r8g8b8:
     case PIXMAN_x8r8g8b8:
         format = SDL_PIXELFORMAT_ARGB8888;
         break;
+    case PIXMAN_a8b8g8r8:
+    case PIXMAN_x8b8g8r8:
+        format = SDL_PIXELFORMAT_ABGR8888;
+        break;
+    case PIXMAN_r8g8b8a8:
     case PIXMAN_r8g8b8x8:
         format = SDL_PIXELFORMAT_RGBA8888;
         break;
     case PIXMAN_b8g8r8x8:
         format = SDL_PIXELFORMAT_BGRX8888;
         break;
+    case PIXMAN_b8g8r8a8:
+        format = SDL_PIXELFORMAT_BGRA8888;
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.17.1
