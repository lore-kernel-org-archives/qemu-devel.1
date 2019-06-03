Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C903C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147C225AD5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147C225AD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoX6-00020M-5p
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:05:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUY-0000O7-KS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUX-0006xq-6K
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoUU-0006k5-2Y; Mon, 03 Jun 2019 11:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 273D5C051684;
	Mon,  3 Jun 2019 15:03:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6587D61B6A;
	Mon,  3 Jun 2019 15:03:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:09 +0200
Message-Id: <20190603150233.6614-5-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 03 Jun 2019 15:03:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/28] tests/perf: Test lseek influence on qcow2
 block-status
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Block layer may recursively check block_status in file child of qcow2,
if qcow2 driver returned DATA. There are several test cases to check
influence of lseek on block_status performance. To see real difference
run on tmpfs.

Tests originally created by Kevin, I just refactored and put them
together into one executable file with simple output.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/perf/block/qcow2/convert-blockstatus | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 tests/perf/block/qcow2/convert-blockstatus

diff --git a/tests/perf/block/qcow2/convert-blockstatus b/tests/perf/bloc=
k/qcow2/convert-blockstatus
new file mode 100755
index 0000000000..a1a3c1ef43
--- /dev/null
+++ b/tests/perf/block/qcow2/convert-blockstatus
@@ -0,0 +1,71 @@
+#!/bin/bash
+#
+# Test lseek influence on qcow2 block-status
+#
+# Block layer may recursively check block_status in file child of qcow2,=
 if
+# qcow2 driver returned DATA. There are several test cases to check infl=
uence
+# of lseek on block_status performance. To see real difference run on tm=
pfs.
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
+ROOT_DIR=3D"$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../.." >/dev/n=
ull 2>&1 && pwd )"
+QEMU_IMG=3D"$ROOT_DIR/qemu-img"
+QEMU_IO=3D"$ROOT_DIR/qemu-io"
+
+size=3D1G
+src=3D"$1"
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
+$QEMU_IMG create -f qcow2 -o preallocation=3Dmetadata "$src" $size > /de=
v/null
+
+echo -n "prealloc: "
+/usr/bin/time -f %e $QEMU_IMG convert -n "$src" null-co://
--=20
2.20.1


