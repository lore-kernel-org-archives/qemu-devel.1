Received: from eggs.gnu.org ([209.51.188.92]:60573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eS-0006yG-8Y
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eP-0001cs-4Z
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eN-0001Me-Ly
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BA0F307D985
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:21 +0100
Message-Id: <20190222075326.9850-11-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/15] char: move SpiceChardev and
 open_spice_port() to spice.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This will allow easier subclassing of SpiceChardev, in upcoming
"display: add -display spice-app launching external application"
patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
Message-id: 20190221110703.5775-7-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/chardev/spice.h | 27 +++++++++++++++++++++++++++
 chardev/spice.c         | 28 +++++-----------------------
 2 files changed, 32 insertions(+), 23 deletions(-)
 create mode 100644 include/chardev/spice.h

diff --git a/include/chardev/spice.h b/include/chardev/spice.h
new file mode 100644
index 000000000000..6431da320599
--- /dev/null
+++ b/include/chardev/spice.h
@@ -0,0 +1,27 @@
+#ifndef CHARDEV_SPICE_H_
+#define CHARDEV_SPICE_H_
+
+#include <spice.h>
+#include "chardev/char-fe.h"
+
+typedef struct SpiceChardev {
+    Chardev               parent;
+
+    SpiceCharDeviceInstance sin;
+    bool                  active;
+    bool                  blocked;
+    const uint8_t         *datapos;
+    int                   datalen;
+    QLIST_ENTRY(SpiceChardev) next;
+} SpiceChardev;
+
+#define TYPE_CHARDEV_SPICE "chardev-spice"
+#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
+#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
+
+#define SPICE_CHARDEV(obj) OBJECT_CHECK(SpiceChardev, (obj), TYPE_CHARDE=
V_SPICE)
+
+void qemu_chr_open_spice_port(Chardev *chr, ChardevBackend *backend,
+                              bool *be_opened, Error **errp);
+
+#endif
diff --git a/chardev/spice.c b/chardev/spice.c
index c68e60115bb1..2202d50eee1e 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -2,30 +2,12 @@
 #include "trace.h"
 #include "ui/qemu-spice.h"
 #include "chardev/char.h"
+#include "chardev/spice.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include <spice.h>
 #include <spice/protocol.h>
=20
-
-typedef struct SpiceChardev {
-    Chardev               parent;
-
-    SpiceCharDeviceInstance sin;
-    bool                  active;
-    bool                  blocked;
-    const uint8_t         *datapos;
-    int                   datalen;
-    QLIST_ENTRY(SpiceChardev) next;
-} SpiceChardev;
-
-#define TYPE_CHARDEV_SPICE "chardev-spice"
-#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
-#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
-
-#define SPICE_CHARDEV(obj) OBJECT_CHECK(SpiceChardev, (obj), TYPE_CHARDE=
V_SPICE)
-
 typedef struct SpiceCharSource {
     GSource               source;
     SpiceChardev       *scd;
@@ -315,10 +297,10 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     chr_open(chr, type);
 }
=20
-static void qemu_chr_open_spice_port(Chardev *chr,
-                                     ChardevBackend *backend,
-                                     bool *be_opened,
-                                     Error **errp)
+void qemu_chr_open_spice_port(Chardev *chr,
+                              ChardevBackend *backend,
+                              bool *be_opened,
+                              Error **errp)
 {
     ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
     const char *name =3D spiceport->fqdn;
--=20
2.9.3
