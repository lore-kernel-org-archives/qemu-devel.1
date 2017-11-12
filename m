Received: from eggs.gnu.org ([2001:4830:134:3::10]:53603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjg-0002Ub-Tg
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpje-00043j-3D
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:32 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDpjd-00043D-Sg
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:30 -0500
Received: by mail-wm0-x241.google.com with SMTP id r68so9766450wmr.1
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 02:43:29 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 11:42:39 +0100
Message-Id: <20171112104246.10007-2-makovick@gmail.com>
In-Reply-To: <20171112104246.10007-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171112104246.10007-1-makovick@gmail.com>
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
