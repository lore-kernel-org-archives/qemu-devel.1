Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C04C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34732178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34732178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1NF-0000JY-JR
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT1KN-0006AZ-Rq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT1KJ-0004yV-W5
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:17:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:56102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT1K8-0004uZ-UC; Fri, 08 Nov 2019 05:17:01 -0500
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT1K3-0002Yp-TA; Fri, 08 Nov 2019 13:16:55 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/2] qapi: deprecate implicit filters
Date: Fri,  8 Nov 2019 13:16:55 +0300
Message-Id: <20191108101655.10611-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191108101655.10611-1-vsementsov@virtuozzo.com>
References: <20191108101655.10611-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, libvir-list@redhat.com,
 armbru@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, vsementsov@virtuozzo.com, dinechin@redhat.com,
 den@openvz.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To get rid of implicit filters related workarounds in future let's
deprecate them now.

Deprecation warning breaks some bash iotests output, so fix it here
too: in most of cases just add filter-node-name in test.

In 161 add FIXME and deprecation warning into 161.out.

In 249, the test case is changed, as we don't need to test "default"
filter node name anymore.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-deprecated.texi       |  6 ++++++
 qapi/block-core.json       |  9 ++++++---
 include/block/block_int.h  | 10 +++++++++-
 blockdev.c                 | 10 ++++++++++
 tests/qemu-iotests/094     |  1 +
 tests/qemu-iotests/095     |  6 ++++--
 tests/qemu-iotests/109     |  1 +
 tests/qemu-iotests/127     |  1 +
 tests/qemu-iotests/141     |  5 ++++-
 tests/qemu-iotests/144     |  3 ++-
 tests/qemu-iotests/156     |  1 +
 tests/qemu-iotests/161     |  7 +++++++
 tests/qemu-iotests/161.out |  1 +
 tests/qemu-iotests/185     |  3 +++
 tests/qemu-iotests/191     |  2 ++
 tests/qemu-iotests/229     |  1 +
 tests/qemu-iotests/247     |  8 +++++---
 tests/qemu-iotests/249     |  5 +++--
 tests/qemu-iotests/249.out |  2 +-
 19 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 296bfc93a3..c969faf55a 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -204,6 +204,12 @@ and accurate ``query-qmp-schema'' command.
 Character devices creating sockets in client mode should not specify
 the 'wait' field, which is only applicable to sockets in server mode
 
+@subsection implicit filters in mirror and commit (since 4.2)
+
+Mirror and commit jobs insert filters, which becomes implicit if user
+omitted @option(filter-node-name) parameter. So omitting it is deprecated
+in ``blockdev-mirror'', ``drive-mirror'' and ``block-commit'', set it always.
+
 @section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 93530d3a13..37caed775f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1659,7 +1659,8 @@
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the commit job inserts into the graph
 #                    above @top. If this option is not given, a node name is
-#                    autogenerated. (Since: 2.9)
+#                    autogenerated. Omitting this option is deprecated, it will
+#                    be required in future. (Since: 2.9)
 #
 # @auto-finalize: When false, this job will wait in a PENDING state after it has
 #                 finished its work, waiting for @block-job-finalize before
@@ -1996,7 +1997,8 @@
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the mirror job inserts into the graph
 #                    above @device. If this option is not given, a node name is
-#                    autogenerated. (Since: 4.2)
+#                    autogenerated. Omitting this option is deprecated, it will
+#                    be required in future. (Since: 4.2)
 #
 # @unmap: Whether to try to unmap target sectors where source has
 #         only zero. If true, and target unallocated sectors will read as zero,
@@ -2311,7 +2313,8 @@
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the mirror job inserts into the graph
 #                    above @device. If this option is not given, a node name is
-#                    autogenerated. (Since: 2.9)
+#                    autogenerated. Omitting this option is deprecated, it will
+#                    be required in future. (Since: 2.9)
 #
 # @copy-mode: when to copy data to the destination; defaults to 'background'
 #             (Since: 3.0)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0b37..48ff3af48d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -793,7 +793,15 @@ struct BlockDriverState {
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
     bool force_share; /* if true, always allow all shared permissions */
-    bool implicit;  /* if true, this filter node was automatically inserted */
+
+    /*
+     * @implicit field is deprecated, don't set it to true for new filters.
+     * If true, this filter node was automatically inserted and user don't
+     * know about it and unprepared for any effects of it. So, implicit
+     * filters are workarounded and skipped in many places of the block
+     * layer code.
+     */
+    bool implicit;
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
diff --git a/blockdev.c b/blockdev.c
index 2ca614c77f..8c3a409c94 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3333,6 +3333,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
     int job_flags = JOB_DEFAULT;
 
