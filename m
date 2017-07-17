Received: from eggs.gnu.org ([2001:4830:134:3::10]:44866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXBfR-0005Gz-Rs
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXBfQ-0004Ef-Tf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:26:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 14:26:34 -0500
Message-Id: <20170717192635.17880-2-eblake@redhat.com>
In-Reply-To: <20170717192635.17880-1-eblake@redhat.com>
References: <20170717192635.17880-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] nbd: Trace client command being sent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com

Make the client trace slightly more legible by including the name
of the command being sent.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 nbd/client.c     | 3 ++-
 nbd/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index c3ee9f36b1..4c12fffcbf 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -902,7 +902,8 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     uint8_t buf[NBD_REQUEST_SIZE];

     trace_nbd_send_request(request->from, request->len, request->handle,
-                           request->flags, request->type);
+                           request->flags, request->type,
+                           nbd_cmd_lookup(request->type));

     stl_be_p(buf, NBD_REQUEST_MAGIC);
     stw_be_p(buf + 4, request->flags);
diff --git a/nbd/trace-events b/nbd/trace-events
index f5024d85a1..d7c7746ea8 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -28,7 +28,7 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = %" PRIx16 ", .type = %" PRIu16 " }"
+nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = %" PRIx16 ", .type = %" PRIu16 " (%s) }"
 nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"

 # nbd/server.c
-- 
2.13.3
