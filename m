Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D56C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767E720702
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767E720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1justw-0001Ug-L3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussi-0007ki-3Y; Mon, 13 Jul 2020 03:28:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:35074 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussc-0007TI-I7; Mon, 13 Jul 2020 03:28:07 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussP-0001Vx-Qw; Mon, 13 Jul 2020 10:27:49 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v9 07/10] qcow2_format.py: Dump bitmap table serialized entries
Date: Mon, 13 Jul 2020 10:27:53 +0300
Message-Id: <1594625276-134500-8-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:27:59
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
It extends the output of the test case #291

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
 tests/qemu-iotests/291.out         | 45 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/qcow2_format.py | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 53a8eeb..9f465c6 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -41,6 +41,15 @@ type                      1
 granularity_bits          19
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      5046272                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
 
 Bitmap name               b2
 bitmap_table_offset       0x500000
@@ -50,6 +59,15 @@ type                      1
 granularity_bits          16
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      5177344                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
 
 
 === Bitmap preservation not possible to non-qcow2 ===
@@ -124,6 +142,15 @@ type                      1
 granularity_bits          19
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      4587520                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
 
 Bitmap name               b2
 bitmap_table_offset       0x490000
@@ -133,6 +160,15 @@ type                      1
 granularity_bits          16
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      4718592                  65536
+1              serialized      4294967296               65536
+2              serialized      5348033147437056         65536
+3              serialized      13792273858822144        65536
+4              serialized      4718592                  65536
+5              serialized      4294967296               65536
+6              serialized      4503608217305088         65536
+7              serialized      14073748835532800        65536
 
 Bitmap name               b0
 bitmap_table_offset       0x510000
@@ -142,6 +178,15 @@ type                      1
 granularity_bits          16
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      5242880                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
 
 
 === Check bitmap contents ===
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index d7198a9..22be3ee 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -170,14 +170,56 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
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


