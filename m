Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C01C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E8F20B80
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E8F20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv6Da-0003ng-IE
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 17:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jv685-0002ym-3V; Mon, 13 Jul 2020 17:36:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:52848 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jv680-00052G-4j; Mon, 13 Jul 2020 17:36:52 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jv67m-0000E2-BT; Tue, 14 Jul 2020 00:36:34 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 05/10] qcow2_format.py: Dump bitmap directory information
Date: Tue, 14 Jul 2020 00:36:38 +0300
Message-Id: <1594676203-436999-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 17:36:45
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

Read and dump entries from the bitmap directory of QCOW2 image.

Header extension:
magic                     0x23852875 (Bitmaps)
...
Bitmap name               bitmap-1
bitmap_table_offset       0xf0000
bitmap_table_size         1
flags                     0x2 (['auto'])
type                      1
granularity_bits          16
name_size                 8
extra_data_size           0

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index e77c831..f0db9f4 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -134,6 +134,53 @@ class Qcow2BitmapExt(Qcow2Struct):
         pad = (struct.calcsize(self.fmt) + 7) & ~7
         if pad:
             fd.seek(pad, 1)
+        position = fd.tell()
+        self.read_bitmap_directory(fd)
+        fd.seek(position)
+
+    def read_bitmap_directory(self, fd):
+        fd.seek(self.bitmap_directory_offset)
+        self.bitmap_directory = \
+            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
+
+    def dump(self):
+        super().dump()
+        for entry in self.bitmap_directory:
+            print()
+            entry.dump()
+
+
+class Qcow2BitmapDirEntry(Qcow2Struct):
+
+    fields = (
+        ('u64', '{:#x}', 'bitmap_table_offset'),
+        ('u32', '{}', 'bitmap_table_size'),
+        ('u32', BitmapFlags, 'flags'),
+        ('u8',  '{}', 'type'),
+        ('u8',  '{}', 'granularity_bits'),
+        ('u16', '{}', 'name_size'),
+        ('u32', '{}', 'extra_data_size')
+    )
+
+    def __init__(self, fd):
+        super().__init__(fd=fd)
+        # Seek relative to the current position in the file
+        fd.seek(self.extra_data_size, 1)
+        bitmap_name = fd.read(self.name_size)
+        self.name = bitmap_name.decode('ascii')
+        # Move position to the end of the entry in the directory
+        entry_raw_size = self.bitmap_dir_entry_raw_size()
+        padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
+        fd.seek(padding, 1)
+
+    def bitmap_dir_entry_raw_size(self):
+        return struct.calcsize(self.fmt) + self.name_size + \
+            self.extra_data_size
+
+    def dump(self):
+        print(f'{"Bitmap name":<25} {self.name}')
+        super(Qcow2BitmapDirEntry, self).dump()
+
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
 
-- 
1.8.3.1


