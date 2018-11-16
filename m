Received: from eggs.gnu.org ([2001:4830:134:3::10]:54458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRk-0002fP-2b
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRj-0000n5-2P
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:15 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 16 Nov 2018 15:53:23 +0000
Message-Id: <20181116155325.22428-5-berrange@redhat.com>
In-Reply-To: <20181116155325.22428-1-berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] tests: check if qemu-nbd is still alive
 before waiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

If the qemu-nbd UNIX socket has not shown up, the tests will sleep a bit
and then check again repeatedly for upto 30 seconds. This is pointless
if the qemu-nbd process has quit due to an error, so check whether the
pid is still alive before waiting and retrying.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/common.nbd | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index f920a578f1..61e9e90fee 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -37,11 +37,19 @@ function nbd_server_stop()
=20
 function nbd_server_wait_for_unix_socket()
 {
+    pid=3D$1
+
     for ((i =3D 0; i < 300; i++))
     do
         if [ -r "$nbd_unix_socket" ]; then
             return
         fi
+        kill -s 0 $pid 2>/dev/null
+        if test $? !=3D 0
+        then
+            echo "qemu-nbd unexpectedly quit"
+            exit 1
+        fi
         sleep 0.1
     done
     echo "Failed in check of unix socket created by qemu-nbd"
@@ -52,5 +60,5 @@ function nbd_server_start_unix_socket()
 {
     nbd_server_stop
     $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &
-    nbd_server_wait_for_unix_socket
+    nbd_server_wait_for_unix_socket $!
 }
--=20
2.19.1
