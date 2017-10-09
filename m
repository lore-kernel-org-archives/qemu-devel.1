Received: from eggs.gnu.org ([2001:4830:134:3::10]:50652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq8-0000WP-DQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq1-0004eb-9V
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:40 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14047 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004Z8-Nh
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:23 +0300
Message-Id: <20171009172723.190282-18-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 10/10] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Minimal implementation: for structured error only error_report error
message.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |   6 +
 block/nbd-client.c  | 358 ++++++++++++++++++++++++++++++++++++++++++++++++----
 nbd/client.c        |   7 +
 3 files changed, 343 insertions(+), 28 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 1ef8c8897f..e3350b67a4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -203,6 +203,11 @@ enum {
 #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
 #define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)
 
+static inline bool nbd_srep_type_is_error(int type)
+{
+    return type & (1 << 15);
+}
+
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
  * Everything else is squashed to EINVAL.
@@ -241,6 +246,7 @@ static inline int nbd_errno_to_system_errno(int err)
 struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
+    bool structured_reply;
     /* Set by server results during nbd_receive_negotiate() */
     uint64_t size;
     uint16_t flags;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 58493b7ac4..eda78130a2 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -29,6 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "nbd-client.h"
 
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
@@ -93,7 +94,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         if (i >= MAX_NBD_REQUESTS ||
             !s->requests[i].coroutine ||
             !s->requests[i].receiving ||
-            nbd_reply_is_structured(&s->reply))
+            (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply))
         {
             break;
         }
@@ -181,41 +182,336 @@ err:
     return rc;
 }
 
-static int nbd_co_receive_reply(NBDClientSession *s,
-                                uint64_t handle,
-                                QEMUIOVector *qiov)
+static inline void payload_advance16(uint8_t **payload, uint16_t **ptr)
+{
+    *ptr = (uint16_t *)*payload;
+    be16_to_cpus(*ptr);
+    *payload += sizeof(**ptr);
+}
+
+static inline void payload_advance32(uint8_t **payload, uint32_t **ptr)
+{
+    *ptr = (uint32_t *)*payload;
+    be32_to_cpus(*ptr);
+    *payload += sizeof(**ptr);
+}
+
+static inline void payload_advance64(uint8_t **payload, uint64_t **ptr)
+{
+    *ptr = (uint64_t *)*payload;
+    be64_to_cpus(*ptr);
+    *payload += sizeof(**ptr);
+}
+
+static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
+                                         uint8_t *payload, QEMUIOVector *qiov)
+{
+    uint64_t *offset;
+    uint32_t *hole_size;
+
+    if (chunk->length != sizeof(*offset) + sizeof(*hole_size)) {
+        return -EINVAL;
+    }
+
+    payload_advance64(&payload, &offset);
+    payload_advance32(&payload, &hole_size);
+
+    if (*offset + *hole_size > qiov->size) {
+        return -EINVAL;
+    }
+
+    qemu_iovec_memset(qiov, *offset, 0, *hole_size);
+
+    return 0;
+}
+
+static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
+                                   uint8_t *payload, int *request_ret)
+{
+    uint32_t *error;
+    uint16_t *message_size;
+
+    assert(chunk->type & (1 << 15));
+
+    if (chunk->length < sizeof(error) + sizeof(message_size)) {
+        return -EINVAL;
+    }
+
+    payload_advance32(&payload, &error);
+    payload_advance16(&payload, &message_size);
+
+    error_report("%.*s", *message_size, payload);
+
+    /* TODO add special case for ERROR_OFFSET */
+
+    *request_ret = nbd_errno_to_system_errno(*error);
+
+    return 0;
+}
+
+static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
+                                              QEMUIOVector *qiov)
+{
+    QEMUIOVector sub_qiov;
+    uint64_t offset;
+    size_t data_size;
+    int ret;
+    NBDStructuredReplyChunk *chunk = &s->reply.structured;
+
+    assert(nbd_reply_is_structured(&s->reply));
+
+    if (chunk->length < sizeof(offset)) {
+        return -EINVAL;
+    }
+
+    if (nbd_read(s->ioc, &offset, sizeof(offset), NULL) < 0) {
+        return -EIO;
+    }
+    be64_to_cpus(&offset);
+
+    data_size = chunk->length - sizeof(offset);
+    if (offset + data_size > qiov->size) {
+        return -EINVAL;
+    }
+
+    qemu_iovec_init(&sub_qiov, qiov->niov);
+    qemu_iovec_concat(&sub_qiov, qiov, offset, data_size);
+    ret = qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, NULL);
+    qemu_iovec_destroy(&sub_qiov);
+
+    return ret < 0 ? -EIO : 0;
+}
+
+#define NBD_MAX_MALLOC_PAYLOAD 1000
+static int nbd_co_receive_structured_payload(NBDClientSession *s,
+                                             void **payload)
+{
+    int ret;
+    uint32_t len;
+
+    assert(nbd_reply_is_structured(&s->reply));
+
+    len = s->reply.structured.length;
+
+    if (len == 0) {
+        return 0;
+    }
+
+    if (payload == NULL) {
+        return -EINVAL;
+    }
+
+    if (len > NBD_MAX_MALLOC_PAYLOAD) {
+        return -EINVAL;
+    }
+
+    *payload = qemu_memalign(8, len);
+    ret = nbd_read(s->ioc, *payload, len, NULL);
+    if (ret < 0) {
+        qemu_vfree(*payload);
+        *payload = NULL;
+        return ret;
+    }
+
+    return 0;
+}
+
+/* nbd_co_do_receive_one_chunk
+ * for simple reply:
+ *   set request_ret to received reply error
+ *   if qiov is not NULL: read payload to @qiov
+ * for structured reply chunk:
+ *   if error chunk: read payload, set @request_ret, do not set @payload
+ *   else if offset_data chunk: read payload data to @qiov, do not set @payload
+ *   else: read payload to @payload
+ */
+static int nbd_co_do_receive_one_chunk(NBDClientSession *s, uint64_t handle,
+                                       bool only_structured, int *request_ret,
+                                       QEMUIOVector *qiov, void **payload)
 {
     int ret;
     int i = HANDLE_TO_INDEX(s, handle);
+    void *local_payload = NULL;
+
+    if (payload) {
+        *payload = NULL;
+    }
+    *request_ret = 0;
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
     if (!s->ioc || s->quit) {
-        ret = -EIO;
-    } else {
-        assert(s->reply.handle == handle);
-        ret = -nbd_errno_to_system_errno(s->reply.simple.error);
-        if (qiov && ret == 0) {
-            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
-                                      NULL) < 0) {
-                ret = -EIO;
-                s->quit = true;
-            }
+        return -EIO;
+    }
+
+    assert(s->reply.handle == handle);
+
+    if (nbd_reply_is_simple(&s->reply)) {
+        if (only_structured) {
+            return -EINVAL;
         }
 
-        /* Tell the read handler to read another header.  */
-        s->reply.handle = 0;
+        *request_ret = -nbd_errno_to_system_errno(s->reply.simple.error);
+        if (*request_ret < 0 || !qiov) {
+            return 0;
+        }
+
+        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
+                                     NULL) < 0 ? -EIO : 0;
     }
 
