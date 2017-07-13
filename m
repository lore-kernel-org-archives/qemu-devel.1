Received: from eggs.gnu.org ([2001:4830:134:3::10]:51907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4e-00025V-BG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4a-0004Q4-8y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4a-0004Pg-1c
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id y28so4892105wrd.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:25 +0200
Message-Id: <1499955874-10954-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/41] nbd: Don't bother tracing an
 NBD_OPT_ABORT response failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We really don't care if our spec-compliant reply to NBD_OPT_ABORT
was received, so shave off some lines of code by not even tracing it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707203049.534-3-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c     | 15 ++++-----------
 nbd/trace-events |  1 -
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 9b0c588..e15385b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -376,7 +376,6 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
 {
     uint32_t flags;
     bool fixedNewstyle = false;
-    Error *local_err = NULL;
 
     /* Client sends:
         [ 0 ..   3]   client flags
@@ -479,7 +478,9 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 if (ret < 0) {
                     return ret;
                 }
-                /* Let the client keep trying, unless they asked to quit */
+                /* Let the client keep trying, unless they asked to
+                 * quit. In this mode, we've already sent an error, so
+                 * we can't ack the abort.  */
                 if (option == NBD_OPT_ABORT) {
                     return 1;
                 }
@@ -498,15 +499,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                 /* NBD spec says we must try to reply before
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
-                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option,
-                                       &local_err);
-
-                if (local_err != NULL) {
-                    const char *error = error_get_pretty(local_err);
-                    trace_nbd_opt_abort_reply_failed(error);
-                    error_free(local_err);
-                }
-
+                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option, NULL);
                 return 1;
 
             case NBD_OPT_EXPORT_NAME:
diff --git a/nbd/trace-events b/nbd/trace-events
index 4b233b8..c6f898e 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -40,7 +40,6 @@ nbd_negotiate_options_newstyle(void) "Client supports fixed newstyle handshake"
 nbd_negotiate_options_no_zeroes(void) "Client supports no zeroes at handshake end"
 nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
 nbd_negotiate_options_check_option(uint32_t option) "Checking option 0x%" PRIx32
-nbd_opt_abort_reply_failed(const char *error) "Reply to NBD_OPT_ABORT request failed: %s"
 nbd_negotiate_begin(void) "Beginning negotiation"
 nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
-- 
1.8.3.1
