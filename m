Received: from eggs.gnu.org ([209.51.188.92]:37483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI54-0000Wh-Er
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI52-00019G-Cf
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:06 +0100
Message-Id: <20190225152053.15976-25-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/71] tests: add test-bdrv-graph-mod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add two tests of node graph modification.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-graph-mod.c | 198 ++++++++++++++++++++++++++++++++++++
 tests/Makefile.include      |   2 +
 2 files changed, 200 insertions(+)
 create mode 100644 tests/test-bdrv-graph-mod.c

diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
new file mode 100644
index 0000000000..458dfa6661
--- /dev/null
+++ b/tests/test-bdrv-graph-mod.c
@@ -0,0 +1,198 @@
+/*
+ * Block node graph modifications tests
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "block/block_int.h"
+#include "sysemu/block-backend.h"
+
+static BlockDriver bdrv_pass_through =3D {
+    .format_name =3D "pass-through",
+    .bdrv_child_perm =3D bdrv_filter_default_perms,
+};
+
+static void no_perm_default_perms(BlockDriverState *bs, BdrvChild *c,
+                                         const BdrvChildRole *role,
+                                         BlockReopenQueue *reopen_queue,
+                                         uint64_t perm, uint64_t shared,
+                                         uint64_t *nperm, uint64_t *nsha=
red)
+{
+    *nperm =3D 0;
+    *nshared =3D BLK_PERM_ALL;
+}
+
+static BlockDriver bdrv_no_perm =3D {
+    .format_name =3D "no-perm",
+    .bdrv_child_perm =3D no_perm_default_perms,
+};
+
+static BlockDriverState *no_perm_node(const char *name)
+{
+    return bdrv_new_open_driver(&bdrv_no_perm, name, BDRV_O_RDWR, &error=
_abort);
+}
+
+static BlockDriverState *pass_through_node(const char *name)
+{
+    return bdrv_new_open_driver(&bdrv_pass_through, name,
+                                BDRV_O_RDWR, &error_abort);
+}
+
+/*
+ * test_update_perm_tree
+ *
+ * When checking node for a possibility to update permissions, it's subt=
ree
+ * should be correctly checked too. New permissions for each node should=
 be
+ * calculated and checked in context of permissions of other nodes. If w=
e
+ * check new permissions of the node only in context of old permissions =
of
+ * its neighbors, we can finish up with wrong permission graph.
+ *
+ * This test firstly create the following graph:
+ *                                +--------+
+ *                                |  root  |
+ *                                +--------+
+ *                                    |
+ *                                    | perm: write, read
+ *                                    | shared: except write
+ *                                    v
+ *  +-------------------+           +----------------+
+ *  | passtrough filter |---------->|  null-co node  |
+ *  +-------------------+           +----------------+
+ *
+ *
+ * and then, tries to append filter under node. Expected behavior: fail.
+ * Otherwise we'll get the following picture, with two BdrvChild'ren, ha=
ving
+ * write permission to one node, without actually sharing it.
+ *
+ *                     +--------+
+ *                     |  root  |
+ *                     +--------+
+ *                         |
+ *                         | perm: write, read
+ *                         | shared: except write
+ *                         v
+ *                +-------------------+
+ *                | passtrough filter |
+ *                +-------------------+
+ *                       |   |
+ *     perm: write, read |   | perm: write, read
+ *  shared: except write |   | shared: except write
+ *                       v   v
+ *                +----------------+
+ *                |  null co node  |
+ *                +----------------+
+ */
+static void test_update_perm_tree(void)
+{
+    Error *local_err =3D NULL;
+
+    BlockBackend *root =3D blk_new(BLK_PERM_WRITE | BLK_PERM_CONSISTENT_=
READ,
+                                 BLK_PERM_ALL & ~BLK_PERM_WRITE);
+    BlockDriverState *bs =3D no_perm_node("node");
+    BlockDriverState *filter =3D pass_through_node("filter");
+
+    blk_insert_bs(root, bs, &error_abort);
+
+    bdrv_attach_child(filter, bs, "child", &child_file, &error_abort);
+
+    bdrv_append(filter, bs, &local_err);
+
+    g_assert_nonnull(local_err);
+
+    bdrv_unref(bs);
+    blk_unref(root);
+}
+
+/*
+ * test_should_update_child
+ *
+ * Test that bdrv_replace_node, and concretely should_update_child
+ * do the right thing, i.e. not creating loops on the graph.
+ *
+ * The test does the following:
+ * 1. initial graph:
+ *
+ *   +------+          +--------+
+ *   | root |          | filter |
+ *   +------+          +--------+
+ *      |                  |
+ *  root|            target|
+ *      v                  v
+ *   +------+          +--------+
+ *   | node |<---------| target |
+ *   +------+  backing +--------+
+ *
+ * 2. Append @filter above @node. If should_update_child works correctly=
,
+ * it understands, that backing child of @target should not be updated,
+ * as it will create a loop on node graph. Resulting picture should
+ * be the left one, not the right:
+ *
+ *     +------+                            +------+
+ *     | root |                            | root |
+ *     +------+                            +------+
+ *        |                                   |
+ *    root|                               root|
+ *        v                                   v
+ *    +--------+   target                 +--------+   target
+ *    | filter |--------------+           | filter |--------------+
+ *    +--------+              |           +--------+              |
+ *        |                   |               |  ^                v
+ * backing|                   |        backing|  |           +--------+
+ *        v                   v               |  +-----------| target |
+ *     +------+          +--------+           v      backing +--------+
+ *     | node |<---------| target |        +------+
+ *     +------+  backing +--------+        | node |
+ *                                         +------+
+ *
+ *    (good picture)                       (bad picture)
+ *
+ */
+static void test_should_update_child(void)
+{
+    BlockBackend *root =3D blk_new(0, BLK_PERM_ALL);
+    BlockDriverState *bs =3D no_perm_node("node");
+    BlockDriverState *filter =3D no_perm_node("filter");
+    BlockDriverState *target =3D no_perm_node("target");
+
+    blk_insert_bs(root, bs, &error_abort);
+
+    bdrv_set_backing_hd(target, bs, &error_abort);
+
+    g_assert(target->backing->bs =3D=3D bs);
+    bdrv_attach_child(filter, target, "target", &child_file, &error_abor=
t);
+    bdrv_append(filter, bs, &error_abort);
+    g_assert(target->backing->bs =3D=3D bs);
+
+    bdrv_unref(bs);
+    blk_unref(root);
+}
+
+int main(int argc, char *argv[])
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/bdrv-graph-mod/update-perm-tree", test_update_perm=
_tree);
+    g_test_add_func("/bdrv-graph-mod/should-update-child",
+                    test_should_update_child);
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b39e989f72..992378e031 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -70,6 +70,7 @@ check-unit-y +=3D tests/test-throttle$(EXESUF)
 check-unit-y +=3D tests/test-thread-pool$(EXESUF)
 check-unit-y +=3D tests/test-hbitmap$(EXESUF)
 check-unit-y +=3D tests/test-bdrv-drain$(EXESUF)
+check-unit-y +=3D tests/test-bdrv-graph-mod$(EXESUF)
 check-unit-y +=3D tests/test-blockjob$(EXESUF)
 check-unit-y +=3D tests/test-blockjob-txn$(EXESUF)
 check-unit-y +=3D tests/test-block-backend$(EXESUF)
@@ -555,6 +556,7 @@ tests/test-aio$(EXESUF): tests/test-aio.o $(test-bloc=
k-obj-y)
 tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test=
-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
 tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain.o $(test-block-obj=
-y) $(test-util-obj-y)
+tests/test-bdrv-graph-mod$(EXESUF): tests/test-bdrv-graph-mod.o $(test-b=
lock-obj-y) $(test-util-obj-y)
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) =
$(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block=
-obj-y) $(test-util-obj-y)
 tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
--=20
2.20.1
