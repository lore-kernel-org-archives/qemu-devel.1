Received: from eggs.gnu.org ([209.51.188.92]:37479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI54-0000Wf-Dg
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI52-00018q-9K
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:05 +0100
Message-Id: <20190225152053.15976-24-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/71] block: fix bdrv_check_perm for non-tree
 subgraph
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

bdrv_check_perm in it's recursion checks each node in context of new
permissions for one parent, because of nature of DFS. It works well,
while children subgraph of top-most updated node is a tree, i.e. it
doesn't have any kind of loops. But if we have a loop (not oriented,
of course), i.e. we have two different ways from top-node to some
child-node, then bdrv_check_perm will do wrong thing:

  top
  | \
  |  |
  v  v
  A  B
  |  |
  v  v
  node

It will once check new permissions of node in context of new A
permissions and old B permissions and once visa-versa. It's a wrong way
and may lead to corruption of permission system. We may start with
no-permissions and all-shared for both A->node and B->node relations
and finish up with non shared write permission for both ways.

The following commit will add a test, which shows this bug.

To fix this situation, let's really set BdrvChild permissions during
bdrv_check_perm procedure. And we are happy here, as check-perm is
already written in transaction manner, so we just need to restore
backed-up permissions in _abort.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  5 +++++
 block.c                   | 27 ++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0075bafd10..8437df85a2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -662,6 +662,11 @@ struct BdrvChild {
      */
     uint64_t shared_perm;
=20
+    /* backup of permissions during permission update procedure */
+    bool has_backup_perm;
+    uint64_t backup_perm;
+    uint64_t backup_shared_perm;
+
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
 };
diff --git a/block.c b/block.c
index bb4bf1237c..16d59e0b32 100644
--- a/block.c
+++ b/block.c
@@ -1954,13 +1954,32 @@ static int bdrv_child_check_perm(BdrvChild *c, Bl=
ockReopenQueue *q,
     ret =3D bdrv_check_update_perm(c->bs, q, perm, shared, ignore_childr=
en, errp);
     g_slist_free(ignore_children);
=20
-    return ret;
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (!c->has_backup_perm) {
+        c->has_backup_perm =3D true;
+        c->backup_perm =3D c->perm;
+        c->backup_shared_perm =3D c->shared_perm;
+    }
+    /*
+     * Note: it's OK if c->has_backup_perm was already set, as we can fi=
nd the
+     * same child twice during check_perm procedure
+     */
+
+    c->perm =3D perm;
+    c->shared_perm =3D shared;
+
+    return 0;
 }
=20
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t sh=
ared)
 {
     uint64_t cumulative_perms, cumulative_shared_perms;
=20
+    c->has_backup_perm =3D false;
+
     c->perm =3D perm;
     c->shared_perm =3D shared;
=20
@@ -1971,6 +1990,12 @@ static void bdrv_child_set_perm(BdrvChild *c, uint=
64_t perm, uint64_t shared)
=20
 static void bdrv_child_abort_perm_update(BdrvChild *c)
 {
+    if (c->has_backup_perm) {
+        c->perm =3D c->backup_perm;
+        c->shared_perm =3D c->backup_shared_perm;
+        c->has_backup_perm =3D false;
+    }
+
     bdrv_abort_perm_update(c->bs);
 }
=20
--=20
2.20.1
