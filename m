Received: from eggs.gnu.org ([2001:4830:134:3::10]:59802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQn-0003wU-7B
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQl-0005n3-WC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:25 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQl-0005mu-PL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:23 -0400
Received: by mail-wm0-x229.google.com with SMTP id n195so30614258wmg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:42 +0200
Message-Id: <1496320911-51305-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/33] nbd: Fully initialize client in case of
 failed negotiation
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

If a non-NBD client connects to qemu-nbd, we would end up with
a SIGSEGV in nbd_cilent_put() because we were trying to
unregister the client's association to the export, even though
we skipped inserting the client into that list.  Easy trigger
in two terminals:

$ qemu-nbd -p 30001 --format=raw file
$ nmap 127.0.0.1 -p 30001

nmap claims that it thinks it connected to a pago-services1
server (which probably means nmap could be updated to learn the
NBD protocol and give a more accurate diagnosis of the open
port - but that's not our problem), then terminates immediately,
so our call to nbd_negotiate() fails.  The fix is to reorder
nbd_co_client_start() to ensure that all initialization occurs
before we ever try talking to a client in nbd_negotiate(), so
that the teardown sequence on negotiation failure doesn't fault
while dereferencing a half-initialized object.

While debugging this, I also noticed that nbd_update_server_watch()
called by nbd_client_closed() was still adding a channel to accept
the next client, even when the state was no longer RUNNING.  That
is fixed by making nbd_can_accept() pay attention to the current
state.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1451614

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170527030421.28366-1-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/server.c | 8 +++-----
 qemu-nbd.c   | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index ee59e5d..49b55f6 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1358,16 +1358,14 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 
     if (exp) {
         nbd_export_get(exp);
+        QTAILQ_INSERT_TAIL(&exp->clients, client, next);
     }
+    qemu_co_mutex_init(&client->send_lock);
+
     if (nbd_negotiate(data)) {
         client_close(client);
         goto out;
     }
-    qemu_co_mutex_init(&client->send_lock);
-
-    if (exp) {
-        QTAILQ_INSERT_TAIL(&exp->clients, client, next);
-    }
 
     nbd_client_receive_next_request(client);
 
diff --git a/qemu-nbd.c b/qemu-nbd.c
index f60842f..651f85e 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -325,7 +325,7 @@ out:
 
 static int nbd_can_accept(void)
 {
-    return nb_fds < shared;
+    return state == RUNNING && nb_fds < shared;
 }
 
 static void nbd_export_closed(NBDExport *exp)
-- 
1.8.3.1
