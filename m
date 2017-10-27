Received: from eggs.gnu.org ([2001:4830:134:3::10]:57142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824H-000186-KW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824G-0005Uf-4k
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 27 Oct 2017 12:40:26 +0200
Message-Id: <20171027104037.8319-2-eblake@redhat.com>
In-Reply-To: <20171027104037.8319-1-eblake@redhat.com>
References: <20171027104037.8319-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 01/12] nbd: Include error names in trace
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

NBD errors were originally sent over the wire based on Linux errno
values; but not all the world is Linux, and not all platforms share
the same values.  Since a number isn't very easy to decipher on all
platforms, update the trace messages to include the name of NBD
errors being sent/received over the wire.  Tweak the trace messages
to be at the point where we are using the NBD error, not the
translation to the host errno values.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v5: trivial whitespace tweak
---
 nbd/nbd-internal.h |  1 +
 nbd/client.c       |  3 ++-
 nbd/common.c       | 23 +++++++++++++++++++++++
 nbd/server.c       |  3 ++-
 nbd/trace-events   |  4 ++--
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 11a130d050..4bfe5be884 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -126,6 +126,7 @@ const char *nbd_opt_lookup(uint32_t opt);
 const char *nbd_rep_lookup(uint32_t rep);
 const char *nbd_info_lookup(uint16_t info);
 const char *nbd_cmd_lookup(uint16_t info);
+const char *nbd_err_lookup(int err);

 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);

diff --git a/nbd/client.c b/nbd/client.c
index cd5a2c80ac..59d7c9d49f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -940,6 +940,8 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     reply->error  = ldl_be_p(buf + 4);
     reply->handle = ldq_be_p(buf + 8);

+    trace_nbd_receive_reply(magic, reply->error, nbd_err_lookup(reply->error),
+                            reply->handle);
     reply->error = nbd_errno_to_system_errno(reply->error);

     if (reply->error == ESHUTDOWN) {
@@ -947,7 +949,6 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
         error_setg(errp, "server shutting down");
         return -EINVAL;
     }
-    trace_nbd_receive_reply(magic, reply->error, reply->handle);

     if (magic != NBD_SIMPLE_REPLY_MAGIC) {
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
diff --git a/nbd/common.c b/nbd/common.c
index 59a5316be9..7456021f7e 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -148,3 +148,26 @@ const char *nbd_cmd_lookup(uint16_t cmd)
         return "<unknown>";
     }
 }
+
+
+const char *nbd_err_lookup(int err)
+{
+    switch (err) {
+    case NBD_SUCCESS:
+        return "success";
+    case NBD_EPERM:
+        return "EPERM";
+    case NBD_EIO:
+        return "EIO";
+    case NBD_ENOMEM:
+        return "ENOMEM";
+    case NBD_EINVAL:
+        return "EINVAL";
+    case NBD_ENOSPC:
+        return "ENOSPC";
+    case NBD_ESHUTDOWN:
+        return "ESHUTDOWN";
+    default:
+        return "<unknown>";
+    }
+}
diff --git a/nbd/server.c b/nbd/server.c
index 3df3548d6d..459e00c553 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1227,7 +1227,8 @@ static int nbd_co_send_simple_reply(NBDClient *client,
         {.iov_base = data, .iov_len = len}
     };

-    trace_nbd_co_send_simple_reply(handle, nbd_err, len);
+    trace_nbd_co_send_simple_reply(handle, nbd_err, nbd_err_lookup(nbd_err),
+                                   len);
     set_be_simple_reply(&reply, nbd_err, handle);

     return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
diff --git a/nbd/trace-events b/nbd/trace-events
index e27614f050..920c8a0e5e 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -29,7 +29,7 @@ nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
 nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
-nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
+nbd_receive_reply(uint32_t magic, int32_t error, const char *errname, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = %" PRId32 " (%s), handle = %" PRIu64" }"

 # nbd/server.c
 nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=0x%" PRIx32 " (%s), type=0x%" PRIx32 " (%s), len=%" PRIu32
@@ -53,7 +53,7 @@ nbd_negotiate_success(void) "Negotiation succeeded"
 nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
-nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 ", len = %d"
+nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_request_cmd_write(uint32_t len) "Reading %" PRIu32 " byte(s)"
-- 
2.13.6
