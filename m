Received: from eggs.gnu.org ([2001:4830:134:3::10]:48652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCk-0001as-NQ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCh-0005vY-AH
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34974
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCh-0005uM-3J
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBKE017922
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:26 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2ww5p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:26 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:25 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:33 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-59-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 58/79] nbd: Fully initialize client in case of
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
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Eric Blake <eblake@redhat.com>

If a non-NBD client connects to qemu-nbd, we would end up with
a SIGSEGV in nbd_client_put() because we were trying to
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
(cherry picked from commit df8ad9f128c15aa0a0ebc7b24e9a22c9775b67af)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 8 +++-----
 qemu-nbd.c   | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 924a1fe..edfda84 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1376,16 +1376,14 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 
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
index e4f00e2..14e7947 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -324,7 +324,7 @@ out:
 
 static int nbd_can_accept(void)
 {
-    return nb_fds < shared;
+    return state == RUNNING && nb_fds < shared;
 }
 
 static void nbd_export_closed(NBDExport *exp)
-- 
2.7.4
