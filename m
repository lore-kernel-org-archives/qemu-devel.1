Received: from eggs.gnu.org ([2001:4830:134:3::10]:46699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTZuD-0002uq-ET
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTZuC-0003vq-Ek
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:31:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 15:30:44 -0500
Message-Id: <20170707203049.534-5-eblake@redhat.com>
In-Reply-To: <20170707203049.534-1-eblake@redhat.com>
References: <20170707203049.534-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/9] nbd: Simplify trace of client flags in
 negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

Simplify the tracing of client flags in the server, and return -EINVAL
instead of -EIO if we successfully read but don't like those flags.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: new patch
---
 nbd/server.c     | 6 ++----
 nbd/trace-events | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 27a0aab..8e363d3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -396,21 +396,19 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         error_prepend(errp, "read failed: ");
         return -EIO;
     }
-    trace_nbd_negotiate_options_flags();
     be32_to_cpus(&flags);
+    trace_nbd_negotiate_options_flags(flags);
     if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
-        trace_nbd_negotiate_options_newstyle();
         fixedNewstyle = true;
         flags &= ~NBD_FLAG_C_FIXED_NEWSTYLE;
     }
     if (flags & NBD_FLAG_C_NO_ZEROES) {
-        trace_nbd_negotiate_options_no_zeroes();
         client->no_zeroes = true;
         flags &= ~NBD_FLAG_C_NO_ZEROES;
     }
     if (flags != 0) {
         error_setg(errp, "Unknown client flags 0x%" PRIx32 " received", flags);
-        return -EIO;
+        return -EINVAL;
     }

     while (1) {
diff --git a/nbd/trace-events b/nbd/trace-events
index e61feda..765f5f4 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -35,9 +35,7 @@ nbd_negotiate_handle_export_name(void) "Checking length"
 nbd_negotiate_handle_export_name_request(const char *name) "Client requested export '%s'"
 nbd_negotiate_handle_starttls(void) "Setting up TLS"
 nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
-nbd_negotiate_options_flags(void) "Checking client flags"
-nbd_negotiate_options_newstyle(void) "Client supports fixed newstyle handshake"
-nbd_negotiate_options_no_zeroes(void) "Client supports no zeroes at handshake end"
+nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
 nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
 nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option 0x%" PRIx32 " (%s)"
 nbd_opt_abort_reply_failed(const char *error) "Reply to NBD_OPT_ABORT request failed: %s"
-- 
2.9.4
