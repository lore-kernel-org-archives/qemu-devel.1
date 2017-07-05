Received: from eggs.gnu.org ([2001:4830:134:3::10]:60419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dShSL-0008VP-DU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dShSK-0002gT-JL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:22:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  5 Jul 2017 11:22:31 +0100
Message-Id: <20170705102231.20711-3-stefanha@redhat.com>
In-Reply-To: <20170705102231.20711-1-stefanha@redhat.com>
References: <20170705102231.20711-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] qcow2: make qcow2_co_create2() a
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

qcow2_create2() calls qemu_co_mutex_lock().  Only a coroutine_fn may
call another coroutine_fn.

Rename the function (the block layer API is now called
.bdrv_co_create()) and add coroutine_fn.  It is always called from
coroutine context.

Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5279839..b0ae612 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2140,11 +2140,12 @@ static int preallocate(BlockDriverState *bs)
     return 0;
 }
=20
-static int qcow2_create2(const char *filename, int64_t total_size,
-                         const char *backing_file, const char *backing_f=
ormat,
-                         int flags, size_t cluster_size, PreallocMode pr=
ealloc,
-                         QemuOpts *opts, int version, int refcount_order=
,
-                         Error **errp)
+static int coroutine_fn
+qcow2_co_create2(const char *filename, int64_t total_size,
+                 const char *backing_file, const char *backing_format,
+                 int flags, size_t cluster_size, PreallocMode prealloc,
+                 QemuOpts *opts, int version, int refcount_order,
+                 Error **errp)
 {
     int cluster_bits;
     QDict *options;
@@ -2476,9 +2477,9 @@ static int coroutine_fn qcow2_co_create(const char =
*filename, QemuOpts *opts,
=20
     refcount_order =3D ctz32(refcount_bits);
=20
-    ret =3D qcow2_create2(filename, size, backing_file, backing_fmt, fla=
gs,
-                        cluster_size, prealloc, opts, version, refcount_=
order,
-                        &local_err);
+    ret =3D qcow2_co_create2(filename, size, backing_file, backing_fmt, =
flags,
+                           cluster_size, prealloc, opts, version,
+                           refcount_order, &local_err);
     error_propagate(errp, local_err);
=20
 finish:
--=20
2.9.4
