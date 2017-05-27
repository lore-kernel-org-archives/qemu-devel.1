Received: from eggs.gnu.org ([2001:4830:134:3::10]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dES1q-0006v4-4g
	for qemu-devel@nongnu.org; Fri, 26 May 2017 23:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dES1p-0001a2-6k
	for qemu-devel@nongnu.org; Fri, 26 May 2017 23:04:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 May 2017 22:04:21 -0500
Message-Id: <20170527030421.28366-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd: Fully initialize client in case of failed
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
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

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
---

I'm planning to run a bisect to see which patch actually introduced
the problem, but wanted to post the patch first to get review started.

 nbd/server.c | 14 ++++++--------
 qemu-nbd.c   |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 0c4f456..d8dfac8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1601,16 +1601,14 @@ static coroutine_fn void nbd_co_client_start(void *opaque)

     if (exp) {
         nbd_export_get(exp);
-    }
-    if (nbd_negotiate(data)) {
-        client_close(client);
-        goto out;
-    }
-    qemu_co_mutex_init(&client->send_lock);
-
-    if (exp) {
         QTAILQ_INSERT_TAIL(&exp->clients, client, next);
     }
+    qemu_co_mutex_init(&client->send_lock);
+
+    if (nbd_negotiate(data)) {
+        client_close(client);
+        goto out;
+    }

     nbd_client_receive_next_request(client);

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 27a4e3a..5410854 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -322,7 +322,7 @@ out:

 static int nbd_can_accept(void)
 {
-    return nb_fds < shared;
+    return state == RUNNING && nb_fds < shared;
 }

 static void nbd_export_closed(NBDExport *exp)
-- 
2.9.4