-    s->requests[i].coroutine = NULL;
+    /* handle structured reply chunk */
+    assert(s->info.structured_reply);
+
+    if (s->reply.structured.type == NBD_SREP_TYPE_NONE) {
+        return 0;
+    }
+
+    if (s->reply.structured.type == NBD_SREP_TYPE_OFFSET_DATA) {
+        if (!qiov) {
+            return -EINVAL;
+        }
+
+        return nbd_co_receive_offset_data_payload(s, qiov);
+    }
+
+    if (nbd_srep_type_is_error(s->reply.structured.type)) {
+        payload = &local_payload;
+    }
+
+    ret = nbd_co_receive_structured_payload(s, payload);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (nbd_srep_type_is_error(s->reply.structured.type)) {
+        ret = nbd_parse_error_payload(&s->reply.structured, local_payload,
+                                      request_ret);
+        qemu_vfree(local_payload);
+        return ret;
+    }
+
+    return 0;
+}
+
+/* nbd_co_receive_one_chunk
+ * Read reply, wake up read_reply_co and set s->quit if needed.
+ * Return value is a fatal error code or normal nbd reply error code
+ */
+static int nbd_co_receive_one_chunk(NBDClientSession *s, uint64_t handle,
+                                    bool only_structured,
+                                    QEMUIOVector *qiov, NBDReply *reply,
+                                    void **payload)
+{
+    int request_ret;
+    int ret = nbd_co_do_receive_one_chunk(s, handle, only_structured,
+                                          &request_ret, qiov, payload);
+
+    if (ret < 0) {
+        s->quit = true;
+    } else {
+        /* For assert at loop start in nbd_read_reply_entry */
+        if (reply) {
+            *reply = s->reply;
+        }
+        s->reply.handle = 0;
+        ret = request_ret;
+    }
 
-    /* Kick the read_reply_co to get the next reply.  */
     if (s->read_reply_co) {
         aio_co_wake(s->read_reply_co);
     }
 
+    return ret;
+}
+
+static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle)
+{
+    int ret = 0;
+    int i = HANDLE_TO_INDEX(s, handle);
+    NBDReply reply;
+    bool only_structured = false;
+
+    do {
+        int rc = nbd_co_receive_one_chunk(s, handle, only_structured,
+                                          NULL, &reply, NULL);
+        if (rc < 0 || nbd_reply_is_simple(&reply)) {
+            if (ret == 0) {
+                ret = rc;
+            }
+            only_structured = true;
+            continue;
+        }
+
+        if (reply.structured.type != NBD_SREP_TYPE_NONE) {
+            /* not allowed reply type */
+            ret = -EIO;
+            s->quit = true;
+            break;
+        }
+
+        only_structured = true;
+    } while (!s->quit && nbd_reply_is_structured(&s->reply) &&
+             !(s->reply.structured.flags & NBD_SREP_FLAG_DONE));
+
+    s->requests[i].coroutine = NULL;
+
+    qemu_co_mutex_lock(&s->send_mutex);
+    s->in_flight--;
+    qemu_co_queue_next(&s->free_sema);
+    qemu_co_mutex_unlock(&s->send_mutex);
+
+    return ret;
+}
+
+static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
+                                        QEMUIOVector *qiov)
+{
+    int ret = 0;
+    int i = HANDLE_TO_INDEX(s, handle);
+    bool only_structured = s->info.structured_reply;
+    NBDReply reply;
+
+    do {
+        void *payload = NULL;
+        int rc = nbd_co_receive_one_chunk(s, handle, only_structured,
+                                          qiov, &reply, &payload);
+        if (rc < 0 || nbd_reply_is_simple(&reply)) {
+            if (ret == 0) {
+                ret = rc;
+            }
+            only_structured = true;
+            continue;
+        }
+
+        switch (reply.structured.type) {
+        case NBD_SREP_TYPE_OFFSET_DATA:
+            /* special cased in nbd_co_receive_one_chunk, data is already
+             * in qiov */
+            break;
+        case NBD_SREP_TYPE_OFFSET_HOLE:
+            ret = nbd_parse_offset_hole_payload(&reply.structured, payload,
+                                                qiov);
+            if (ret < 0) {
+                s->quit = true;
+            }
+            break;
+        default:
+            /* not allowed reply type */
+            ret = -EINVAL;
+            s->quit = true;
+        }
+
+        qemu_vfree(payload);
+        only_structured = true;
+    } while (!s->quit && nbd_reply_is_structured(&s->reply) &&
+             !(s->reply.structured.flags & NBD_SREP_FLAG_DONE));
+
+
+    s->requests[i].coroutine = NULL;
+
     qemu_co_mutex_lock(&s->send_mutex);
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
@@ -226,30 +522,31 @@ static int nbd_co_receive_reply(NBDClientSession *s,
 
 static int nbd_co_request(BlockDriverState *bs,
                           NBDRequest *request,
-                          QEMUIOVector *qiov)
+                          QEMUIOVector *write_qiov)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
 
-    if (qiov) {
-        assert(request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ);
-        assert(request->len == iov_size(qiov->iov, qiov->niov));
+    assert(request->type != NBD_CMD_READ);
+    if (write_qiov) {
+        assert(request->type == NBD_CMD_WRITE);
+        assert(request->len == iov_size(write_qiov->iov, write_qiov->niov));
     } else {
-        assert(request->type != NBD_CMD_WRITE && request->type != NBD_CMD_READ);
+        assert(request->type != NBD_CMD_WRITE);
     }
-    ret = nbd_co_send_request(bs, request,
-                              request->type == NBD_CMD_WRITE ? qiov : NULL);
+    ret = nbd_co_send_request(bs, request, write_qiov);
     if (ret < 0) {
         return ret;
     }
 
-    return nbd_co_receive_reply(client, request->handle,
-                                request->type == NBD_CMD_READ ? qiov : NULL);
+    return nbd_co_receive_return_code(client, request->handle);
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
+    int ret;
+    NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = {
         .type = NBD_CMD_READ,
         .from = offset,
@@ -259,7 +556,12 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     assert(bytes <= NBD_MAX_BUFFER_SIZE);
     assert(!flags);
 
-    return nbd_co_request(bs, &request, qiov);
+    ret = nbd_co_send_request(bs, &request, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return nbd_co_receive_cmdread_reply(client, request.handle, qiov);
 }
 
 int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
diff --git a/nbd/client.c b/nbd/client.c
index a38e1a7d8e..2f256ee771 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -687,6 +687,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
         if (fixedNewStyle) {
             int result;
 
+            result = nbd_request_simple_option(ioc, NBD_OPT_STRUCTURED_REPLY,
+                                               errp);
+            if (result < 0) {
+                goto fail;
+            }
+            info->structured_reply = result == 1;
+
             /* Try NBD_OPT_GO first - if it works, we are done (it
              * also gives us a good message if the server requires
              * TLS).  If it is not available, fall back to
-- 
2.11.1
