Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB30AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E6A208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2ZIebj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E6A208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPxN-0001oG-J8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtt-00052X-QQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtp-0008OC-K9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1V5mA749xD1QPqQveSZUBvdAsMs46M/NOoObw5/ie8=;
 b=P2ZIebj1V9+CCnbbxPkrDKfaj7ZityZleizv7YZDp7XHeqjC0Qe80M0+9AOCA8CcmK6Y6O
 5aI+j4HFL2H/WzZaHvCc3nKLwU4LKKpl1+IeHN30EFmGSXHkb5jRPvAILL9tumRXcU2hBO
 NVgncY6ar7UlQ5JTjdECQbBWCwKqTxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-FtfiMUATMteYGoG3eNBfMA-1; Fri, 17 Jul 2020 08:55:33 -0400
X-MC-Unique: FtfiMUATMteYGoG3eNBfMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F03518C63C9;
 Fri, 17 Jul 2020 12:55:26 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E12C710B1;
 Fri, 17 Jul 2020 12:55:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/12] iotests: test shutdown when bitmap is exported through
 NBD
Date: Fri, 17 Jul 2020 14:55:05 +0200
Message-Id: <20200717125510.238374-8-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
References: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Test shutdown when bitmap is exported through NBD and active client
exists. The previous patch fixes a crash, provoked by this scenario.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200714162234.13113-3-vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/299     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/299.out | 10 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100644 tests/qemu-iotests/299
 create mode 100644 tests/qemu-iotests/299.out

diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
new file mode 100644
index 0000000000..e129c7f7cb
--- /dev/null
+++ b/tests/qemu-iotests/299
@@ -0,0 +1,65 @@
+#!/usr/bin/env python3
+#
+# Test shutdown when bitmap is exported through NBD server
+#
+# Copyright (c) 2020 Virtuozzo International GmbH.
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
+
+# The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
+iotests.script_initialize(
+    supported_fmts=['qcow2'],
+)
+
+nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
+nbd_uri = 'nbd+unix:///disk?socket=' + nbd_sock
+size = 1024 * 1024
+
+vm = iotests.VM()
+vm.launch()
+
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'disk',
+    'driver': 'null-co',
+    'size': 1024 * 1024,
+})
+
+vm.qmp_log('block-dirty-bitmap-add', **{
+    'node': 'disk',
+    'name': 'bitmap0'
+})
+
+vm.qmp_log('nbd-server-start', **{
+    'addr': {
+        'type': 'unix',
+        'data': {'path': nbd_sock}
+    }
+}, filters=[iotests.filter_qmp_testfiles])
+
+vm.qmp_log('nbd-server-add', **{
+    'device': 'disk',
+    'writable': True,
+    'bitmap': 'bitmap0'
+})
+
+p = iotests.QemuIoInteractive('-f', 'raw', nbd_uri)
+# wait for connection and check it:
+iotests.log(p.cmd('read 0 512').rstrip(), filters=[iotests.filter_qemu_io])
+
+vm.shutdown()
+
+p.close()
diff --git a/tests/qemu-iotests/299.out b/tests/qemu-iotests/299.out
new file mode 100644
index 0000000000..bba4252923
--- /dev/null
+++ b/tests/qemu-iotests/299.out
@@ -0,0 +1,10 @@
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "disk", "size": 1048576}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "disk"}}
+{"return": {}}
+{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
+{"return": {}}
+{"execute": "nbd-server-add", "arguments": {"bitmap": "bitmap0", "device": "disk", "writable": true}}
+{"return": {}}
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a4f9e11e7a..1d0252e1f0 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -306,4 +306,5 @@
 295 rw
 296 rw
 297 meta
+299 auto quick
 301 backing quick
-- 
2.25.4


