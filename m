Received: from eggs.gnu.org ([2001:4830:134:3::10]:47323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXAMw-0005aG-1T
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXAMu-0007k7-UY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:29 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 20:40:07 +0100
Message-Id: <20181212194009.2951-3-lvivier@redhat.com>
In-Reply-To: <20181212194009.2951-1-lvivier@redhat.com>
References: <20181212194009.2951-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] block/curl: Convert from DPRINTF() macro
 to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Liu Yuan <namei.unix@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 block/curl.c       | 29 ++++++++---------------------
 block/trace-events |  9 +++++++++
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index db5d2bd8ef..b7ac265d3a 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -32,22 +32,10 @@
 #include "crypto/secret.h"
 #include <curl/curl.h>
 #include "qemu/cutils.h"
+#include "trace.h"
=20
-// #define DEBUG_CURL
 // #define DEBUG_VERBOSE
=20
-#ifdef DEBUG_CURL
-#define DEBUG_CURL_PRINT 1
-#else
-#define DEBUG_CURL_PRINT 0
-#endif
-#define DPRINTF(fmt, ...)                                            \
-    do {                                                             \
-        if (DEBUG_CURL_PRINT) {                                      \
-            fprintf(stderr, fmt, ## __VA_ARGS__);                    \
-        }                                                            \
-    } while (0)
-
 #if LIBCURL_VERSION_NUM >=3D 0x071000
 /* The multi interface timer callback was introduced in 7.16.0 */
 #define NEED_CURL_TIMER_CALLBACK
@@ -154,7 +142,7 @@ static int curl_timer_cb(CURLM *multi, long timeout_m=
s, void *opaque)
 {
     BDRVCURLState *s =3D opaque;
=20
-    DPRINTF("CURL: timer callback timeout_ms %ld\n", timeout_ms);
+    trace_curl_timer_cb(timeout_ms);
     if (timeout_ms =3D=3D -1) {
         timer_del(&s->timer);
     } else {
@@ -193,7 +181,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd,=
 int action,
     }
     socket =3D NULL;
=20
-    DPRINTF("CURL (AIO): Sock action %d on fd %d\n", action, (int)fd);
+    trace_curl_sock_cb(action, (int)fd);
     switch (action) {
         case CURL_POLL_IN:
             aio_set_fd_handler(s->aio_context, fd, false,
@@ -238,7 +226,7 @@ static size_t curl_read_cb(void *ptr, size_t size, si=
ze_t nmemb, void *opaque)
     size_t realsize =3D size * nmemb;
     int i;
=20
-    DPRINTF("CURL: Just reading %zd bytes\n", realsize);
+    trace_curl_read_cb(realsize);
=20
     if (!s || !s->orig_buf) {
         goto read_end;
@@ -777,7 +765,7 @@ static int curl_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
         }
     }
=20
-    DPRINTF("CURL: Opening %s\n", file);
+    trace_curl_open(file);
     qemu_co_queue_init(&s->free_state_waitq);
     s->aio_context =3D bdrv_get_aio_context(bs);
     s->url =3D g_strdup(file);
@@ -830,7 +818,7 @@ static int curl_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
                 "Server does not support 'range' (byte ranges).");
         goto out;
     }
-    DPRINTF("CURL: Size =3D %" PRIu64 "\n", s->len);
+    trace_curl_open_size(s->len);
=20
     qemu_mutex_lock(&s->mutex);
     curl_clean_state(state);
@@ -908,8 +896,7 @@ static void curl_setup_preadv(BlockDriverState *bs, C=
URLAIOCB *acb)
     state->acb[0] =3D acb;
=20
     snprintf(state->range, 127, "%" PRIu64 "-%" PRIu64, start, end);
-    DPRINTF("CURL (AIO): Reading %" PRIu64 " at %" PRIu64 " (%s)\n",
-            acb->bytes, start, state->range);
+    trace_curl_setup_preadv(acb->bytes, start, state->range);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
=20
     curl_multi_add_handle(s->multi, state->curl);
@@ -943,7 +930,7 @@ static void curl_close(BlockDriverState *bs)
 {
     BDRVCURLState *s =3D bs->opaque;
=20
-    DPRINTF("CURL: Close\n");
+    trace_curl_close();
     curl_detach_aio_context(bs);
     qemu_mutex_destroy(&s->mutex);
=20
diff --git a/block/trace-events b/block/trace-events
index b13b1e9706..5b83280b02 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -173,3 +173,12 @@ ssh_write(int64_t offset, size_t size) "offset=3D%" =
PRIi64 " size=3D%zu"
 ssh_write_buf(void *buf, size_t size) "sftp_write buf=3D%p size=3D%zu"
 ssh_write_return(size_t ret) "sftp_write returned %zd"
 ssh_seek(uint64_t offset) "seeking to offset=3D%" PRIi64
+
+# block/curl.c
+curl_timer_cb(long timeout_ms) "timer callback timeout_ms %ld"
+curl_sock_cb(int action, int fd) "sock action %d on fd %d"
+curl_read_cb(size_t realsize) "just reading %zd bytes"
+curl_open(const char *file) "opening %s"
+curl_open_size(uint64_t size) "size =3D %" PRIu64
+curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "re=
ading %" PRIu64 " at %" PRIu64 " (%s)"
+curl_close(void) "close"
--=20
2.19.2
