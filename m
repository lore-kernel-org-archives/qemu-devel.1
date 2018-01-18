Received: from eggs.gnu.org ([2001:4830:134:3::10]:40016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ec9Xz-0001Dm-Ho
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ec9Xy-0004Wp-5d
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:43:59 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Jan 2018 13:43:46 +0100
Message-Id: <1516279431-30424-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/7] qcow2: make qcow2_co_create2() a
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

qcow2_create2() calls qemu_co_mutex_lock().  Only a coroutine_fn may
call another coroutine_fn.  In fact, qcow2_create2 is always called from
coroutine context.

Rename the function to add the "co" moniker and add coroutine_fn.

Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170705102231.20711-3-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index be2d485..fec065b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2690,11 +2690,12 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
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
 
@@ -2963,9 +2964,9 @@ static int coroutine_fn qcow2_co_create(const char *filename, QemuOpts *opts,
 
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
1.8.3.1
