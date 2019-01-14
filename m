Received: from eggs.gnu.org ([209.51.188.92]:57715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54b-0003xe-OY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54a-0005RZ-Rt
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:58 -0600
Message-Id: <20190114162605.5330-14-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/20] nbd: Add some error case testing to
 iotests 223
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

Testing success paths is important, but it's also nice to highlight
expected failure handling, to show that we don't crash, and so that
upcoming tests that change behavior can demonstrate the resulting
effects on error paths.

Add the following errors:
Attempting to export without a running server
Attempting to start a second server
Attempting to export a bad node name
Attempting to export a name that is already exported
Attempting to export an enabled bitmap
Attempting to remove an already removed export
Attempting to quit server a second time

All of these properly complain except for a second server-stop,
which will be fixed next.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190111194720.15671-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/223     | 19 +++++++++++++++++--
 tests/qemu-iotests/223.out |  7 +++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 5513dc62159..61b46a2f066 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -107,6 +107,7 @@ echo

 _launch_qemu 2> >(_filter_nbd)

+# Intentionally provoke some errors as well, to check error handling
 silent=3D
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabilities"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
@@ -114,17 +115,28 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-a=
dd",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
-  "arguments":{"node":"n", "name":"b2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n"}}' "error" # Attempt add without server
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
+  "arguments":{"addr":{"type":"unix",
+    "data":{"path":"'"$TEST_DIR/nbd"1'"}}}}' "error" # Attempt second se=
rver
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"nosuch"}}' "error" # Attempt to export missing =
node
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n"}}' "error" # Attempt to export same name twi=
ce
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
+  "arguments":{"name":"n2", "bitmap":"b2"}}' "error" # Attempt enabled b=
itmap
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
+  "arguments":{"node":"n", "name":"b2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n2", "bitmap":"b2"}}' "return"

@@ -157,7 +169,10 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-=
remove",
   "arguments":{"name":"n"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}' "error" # Attempt duplicate clean
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return" # O=
ops
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"

 # success, all done
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 99ca172fbb8..e6ede0591cd 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -27,10 +27,15 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "NBD server already running"=
}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch=
 nor node_name=3Dnosuch"}}
+{"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'b2' is enabled"}}
 {"return": {}}
 {"return": {}}

@@ -62,6 +67,8 @@ read 2097152/2097152 bytes at offset 2097152

 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
+{"return": {}}
 {"return": {}}
 {"return": {}}
 *** done
--=20
2.20.1
