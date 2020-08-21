Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4E120FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzQ560FD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4E120FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97js-0000tb-K5
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iu-00075F-8b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97ir-0004Vw-CG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emZF2mYnnEZmfx/We7TVxfW8bQGfU8OWig/qmvfgpYU=;
 b=fzQ560FDCZGRVubhjKn10ZxTV8kGggu+mEAuCvuE9JEr0ez2sm5ckg+zhXtgrBcvUgraF5
 eWFQqQ2Mkt2QJuv81m+3/pJyZ+1vzc5CAim1Ewt7AavcFOCiG2yzZZRKRDmjjFu4N/VBfj
 iLwkVwwRTYp/ZRZQWF7GQwlpPq8Qqss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-a0TGXhipO16Jiv12XfvLXQ-1; Fri, 21 Aug 2020 10:08:31 -0400
X-MC-Unique: a0TGXhipO16Jiv12XfvLXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D00211074666;
 Fri, 21 Aug 2020 14:08:29 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B8797A40B;
 Fri, 21 Aug 2020 14:08:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] iotests: add test for QCOW2 header dump
Date: Fri, 21 Aug 2020 09:08:13 -0500
Message-Id: <20200821140826.194322-2-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The simple script creates a QCOW2 image and fills it with some data.
Two bitmaps are created as well. Then the script reads the image header
with extensions from the disk by running the script qcow2.py and dumps
the information to the output. Other entities, such as snapshots, may
be added to the test later.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/303     | 60 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/303.out | 60 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 121 insertions(+)
 create mode 100755 tests/qemu-iotests/303
 create mode 100644 tests/qemu-iotests/303.out

diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
new file mode 100755
index 000000000000..e9accdc7bc92
--- /dev/null
+++ b/tests/qemu-iotests/303
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+#
+# Test for dumping of qcow2 image metadata
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
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
+import subprocess
+from iotests import qemu_img_create, qemu_io, file_path, log, filter_qemu_io
+
+iotests.script_initialize(supported_fmts=['qcow2'])
+
+disk = file_path('disk')
+chunk = 1024 * 1024
+
+
+def create_bitmap(bitmap_number, disabled):
+    granularity = 1 << (14 + bitmap_number)
+    bitmap_name = 'bitmap-' + str(bitmap_number)
+    args = ['bitmap', '--add', '-g', f'{granularity}', '-f', iotests.imgfmt,
+            disk, bitmap_name]
+    if disabled:
+        args.append('--disable')
+
+    iotests.qemu_img_pipe(*args)
+
+
+def write_to_disk(offset, size):
+    write = f'write {offset} {size}'
+    log(qemu_io('-c', write, disk), filters=[filter_qemu_io])
+
+
+def add_bitmap(num, begin, end, disabled):
+    log(f'Add bitmap {num}')
+    create_bitmap(num, disabled)
+    for i in range(begin, end):
+        write_to_disk((i) * chunk, chunk)
+    log('')
+
+
+qemu_img_create('-f', iotests.imgfmt, disk, '10M')
+
+add_bitmap(1, 0, 6, False)
+add_bitmap(2, 6, 8, True)
+dump = ['qcow2.py', disk, 'dump-header']
+subprocess.run(dump)
diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
new file mode 100644
index 000000000000..8d7973ccc201
--- /dev/null
+++ b/tests/qemu-iotests/303.out
@@ -0,0 +1,60 @@
+Add bitmap 1
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 1048576/1048576 bytes at offset 2097152
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 1048576/1048576 bytes at offset 4194304
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 1048576/1048576 bytes at offset 5242880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+
+Add bitmap 2
+wrote 1048576/1048576 bytes at offset 6291456
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 1048576/1048576 bytes at offset 7340032
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+
+magic                     0x514649fb
+version                   3
+backing_file_offset       0x0
+backing_file_size         0x0
+cluster_bits              16
+size                      10485760
+crypt_method              0
+l1_size                   1
+l1_table_offset           0x30000
+refcount_table_offset     0x10000
+refcount_table_clusters   1
+nb_snapshots              0
+snapshot_offset           0x0
+incompatible_features     []
+compatible_features       []
+autoclear_features        [0]
+refcount_order            4
+header_length             112
+
+Header extension:
+magic                     0x6803f857 (Feature table)
+length                    336
+data                      <binary>
+
+Header extension:
+magic                     0x23852875 (Bitmaps)
+length                    24
+nb_bitmaps                2
+reserved32                0
+bitmap_directory_size     0x40
+bitmap_directory_offset   0x9d0000
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7f76066640a6..ecff2621cddc 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -309,4 +309,5 @@
 299 auto quick
 301 backing quick
 302 quick
+303 rw quick
 304 rw quick
-- 
2.28.0


