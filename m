Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e5GIy-0007kL-SR
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e5GIt-0006Rl-TX
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:16:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:61896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e5GIt-0006Qm-Ji
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:16:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 19 Oct 2017 21:16:06 +0200
Message-Id: <20171019191606.14129-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] configure: disable qemu-keymap for linux-user
 qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

We don't need qemu-keymap when we build only linux-user qemu.

When we compile in static mode, the libxkbcommon is detected
by configure if the shared one is available, but cannot
be linked if the static version is not available.

As we don't need it for qemu-linux-user, and we generally need
a static link to use it in a chroot, disable qemu-keymap in
this case.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 6f21aaf989..03547cea6a 100755
--- a/configure
+++ b/configure
@@ -5136,9 +5136,9 @@ if test "$softmmu" = yes ; then
     fi
     mpath=no
   fi
-fi
-if test "$xkbcommon" = "yes"; then
-  tools="qemu-keymap\$(EXESUF) $tools"
+  if test "$xkbcommon" = "yes"; then
+    tools="qemu-keymap\$(EXESUF) $tools"
+  fi
 fi
 
 # Probe for guest agent support/options
-- 
2.13.6
