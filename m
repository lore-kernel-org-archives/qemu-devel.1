Received: from eggs.gnu.org ([2001:4830:134:3::10]:53175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqn-0001xZ-9K
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqk-0003Kv-1G
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:43 +0100
Message-Id: <20180302185448.6314-33-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/37] qcow2: make qcow2_co_create2() a
 coroutine_fn
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

From: Stefan Hajnoczi <stefanha@redhat.com>

qcow2_create2() calls qemu_co_mutex_lock().  Only a coroutine_fn may
call another coroutine_fn.  In fact, qcow2_create2 is always called from
coroutine context.

Rename the function to add the "co" moniker and add coroutine_fn.

Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170705102231.20711-3-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 93fb625dcb..7cf3c1518a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2725,11 +2725,12 @@ static uint64_t qcow2_opt_get_refcount_bits_del(Q=
emuOpts *opts, int version,
     return refcount_bits;
 }
=20
-static int qcow2_create2(const char *filename, int64_t total_size,
-                         const char *backing_file, const char *backing_f=
ormat,
-                         int flags, size_t cluster_size, PreallocMode pr=
ealloc,
-                         QemuOpts *opts, int version, int refcount_order=
,
-                         const char *encryptfmt, Error **errp)
+static int coroutine_fn
+qcow2_co_create2(const char *filename, int64_t total_size,
+                 const char *backing_file, const char *backing_format,
+                 int flags, size_t cluster_size, PreallocMode prealloc,
+                 QemuOpts *opts, int version, int refcount_order,
+                 const char *encryptfmt, Error **errp)
 {
     QDict *options;
=20
@@ -2998,9 +2999,9 @@ static int coroutine_fn qcow2_co_create_opts(const =
char *filename, QemuOpts *opt
=20
     refcount_order =3D ctz32(refcount_bits);
=20
-    ret =3D qcow2_create2(filename, size, backing_file, backing_fmt, fla=
gs,
-                        cluster_size, prealloc, opts, version, refcount_=
order,
-                        encryptfmt, &local_err);
+    ret =3D qcow2_co_create2(filename, size, backing_file, backing_fmt, =
flags,
+                           cluster_size, prealloc, opts, version, refcou=
nt_order,
+                           encryptfmt, &local_err);
     error_propagate(errp, local_err);
=20
 finish:
--=20
2.13.6
