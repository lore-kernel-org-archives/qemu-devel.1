Received: from eggs.gnu.org ([209.51.188.92]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1EoW-0003IF-W3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1EoW-0007Wo-2R
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:29:16 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  5 Mar 2019 12:29:08 -0600
Message-Id: <20190305182908.13557-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] iotests: Wait for qemu to end in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berto@igalia.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

When iotest 223 was first written, it didn't matter if we waited for
the qemu process to clean up. But with the introduction of a later
qemu-nbd process trying to reuse the same file, there is a race where
even though the asynchronous qemu process has responded to "quit", it
has not yet had time to unlock the file and exit, resulting in:

-[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false=
},
-{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true},
-{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
+qemu-nbd: Failed to blk_new_open 'tests/qemu-iotests/scratch/t.qcow2': F=
ailed to get shared "write" lock
+Is another process using the image [tests/qemu-iotests/scratch/t.qcow2]?
+qemu-img: Could not open 'driver=3Dnbd,server.type=3Dunix,server.path=3D=
tests/qemu-iotests/scratch/qemu-nbd.sock,x-dirty-bitmap=3Dqemu:dirty-bitm=
ap:b': Failed to connect socket tests/qemu-iotests/scratch/qemu-nbd.sock:=
 Connection refused
+./common.nbd: line 33: kill: (11122) - No such process

Fixes: ddd09448
Reported-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/223     | 1 +
 tests/qemu-iotests/223.out | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index f120a016460..c0a4f9c14b7 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -179,6 +179,7 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-r=
emove",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "error" # Ag=
ain
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
+wait=3Dyes _cleanup_qemu

 echo
 echo "=3D=3D=3D Use qemu-nbd as server =3D=3D=3D"
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 6476b77ba20..95c40a17ad7 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -89,6 +89,7 @@ read 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}

 =3D=3D=3D Use qemu-nbd as server =3D=3D=3D

--=20
2.20.1
