Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AA9ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE2F207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE2F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyyA-0004AT-UW
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJysx-0008Af-Or
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJysw-0005ld-Gm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:51:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:57682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJyss-0005eQ-OA; Mon, 14 Oct 2019 07:51:30 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJysq-0002Oa-1M; Mon, 14 Oct 2019 14:51:28 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/2] iotests: add 269 to check maximum of bitmaps in qcow2
Date: Mon, 14 Oct 2019 14:51:26 +0300
Message-Id: <20191014115126.15360-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014115126.15360-1-vsementsov@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check that it's impossible to create more persistent bitmaps than qcow2
supports.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/269     | 47 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/269.out |  3 +++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 51 insertions(+)
 create mode 100755 tests/qemu-iotests/269
 create mode 100644 tests/qemu-iotests/269.out

diff --git a/tests/qemu-iotests/269 b/tests/qemu-iotests/269
new file mode 100755
index 0000000000..cf14d519ee
--- /dev/null
+++ b/tests/qemu-iotests/269
@@ -0,0 +1,47 @@
+#!/usr/bin/env python
+#
+# Test exceeding dirty bitmaps maximum amount in qcow2 image
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
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
+import iotests
+from iotests import qemu_img_create, file_path, log, filter_qmp_event
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+img = file_path('img')
+size = 64 * 1024
+
+qemu_img_create('-f', iotests.imgfmt, img, str(size))
+vm = iotests.VM().add_drive(img)
+vm.launch()
+
+# Look at block/qcow2.h
+QCOW2_MAX_BITMAPS = 65535
+
+for i in range(QCOW2_MAX_BITMAPS):
+    result = vm.qmp('block-dirty-bitmap-add', node='drive0',
+                    name='bitmap{}'.format(i), persistent=True)
+    assert result['return'] == {}
+
+log("{} persistent bitmap already created, " \
+    "let's try to create one more".format(QCOW2_MAX_BITMAPS))
+
+vm.qmp_log('block-dirty-bitmap-add', node='drive0',
+           name='bitmap{}'.format(QCOW2_MAX_BITMAPS), persistent=True)
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/269.out b/tests/qemu-iotests/269.out
new file mode 100644
index 0000000000..bcfa616a2b
--- /dev/null
+++ b/tests/qemu-iotests/269.out
@@ -0,0 +1,3 @@
+65535 persistent bitmap already created, let's try to create one more
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap65535", "node": "drive0", "persistent": true}}
+{"error": {"class": "GenericError", "desc": "Can't make bitmap 'bitmap65535' persistent in 'drive0': Maximum number of persistent bitmaps is already reached"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0c1e5ef414..fe8274a204 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -279,3 +279,4 @@
 265 rw auto quick
 266 rw quick
 267 rw auto quick snapshot
+269
-- 
2.21.0


