Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C35EC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 18:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EC8214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 18:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EC8214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwA1X-00078W-Er
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 14:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52465)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hwA0c-0006by-MN
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hwA0b-0001VH-AQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 14:53:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hwA0W-0001Nt-Tj; Fri, 09 Aug 2019 14:52:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F1928E914;
 Fri,  9 Aug 2019 18:52:56 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 801CA10013A1;
 Fri,  9 Aug 2019 18:52:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 20:52:53 +0200
Message-Id: <20190809185253.17535-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 09 Aug 2019 18:52:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] iotests: Fix 141 when run with qed
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

69f47505ee has changed qcow2 in such a way that the commit job run in
test 141 (and 144[1]) returns before it emits the READY event.  However,
141 also runs with qed, where the order is still the other way around.
Just filter out the {"return": {}} so the test passes for qed again.

[1] 144 only runs with qcow2, so it is fine as it is.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Fixes: 69f47505ee66afaa513305de0c1895a224e52c45
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/141           | 9 +++++++--
 tests/qemu-iotests/141.out       | 5 -----
 tests/qemu-iotests/common.filter | 5 +++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 2197a82d45..8c2ae79f2b 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -58,16 +58,21 @@ test_blockjob()
               }}}" \
         'return'
=20
+    # If "$2" is an event, we may or may not see it before the
+    # {"return": {}}.  Therefore, filter the {"return": {}} out both
+    # here and in the next command.  (Naturally, if we do not see it
+    # here, we will see it before the next command can be executed,
+    # so it will appear in the next _send_qemu_cmd's output.)
     _send_qemu_cmd $QEMU_HANDLE \
         "$1" \
         "$2" \
-        | _filter_img_create
+        | _filter_img_create | _filter_qmp_empty_return
=20
     # We want this to return an error because the block job is still run=
ning
     _send_qemu_cmd $QEMU_HANDLE \
         "{'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}" \
-        'error' | _filter_generated_node_ids
+        'error' | _filter_generated_node_ids | _filter_qmp_empty_return
=20
     _send_qemu_cmd $QEMU_HANDLE \
         "{'execute': 'block-job-cancel',
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 4d71d9dcae..dbd3bdef6c 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -10,7 +10,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/m.
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
@@ -27,7 +26,6 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "mirror"}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block =
device is in use by block job: mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
@@ -42,7 +40,6 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "commit"}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block =
device is in use by block job: commit"}}
@@ -61,7 +58,6 @@ wrote 1048576/1048576 bytes at offset 0
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
@@ -77,7 +73,6 @@ wrote 1048576/1048576 bytes at offset 0
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 35fddc746f..8e9235d6fe 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -219,5 +219,10 @@ _filter_nbd()
         -e 's#\(foo\|PORT/\?\|.sock\): Failed to .*$#\1#'
 }
=20
+_filter_qmp_empty_return()
+{
+    grep -v '{"return": {}}'
+}
+
 # make sure this script returns success
 true
--=20
2.21.0


