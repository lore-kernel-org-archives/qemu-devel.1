Received: from eggs.gnu.org ([2001:4830:134:3::10]:51457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3g-0001Ev-Ka
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3f-0002gV-F2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:36 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3f-0002et-8j
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:35 -0400
Received: by mail-wm0-x244.google.com with SMTP id y5so5447973wmh.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:27 +0200
Message-Id: <1499955874-10954-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/41] nbd: Simplify trace of client flags in
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

From: Eric Blake <eblake@redhat.com>

Simplify the tracing of client flags in the server, and return -EINVAL
instead of -EIO if we successfully read but don't like those flags.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707203049.534-5-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 5e2f961..8db0500 100644
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
 nbd_negotiate_begin(void) "Beginning negotiation"
-- 
1.8.3.1
