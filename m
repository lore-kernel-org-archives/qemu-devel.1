Received: from eggs.gnu.org ([2001:4830:134:3::10]:43699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTYdE-0007FB-Vc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 15:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTYdD-0008FL-NJ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 15:09:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 14:09:19 -0500
Message-Id: <20170707190919.31246-1-eblake@redhat.com>
In-Reply-To: <514bf953-81b7-d379-db20-0cb2af29094b@redhat.com>
References: <514bf953-81b7-d379-db20-0cb2af29094b@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

[eblake minor tweaks to a couple of traces]
Signed-off-by: Eric Blake <eblake@redhat.com>
---

If you are okay with this, I plan to squash this into your patch 10
when I send my pull request

 nbd/client.c     | 3 +--
 nbd/server.c     | 5 +++--
 nbd/trace-events | 4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index ab46653..9c52b9b 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -346,7 +346,6 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
         return -1;
     }

-    trace_nbd_receive_query_exports_loop();
     while (1) {
         int ret = nbd_receive_list(ioc, wantname, &foundExport, errp);

@@ -472,7 +471,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
     magic = be64_to_cpu(magic);
-    trace_nbd_receive_negotiate_magic2(magic);
+    trace_nbd_receive_negotiate_magic(magic);

     if (magic == NBD_OPTS_MAGIC) {
         uint32_t clientflags = 0;
diff --git a/nbd/server.c b/nbd/server.c
index ca95f43..9b0c588 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -422,8 +422,9 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
-        trace_nbd_negotiate_options_check_magic();
-        if (magic != be64_to_cpu(NBD_OPTS_MAGIC)) {
+        magic = be64_to_cpu(magic);
+        trace_nbd_negotiate_options_check_magic(magic);
+        if (magic != NBD_OPTS_MAGIC) {
             error_setg(errp, "Bad magic received");
             return -EINVAL;
         }
diff --git a/nbd/trace-events b/nbd/trace-events
index b20165a..4b233b8 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -4,7 +4,6 @@ nbd_send_option_request(uint32_t opt, uint32_t len) "Sending option request %" P
 nbd_receive_option_reply(uint32_t option, uint32_t type, uint32_t length) "Received option reply %" PRIx32", type %" PRIx32", len %" PRIu32
 nbd_reply_err_unsup(uint32_t option) "server doesn't understand request %" PRIx32 ", attempting fallback"
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
-nbd_receive_query_exports_loop(void) "Reading available export names"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_request(void) "Requesting TLS from server"
 nbd_receive_starttls_reply(void) "Getting TLS reply from server"
@@ -12,7 +11,6 @@ nbd_receive_starttls_new_client(void) "TLS request approved, setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-nbd_receive_negotiate_magic2(uint64_t magic) "Magic is 0x%" PRIx64
 nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are %" PRIx32
 nbd_receive_negotiate_default_name(void) "Using default NBD export name \"\""
 nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags %" PRIx16
@@ -40,7 +38,7 @@ nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
 nbd_negotiate_options_flags(void) "Checking client flags"
 nbd_negotiate_options_newstyle(void) "Client supports fixed newstyle handshake"
 nbd_negotiate_options_no_zeroes(void) "Client supports no zeroes at handshake end"
-nbd_negotiate_options_check_magic(void) "Checking opts magic"
+nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
 nbd_negotiate_options_check_option(uint32_t option) "Checking option 0x%" PRIx32
 nbd_opt_abort_reply_failed(const char *error) "Reply to NBD_OPT_ABORT request failed: %s"
 nbd_negotiate_begin(void) "Beginning negotiation"
-- 
2.9.4
