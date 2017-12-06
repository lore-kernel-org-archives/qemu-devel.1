Received: from eggs.gnu.org ([2001:4830:134:3::10]:49279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCN-0000cj-Eb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCK-0000Y5-91
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCK-0000XA-3d
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEAux050895
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epk5h2kxh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:35 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:34 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:23 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-31-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 30/55] qcow2: Always execute preallocate() in a
 coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Some qcow2 functions (at least perform_cow()) expect s->lock to be
taken.  Therefore, if we want to make use of them, we should execute
preallocate() (as "preallocate_co") in a coroutine so that we can use
the qemu_co_mutex_* functions.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171009215533.12530-3-mreitz@redhat.com
Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 572b07bea1d1a0f7726fd95c2613c76002a379bc)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 10e38074ad..668665ea8d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2476,6 +2476,14 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
 }
 
 
+typedef struct PreallocCo {
+    BlockDriverState *bs;
+    uint64_t offset;
+    uint64_t new_length;
+
+    int ret;
+} PreallocCo;
+
 /**
  * Preallocates metadata structures for data clusters between @offset (in the
  * guest disk) and @new_length (which is thus generally the new guest disk
@@ -2483,9 +2491,12 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
  *
  * Returns: 0 on success, -errno on failure.
  */
-static int preallocate(BlockDriverState *bs,
-                       uint64_t offset, uint64_t new_length)
+static void coroutine_fn preallocate_co(void *opaque)
 {
+    PreallocCo *params = opaque;
+    BlockDriverState *bs = params->bs;
+    uint64_t offset = params->offset;
+    uint64_t new_length = params->new_length;
     BDRVQcow2State *s = bs->opaque;
     uint64_t bytes;
     uint64_t host_offset = 0;
@@ -2493,9 +2504,7 @@ static int preallocate(BlockDriverState *bs,
     int ret;
     QCowL2Meta *meta;
 
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_lock(&s->lock);
-    }
+    qemu_co_mutex_lock(&s->lock);
 
     assert(offset <= new_length);
     bytes = new_length - offset;
@@ -2549,10 +2558,28 @@ static int preallocate(BlockDriverState *bs,
     ret = 0;
 
 done:
+    qemu_co_mutex_unlock(&s->lock);
+    params->ret = ret;
+}
+
+static int preallocate(BlockDriverState *bs,
+                       uint64_t offset, uint64_t new_length)
+{
+    PreallocCo params = {
+        .bs         = bs,
+        .offset     = offset,
+        .new_length = new_length,
+        .ret        = -EINPROGRESS,
+    };
+
     if (qemu_in_coroutine()) {
-        qemu_co_mutex_unlock(&s->lock);
+        preallocate_co(&params);
+    } else {
+        Coroutine *co = qemu_coroutine_create(preallocate_co, &params);
+        bdrv_coroutine_enter(bs, co);
+        BDRV_POLL_WHILE(bs, params.ret == -EINPROGRESS);
     }
-    return ret;
+    return params.ret;
 }
 
 /* qcow2_refcount_metadata_size:
-- 
2.11.0