+    if (!has_filter_node_name) {
+        warn_report("Omitting filter-node-name parameter is deprecated, it "
+                    "will be required in future");
+    }
+
     if (!has_speed) {
         speed = 0;
     }
@@ -3780,6 +3785,11 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 {
     int job_flags = JOB_DEFAULT;
 
+    if (!has_filter_node_name) {
+        warn_report("Omitting filter-node-name parameter is deprecated, it "
+                    "will be required in future");
+    }
+
     if (!has_speed) {
         speed = 0;
     }
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 9343e09492..07017d5821 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -61,6 +61,7 @@ _send_qemu_cmd $QEMU_HANDLE \
 _send_qemu_cmd $QEMU_HANDLE  \
     "{'execute': 'drive-mirror',
       'arguments': {'device': 'src',
+                    'filter-node-name': 'filter0',
                     'target': '$TEST_IMG',
                     'format': 'nbd',
                     'sync':'full',
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 58fe174b5e..3dc206ba9d 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -69,8 +69,10 @@ h=$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" "return"
 
 _send_qemu_cmd $h "{ 'execute': 'block-commit',
-                                 'arguments': { 'device': 'test',
-                                 'top': '"${TEST_IMG}.snp1"' } }" '"status": "null"'
+                     'arguments': { 'device': 'test',
+                                    'filter-node-name': 'filter0',
+                                    'top': '"${TEST_IMG}.snp1"' } }" \
+                  '"status": "null"'
 
 _cleanup_qemu
 
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 9897ceb6cd..aa7da57f8c 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -57,6 +57,7 @@ run_qemu()
 
     _send_qemu_cmd $QEMU_HANDLE \
         "{'execute':'drive-mirror', 'arguments':{
+            'filter-node-name': 'filter0',
             'device': 'src', 'target': '$raw_img', $qmp_format
             'mode': 'existing', 'sync': 'full'}}" \
         "return"
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index b64926ab31..b2ba9c66cb 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -70,6 +70,7 @@ _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'drive-mirror',
        'arguments': {
            'job-id': 'mirror',
+           'filter-node-name': 'filter0',
            'device': 'source',
            'target': '$TEST_IMG.overlay1',
            'mode':   'existing',
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 8c2ae79f2b..178cee460d 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -123,6 +123,7 @@ echo
 test_blockjob \
     "{'execute': 'drive-mirror',
       'arguments': {'job-id': 'job0',
+                    'filter-node-name': 'filter0',
                     'device': 'drv0',
                     'target': '$TEST_DIR/o.$IMGFMT',
                     'format': '$IMGFMT',
@@ -140,7 +141,8 @@ echo
 
 test_blockjob \
     "{'execute': 'block-commit',
-      'arguments': {'job-id': 'job0', 'device': 'drv0'}}" \
+      'arguments': {'job-id': 'job0', 'filter-node-name': 'filter0',
+                    'device': 'drv0'}}" \
     'BLOCK_JOB_READY' \
     '"status": "null"'
 
@@ -157,6 +159,7 @@ $QEMU_IO -c 'write 0 1M' "$TEST_DIR/m.$IMGFMT" | _filter_qemu_io
 test_blockjob \
     "{'execute': 'block-commit',
       'arguments': {'job-id': 'job0',
+                    'filter-node-name': 'filter0',
                     'device': 'drv0',
                     'top':    '$TEST_DIR/m.$IMGFMT',
                     'speed':  1}}" \
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 011ed4f2bc..de60b0ccba 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -83,7 +83,8 @@ echo
 # Block commit on active layer, push the new overlay into base
 _send_qemu_cmd $h "{ 'execute': 'block-commit',
                                 'arguments': {
-                                                 'device': 'virtio0'
+                                                 'device': 'virtio0',
+                                                 'filter-node-name': 'filter0'
                                               }
                     }" "READY"
 
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 2ffa3ca942..2dc50444db 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -87,6 +87,7 @@ TEST_IMG="$TEST_IMG.target.overlay" _make_test_img -u -b "$TEST_IMG.target" 1M
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'drive-mirror',
        'arguments': { 'device': 'source',
+                      'filter-node-name': 'filter0',
                       'target': '$TEST_IMG.target.overlay',
                       'mode': 'existing',
                       'sync': 'top' } }" \
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index 456a4bd8c4..9cf3e96c74 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -120,6 +120,13 @@ _send_qemu_cmd $QEMU_HANDLE \
                       'top': '${TEST_IMG}.int' } }" \
     'return'
 
