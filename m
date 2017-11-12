Received: from eggs.gnu.org ([2001:4830:134:3::10]:39874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxo-0001dV-D5
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxm-0008Dl-4S
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDxxl-0008DZ-U3
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:38 -0500
Received: by mail-wm0-x244.google.com with SMTP id t139so11344282wmt.1
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 11:30:37 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 20:30:25 +0100
Message-Id: <20171112193032.9724-2-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating after
 the window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>

With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
blocks all subsequent display updates.

Instead of trying to override the change, just update the scon->hidden
flag.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/sdl2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 53dd447fd2..774904cbf2 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -572,14 +572,10 @@ static void handle_windowevent(SDL_Event *ev)
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
2.15.0
