Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB2EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56D220842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56D220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Ue-0006En-7w
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19L9-0004yF-3U; Thu, 30 Jul 2020 10:15:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:44441 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19L4-00052g-9y; Thu, 30 Jul 2020 10:15:22 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19Km-0004Cz-Nl; Thu, 30 Jul 2020 17:15:00 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v12 03/11] qcow2_format.py: change Qcow2BitmapExt
 initialization method
Date: Thu, 30 Jul 2020 17:15:04 +0300
Message-Id: <1596118512-424960-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 10:15:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are two ways to initialize a class derived from Qcow2Struct:
1. Pass a block of binary data to the constructor.
2. Pass the file descriptor to allow reading the file from constructor.
Let's change the Qcow2BitmapExt initialization method from 1 to 2 to
support a scattered reading in the initialization chain.
The implementation comes with the patch that follows.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 2f3681b..d4a9974 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -113,6 +113,11 @@ class Qcow2BitmapExt(Qcow2Struct):
         ('u64', '{:#x}', 'bitmap_directory_offset')
     )
 
+    def __init__(self, fd):
+        super().__init__(fd=fd)
+        tail = struct.calcsize(self.fmt) % 8
+        if tail:
+            fd.seek(8 - tail, 1)
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
 
@@ -161,21 +166,24 @@ class QcowHeaderExtension(Qcow2Struct):
         else:
             assert all(v is None for v in (magic, length, data))
             super().__init__(fd=fd)
-            padded = (self.length + 7) & ~7
-            self.data = fd.read(padded)
-            assert self.data is not None
-
-        data_str = self.data[:self.length]
-        if all(c in string.printable.encode('ascii') for c in data_str):
-            data_str = f"'{ data_str.decode('ascii') }'"
-        else:
-            data_str = '<binary>'
-        self.data_str = data_str
+            if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
+                self.obj = Qcow2BitmapExt(fd=fd)
+                self.data = None
+            else:
+                padded = (self.length + 7) & ~7
+                self.data = fd.read(padded)
+                assert self.data is not None
+                self.obj = None
+
+        if self.data is not None:
+            data_str = self.data[:self.length]
+            if all(c in string.printable.encode(
+                'ascii') for c in data_str):
+                data_str = f"'{ data_str.decode('ascii') }'"
+            else:
+                data_str = '<binary>'
+            self.data_str = data_str
 
-        if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
-            self.obj = Qcow2BitmapExt(data=self.data)
-        else:
-            self.obj = None
 
     def dump(self):
         super().dump()
-- 
1.8.3.1


