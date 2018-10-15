Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eH-0008Js-T6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3eF-0007ND-V4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:15:09 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 16:14:45 +0200
Message-Id: <20181015141453.32632-2-mreitz@redhat.com>
In-Reply-To: <20181015141453.32632-1-mreitz@redhat.com>
References: <20181015141453.32632-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

When closing a connection, make the nbd-fault-injector flush the socket.
Without this, the output is a bit unreliable with Python 3.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/083.out               | 9 +++++++++
 tests/qemu-iotests/nbd-fault-injector.py | 1 +
 2 files changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index be6079d27e..f9af8bb691 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -41,6 +41,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect after neg2 ===
 
+Unable to read from socket: Connection reset by peer
 Connection closed
 read failed: Input/output error
 
@@ -54,6 +55,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect before request ===
 
+Unable to read from socket: Connection reset by peer
 Connection closed
 read failed: Input/output error
 
@@ -116,6 +118,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect after neg-classic ===
 
+Unable to read from socket: Connection reset by peer
 Connection closed
 read failed: Input/output error
 
@@ -161,6 +164,8 @@ can't open device nbd+unix:///foo?socket=TEST_DIR/nbd.sock
 
 === Check disconnect after neg2 ===
 
+Unable to read from socket: Connection reset by peer
+Connection closed
 read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
@@ -173,6 +178,8 @@ can't open device nbd+unix:///foo?socket=TEST_DIR/nbd.sock
 
 === Check disconnect before request ===
 
+Unable to read from socket: Connection reset by peer
+Connection closed
 read failed: Input/output error
 
 === Check disconnect after request ===
@@ -234,6 +241,8 @@ can't open device nbd+unix:///?socket=TEST_DIR/nbd.sock
 
 === Check disconnect after neg-classic ===
 
+Unable to read from socket: Connection reset by peer
+Connection closed
 read failed: Input/output error
 
 *** done
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index f9193c0fae..439a090eb6 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -112,6 +112,7 @@ class FaultInjectionSocket(object):
             if rule.match(event, io):
                 if rule.when == 0 or bufsize is None:
                     print('Closing connection on rule match %s' % rule.name)
+                    self.sock.flush()
                     sys.exit(0)
                 if rule.when != -1:
                     return rule.when
-- 
2.17.1