+# FIXME
+# Need to use filter-node-name in previous command, as it's omitting is
+# deprecated, as described by warning in test output. But if just put
+# filter-node-name into previous command the following reopen is failed with
+# messasge "Cannot change the option 'backing.detect-zeroes". It's a bug and
+# shoud be fixed.
+
 # Wait for block-commit to finish
 sleep 0.5
 
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index 39951993ee..497f98f3c3 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -27,6 +27,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
 Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
 {"return": {}}
+warning: Omitting filter-node-name parameter is deprecated, it will be required in future
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 454ff600cc..65ef64f0c0 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -107,6 +107,7 @@ echo
 _send_qemu_cmd $h \
     "{ 'execute': 'block-commit',
        'arguments': { 'device': 'disk',
+                      'filter-node-name': 'filter0',
                       'base':'$TEST_IMG.base',
                       'top': '$TEST_IMG.mid',
                       'speed': 65536 } }" \
@@ -132,6 +133,7 @@ _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 _send_qemu_cmd $h \
     "{ 'execute': 'block-commit',
        'arguments': { 'device': 'disk',
+                      'filter-node-name': 'filter0',
                       'base':'$TEST_IMG.base',
                       'speed': 65536 } }" \
     "return"
@@ -154,6 +156,7 @@ _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
 _send_qemu_cmd $h \
     "{ 'execute': 'drive-mirror',
        'arguments': { 'device': 'disk',
+                      'filter-node-name': 'filter0',
                       'target': '$TEST_IMG.copy',
                       'format': '$IMGFMT',
                       'sync': 'full',
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 528022e8d8..79d572f6d5 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -76,6 +76,7 @@ echo
 _send_qemu_cmd $h \
     "{ 'execute': 'block-commit',
        'arguments': { 'job-id': 'commit0',
+                      'filter-node-name': 'filter0',
                       'device': 'top',
                       'base':'$TEST_IMG.base',
                       'top': '$TEST_IMG.mid' } }" \
@@ -124,6 +125,7 @@ echo
 _send_qemu_cmd $h \
     "{ 'execute': 'block-commit',
        'arguments': { 'job-id': 'commit0',
+                      'filter-node-name': 'filter0',
                       'device': 'top',
                       'base':'$TEST_IMG.base',
                       'top': '$TEST_IMG.mid' } }" \
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index e18a464fe0..08a7887e90 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -69,6 +69,7 @@ echo
 _send_qemu_cmd $QEMU_HANDLE \
     "{'execute': 'drive-mirror',
                  'arguments': {'device': 'testdisk',
+                               'filter-node-name': 'filter0',
                                'format': '$IMGFMT',
                                'target': '$DEST_IMG',
                                'sync':   'full',
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index c853b73819..394f4e221c 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -53,9 +53,11 @@ TEST_IMG="$TEST_IMG.3" _make_test_img $size
 TEST_IMG="$TEST_IMG.4" _make_test_img $size
 
 (cat <<EOF
-{"execute":"qmp_capabilities"}
-{"execute":"block-commit",
- "arguments":{"device":"format-4", "top-node": "format-2", "base-node":"format-0", "job-id":"job0"}}
+{"execute": "qmp_capabilities"}
+{"execute": "block-commit",
+ "arguments": {"device": "format-4", "filter-node-name": "filter0",
+               "top-node": "format-2", "base-node":"format-0",
+               "job-id":"job0"}}
 EOF
 if [ "${VALGRIND_QEMU}" == "y" ]; then
     sleep 10
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index e4650ecf6b..be84b9f961 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -88,11 +88,12 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 echo
-echo '=== Run block-commit on base using the default filter node name'
+echo '=== Run block-commit on base using the valid filter node name'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'block-commit',
-       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'int'}}" \
+       'arguments': {'job-id': 'job0', 'filter-node-name': 'filter0',
+                     'device': 'none1', 'top-node': 'int'}}" \
     'return'
 
 # Wait for block-commit to finish
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 1c93164e84..89092b75d7 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -18,7 +18,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 {"return": "Block node is read-onlyrn"}
 
-=== Run block-commit on base using the default filter node name
+=== Run block-commit on base using the valid filter node name
 
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-- 
2.21.0


