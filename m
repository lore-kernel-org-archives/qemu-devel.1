Received: from eggs.gnu.org ([2001:4830:134:3::10]:55933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiz-0008Tm-Og
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiw-0007YH-Vq
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZIiw-0007XD-Pw
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64D754022414
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 16:27:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 30 Jun 2018 18:27:43 +0200
Message-Id: <20180630162744.15920-5-armbru@redhat.com>
In-Reply-To: <20180630162744.15920-1-armbru@redhat.com>
References: <20180630162744.15920-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] tests: iotests: drop some stderr line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

In my Out-Of-Band test, "check -qcow2 060" fail with this:

  --- /home/peterx/git/qemu/tests/qemu-iotests/060.out
  +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/060.out.bad
  @@ -427,8 +427,8 @@
  QMP_VERSION
  {"return": {}}
  qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1
  index: 0); further non-fatal corruption events will be suppressed
  -{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a0
  0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
  read failed: Input/output error
  +{"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a0
  0 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
  {"return": ""}
  {"return": {}}
  {"timestamp": {"seconds": TIMESTAMP, "microseconds": TIMESTAMP},
  "event": "SHUTDOWN", "data": {"guest": false}}

The order of the event and the in/out error line is swapped.  I didn't
dig up the reason, but AFAIU what we want to verify is the event rather
than stderr.  Let's drop the stderr line directly for this test.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180620073223.31964-5-peterx@redhat.com>
[Commit message touched up]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
