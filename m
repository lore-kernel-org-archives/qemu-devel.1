Received: from eggs.gnu.org ([209.51.188.92]:55582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gozf8-00019f-L2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gozf7-00069d-OZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:52:58 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 00:52:51 +0100
Message-Id: <20190130235251.17911-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] iotests: Filter second BLOCK_JOB_ERROR from 229
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Without this filter, this test sometimes fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I intended to send this as part of my iotest fixes series, but it ended
up on the wrong branch...  Doesn't really matter, though, as there is no
functional dependency.
---
 tests/qemu-iotests/229     | 6 +++++-
 tests/qemu-iotests/229.out | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 893d098ad2..b0d4885fa6 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -81,11 +81,15 @@ echo
 echo '=3D=3D=3D Force cancel job paused in error state  =3D=3D=3D'
 echo
=20
+# Filter out BLOCK_JOB_ERROR events because they may or may not occur.
+# Cancelling the job means resuming it for a bit before it is actually
+# aborted, and in that time it may or may not re-encounter the error.
 success_or_failure=3D"y" _send_qemu_cmd $QEMU_HANDLE \
     "{'execute': 'block-job-cancel',
                  'arguments': { 'device': 'testdisk',
                                 'force': true}}" \
-     "BLOCK_JOB_CANCELLED" "Assertion"
+     "BLOCK_JOB_CANCELLED" "Assertion" \
+    | grep -v '"BLOCK_JOB_ERROR"'
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
index 4c4112805f..a3eb33788a 100644
--- a/tests/qemu-iotests/229.out
+++ b/tests/qemu-iotests/229.out
@@ -17,7 +17,6 @@ wrote 2097152/2097152 bytes at offset 0
=20
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "write=
", "action": "stop"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}=
}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152,=
 "offset": 1048576, "speed": 0, "type": "mirror"}}
 *** done
--=20
2.20.1
