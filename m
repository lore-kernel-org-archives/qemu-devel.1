Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A99C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E969320850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E969320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzUC-0003OM-LE
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlzT7-0007N9-6j
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlzT4-0004f9-Kq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlzT1-0004YO-Ru; Fri, 12 Jul 2019 13:36:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 304BC3098458;
 Fri, 12 Jul 2019 17:36:19 +0000 (UTC)
Received: from localhost (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE86860142;
 Fri, 12 Jul 2019 17:36:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 19:36:00 +0200
Message-Id: <20190712173600.14554-8-mreitz@redhat.com>
In-Reply-To: <20190712173600.14554-1-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 12 Jul 2019 17:36:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 7/7] iotests: Add test for image creation
 fallback
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/259     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 14 +++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

diff --git a/tests/qemu-iotests/259 b/tests/qemu-iotests/259
new file mode 100755
index 0000000000..22b4c10241
--- /dev/null
+++ b/tests/qemu-iotests/259
@@ -0,0 +1,61 @@
+#!/usr/bin/env bash
+#
+# Test generic image creation fallback (by using NBD)
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
+# creator
+owner=3Dmreitz@redhat.com
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
+_supported_fmt raw
+_supported_proto nbd
+_supported_os Linux
+
+
+_make_test_img 64M
+
+echo
+echo '--- Testing creation ---'
+
+$QEMU_IMG create -f qcow2 "$TEST_IMG" 64M | _filter_img_create
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info
+
+echo
+echo '--- Testing creation for which the node would need to grow ---'
+
+$QEMU_IMG create -f qcow2 -o preallocation=3Dmetadata "$TEST_IMG" 64M 2>=
&1 \
+    | _filter_img_create
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
new file mode 100644
index 0000000000..ffed19c2a0
--- /dev/null
+++ b/tests/qemu-iotests/259.out
@@ -0,0 +1,14 @@
+QA output created by 259
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+
+--- Testing creation ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3Dqcow2 size=3D67108864
+image: TEST_DIR/t.IMGFMT
+file format: qcow2
+virtual size: 64 MiB (67108864 bytes)
+disk size: unavailable
+
+--- Testing creation for which the node would need to grow ---
+qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver=
 does not support resize
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3Dqcow2 size=3D67108864 preallocatio=
n=3Dmetadata
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b34c8e3c0c..80e7603174 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -269,3 +269,4 @@
 254 rw auto backing quick
 255 rw auto quick
 256 rw auto quick
+259 rw auto quick
--=20
2.21.0


