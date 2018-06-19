Received: from eggs.gnu.org ([2001:4830:134:3::10]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9IL-0005SR-TM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9IK-0003nz-JB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9IK-0003nj-EM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:35:08 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Jun 2018 13:34:23 +0800
Message-Id: <20180619053426.13065-5-peterx@redhat.com>
In-Reply-To: <20180619053426.13065-1-peterx@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/7] tests: iotests: drop some stderr line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

In my Out-Of-Band test, "check -qcow2 060" fail with this (the output is
manually changed due to line width requirement):

060 5s ... - output mismatch (see 060.out.bad)
--- /home/peterx/git/qemu/tests/qemu-iotests/060.out
+++ /home/peterx/git/qemu/bin/tests/qemu-iotests/060.out.bad
@@ -427,8 +427,8 @@
 QMP_VERSION
 {"return": {}}
 qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1
  index: 0); further non-fatal corruption events will be suppressed
-{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
- "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2
- table offset 0x2a2a2a0
0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
 read failed: Input/output error
+{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
+ "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2
+ table offset 0x2a2a2a0
0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
 {"return": ""}
 {"return": {}}
 {"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
  "event": "SHUTDOWN", "data": {"guest": false}}

The order of the event and the in/out error line is swapped.  I didn't
dig up the reason, but AFAIU what we want to verify is the event rather
than stderr.  Let's drop the stderr line directly for this test.

Signed-off-by: Peter Xu <peterx@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qemu-iotests/060     | 10 +++++++++-
 tests/qemu-iotests/060.out |  1 -
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 7bdf609f3f..74ad371885 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -33,6 +33,14 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+# Sometimes the error line might be dumped before/after an event
+# randomly.  Mask it out for specific test that may trigger this
+# uncertainty for current test for now.
+_filter_io_error()
+{
+    sed '/Input\/output error/d'
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -464,7 +472,7 @@ echo "{'execute': 'qmp_capabilities'}
                         }}" \
             -incoming exec:'cat /dev/null' \
             2>&1 \
-    | _filter_qmp | _filter_qemu_io
+    | _filter_qmp | _filter_qemu_io | _filter_io_error
 
 echo
 # Image should not have been marked corrupt
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index bff023d889..d67c6234a4 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -428,7 +428,6 @@ QMP_VERSION
 {"return": {}}
 qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further non-fatal corruption events will be suppressed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
-read failed: Input/output error
 {"return": ""}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-- 
2.17.1
