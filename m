Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Og-0001qX-Bv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Of-0001aM-IT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:03 -0500
Message-Id: <20170830180711.7974-4-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] qemu-iotests: improve
 nbd-fault-injector.py startup protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Currently 083 waits for the nbd-fault-injector.py server to start up by
looping until netstat shows the TCP listen socket.

The startup protocol can be simplified by passing a 0 port number to
nbd-fault-injector.py.  The kernel will allocate a port in bind(2) and
the final port number can be printed by nbd-fault-injector.py.

This should make it slightly nicer and less TCP-specific to wait for
server startup.  This patch changes nbd-fault-injector.py, the next one
will rewrite server startup in 083.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170829122745.14309-3-stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/nbd-fault-injector.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index 6c07191a5a..1c10dcb51c 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -235,11 +235,15 @@ def open_socket(path):
         sock = socket.socket()
         sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
         sock.bind((host, int(port)))
+
+        # If given port was 0 the final port number is now available
+        path = '%s:%d' % sock.getsockname()
     else:
         sock = socket.socket(socket.AF_UNIX)
         sock.bind(path)
     sock.listen(0)
     print 'Listening on %s' % path
+    sys.stdout.flush() # another process may be waiting, show message now
     return sock

 def usage(args):
-- 
2.13.5
