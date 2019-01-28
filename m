Received: from eggs.gnu.org ([209.51.188.92]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go7ta-0000TQ-1Z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go7tZ-0006JT-BN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:28:18 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Date: Mon, 28 Jan 2019 17:27:47 +0300
Message-Id: <20190128142748.29140-2-antonkuchin@yandex-team.ru>
In-Reply-To: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
References: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] block: add functions to search
 BlockBackend by root BDS name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, Anton Kuchin <antonkuchin@yandex-team.ru>

BlockBackend name is empty if it is added with '-blockdev' and '-device'
options or hotplugged with QMP but callers still expect backend to be
accesible by name for operations like commit or statistics access.
Intoduce blk_lookup function to search both by name and BDS-root node_nam=
e.

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 block/block-backend.c          | 29 +++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 60d37a0c3d..86a492853c 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -684,6 +684,35 @@ static BlockBackend *bdrv_first_blk(BlockDriverState=
 *bs)
     return NULL;
 }
=20
+/*
+ * Return the BlockBackend that has attached BDS-tree root with
+ * node_name @node_name if it exists, else null.
+ * @node_name must not be null.
+ */
+static BlockBackend *blk_by_root_name(const char *node_name)
+{
+    BlockBackend *blk =3D NULL;
+
+    assert(node_name);
+    while ((blk =3D blk_all_next(blk)) !=3D NULL) {
+        BlockDriverState *bs =3D blk_bs(blk);
+        if (bs && !strcmp(node_name, bs->node_name)) {
+            return blk;
+        }
+    }
+    return NULL;
+}
+
+BlockBackend *blk_lookup(const char *name)
+{
+    assert(name);
+    BlockBackend *blk =3D blk_by_name(name);
+    if (!blk) {
+        blk =3D blk_by_root_name(name);
+    }
+    return blk;
+}
+
 /*
  * Returns true if @bs has an associated BlockBackend.
  */
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index c96bcdee14..290b8f8fc9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -85,6 +85,13 @@ void blk_unref(BlockBackend *blk);
 void blk_remove_all_bs(void);
 const char *blk_name(const BlockBackend *blk);
 BlockBackend *blk_by_name(const char *name);
+
+/*
+ * Search BlockBackend by name or root BlockDriverSate node_name.
+ * Hotplug BlockBackends have no name so need to also check BDS-tree roo=
ts
+ * @name must not be null.
+ */
+BlockBackend *blk_lookup(const char *name);
 BlockBackend *blk_next(BlockBackend *blk);
 BlockBackend *blk_all_next(BlockBackend *blk);
 bool monitor_add_blk(BlockBackend *blk, const char *name, Error **errp);
--=20
2.19.1
