Received: from eggs.gnu.org ([2001:4830:134:3::10]:33553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLM-00008e-S9
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLL-0004dI-Rb
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:40 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 17:27:22 -0500
Message-Id: <bc6988fb22c5a5c67300ab99fa2e955df10aae61.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/7] block/curl: check error return of
 curl_global_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com, eblake@redhat.com

If curl_global_init() fails, per the documentation no other curl
functions may be called, so make sure to check the return value.

Also, some minor changes to the initialization latch variable 'inited':

- Make it static in the file, for clarity
- Change the name for clarity
- Make it a bool

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/curl.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 2a244e2..00a9879 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -89,6 +89,8 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 
 struct BDRVCURLState;
 
+static bool libcurl_initialized;
+
 typedef struct CURLAIOCB {
     Coroutine *co;
     QEMUIOVector *qiov;
@@ -686,14 +688,23 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     double d;
     const char *secretid;
     const char *protocol_delimiter;
+    int ret;
 
-    static int inited = 0;
 
     if (flags & BDRV_O_RDWR) {
         error_setg(errp, "curl block device does not support writes");
         return -EROFS;
     }
 
+    if (!libcurl_initialized) {
+        ret = curl_global_init(CURL_GLOBAL_ALL);
+        if (ret) {
+            error_setg(errp, "libcurl initialization failed with %d", ret);
+            return -EIO;
+        }
+        libcurl_initialized = true;
+    }
+
     qemu_mutex_init(&s->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -772,11 +783,6 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (!inited) {
-        curl_global_init(CURL_GLOBAL_ALL);
-        inited = 1;
-    }
-
     DPRINTF("CURL: Opening %s\n", file);
     QSIMPLEQ_INIT(&s->free_state_waitq);
     s->aio_context = bdrv_get_aio_context(bs);
-- 
2.9.5
