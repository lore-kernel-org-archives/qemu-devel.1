Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0S-00084s-95
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0P-0001Mi-6u
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0P-0001MU-1E
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 930684012981
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:11 +0200
Message-Id: <20180803173614.12358-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/10] char: move SpiceChardev and
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This will allow to subclass SpiceChardev easily.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/spice.h | 27 +++++++++++++++++++++++++++
 chardev/spice.c         | 28 +++++-----------------------
 2 files changed, 32 insertions(+), 23 deletions(-)
 create mode 100644 include/chardev/spice.h

diff --git a/include/chardev/spice.h b/include/chardev/spice.h
new file mode 100644
index 0000000000..6431da3205
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
index 4d4bafe34e..0112efb6d2 100644
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
@@ -307,10 +289,10 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
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
2.18.0.547.g1d89318c48
