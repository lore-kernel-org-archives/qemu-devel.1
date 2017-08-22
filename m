Received: from eggs.gnu.org ([2001:4830:134:3::10]:54664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HW-0006Oi-Ut
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HR-0005mJ-2x
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:11 +0200
Message-Id: <20170822132255.23945-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/54] block: use qemu_enum_parse() in
 blkdebug_debug_breakpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

This slightly change the error report message from "Invalid event
name" to "Invalid parameter".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/blkdebug.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index c19ab28f07..50edda2a31 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -32,6 +32,7 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/util.h"
 #include "sysemu/qtest.h"
=20
 typedef struct BDRVBlkdebugState {
@@ -149,20 +150,6 @@ static QemuOptsList *config_groups[] =3D {
     NULL
 };
=20
-static int get_event_by_name(const char *name, BlkdebugEvent *event)
-{
-    int i;
-
-    for (i =3D 0; i < BLKDBG__MAX; i++) {
-        if (!strcmp(BlkdebugEvent_lookup[i], name)) {
-            *event =3D i;
-            return 0;
-        }
-    }
-
-    return -1;
-}
-
 struct add_rule_data {
     BDRVBlkdebugState *s;
     int action;
@@ -173,7 +160,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Err=
or **errp)
     struct add_rule_data *d =3D opaque;
     BDRVBlkdebugState *s =3D d->s;
     const char* event_name;
-    BlkdebugEvent event;
+    int event;
     struct BlkdebugRule *rule;
     int64_t sector;
=20
@@ -182,8 +169,9 @@ static int add_rule(void *opaque, QemuOpts *opts, Err=
or **errp)
     if (!event_name) {
         error_setg(errp, "Missing event name for rule");
         return -1;
-    } else if (get_event_by_name(event_name, &event) < 0) {
-        error_setg(errp, "Invalid event name \"%s\"", event_name);
+    }
+    event =3D qapi_enum_parse(BlkdebugEvent_lookup, event_name, BLKDBG__=
MAX, -1, errp);
+    if (event < 0) {
         return -1;
     }
=20
@@ -743,13 +731,13 @@ static int blkdebug_debug_breakpoint(BlockDriverSta=
te *bs, const char *event,
 {
     BDRVBlkdebugState *s =3D bs->opaque;
     struct BlkdebugRule *rule;
-    BlkdebugEvent blkdebug_event;
+    int blkdebug_event;
=20
-    if (get_event_by_name(event, &blkdebug_event) < 0) {
+    blkdebug_event =3D qapi_enum_parse(BlkdebugEvent_lookup, event, BLKD=
BG__MAX, -1, NULL);
+    if (blkdebug_event < 0) {
         return -ENOENT;
     }
=20
-
     rule =3D g_malloc(sizeof(*rule));
     *rule =3D (struct BlkdebugRule) {
         .event  =3D blkdebug_event,
--=20
2.14.1.146.gd35faa819
