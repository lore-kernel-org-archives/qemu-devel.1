Received: from eggs.gnu.org ([2001:4830:134:3::10]:37205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmQ-0003Pd-BD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0000QT-O9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmO-0000PY-Dp
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:03 +0200
Message-Id: <1503564371-26090-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/16] quorum: Use qapi_enum_parse() in
 quorum_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, Alberto Garcia <berto@igalia.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-12-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, qemu_opt_get() factored out, commit message tweaked]
Cc: Alberto Garcia <berto@igalia.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/quorum.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index d04da4f..cb66177 100644
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
@@ -867,30 +868,13 @@ static QemuOptsList quorum_runtime_opts =3D {
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
     BDRVQuorumState *s =3D bs->opaque;
     Error *local_err =3D NULL;
     QemuOpts *opts =3D NULL;
+    const char *pattern_str;
     bool *opened;
     int i;
     int ret =3D 0;
@@ -925,7 +909,13 @@ static int quorum_open(BlockDriverState *bs, QDict *=
options, int flags,
         goto exit;
     }
=20
-    ret =3D parse_read_pattern(qemu_opt_get(opts, QUORUM_OPT_READ_PATTER=
N));
+    pattern_str =3D qemu_opt_get(opts, QUORUM_OPT_READ_PATTERN);
+    if (!pattern_str) {
+        ret =3D QUORUM_READ_PATTERN_QUORUM;
+    } else {
+        ret =3D qapi_enum_parse(QuorumReadPattern_lookup, pattern_str,
+                              -EINVAL, NULL);
+    }
     if (ret < 0) {
         error_setg(&local_err, "Please set read-pattern as fifo or quoru=
m");
         goto exit;
--=20
2.7.5
