Received: from eggs.gnu.org ([209.51.188.92]:57931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj550-0004JO-OS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54z-0005ft-S3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:27:14 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:59 -0600
Message-Id: <20190114162605.5330-15-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/20] nbd: Forbid nbd-server-stop when server
 is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Since we already forbid other nbd-server commands when not
in the right state, it is unlikely that any caller was relying
on a second stop to behave as a silent no-op.  Update iotest
223 to show the improved behavior.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190111194720.15671-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev-nbd.c             | 5 +++++
 tests/qemu-iotests/223     | 2 +-
 tests/qemu-iotests/223.out | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1d170c80b82..ca584919194 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -214,6 +214,11 @@ void qmp_nbd_server_remove(const char *name,

 void qmp_nbd_server_stop(Error **errp)
 {
+    if (!nbd_server) {
+        error_setg(errp, "NBD server not running");
+        return;
+    }
+
     nbd_export_close_all();

     nbd_server_free(nbd_server);
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 61b46a2f066..a4016091b21 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -172,7 +172,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-r=
emove",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}' "error" # Attempt duplicate clean
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return" # O=
ops
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "error" # Ag=
ain
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"

 # success, all done
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index e6ede0591cd..8a4d63a4fc2 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -69,6 +69,6 @@ read 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
 {"return": {}}
-{"return": {}}
+{"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"return": {}}
 *** done
--=20
2.20.1
