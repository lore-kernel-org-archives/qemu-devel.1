Received: from eggs.gnu.org ([2001:4830:134:3::10]:42482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEg-00029D-L0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEf-0002gV-HD
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:30 +0100
Message-Id: <1488901251-16214-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/27] block: Factor out should_update_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 block.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index f293ccb..6dc02b8 100644
--- a/block.c
+++ b/block.c
@@ -2886,28 +2886,40 @@ void bdrv_close_all(void)
     assert(QTAILQ_EMPTY(&all_bdrv_states));
 }
=20
+static bool should_update_child(BdrvChild *c, BlockDriverState *to)
+{
+    BdrvChild *to_c;
+
+    if (c->role->stay_at_node) {
+        return false;
+    }
+
+    if (c->role =3D=3D &child_backing) {
+        /* If @from is a backing file of @to, ignore the child to avoid
+         * creating a loop. We only want to change the pointer of other
+         * parents. */
+        QLIST_FOREACH(to_c, &to->children, next) {
+            if (to_c =3D=3D c) {
+                break;
+            }
+        }
+        if (to_c) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void change_parent_backing_link(BlockDriverState *from,
                                        BlockDriverState *to)
 {
-    BdrvChild *c, *next, *to_c;
+    BdrvChild *c, *next;
=20
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
-        if (c->role->stay_at_node) {
+        if (!should_update_child(c, to)) {
             continue;
         }
-        if (c->role =3D=3D &child_backing) {
-            /* If @from is a backing file of @to, ignore the child to av=
oid
-             * creating a loop. We only want to change the pointer of ot=
her
-             * parents. */
-            QLIST_FOREACH(to_c, &to->children, next) {
-                if (to_c =3D=3D c) {
-                    break;
-                }
-            }
-            if (to_c) {
-                continue;
-            }
-        }
=20
         bdrv_ref(to);
         /* FIXME Are we sure that bdrv_replace_child() can't run into
--=20
1.8.3.1
