Received: from eggs.gnu.org ([2001:4830:134:3::10]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1djpMi-00088T-HU
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1djpMh-0001aW-Jv
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:15:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 21 Aug 2017 17:15:39 +0100
Message-Id: <20170821161539.11066-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd-client: fix hang after server closes
 connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Commit 72b6ffc76653214b69a94a7b1643ff80df134486 ("nbd-client: Fix
regression when server sends garbage") improved NBD client behavior when
the connection enters a broken state.

The following still does not behave as expected:

  $ qemu-nbd -p 1234 -x drive0 -f qcow2 test.qcow2
  $ qemu-system-x86_64 -M accel=kvm -m 1G \
        -drive if=virtio,id=drive0,file=nbd://localhost:1234/drive0,format=raw
  $ pkill qemu-nbd
  (qemu) quit
  ...hang...

QEMU should be able to quit even when the connection was previously
closed by the NBD server.  Currently the nbd_read_reply_entry()
coroutine terminates without letting in-flight requests know that the
connection is dead.

This patch flags the connection as dead so in-flight requests can
complete.

Reported-by: Longxiang Lyu <lolyu@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nbd-client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 422ecb4307..5a5fe02015 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -80,6 +80,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
             error_report_err(local_err);
         }
         if (ret <= 0) {
+            s->quit = true;
             break;
         }
 
@@ -107,9 +108,6 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         qemu_coroutine_yield();
     }
 
-    if (ret < 0) {
-        s->quit = true;
-    }
     nbd_recv_coroutines_enter_all(s);
     s->read_reply_co = NULL;
 }
-- 
2.13.5
