Received: from eggs.gnu.org ([2001:4830:134:3::10]:35597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3JHG-00085r-U6
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3JHD-0002pt-Ru
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:34:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f3JHD-0002pg-Mi
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:34:55 -0400
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue,  3 Apr 2018 12:34:37 +0200
Message-Id: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com

When trying to build with latest libcacard-2.5.1, I hit the
following error:

In file included from hw/usb/ccid-card-passthru.c:12:0:
/usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcacard.h> can be included directly" [-Werror=cpp]
 #warning "Only <libcacard.h> can be included directly"

While it was fixed in libcacard upstream (so that individual
files can be included directly), it doesn't make much sense.
Let's switch to including the main libcacard.h and also require
at least libcacard-2.5.1 which introduced it. It's available
since late 2015.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---

diff to v1:
- Introduce configure change to require newer libcacard version

 configure                   | 2 +-
 hw/usb/ccid-card-emulated.c | 5 +----
 hw/usb/ccid-card-passthru.c | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 4d0e92c96c..0edec24fff 100755
--- a/configure
+++ b/configure
@@ -4440,7 +4440,7 @@ fi
 
 # check for smartcard support
 if test "$smartcard" != "no"; then
-    if $pkg_config libcacard; then
+    if $pkg_config --atleast-version=2.5.1 libcacard; then
         libcacard_cflags=$($pkg_config --cflags libcacard)
         libcacard_libs=$($pkg_config --libs libcacard)
         smartcard="yes"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index ea42e4681d..7b538ae6da 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -27,10 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include <eventt.h>
-#include <vevent.h>
-#include <vreader.h>
-#include <vcard_emul.h>
+#include <cacard/libcacard.h>
 
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index b7dd3602dc..982d575edd 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include <cacard/vscard_common.h>
+#include <cacard/libcacard.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-- 
2.16.1
