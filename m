Received: from eggs.gnu.org ([209.51.188.92]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbno-0007Qt-D2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbng-0008He-Up
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:52 +0100
Message-Id: <20190201163518.31157-2-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/27] mirror: Release the dirty bitmap if
 mirror_start_job() fails
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

At the moment I don't see how to make this function fail after the
dirty bitmap has been created, but if that was possible then we would
hit the assert(QLIST_EMPTY(&bs->dirty_bitmaps)) in bdrv_close().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 24ede6fdaa..4cf1c088c0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1649,6 +1649,9 @@ fail:
         g_free(s->replaces);
         blk_unref(s->target);
         bs_opaque->job =3D NULL;
+        if (s->dirty_bitmap) {
+            bdrv_release_dirty_bitmap(bs, s->dirty_bitmap);
+        }
         job_early_fail(&s->common.job);
     }
=20
--=20
2.20.1
