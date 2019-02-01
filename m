Received: from eggs.gnu.org ([209.51.188.92]:39538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboO-00084C-07
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboK-0000IM-Cw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:13 +0100
Message-Id: <20190201163518.31157-23-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/27] iotests: Filter second BLOCK_JOB_ERROR
 from 229
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Without this filter, this test sometimes fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
