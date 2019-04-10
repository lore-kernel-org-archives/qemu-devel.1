Received: from eggs.gnu.org ([209.51.188.92]:34668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiN-0006uM-VE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiM-0004Lo-Nb
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:20:59 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 10 Apr 2019 22:20:23 +0200
Message-Id: <20190410202033.28617-2-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-1-mreitz@redhat.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/11] block: Mark commit and mirror as
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

The commit and mirror block nodes are filters, so they should be marked
as such.  (Strictly speaking, BDS.is_filter's documentation states that
a filter's child must be bs->file.  The following patch will relax this
restriction, however.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 2 ++
 block/mirror.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..02eab34925 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -257,6 +257,8 @@ static BlockDriver bdrv_commit_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_commit_top_child_perm,
+
+    .is_filter                  =3D true,
 };
=20
 void commit_start(const char *job_id, BlockDriverState *bs,
diff --git a/block/mirror.c b/block/mirror.c
index ff15cfb197..8b2404051f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1489,6 +1489,8 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
+
+    .is_filter                  =3D true,
 };
=20
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
--=20
2.20.1
