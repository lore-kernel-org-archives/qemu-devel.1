Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32236C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D9020B80
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D9020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv6DY-0003jr-7V
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 17:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jv684-0002y3-Ta; Mon, 13 Jul 2020 17:36:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:52824 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jv680-000527-1d; Mon, 13 Jul 2020 17:36:52 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jv67m-0000E2-Nj; Tue, 14 Jul 2020 00:36:34 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 07/10] qcow2_format.py: Dump bitmap table serialized
 entries
Date: Tue, 14 Jul 2020 00:36:40 +0300
Message-Id: <1594676203-436999-8-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Add bitmap table information to the QCOW2 metadata dump.

Bitmap name               bitmap-1
...
Bitmap table   type            offset                   size
0              serialized      4718592                  65536
1              serialized      4294967296               65536
2              serialized      5348033147437056         65536
3              serialized      13792273858822144        65536
4              serialized      4718592                  65536
5              serialized      4294967296               65536
6              serialized      4503608217305088         65536
7              serialized      14073748835532800        65536

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index d9c8513..2c78d46 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -175,14 +175,56 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         entry_raw_size = self.bitmap_dir_entry_raw_size()
         padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
         fd.seek(padding, 1)
+        position = fd.tell()
+        self.read_bitmap_table(fd)
+        fd.seek(position)
 
     def bitmap_dir_entry_raw_size(self):
         return struct.calcsize(self.fmt) + self.name_size + \
             self.extra_data_size
 
+    def read_bitmap_table(self, fd):
+        fd.seek(self.bitmap_table_offset)
+        table_size = self.bitmap_table_size * 8 * 8
+        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
+        self.bitmap_table = Qcow2BitmapTable(raw_table=table,
+                                             cluster_size=self.cluster_size)
+
     def dump(self):
         print(f'{"Bitmap name":<25} {self.name}')
         super(Qcow2BitmapDirEntry, self).dump()
+        self.bitmap_table.dump()
+
+
+class Qcow2BitmapTableEntry:
+
+    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+
+    def __init__(self, entry):
+        self.offset = entry & self.BME_TABLE_ENTRY_OFFSET_MASK
+        if self.offset:
+            self.type = 'serialized'
+        elif entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
+            self.type = 'all-ones'
+        else:
+            self.type = 'all-zeroes'
+
+
+class Qcow2BitmapTable:
+
+    def __init__(self, raw_table, cluster_size):
+        self.entries = []
+        self.cluster_size = cluster_size
+        for entry in raw_table:
+            self.entries.append(Qcow2BitmapTableEntry(entry))
+
+    def dump(self):
+        size = self.cluster_size
+        bitmap_table = enumerate(self.entries)
+        print(f'{"Bitmap table":<14} {"type":<15} {"offset":<24} {"size"}')
+        for i, entry in bitmap_table:
+            print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {size}')
 
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
-- 
1.8.3.1


