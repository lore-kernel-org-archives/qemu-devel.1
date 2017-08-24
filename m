Received: from eggs.gnu.org ([2001:4830:134:3::10]:37234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmR-0003QU-Ny
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmQ-0000S5-Tb
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:23 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:02 +0200
Message-Id: <1503564371-26090-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/16] block: Use qemu_enum_parse() in
 blkdebug_debug_breakpoint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The error message on invalid blkdebug events changes from

    qemu-system-x86_64: LOCATION: Invalid event name "VALUE"

to

    qemu-system-x86_64: LOCATION: invalid parameter value: VALUE

Slight degradation, but the message is sub-par even before the patch.
When complaining about a parameter value, both parameter name and
value should be mentioned, as the value may well not be unique.  Left
for another day.

Also left is the error message's unhelpful location: it points to the
config=3DFILENAME rather than into that file.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-11-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, commit message rewritten]
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/blkdebug.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index c19ab28..f1bbee9 100644
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
+    event =3D qapi_enum_parse(BlkdebugEvent_lookup, event_name, -1, errp=
);
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
+    blkdebug_event =3D qapi_enum_parse(BlkdebugEvent_lookup, event, -1, =
NULL);
+    if (blkdebug_event < 0) {
         return -ENOENT;
     }
=20
-
     rule =3D g_malloc(sizeof(*rule));
     *rule =3D (struct BlkdebugRule) {
         .event  =3D blkdebug_event,
--=20
2.7.5
