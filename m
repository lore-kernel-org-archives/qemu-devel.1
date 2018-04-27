Received: from eggs.gnu.org ([2001:4830:134:3::10]:47796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC0Ue-00070M-R4
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC0UZ-0003M1-PB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC0UZ-0003LR-Ha
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB27AEC01D
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 10:20:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 12:20:33 +0200
Message-Id: <20180427102033.20232-4-kraxel@redhat.com>
In-Reply-To: <20180427102033.20232-1-kraxel@redhat.com>
References: <20180427102033.20232-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Michal Privoznik <mprivozn@redhat.com>

From: Michal Privoznik <mprivozn@redhat.com>

When trying to build with latest libcacard-2.5.1, I hit the
following error:

In file included from hw/usb/ccid-card-passthru.c:12:0:
/usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcacar=
d.h> can be included directly" [-Werror=3Dcpp]
 #warning "Only <libcacard.h> can be included directly"

While it was fixed in libcacard upstream (so that individual
files can be included directly), it doesn't make much sense.
Let's switch to including the main libcacard.h and also require
at least libcacard-2.5.1 which introduced it. It's available
since late 2015.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mpriv=
ozn@redhat.com

[ kraxel: fix include path ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                   | 2 +-
 hw/usb/ccid-card-emulated.c | 5 +----
 hw/usb/ccid-card-passthru.c | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 0a19b033bc..0a4f0da58f 100755
--- a/configure
+++ b/configure
@@ -4449,7 +4449,7 @@ fi
=20
 # check for smartcard support
 if test "$smartcard" !=3D "no"; then
-    if $pkg_config libcacard; then
+    if $pkg_config --atleast-version=3D2.5.1 libcacard; then
         libcacard_cflags=3D$($pkg_config --cflags libcacard)
         libcacard_libs=3D$($pkg_config --libs libcacard)
         smartcard=3D"yes"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index ea42e4681d..5c8b3c9907 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -27,10 +27,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include <eventt.h>
-#include <vevent.h>
-#include <vreader.h>
-#include <vcard_emul.h>
+#include <libcacard.h>
=20
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index b7dd3602dc..7684db0cb3 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,7 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include <cacard/vscard_common.h>
+#include <libcacard.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
--=20
2.9.3
