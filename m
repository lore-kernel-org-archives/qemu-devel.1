Received: from eggs.gnu.org ([2001:4830:134:3::10]:54906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9I6-0006yH-84
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9I5-0006JV-C7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:12 +0200
Message-Id: <20170822132255.23945-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/54] quorum: use qapi_enum_parse() in
 quorum_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Quorum" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/quorum.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index d04da4f430..e4271caa7a 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/util.h"
 #include "qapi-event.h"
 #include "crypto/hash.h"
=20
@@ -867,24 +868,6 @@ static QemuOptsList quorum_runtime_opts =3D {
     },
 };
=20
-static int parse_read_pattern(const char *opt)
-{
-    int i;
-
-    if (!opt) {
-        /* Set quorum as default */
-        return QUORUM_READ_PATTERN_QUORUM;
-    }
-
-    for (i =3D 0; i < QUORUM_READ_PATTERN__MAX; i++) {
-        if (!strcmp(opt, QuorumReadPattern_lookup[i])) {
-            return i;
-        }
-    }
-
-    return -EINVAL;
-}
-
 static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
                        Error **errp)
 {
@@ -925,7 +908,13 @@ static int quorum_open(BlockDriverState *bs, QDict *=
options, int flags,
         goto exit;
     }
=20
-    ret =3D parse_read_pattern(qemu_opt_get(opts, QUORUM_OPT_READ_PATTER=
N));
+    if (!qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN)) {
+        ret =3D QUORUM_READ_PATTERN_QUORUM;
+    } else {
+        ret =3D qapi_enum_parse(QuorumReadPattern_lookup,
+                              qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN=
),
+                              QUORUM_READ_PATTERN__MAX, -EINVAL, NULL);
+    }
     if (ret < 0) {
         error_setg(&local_err, "Please set read-pattern as fifo or quoru=
m");
         goto exit;
--=20
2.14.1.146.gd35faa819
