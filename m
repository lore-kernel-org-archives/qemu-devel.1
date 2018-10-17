Received: from eggs.gnu.org ([2001:4830:134:3::10]:51473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB4-0000Kx-Ux
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB2-0001yf-5u
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChB1-00018X-N4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24001D3C14
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:27:01 +0200
Message-Id: <20181017082702.5581-38-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 37/38] raw: Convert a warning to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Convert the warning about dangerous automatic probing of raw images to
warn_report().  Split its text to conform to conventions spelled out
in warn_report()'s contract.

Update expected output of qemu-iotest 109 accordingly.  Update
qemu-iotest 099's output filtering to keep filtering out the warning.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/raw-format.c         | 17 ++++++------
 tests/qemu-iotests/099     |  3 ++-
 tests/qemu-iotests/109.out | 55 +++++++++++++++++++++++---------------
 3 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 6f6dc99b2c..d65fd0ffce 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/option.h"
 
 typedef struct BDRVRawState {
@@ -436,14 +437,14 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
             bs->file->bs->supported_zero_flags);
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
-        fprintf(stderr,
-                "WARNING: Image format was not specified for '%s' and probing "
-                "guessed raw.\n"
-                "         Automatically detecting the format is dangerous for "
-                "raw images, write operations on block 0 will be restricted.\n"
-                "         Specify the 'raw' format explicitly to remove the "
-                "restrictions.\n",
-                bs->file->bs->filename);
+        warn_report("Image format was not specified for '%s' and probing "
+                    "guessed raw",
+                    bs->file->bs->filename);
+        error_printf("Automatically detecting the format is dangerous for "
+                     "raw images, write\n"
+                     "operations on block 0 will be restricted.\n"
+                     "Specify the 'raw' format explicitly to remove the "
+                     "restrictions.\n");
     }
 
     ret = raw_read_options(options, bs, s, errp);
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index caaf58eee5..f2a62448d8 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -57,7 +57,8 @@ function run_qemu()
     # which is how we can extract it)
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_imgfmt | _filter_qmp \
         | _filter_qemu | grep "drv0" \
-        | sed -e 's/^.*"file": "\(\(\\"\|[^"]\)*\)".*$/\1/' -e 's/\\"/"/g'
+        | sed -e 's/^.*"file": "\(\(\\"\|[^"]\)*\)".*$/\1/' -e 's/\\"/"/g' \
+	      -e '/probing guessed raw/d'
 }
 
 function test_qemu()
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index ad0ee6fb48..99add53271 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -5,8 +5,9 @@ QA output created by 109
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -43,8 +44,9 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -81,8 +83,9 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -119,8 +122,9 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -157,8 +161,9 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -195,8 +200,9 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -232,8 +238,9 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -269,8 +276,9 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -306,8 +314,9 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -343,8 +352,9 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
@@ -380,8 +390,9 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
-WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+warning: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw
+Automatically detecting the format is dangerous for raw images, write
+operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
-- 
2.17.1
