Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66328C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB7B20756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQoQrFx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB7B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Qio-0002hX-F2
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qgh-0000Dq-EO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:35:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qgf-0001Fh-Cw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597138516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QneWKlrP0albiRJHLibfn0RC27lZqr/kUeBMHqn6H6g=;
 b=KQoQrFx9WE5gnuTTsrd7YHOia085vQNPQokLYWOfBO0qCPPum6IJVxPVOwO0ZqHPiOrVHJ
 TOXHDcwPhCKqzuUQSIaYfSCoi5tFXZFOnMRQnlkfFimpCk1r/5CKV0VHqBdXj73aazdf65
 tnnvldXRoplXVA+cMiHUTvKOsS3OTWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-T1JDczgYOraBS_Xch3BklQ-1; Tue, 11 Aug 2020 05:35:12 -0400
X-MC-Unique: T1JDczgYOraBS_Xch3BklQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F24A800479;
 Tue, 11 Aug 2020 09:35:11 +0000 (UTC)
Received: from localhost (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F1AB5DA33;
 Tue, 11 Aug 2020 09:35:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/2] iotests: add test for unaligned granularity bitmap backup
Date: Tue, 11 Aug 2020 11:35:05 +0200
Message-Id: <20200811093505.972894-3-mreitz@redhat.com>
In-Reply-To: <20200811093505.972894-1-mreitz@redhat.com>
References: <20200811093505.972894-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Reiter <s.reiter@proxmox.com>

Start a VM with a 4097 byte image attached, add a 4096 byte granularity
dirty bitmap, mark it dirty, and then do a backup.

This used to run into an assert and fail, check that it works as
expected and also check the created image to ensure that misaligned
backups in general work correctly.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
Message-Id: <20200810095523.15071-2-s.reiter@proxmox.com>
[mreitz: Drop bitmap, and do not write past the image's end]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/304     | 60 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/304.out |  2 ++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 63 insertions(+)
 create mode 100755 tests/qemu-iotests/304
 create mode 100644 tests/qemu-iotests/304.out

diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
new file mode 100755
index 0000000000..aaf9e14617
--- /dev/null
+++ b/tests/qemu-iotests/304
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+#
+# Tests dirty-bitmap backup with unaligned bitmap granularity
+#
+# Copyright (c) 2020 Proxmox Server Solutions
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
+# owner=s.reiter@proxmox.com
+
+import iotests
+from iotests import qemu_img_create, qemu_img_log, file_path
+
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_protocols=['file'])
+
+test_img = file_path('test.qcow2')
+target_img = file_path('target.qcow2')
+
+# unaligned by one byte
+image_len = 4097
+bitmap_granularity = 4096
+
+qemu_img_create('-f', iotests.imgfmt, test_img, str(image_len))
+
+# create VM
+vm = iotests.VM().add_drive(test_img)
+vm.launch()
+
+# write to the entire image
+vm.hmp_qemu_io('drive0', 'write -P0x16 0 4096');
+vm.hmp_qemu_io('drive0', 'write -P0x17 4096 1');
+
+# do backup and wait for completion
+vm.qmp('drive-backup', **{
+    'device': 'drive0',
+    'sync': 'full',
+    'target': target_img
+})
+
+event = vm.event_wait(name='BLOCK_JOB_COMPLETED',
+                      match={'data': {'device': 'drive0'}},
+                      timeout=5.0)
+
+# shutdown to sync images
+vm.shutdown()
+
+# backup succeeded, check if image is correct
+qemu_img_log('compare', test_img, target_img)
diff --git a/tests/qemu-iotests/304.out b/tests/qemu-iotests/304.out
new file mode 100644
index 0000000000..381cc056f7
--- /dev/null
+++ b/tests/qemu-iotests/304.out
@@ -0,0 +1,2 @@
+Images are identical.
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 025ed5238d..7f76066640 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -309,3 +309,4 @@
 299 auto quick
 301 backing quick
 302 quick
+304 rw quick
-- 
2.26.2


