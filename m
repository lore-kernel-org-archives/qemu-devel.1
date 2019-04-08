Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B46C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3797E2147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3797E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDX7W-0001mg-Gi
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:27:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6I-00015h-Pu
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6G-0006Ly-55
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:50300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDX6D-0006EU-4K; Mon, 08 Apr 2019 12:26:23 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hDX69-0001tt-Ii; Mon, 08 Apr 2019 19:26:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 19:26:16 +0300
Message-Id: <20190408162617.258535-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190408162617.258535-1-vsementsov@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 1/2] tests/perf: Test lseek influence on
 qcow2 block-status
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408162616.c5dGU08gpACcv6lK3jhoJCyzhG1kCNXFU0R66UTBXZQ@z>

Block layer may recursively check block_status in file child of qcow2,
if qcow2 driver returned DATA. There are several test cases to check
influence of lseek on block_status performance. To see real difference
run on tmpfs.

Tests originally created by Kevin, I just refactored and put them
together into one executable file with simple output.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/perf/block/qcow2/convert-blockstatus | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 tests/perf/block/qcow2/convert-blockstatus

diff --git a/tests/perf/block/qcow2/convert-blockstatus b/tests/perf/block/qcow2/convert-blockstatus
new file mode 100755
index 0000000000..a1a3c1ef43
--- /dev/null
+++ b/tests/perf/block/qcow2/convert-blockstatus
@@ -0,0 +1,71 @@
+#!/bin/bash
+#
+# Test lseek influence on qcow2 block-status
+#
+# Block layer may recursively check block_status in file child of qcow2, if
+# qcow2 driver returned DATA. There are several test cases to check influence
+# of lseek on block_status performance. To see real difference run on tmpfs.
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
+#
+# Tests originally written by Kevin Wolf
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
+if [ "$#" -lt 1 ]; then
+    echo "Usage: $0 SOURCE_FILE"
+    exit 1
+fi
+
+ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../.." >/dev/null 2>&1 && pwd )"
+QEMU_IMG="$ROOT_DIR/qemu-img"
+QEMU_IO="$ROOT_DIR/qemu-io"
+
+size=1G
+src="$1"
+
+# test-case plain
+
+(
+$QEMU_IMG create -f qcow2 "$src" $size
+for i in $(seq 16384 -1 0); do
+    echo "write $((i * 65536)) 64k"
+done | $QEMU_IO "$src"
+) > /dev/null
+
+echo -n "plain: "
+/usr/bin/time -f %e $QEMU_IMG convert -n "$src" null-co://
+
+# test-case forward
+
+(
+$QEMU_IMG create -f qcow2 "$src" $size
+for i in $(seq 0 2 16384); do
+    echo "write $((i * 65536)) 64k"
+done | $QEMU_IO "$src"
+for i in $(seq 1 2 16384); do
+    echo "write $((i * 65536)) 64k"
+done | $QEMU_IO "$src"
+) > /dev/null
+
+echo -n "forward: "
+/usr/bin/time -f %e $QEMU_IMG convert -n "$src" null-co://
+
+# test-case prealloc
+
+$QEMU_IMG create -f qcow2 -o preallocation=metadata "$src" $size > /dev/null
+
+echo -n "prealloc: "
+/usr/bin/time -f %e $QEMU_IMG convert -n "$src" null-co://
-- 
2.18.0


