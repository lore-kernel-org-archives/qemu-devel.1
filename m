Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRC5-0006WC-Lg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRC4-0002hK-ED
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:36:33 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Mar 2018 17:36:13 +0100
Message-Id: <20180301163619.21072-3-pbonzini@redhat.com>
In-Reply-To: <20180301163619.21072-1-pbonzini@redhat.com>
References: <20180301163619.21072-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/8] qcow2: make qcow2_co_create2() a
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

qcow2_create2() calls qemu_co_mutex_lock().  Only a coroutine_fn may
call another coroutine_fn.  In fact, qcow2_create2 is always called from
coroutine context.

Rename the function to add the "co" moniker and add coroutine_fn.

Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170705102231.20711-3-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1516279431-30424-3-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d62705d9aa..24edbb431b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2700,11 +2700,12 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(const char *filename, int64_t total_size,
-                         const char *backing_file, const char *backing_format,
-                         int flags, size_t cluster_size, PreallocMode prealloc,
-                         QemuOpts *opts, int version, int refcount_order,
-                         const char *encryptfmt, Error **errp)
+static int coroutine_fn
+qcow2_co_create2(const char *filename, int64_t total_size,
+                 const char *backing_file, const char *backing_format,
+                 int flags, size_t cluster_size, PreallocMode prealloc,
+                 QemuOpts *opts, int version, int refcount_order,
+                 const char *encryptfmt, Error **errp)
 {
     QDict *options;
 
@@ -2973,9 +2974,9 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 
     refcount_order = ctz32(refcount_bits);
 
-    ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
-                        cluster_size, prealloc, opts, version, refcount_order,
-                        encryptfmt, &local_err);
+    ret = qcow2_co_create2(filename, size, backing_file, backing_fmt, flags,
+                           cluster_size, prealloc, opts, version, refcount_order,
+                           encryptfmt, &local_err);
     error_propagate(errp, local_err);
 
 finish:
-- 
2.14.3
