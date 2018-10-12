Received: from eggs.gnu.org ([2001:4830:134:3::10]:34238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNw-0006qW-TF
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNs-0002Y3-7H
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAxNr-0002X5-Ug
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AA5030001E2
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 13:21:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 15:21:34 +0200
Message-Id: <20181012132135.12313-3-kraxel@redhat.com>
In-Reply-To: <20181012132135.12313-1-kraxel@redhat.com>
References: <20181012132135.12313-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

There are some 2D resource formats that can be used through virtio-gpu,
but which are not supported by SDL2 when used for a scanout; these are
all alpha-channel formats and also XBGR (RGBX in non-BE pixman).

Add these formats in the switch converting pixman to SDL format
constants so a guest cannot crash the VM by triggering the
g_assert_not_reached() with an unsupported format.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20181008185013.19371-1-mreitz@redhat.com

[ kraxel: also update sdl2_2d_check_format() ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-2d.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 85484407be..091ecfcc7f 100644
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
@@ -149,7 +158,13 @@ bool sdl2_2d_check_format(DisplayChangeListener *dcl,
      * the native ones. Thes are the ones I have tested.
      */
     return (format == PIXMAN_x8r8g8b8 ||
+            format == PIXMAN_a8r8g8b8 ||
+            format == PIXMAN_a8b8g8r8 ||
+            format == PIXMAN_x8b8g8r8 ||
             format == PIXMAN_b8g8r8x8 ||
+            format == PIXMAN_b8g8r8a8 ||
+            format == PIXMAN_r8g8b8x8 ||
+            format == PIXMAN_r8g8b8a8 ||
             format == PIXMAN_x1r5g5b5 ||
             format == PIXMAN_r5g6b5);
 }
-- 
2.9.3
