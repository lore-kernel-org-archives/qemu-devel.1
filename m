Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0AC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AAA2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AAA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PTR-0004j3-GR
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQb-0002bg-1O
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQZ-0001Im-E2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQV-0001GR-Jj; Thu, 12 Sep 2019 09:46:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6FD9308A9E2;
 Thu, 12 Sep 2019 13:46:22 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC1AB600C8;
 Thu, 12 Sep 2019 13:46:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:46 +0200
Message-Id: <20190912134604.22019-5-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 12 Sep 2019 13:46:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/22] iotests: Test reverse sub-cluster qcow2
 writes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

This exercises the regression introduced in commit
50ba5b2d994853b38fed10e0841b119da0f8b8e5.  On my machine, it has close
to a 50 % false-negative rate, but that should still be sufficient to
test the fix.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/265     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/265.out |  6 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tests/qemu-iotests/265
 create mode 100644 tests/qemu-iotests/265.out

diff --git a/tests/qemu-iotests/265 b/tests/qemu-iotests/265
new file mode 100755
index 0000000000..dce6f77be3
--- /dev/null
+++ b/tests/qemu-iotests/265
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+#
+# Test reverse-ordered qcow2 writes on a sub-cluster level
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# qcow2-specific test
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo '--- Writing to the image ---'
+
+# Reduce cluster size so we get more and quicker I/O
+IMGOPTS=3D'cluster_size=3D4096' _make_test_img 1M
+(for ((kb =3D 1024 - 4; kb >=3D 0; kb -=3D 4)); do \
+     echo "aio_write -P 42 $((kb + 1))k 2k"; \
+ done) \
+ | $QEMU_IO "$TEST_IMG" > /dev/null
+
+echo '--- Verifying its content ---'
+
+(for ((kb =3D 0; kb < 1024; kb +=3D 4)); do \
+    echo "read -P 0 ${kb}k 1k"; \
+    echo "read -P 42 $((kb + 1))k 2k"; \
+    echo "read -P 0 $((kb + 3))k 1k"; \
+ done) \
+ | $QEMU_IO "$TEST_IMG" | _filter_qemu_io | grep 'verification'
+
+# Status of qemu-io
+if [ ${PIPESTATUS[1]} =3D 0 ]; then
+    echo 'Content verified.'
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/265.out b/tests/qemu-iotests/265.out
new file mode 100644
index 0000000000..6eac620f25
--- /dev/null
+++ b/tests/qemu-iotests/265.out
@@ -0,0 +1,6 @@
+QA output created by 265
+--- Writing to the image ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
+--- Verifying its content ---
+Content verified.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d95d556414..0c129c1644 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -274,3 +274,4 @@
 257 rw
 258 rw quick
 262 rw quick migration
+265 rw auto quick
--=20
2.20.1


