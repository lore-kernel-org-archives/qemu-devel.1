Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA2-0007Uh-DT
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA1-0003QZ-Ig
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:30 -0600
Message-Id: <20171107030236.23633-3-eblake@redhat.com>
In-Reply-To: <20171107030236.23633-1-eblake@redhat.com>
References: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] nbd/client: Nicer trace of structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com

It's useful to know which structured reply chunk is being processed.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c     | 4 +++-
 nbd/trace-events | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 3d680e63e1..1880103d2a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -979,6 +979,7 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
     int ret;
+    const char *type;

     ret = nbd_read_eof(ioc, &reply->magic, sizeof(reply->magic), errp);
     if (ret <= 0) {
@@ -1008,8 +1009,9 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
         if (ret < 0) {
             break;
         }
+        type = nbd_reply_type_lookup(reply->structured.type);
         trace_nbd_receive_structured_reply_chunk(reply->structured.flags,
-                                                 reply->structured.type,
+                                                 reply->structured.type, type,
                                                  reply->structured.handle,
                                                  reply->structured.length);
         break;
diff --git a/nbd/trace-events b/nbd/trace-events
index 4a13757524..bbc75f6414 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -27,7 +27,7 @@ nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
 nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
 nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t handle) "Got simple reply: { .error = %" PRId32 " (%s), handle = %" PRIu64" }"
-nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d, handle = %" PRIu64 ", length = %" PRIu32 " }"
+nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), handle = %" PRIu64 ", length = %" PRIu32 " }"

 # nbd/common.c
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
-- 
2.13.6
