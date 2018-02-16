Received: from eggs.gnu.org ([2001:4830:134:3::10]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dJ-Mt
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003fB-Gh
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003e9-BE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56C62402291E
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:06 +0100
Message-Id: <20180216115410.27287-6-kraxel@redhat.com>
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] sdl2: fix mouse grab
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

When qemu mouse mode changes from relative to absolute
we must turn off sdl relative mouse mode too.

Fixes: https://bugs.launchpad.net/qemu/+bug/1703795
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20180202120803.11501-1-kraxel@redhat.com>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 812c315891..858e04d7c0 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -249,6 +249,7 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
     if (qemu_input_is_absolute()) {
         if (!absolute_enabled) {
             absolute_enabled = 1;
+            SDL_SetRelativeMouseMode(SDL_FALSE);
             absolute_mouse_grab(&sdl2_console[0]);
         }
     } else if (absolute_enabled) {
-- 
2.9.3
