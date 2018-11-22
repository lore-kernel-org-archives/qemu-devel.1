Received: from eggs.gnu.org ([2001:4830:134:3::10]:37189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFU-0001ms-OO
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFT-0000vv-Hs
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:11 +0100
Message-Id: <20181122165417.23894-8-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/13] block: Fix update of BDRV_O_AUTO_RDONLY
 in update_flags_from_options()
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

From: Alberto Garcia <berto@igalia.com>

Commit e35bdc123a4ace9f4d3fcca added the auto-read-only option and the
code to update its corresponding flag in update_flags_from_options(),
but forgot to clear the flag if auto-read-only is false.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 3feac08535..9cd6f4a50d 100644
--- a/block.c
+++ b/block.c
@@ -1137,7 +1137,7 @@ static int bdrv_open_flags(BlockDriverState *bs, in=
t flags)
=20
 static void update_flags_from_options(int *flags, QemuOpts *opts)
 {
-    *flags &=3D ~BDRV_O_CACHE_MASK;
+    *flags &=3D ~(BDRV_O_CACHE_MASK | BDRV_O_RDWR | BDRV_O_AUTO_RDONLY);
=20
     assert(qemu_opt_find(opts, BDRV_OPT_CACHE_NO_FLUSH));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
@@ -1149,8 +1149,6 @@ static void update_flags_from_options(int *flags, Q=
emuOpts *opts)
         *flags |=3D BDRV_O_NOCACHE;
     }
=20
-    *flags &=3D ~BDRV_O_RDWR;
-
     assert(qemu_opt_find(opts, BDRV_OPT_READ_ONLY));
     if (!qemu_opt_get_bool_del(opts, BDRV_OPT_READ_ONLY, false)) {
         *flags |=3D BDRV_O_RDWR;
--=20
2.19.1
