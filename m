Received: from eggs.gnu.org ([2001:4830:134:3::10]:51408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl1-00008x-T2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl1-0002cA-6S
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:47 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:23 -0600
Message-Id: <20181119175427.2298497-9-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/12] tests: check if qemu-nbd is still alive
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

If the qemu-nbd UNIX socket has not shown up, the tests will sleep a bit
and then check again repeatedly for up to 30 seconds. This is pointless
if the qemu-nbd process has quit due to an error, so check whether the
pid is still alive before waiting and retrying.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20181116155325.22428-5-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.nbd | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 27357f3151d..9f841ab4029 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -37,11 +37,19 @@ function nbd_server_stop()

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
     $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
-    nbd_server_wait_for_unix_socket
+    nbd_server_wait_for_unix_socket $!
 }
--=20
2.17.2
