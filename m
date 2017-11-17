Received: from eggs.gnu.org ([2001:4830:134:3::10]:42485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY4-0006eO-B7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY2-00064g-7l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdY2-000641-1U
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:06:58 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:06:53 +0100
Message-Id: <20171117100653.13015-6-kraxel@redhat.com>
In-Reply-To: <20171117100653.13015-1-kraxel@redhat.com>
References: <20171117100653.13015-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] sdl2: Fix broken display updating after the
 window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jindrich Makovicka <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jindrich Makovicka <makovick@gmail.com>

With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
blocks all subsequent display updates.

Instead of trying to override the change, just update the scon->hidden
flag.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Message-Id: <20171112193032.9724-2-makovick@gmail.com>

This is a partial revert of d3f3a0f453ea590be529079ae214c200bb5ecc1a,
which in turn is a workaround for a SDL bug.  The bug is fixed in 2.0.6,
see https://bugzilla.libsdl.org/show_bug.cgi?id=3410

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 8360054094..8718cf36b5 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -581,14 +581,10 @@ static void handle_windowevent(SDL_Event *ev)
         }
         break;
     case SDL_WINDOWEVENT_SHOWN:
-        if (scon->hidden) {
-            SDL_HideWindow(scon->real_window);
-        }
+        scon->hidden = false;
         break;
     case SDL_WINDOWEVENT_HIDDEN:
-        if (!scon->hidden) {
-            SDL_ShowWindow(scon->real_window);
-        }
+        scon->hidden = true;
         break;
     }
 }
-- 
2.9.3
