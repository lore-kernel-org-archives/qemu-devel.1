Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE77C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6545020675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="R6/k563e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6kc-0007ka-PB
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:55:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6hA-000508-Jb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h8-0007tQ-UC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:48 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hL6h8-0007jD-Bb; Mon, 29 Apr 2019 09:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=7bDwzqplm35txYiR9F4Jb3HPhZMSDEOZXnh2npFaYTo=; 
	b=R6/k563e/AglwTZh8sKWN70/SVDqmQB0dtKuR+EravO2aE3MboYcwypvLcaG9xHMUWmkAhZgjBGryWUki41bXpmRoeN0W1rSL7KJALEXfWrr7tekyi5trhITW7Rn3PjVMY9jlkbYd/o+CBgD7JrD3sUJTvVdHfncDW8R3iE06j9cRm27P6lA4iJmIyKysEXJR5zbR9b1+qShLZpb7Tf/soKTDDjKhlU/zC83AJdEOZDfB4Fgikzs5nu6W5cBWq+NP3akvfADa3tHeyz66dO5N2tm5WfA6EDRduoxuDn3J89XMg2gEpZ9e3Bn4tRFZ9QvZkqg52wBiCWaMqpo3gJIWQ==;
Received: from [212.145.226.66] (helo=perseus.local)
	by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hL6gp-0006BK-ST; Mon, 29 Apr 2019 15:51:27 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hL6gd-0007Kl-Do; Mon, 29 Apr 2019 16:51:15 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 15:51:09 +0200
Message-Id:
 <6b914458dc9a8b37fe83afa816b085b84777653a.1556540297.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
References: <cover.1556540297.git.berto@igalia.com>
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
References: <cover.1556540297.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v3 2/2] iotests: Check that images are in
 read-only mode after block-commit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429135109.iGAQ39Y9jItFY6zDRczMJiZBhv_U9FRHotTbAo804Kg@z>

This tests the fix from the previous patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  35 ++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 151 insertions(+)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
new file mode 100755
index 0000000000..e4650ecf6b
--- /dev/null
+++ b/tests/qemu-iotests/249
@@ -0,0 +1,115 @@
+#!/usr/bin/env bash
+#
+# Test that a backing image is put back in read-only mode after
+# block-commit (both when it fails and when it succeeds).
+#
+# Copyright (C) 2019 Igalia, S.L.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=berto@igalia.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG.base"
+    rm -f "$TEST_IMG.int"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+# Any format implementing BlockDriver.bdrv_change_backing_file
+_supported_fmt qcow2 qed
+_supported_proto file
+_supported_os Linux
+
+IMG_SIZE=1M
+
+# Create the images: base <- int <- active
+TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+
+# Launch QEMU with these two drives:
+# none0: base (read-only)
+# none1: base <- int <- active
+_launch_qemu -drive if=none,file="${TEST_IMG}.base",node-name=base,read-only=on \
+             -drive if=none,file="${TEST_IMG}",backing.node-name=int,backing.backing=base
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+echo
+echo '=== Send a write command to a drive opened in read-only mode (1)'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
+    'return'
+
+echo
+echo '=== Run block-commit on base using an invalid filter node name'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit',
+       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'int',
+                     'filter-node-name': '1234'}}" \
+    'error'
+
+echo
+echo '=== Send a write command to a drive opened in read-only mode (2)'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
+    'return'
+
+echo
+echo '=== Run block-commit on base using the default filter node name'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit',
+       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'int'}}" \
+    'return'
+
+# Wait for block-commit to finish
+_send_qemu_cmd $QEMU_HANDLE '' \
+    '"status": "null"'
+
+echo
+echo '=== Send a write command to a drive opened in read-only mode (3)'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
+    'return'
+
+_cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
new file mode 100644
index 0000000000..1c93164e84
--- /dev/null
+++ b/tests/qemu-iotests/249.out
@@ -0,0 +1,35 @@
+QA output created by 249
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
+{"return": {}}
+
+=== Send a write command to a drive opened in read-only mode (1)
+
+{"return": "Block node is read-onlyrn"}
+
+=== Run block-commit on base using an invalid filter node name
+
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"error": {"class": "GenericError", "desc": "Invalid node name"}}
+
+=== Send a write command to a drive opened in read-only mode (2)
+
+{"return": "Block node is read-onlyrn"}
+
+=== Run block-commit on base using the default filter node name
+
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+
+=== Send a write command to a drive opened in read-only mode (3)
+
+{"return": "Block node is read-onlyrn"}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..7ac9a5ea4a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+249 rw auto quick
-- 
2.11.0


